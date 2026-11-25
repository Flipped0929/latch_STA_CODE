"""Measure actual routed clock paths, filtering out enable-branch clock tags."""
import csv
import json
import re


def analyze_clock_paths(root, routed, sdc_path):
    reports = root / "reports"
    buffer_inputs = {}
    for name, (master, pins) in routed.items():
        if master.startswith("sky130_fd_sc_hd__clkbuf_") and "X" in pins:
            buffer_inputs[pins["X"]] = (name, pins["A"])
    clock_pins = {f"state_phi1_bit{bit}/GATE": "phi1" for bit in range(4)}
    clock_pins.update({f"state_phi1_carry_bit{bit}/GATE": "phi1" for bit in (2, 3)})
    clock_pins["enable_phi1/GATE"] = "phi1"
    clock_pins.update({f"state_phi2_bit{bit}/GATE": "phi2" for bit in range(4)})
    samples = {}
    for filename in ("setup.rpt", "hold.rpt"):
        clock = edge = root_time = None
        for line in (reports / filename).read_text().splitlines():
            start = re.search(r"clock (phi[12]) \((rise|fall) edge\)", line)
            if start:
                clock, edge = start.groups()
                root_time = float(re.findall(r"[-+]?\d+\.\d+", line)[-1])
            pin_match = re.search(r"[\^v] (\S+/GATE) \(", line)
            if pin_match and clock_pins.get(pin_match[1]) == clock:
                numbers = [float(x) for x in re.findall(r"[-+]?\d+\.\d+", line)]
                if len(numbers) >= 3:
                    key = (clock, pin_match[1], edge)
                    samples.setdefault(key, []).append((numbers[-1] - root_time, numbers[-3]))
    expected = {(clock, pin, edge) for pin, clock in clock_pins.items() for edge in ("rise", "fall")}
    assert set(samples) == expected, ("Incomplete clock endpoint coverage", expected - set(samples))
    rows = []
    for (clock, pin, edge), values in sorted(samples.items()):
        net = routed[pin.split("/")[0]][1]["GATE"]
        stages = []
        while net in buffer_inputs:
            name, net = buffer_inputs[net]
            assert name not in stages, "Clock buffer loop"
            stages.insert(0, name)
        rows.append({
            "clock": clock, "pin": pin, "edge": edge,
            "buffer_stages": len(stages), "buffers": " -> ".join(stages),
            "latency_min_ns": round(min(x[0] for x in values), 6),
            "latency_max_ns": round(max(x[0] for x in values), 6),
            "slew_max_ns": round(max(x[1] for x in values), 6),
        })
    with (reports / "clock_endpoints.csv").open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    phases = {}
    for clock in ("phi1", "phi2"):
        phases[clock] = {}
        for edge in ("rise", "fall"):
            group = [row for row in rows if row["clock"] == clock and row["edge"] == edge]
            phases[clock][edge] = {
                "latency_min_ns": min(row["latency_min_ns"] for row in group),
                "latency_max_ns": max(row["latency_max_ns"] for row in group),
                "skew_envelope_ns": round(max(row["latency_max_ns"] for row in group)
                                           - min(row["latency_min_ns"] for row in group), 6),
                "slew_max_ns": max(row["slew_max_ns"] for row in group),
                "buffer_stages": sorted({row["buffer_stages"] for row in group}),
            }
    clocks = {
        name: (float(period), float(rise), float(fall))
        for name, period, rise, fall in re.findall(
            r"create_clock\s+-name\s+(\w+)\s+-period\s+([\d.]+)\s+-waveform\s+\{([\d.]+)\s+([\d.]+)\}",
            sdc_path.read_text())
    }
    assert set(clocks) == {"phi1", "phi2"} and clocks["phi1"][0] == clocks["phi2"][0]
    period, rise1, fall1 = clocks["phi1"]
    _, rise2, fall2 = clocks["phi2"]
    # Positive gap means nominal non-overlap; excludes clock uncertainty/OCV.
    gaps = {
        "phi1_close_to_phi2_open_ns": round(rise2 + phases["phi2"]["rise"]["latency_min_ns"]
            - fall1 - phases["phi1"]["fall"]["latency_max_ns"], 6),
        "phi2_close_to_next_phi1_open_ns": round(period + rise1 + phases["phi1"]["rise"]["latency_min_ns"]
            - fall2 - phases["phi2"]["fall"]["latency_max_ns"], 6),
    }
    result = {"phases": phases, "nominal_phase_gaps": gaps,
              "note": "Pin latency from full SPEF STA clock paths; phase gaps exclude uncertainty and OCV."}
    (reports / "clock_metrics.json").write_text(json.dumps(result, indent=2) + "\n")
    return result
