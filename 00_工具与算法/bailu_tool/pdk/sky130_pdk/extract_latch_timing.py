"""Extract a fixed-condition, rise/fall envelope for the supplied SKY130 latch."""

import argparse
import bisect
import hashlib
import json
import math
from pathlib import Path


ROOT = Path(__file__).resolve().parent
COMMON = "sky130_fd_sc_hd__common.lib.json"
CELL = "sky130_fd_sc_hd__dlxtp_1__tt_025C_1v80.lib.json"


def interpolate(table, x, y):
    xs, ys, values = table["index_1"], table["index_2"], table["values"]
    for axis in (xs, ys):
        if (len(axis) < 2 or not all(math.isfinite(v) for v in axis)
                or any(a >= b for a, b in zip(axis, axis[1:]))):
            raise ValueError("Table axes must be finite and strictly increasing")
    if (len(values) != len(xs) or any(len(row) != len(ys) for row in values)
            or not all(math.isfinite(v) for row in values for v in row)):
        raise ValueError("Invalid table dimensions or non-finite values")
    if not (math.isfinite(x) and math.isfinite(y)
            and xs[0] <= x <= xs[-1] and ys[0] <= y <= ys[-1]):
        raise ValueError("Operating point is outside the table; extrapolation is disabled")
    i = min(bisect.bisect_right(xs, x) - 1, len(xs) - 2)
    j = min(bisect.bisect_right(ys, y) - 1, len(ys) - 2)
    tx, ty = (x - xs[i]) / (xs[i + 1] - xs[i]), (y - ys[j]) / (ys[j + 1] - ys[j])
    left = values[i][j] * (1 - tx) + values[i + 1][j] * tx
    right = values[i][j + 1] * (1 - tx) + values[i + 1][j + 1] * tx
    return left * (1 - ty) + right * ty


def arc(cell, pin, related, timing_type):
    arcs = cell["pin," + pin]["timing"]
    if isinstance(arcs, dict):
        arcs = [arcs]
    matches = [a for a in arcs if a.get("related_pin") == related
               and a.get("timing_type") == timing_type]
    if len(matches) != 1 or "when" in matches[0]:
        raise ValueError(f"Expected one unconditional {related}->{pin} {timing_type} arc")
    return matches[0]


def evaluate(common, timing_arc, prefix, x, y, variables):
    keys = [key for key in timing_arc if key.startswith(prefix + ",")]
    if len(keys) != 1:
        raise ValueError(f"Expected one {prefix} table")
    key = keys[0]
    template = common["lu_table_template," + key.split(",", 1)[1]]
    if (template["variable_1"], template["variable_2"]) != variables:
        raise ValueError(f"Unsupported table variables for {key}")
    return interpolate(timing_arc[key], x, y)


def extract_pulse_width(common, cell, clock_slew):
    """Evaluate the supplied latch's one-dimensional GATE pulse-width tables."""
    if common["time_unit"] != "1ns":
        raise ValueError("Pulse-width extraction requires ns")
    if cell["latch,IQ,IQ_N"] != {"data_in": "D", "enable": "GATE"}:
        raise ValueError("Expected a positive-level D/GATE latch")
    timing = arc(cell, "GATE", "GATE", "min_pulse_width")
    result = {}
    for level, prefix in (("high", "rise_constraint"), ("low", "fall_constraint")):
        keys = [key for key in timing if key.startswith(prefix + ",")]
        if not keys:
            result["min_pulse_width_" + level] = None  # No corresponding check in this library arc.
            continue
        if len(keys) != 1:
            raise ValueError(f"Ambiguous {level} pulse-width table")
        key = keys[0]
        template = common["lu_table_template," + key.split(",", 1)[1]]
        if template.get("variable_1") not in ("related_pin_transition", "constrained_pin_transition") or "variable_2" in template:
            raise ValueError("Unsupported pulse-width table variables")
        table = timing[key]
        xs, values = table["index_1"], table["values"]
        if (len(xs) < 2 or len(xs) != len(values) or
                not all(math.isfinite(v) for v in xs + values) or
                any(a >= b for a, b in zip(xs, xs[1:])) or any(v < 0 for v in values)):
            raise ValueError("Invalid pulse-width table")
        if not math.isfinite(clock_slew) or not xs[0] <= clock_slew <= xs[-1]:
            raise ValueError("Clock slew outside pulse-width table; extrapolation is disabled")
        i = min(bisect.bisect_right(xs, clock_slew) - 1, len(xs) - 2)
        fraction = (clock_slew - xs[i]) / (xs[i + 1] - xs[i])
        result["min_pulse_width_" + level] = values[i] * (1 - fraction) + values[i + 1] * fraction
    if all(value is None for value in result.values()):
        raise ValueError("Pulse-width arc has no supported constraint tables")
    return result


