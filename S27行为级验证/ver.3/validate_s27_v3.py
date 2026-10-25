#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Deterministic S27 ver.3 cross-checks.

This module deliberately keeps the experiment small and reproducible.  It
loads the edge table and the optimum reported by ver.2, then drives the event
simulator from ver.1 with all 256 possible eight-cycle periodic bit patterns.
It also evaluates a T/W boundary grid and a delay sensitivity table.  The
simulator is an XOR timing-graph model; this file does not claim to be a
gate-level or post-layout verification.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import importlib.util
import json
import math
from collections import Counter
from pathlib import Path
from typing import Dict, Iterable, List, Mapping, Sequence, Tuple


HERE = Path(__file__).resolve().parent
V2_DIR = HERE.parent / "ver.2"
V1_SIM = HERE.parent / "ver.1" / "sim.py"
RESULTS_DIR = HERE / "results"
TOL = 1.0e-8
T_GOLD = 30.0
PATTERN_WIDTH = 8


def _load_sim():
    spec = importlib.util.spec_from_file_location("s27_ver1_sim", V1_SIM)
    if spec is None or spec.loader is None:
        raise ImportError(f"cannot import simulator: {V1_SIM}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


SIM = _load_sim()
NODES = tuple(SIM.NODES)


def load_edges(path: Path | None = None) -> List[dict]:
    """Read the normalized v2 timing edge table."""
    path = path or (V2_DIR / "data" / "s27_edges.csv")
    with path.open("r", encoding="utf-8-sig", newline="") as fh:
        rows = []
        for row in csv.DictReader(fh):
            rows.append({
                "source": row["source"],
                "target": row["target"],
                "max_delay_ns": float(row["max_delay_ns"]),
                "min_delay_ns": float(row["min_delay_ns"]),
            })
    if not rows:
        raise ValueError(f"edge table is empty: {path}")
    pairs = [(e["source"], e["target"]) for e in rows]
    if len(set(pairs)) != len(pairs) or set(pairs) != set(SIM.DELAY):
        raise ValueError("edge table must match the ten unique simulator edges")
    if any(not math.isfinite(e["min_delay_ns"] + e["max_delay_ns"])
           or not 0 <= e["min_delay_ns"] <= e["max_delay_ns"] for e in rows):
        raise ValueError("edge table has an invalid delay interval")
    return rows


def load_solution(path: Path | None = None) -> dict:
    """Read the actual ver.2 report, failing if it is missing."""
    path = path or (V2_DIR / "results" / "summary.json")
    with path.open("r", encoding="utf-8") as fh:
        src = json.load(fh)
    return {
        "T": float(src["period_ns"]),
        "W": float(src["window_ns"]),
        "skew": {str(k): float(v) for k, v in src["skews_ns"].items()},
        "hold_margin": float(src.get("hold_margin_ns", 0.10)),
    }


def skew_vector(skew: Mapping[str, float]) -> List[float]:
    return [float(skew[n]) for n in NODES]


def pattern_bits(mask: int, width: int = PATTERN_WIDTH) -> List[int]:
    """Return one period, least-significant bit first, as 0/1 values."""
    if mask < 0 or mask >= (1 << width):
        raise ValueError("pattern mask outside requested width")
    return [(mask >> i) & 1 for i in range(width)]


def periodic_stim(mask: int, n: int, width: int = PATTERN_WIDTH) -> List[int]:
    period = pattern_bits(mask, width)
    return [period[i % width] for i in range(n)]


def static_check(
    T: float,
    W: float,
    skew: Mapping[str, float] | Sequence[float],
    edges: Sequence[Mapping[str, float]],
    hold_margin: float,
    tol: float = TOL,
) -> dict:
    """Evaluate v2's setup, extended-setup and hold inequalities."""
    if isinstance(skew, Mapping):
        s = {str(k): float(v) for k, v in skew.items()}
    else:
        s = {n: float(skew[i]) for i, n in enumerate(NODES)}
    details = []
    for edge in edges:
        u, v = str(edge["source"]), str(edge["target"])
        dmax, dmin = float(edge["max_delay_ns"]), float(edge["min_delay_ns"])
        setup = T - dmax - s[u] + s[v]
        extended = T + W - dmax - s[u] + s[v]
        hold = dmin - hold_margin - W + s[u] - s[v]
        details.append({
            "source": u,
            "target": v,
            "setup_slack_ns": setup,
            "extended_setup_slack_ns": extended,
            "hold_slack_ns": hold,
            "pass": bool(min(setup, extended, hold) >= -tol),
        })
    min_setup = min(x["setup_slack_ns"] for x in details)
    min_extended = min(x["extended_setup_slack_ns"] for x in details)
    min_hold = min(x["hold_slack_ns"] for x in details)
    half_window = T / 2.0 - W
    edge_pass = all(x["pass"] for x in details)
    delay_range_valid = all(0 <= float(e["min_delay_ns"]) <=
                            float(e["max_delay_ns"]) + tol for e in edges)
    parameter_valid = all(math.isfinite(value) for value in (T, W, hold_margin)) and \
        T > 0 and W >= 0 and hold_margin >= 0
    return {
        "T": float(T),
        "W": float(W),
        "min_setup_slack_ns": min_setup,
        "min_extended_setup_slack_ns": min_extended,
        "min_hold_slack_ns": min_hold,
        "half_window_slack_ns": half_window,
        "edge_pass": edge_pass,
        "delay_range_valid": delay_range_valid,
        "parameter_valid": parameter_valid,
        "window_pass": half_window >= -tol,
        "pass": bool(edge_pass and half_window >= -tol and
                     delay_range_valid and parameter_valid),
        "details": details,
    }


def compare_captures(fast: dict, gold: dict, c0: int, c1: int,
                     max_off: int = 24) -> Tuple[bool, int | None, float, float]:
    """Compare G5/G6/G7 captures at one constant pipeline offset."""
    state_pairs = [(fast["cap"][k], gold["cap"][k]) for k in (1, 2, 3)]
    tap_pairs = [(fast["obs"][k], gold["obs"][k]) for k in SIM.TAPS]

    def frac(a: Sequence[int], b: Sequence[int], off: int) -> float:
        if not (0 <= c0 < c1 <= len(a) and 0 <= c0 + off < c1 + off <= len(b)):
            return 0.0
        return sum(int(a[c] == b[c + off]) for c in range(c0, c1)) / (c1 - c0)

    best = (0.0, None, 0.0)
    for off in range(-4, max_off + 1):
        state = min(frac(a, b, off) for a, b in state_pairs)
        taps = min(frac(a, b, off) for a, b in tap_pairs)
        if state > best[0] + TOL:
            best = (state, off, taps)
        if state >= 0.995 - TOL:
            return True, off, state, taps
    return False, best[1], best[0], best[2]


def behavior_case(T: float, W: float, skew: Mapping[str, float], mask: int,
                  cycles: int = 64, c0: int = 16, c1: int = 56,
                  edge_delays: Mapping[Tuple[str, str], float] | None = None) -> dict:
    """Run one deterministic pattern against the 30 ns reference."""
    gold_cycles = cycles + 32
    stim = periodic_stim(mask, gold_cycles + 64)
    vec = skew_vector(skew)
    fast = SIM.run_sim(T, W, vec, cycles, stim, edge_delays=edge_delays)
    gold = SIM.run_sim(T_GOLD, W, vec, gold_cycles, stim, edge_delays=edge_delays)
    io_ok = all(fast["cap"][0][c] == stim[c] for c in range(cycles))
    passed, offset, match, tap_match = compare_captures(fast, gold, c0, c1)
    zero_match = min(
        sum(fast["cap"][k][c] == gold["cap"][k][c] for c in range(c0, c1)) / (c1 - c0)
        for k in (1, 2, 3)
    )
    off = offset if offset is not None else 0
    mismatch = next(((c, NODES[k]) for c in range(c0, c1) for k in (1, 2, 3)
                     if 0 <= c + off < len(gold["cap"][k])
                     and fast["cap"][k][c] != gold["cap"][k][c + off]), None)
    return {
        "pattern": mask,
        "pattern_hex": f"0x{mask:02X}",
        "pattern_bits_in_time_order": "".join(map(str, pattern_bits(mask))),
        "pass": bool(passed and io_ok),
        "io_ok": bool(io_ok),
        "offset_cycles": offset,
        "state_match": match,
        "tap_match": tap_match,
        "zero_offset_state_match": zero_match,
        "pass_at_zero_offset": bool(io_ok and zero_match >= 0.995 - TOL),
        "first_mismatch_cycle": mismatch[0] if mismatch else "",
        "first_mismatch_node": mismatch[1] if mismatch else "",
        "T": float(T),
        "W": float(W),
    }


def pattern_results(T: float, W: float, skew: Mapping[str, float],
                    patterns: Iterable[int] = range(256)) -> List[dict]:
    return [behavior_case(T, W, skew, int(mask)) for mask in patterns]


def choose_grid(T0: float, W0: float) -> Tuple[List[float], List[float]]:
    # ±0.02 ns around T* and ±0.10 ns around W*, including the exact boundary.
    Ts = sorted({round(T0 + x, 8) for x in
                 (-0.020, -0.010, -0.001, -0.00001, 0.0, 0.00001, 0.001, 0.010, 0.020)})
    Ws = sorted({round(W0 + x, 8) for x in
                 (-0.100, -0.050, -0.010, -0.00001, 0.0, 0.00001, 0.010, 0.050, 0.100)})
    return Ts, Ws


REPRESENTATIVE_PATTERNS = (0, 1, 3, 15, 51, 85, 127, 128,
                            170, 192, 204, 240, 254, 255)


def grid_results(T0: float, W0: float, skew: Mapping[str, float],
                 edges: Sequence[Mapping[str, float]], hold_margin: float,
                 patterns: Sequence[int] = REPRESENTATIVE_PATTERNS) -> List[dict]:
    rows = []
    for T in choose_grid(T0, W0)[0]:
        for W in choose_grid(T0, W0)[1]:
            static = static_check(T, W, skew, edges, hold_margin)
            results = [behavior_case(T, W, skew, p, cycles=48, c0=12, c1=40)
                       for p in patterns]
            rows.append({
                "T": T,
                "W": W,
                "static_pass": static["pass"],
                "min_setup_slack_ns": static["min_setup_slack_ns"],
                "min_extended_setup_slack_ns": static["min_extended_setup_slack_ns"],
                "min_hold_slack_ns": static["min_hold_slack_ns"],
                "half_window_slack_ns": static["half_window_slack_ns"],
                "behavior_patterns": len(results),
                "behavior_pass_count": sum(int(r["pass"]) for r in results),
                "behavior_pass_rate": sum(int(r["pass"]) for r in results) / len(results),
                "behavior_min_match": min(r["state_match"] for r in results),
                "behavior_io_failures": sum(int(not r["io_ok"]) for r in results),
                "behavior_pass_at_zero_offset_count": sum(int(r["pass_at_zero_offset"]) for r in results),
                "classification": ("both_pass" if static["pass"] else "static_fail_behavior_pass")
                    if all(r["pass"] for r in results) else
                    ("static_pass_behavior_fail" if static["pass"] else "both_fail"),
            })
    return rows


def perturbation_results(T: float, W: float, skew: Mapping[str, float],
                         edges: Sequence[Mapping[str, float]], hold_margin: float) -> List[dict]:
    """Static and deterministic behavior/hold sensitivity to delay scaling."""
    rows = []
    factors = (-0.10, -0.05, 0.0, 0.05, 0.10)
    behavior_by_max = {}
    for factor in factors:
        delay_map = { (e["source"], e["target"]): e["max_delay_ns"] * (1 + factor)
                      for e in edges }
        br = [behavior_case(T, W, skew, p, cycles=48, c0=12, c1=40,
                            edge_delays=delay_map)
              for p in REPRESENTATIVE_PATTERNS]
        behavior_by_max[factor] = {
            "patterns": len(br),
            "pass_count": sum(int(x["pass"]) for x in br),
            "pass_rate": sum(int(x["pass"]) for x in br) / len(br),
        }

    hold_by_min = {}
    for factor in factors:
        min_map = { (e["source"], e["target"]): e["min_delay_ns"] * (1 + factor)
                    for e in edges }
        hold_by_min[factor] = dynamic_hold_for_delay(
            T, W, skew, min_map, hold_margin, cycles=96, c0=24, c1=80, seed=2701)

    for max_factor in factors:
        for min_factor in factors:
            perturbed = [dict(e,
                              max_delay_ns=e["max_delay_ns"] * (1 + max_factor),
                              min_delay_ns=e["min_delay_ns"] * (1 + min_factor))
                         for e in edges]
            r = static_check(T, W, skew, perturbed, hold_margin)
            invalid_edges = sum(
                int(float(e["min_delay_ns"]) > float(e["max_delay_ns"]) + TOL)
                for e in perturbed
            )
            range_valid = invalid_edges == 0
            rows.append({
                "max_delay_factor": max_factor,
                "min_delay_factor": min_factor,
                "delay_range_valid": range_valid,
                "invalid_edge_count": invalid_edges,
                # A mathematically feasible point with Dmin>Dmax is not a
                # physical delay interval, so it must not be reported PASS.
                "static_pass": bool(range_valid and r["pass"]),
                "min_setup_slack_ns": r["min_setup_slack_ns"],
                "min_extended_setup_slack_ns": r["min_extended_setup_slack_ns"],
                "min_hold_slack_ns": r["min_hold_slack_ns"],
                "dmax_behavior_patterns": behavior_by_max[max_factor]["patterns"],
                "dmax_behavior_pass_count": behavior_by_max[max_factor]["pass_count"],
                "dmax_behavior_pass_rate": behavior_by_max[max_factor]["pass_rate"],
                "dmin_dynamic_hold_pass": hold_by_min[min_factor]["pass"],
                "dmin_dynamic_hold_min_slack_ns": hold_by_min[min_factor]["min_slack_ns"],
                "dmin_dynamic_hold_worst_edge": hold_by_min[min_factor]["worst_edge"],
            })
    return rows


def dynamic_hold_for_delay(T: float, W: float, skew: Mapping[str, float],
                           min_delay: Mapping[Tuple[str, str], float],
                           hold_margin: float, cycles: int = 96,
                           c0: int = 24, c1: int = 80, seed: int = 2701) -> dict:
    """Run the v1 transition-observation hold diagnostic with a delay table."""
    import bisect

    stim = SIM.make_stim(cycles + 64, seed)
    run = SIM.run_sim(T, W, skew_vector(skew), cycles, stim, edge_delays=min_delay)
    checks = []
    for dst in range(1, len(NODES)):
        for src, _ in SIM.FANIN[dst]:
            edge = (NODES[src], NODES[dst])
            arrivals = sorted(t + min_delay[edge] for t in run["times"][src][1:])
            for cycle in range(c0, c1):
                close_time = skew[NODES[dst]] + cycle * T + W
                check = SIM.hold_slack_for_edge(arrivals, close_time, hold_margin)
                if check is not None:
                    checks.append((check["slack"], edge[0], edge[1]))
    if not checks:
        return {"pass": False, "min_slack_ns": None, "worst_edge": ""}
    slack, src, dst = min(checks)
    return {"pass": slack >= -TOL, "min_slack_ns": slack,
            "worst_edge": f"{src}->{dst}"}


def hold_sensitivity(T0: float, W0: float, skew: Mapping[str, float],
                    edges: Sequence[Mapping[str, float]], hold_margin: float) -> List[dict]:
    points = [("nominal", T0, W0), ("T_minus_0.01", T0 - .01, W0),
              ("T_plus_0.01", T0 + .01, W0), ("W_minus_0.05", T0, W0 - .05),
              ("W_plus_0.05", T0, W0 + .05)]
    rows = []
    for name, T, W in points:
        static = static_check(T, W, skew, edges, hold_margin)
        # This is the ver.1 MIN_DELAY dynamic check.  It is intentionally a
        # separate diagnostic because it only observes transitions generated
        # by one deterministic seed, whereas static_check covers every edge.
        h = SIM.analyze_hold(T, W, skew_vector(skew), hold_margin,
                             cycles=96, c0=24, c1=80, seed=2701)
        worst = h.get("worst") or {}
        rows.append({
            "point": name, "T": T, "W": W,
            "static_pass": static["pass"],
            "static_min_hold_slack_ns": static["min_hold_slack_ns"],
            "dynamic_pass": bool(h["pass"]),
            "dynamic_min_slack_ns": h.get("min_slack"),
            "dynamic_worst_edge": f"{worst.get('src', '')}->{worst.get('dst', '')}",
            "dynamic_seed": 2701,
        })
    return rows


def hold_margin_sensitivity(T: float, W: float, skew: Mapping[str, float],
                            edges: Sequence[Mapping[str, float]]) -> List[dict]:
    """Recheck the nominal schedule for several requested hold margins.

    This is a static requirement sweep.  The dynamic column is deliberately
    kept as a supplementary observation using the same min-delay transitions
    and seed for each requested margin.
    """
    rows = []
    for margin in (0.0, 0.05, 0.10, 0.20, 0.30):
        static = static_check(T, W, skew, edges, margin)
        dynamic = SIM.analyze_hold(T, W, skew_vector(skew), margin,
                                   cycles=96, c0=24, c1=80, seed=2701)
        worst = dynamic.get("worst") or {}
        rows.append({
            "hold_margin_ns": margin,
            "static_pass": static["pass"],
            "static_min_hold_slack_ns": static["min_hold_slack_ns"],
            "dynamic_pass": bool(dynamic["pass"]),
            "dynamic_min_slack_ns": dynamic.get("min_slack"),
            "dynamic_worst_edge": f"{worst.get('src', '')}->{worst.get('dst', '')}",
            "dynamic_seed": 2701,
        })
    return rows


def _write_csv(path: Path, rows: Sequence[Mapping[str, object]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if not rows:
        path.write_text("", encoding="utf-8")
        return
    fields = list(rows[0].keys())
    with path.open("w", encoding="utf-8", newline="") as fh:
        writer = csv.DictWriter(fh, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def run_all(output_dir: Path = RESULTS_DIR, include_grid: bool = True,
            include_perturbation: bool = True) -> dict:
    output_dir.mkdir(parents=True, exist_ok=True)
    edges = load_edges()
    sol = load_solution()
    T0, W0, skew, hold_margin = sol["T"], sol["W"], sol["skew"], sol["hold_margin"]
    nominal_static = static_check(T0, W0, skew, edges, hold_margin)
    nominal = pattern_results(T0, W0, skew)
    _write_csv(output_dir / "pattern_results.csv", nominal)

    grid = grid_results(T0, W0, skew, edges, hold_margin) if include_grid else []
    if include_grid:
        _write_csv(output_dir / "boundary_grid.csv", grid)
    perturb = perturbation_results(T0, W0, skew, edges, hold_margin) if include_perturbation else []
    if include_perturbation:
        _write_csv(output_dir / "perturbation.csv", perturb)
    holds = hold_sensitivity(T0, W0, skew, edges, hold_margin)
    _write_csv(output_dir / "hold_sensitivity.csv", holds)
    hold_requirements = hold_margin_sensitivity(T0, W0, skew, edges)
    _write_csv(output_dir / "hold_margin_sensitivity.csv", hold_requirements)

    edge_hash = hashlib.sha256((V2_DIR / "data" / "s27_edges.csv").read_bytes()).hexdigest()
    summary = {
        "version": "ver.3",
        "model": "ver.1 event simulator with XOR timing-graph behavior",
        "v1_sim": str(V1_SIM),
        "v2_edges": str(V2_DIR / "data" / "s27_edges.csv"),
        "edge_data_sha256": edge_hash,
        "period_ns": T0,
        "window_ns": W0,
        "skews_ns": skew,
        "hold_margin_ns": hold_margin,
        "float_tolerance_ns": TOL,
        "nominal_static": {k: v for k, v in nominal_static.items() if k != "details"},
        "nominal_patterns": 256,
        "nominal_behavior_pass_count": sum(int(x["pass"]) for x in nominal),
        "nominal_behavior_pass_rate": sum(int(x["pass"]) for x in nominal) / len(nominal),
        "nominal_min_state_match": min(x["state_match"] for x in nominal),
        "boundary_grid_points": len(grid),
        "boundary_grid_behavior_patterns": len(REPRESENTATIVE_PATTERNS),
        "boundary_grid_static_pass_count": sum(int(x["static_pass"]) for x in grid),
        "boundary_grid_behavior_pass_points": sum(int(x["behavior_pass_rate"] >= 0.995) for x in grid),
        "perturbation_points": len(perturb),
        "perturbation_valid_points": sum(int(x["delay_range_valid"]) for x in perturb),
        "perturbation_static_pass_count": sum(int(x["static_pass"]) for x in perturb),
        "perturbation_valid_static_pass_count": sum(
            int(x["delay_range_valid"] and x["static_pass"]) for x in perturb
        ),
        "perturbation_invalid_points": sum(
            int(not x["delay_range_valid"]) for x in perturb
        ),
        "boundary_grid_classification": dict(
            Counter(x["classification"] for x in grid)
        ),
        "hold_margin_points": len(hold_requirements),
        "files": {
            "pattern_results": "pattern_results.csv",
            "boundary_grid": "boundary_grid.csv",
            "perturbation": "perturbation.csv",
            "hold_sensitivity": "hold_sensitivity.csv",
            "hold_margin_sensitivity": "hold_margin_sensitivity.csv",
        },
    }
    (output_dir / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return summary


def main(argv: Sequence[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--output-dir", type=Path, default=RESULTS_DIR)
    ap.add_argument("--skip-grid", action="store_true")
    ap.add_argument("--skip-perturbation", action="store_true")
    args = ap.parse_args(argv)
    summary = run_all(args.output_dir, not args.skip_grid, not args.skip_perturbation)
    print(json.dumps(summary, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