def extract(common, cell, data_slew, clock_slew, load):
    if common["time_unit"] != "1ns" or common["comp_attribute,capacitive_load_unit"] != [1.0, "pf"]:
        raise ValueError("This extractor requires ns and pF")
    if cell["latch,IQ,IQ_N"] != {"data_in": "D", "enable": "GATE"}:
        raise ValueError("Expected a positive-level D/GATE latch")
    constraint_vars = ("related_pin_transition", "constrained_pin_transition")
    delay_vars = ("input_net_transition", "total_output_net_capacitance")
    details = {}
    for name, pin, related, kind, prefixes, x, y, variables in (
        ("setup", "D", "GATE", "setup_falling", ("rise_constraint", "fall_constraint"), clock_slew, data_slew, constraint_vars),
        ("hold", "D", "GATE", "hold_falling", ("rise_constraint", "fall_constraint"), clock_slew, data_slew, constraint_vars),
        ("dq", "Q", "D", "combinational", ("cell_rise", "cell_fall"), data_slew, load, delay_vars),
        ("cq", "Q", "GATE", "rising_edge", ("cell_rise", "cell_fall"), clock_slew, load, delay_vars),
    ):
        timing_arc = arc(cell, pin, related, kind)
        details[name] = {prefix: evaluate(common, timing_arc, prefix, x, y, variables) for prefix in prefixes}
    params = {
        "tsu": max(details["setup"].values()),
        "thd": max(details["hold"].values()),
        "tdqMin": min(details["dq"].values()),
        "tdqMax": max(details["dq"].values()),
        "tcqMin": min(details["cq"].values()),
        "tcqMax": max(details["cq"].values()),
    }
    if not all(math.isfinite(v) for v in params.values()) or params["tdqMin"] < 0 or params["tcqMin"] < 0:
        raise ValueError("Parameters do not satisfy the current MCR input requirements")
    return params, details


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--data-slew-ns", type=float, default=0.01)
    parser.add_argument("--clock-slew-ns", type=float, default=0.01)
    parser.add_argument("--load-pf", type=float, default=0.0005)
    parser.add_argument("--output", type=Path, default=ROOT / "latch_timing.json")
    args = parser.parse_args()
    try:
        files = [ROOT / COMMON, ROOT / CELL]
        if args.output.resolve() in [p.resolve() for p in files] or args.output.resolve() == Path(__file__).resolve():
            raise ValueError("Output must not overwrite the input files or extractor")
        raw = [p.read_bytes() for p in files]
        common, cell = [json.loads(b.decode("utf-8-sig")) for b in raw]
        params, details = extract(common, cell, args.data_slew_ns, args.clock_slew_ns, args.load_pf)
        clock_checks = extract_pulse_width(common, cell, args.clock_slew_ns)
        report = {
            "cell": "sky130_fd_sc_hd__dlxtp_1",
            "corner_from_filename": "tt_025C_1v80",
            "conditions": {"data_slew_ns": args.data_slew_ns, "clock_slew_ns": args.clock_slew_ns, "load_pf": args.load_pf},
            "sources": [{"file": p.name, "sha256": hashlib.sha256(b).hexdigest()} for p, b in zip(files, raw)],
            "method": "Bilinear interpolation; setup/hold use max(rise, fall); propagation uses min/max(rise, fall). Pulse widths use linear interpolation at clock slew. No extrapolation.",
            "limitations": ["One TT condition, not a multi-PVT envelope.", "Fixed slew/load; no circuit path delays or IO constraints.", "Minimum pulse width and other library checks are not included in these six MCR parameters."],
            "parameters_ns": params,
            "clock_checks_ns": clock_checks,
            "arc_values_ns": details,
        }
        args.output.write_text(json.dumps(report, indent=2, allow_nan=False) + "\n", encoding="utf-8")
    except (OSError, ValueError, KeyError, TypeError) as error:
        parser.error(str(error))
    print("Saved:", args.output)
    print("LatchTiming{" + ", ".join(format(v, ".12g") for v in params.values()) + "}")


if __name__ == "__main__":
    main()
