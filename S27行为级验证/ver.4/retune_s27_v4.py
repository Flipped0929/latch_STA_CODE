#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""S27 ver.4: retune the latch schedule after delay perturbations.

The experiment compares the fixed ver.2 nominal schedule with a fresh
ver.2-style optimization for each physically valid Dmax/Dmin perturbation.
It remains a timing-graph/XOR behavioral model, not a gate-level run.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import importlib.util
import json
import sys
from pathlib import Path
from typing import Mapping, Sequence


HERE = Path(__file__).resolve().parent
V2_DIR = HERE.parent / "ver.2"
V3_DIR = HERE.parent / "ver.3"
EDGE_FILE = V2_DIR / "data" / "s27_edges.csv"
V2_OPTIMIZER = V2_DIR / "optimize_s27.py"
V3_VALIDATOR = V3_DIR / "validate_s27_v3.py"
RESULTS_DIR = HERE / "results"
TOL = 1e-8
HOLD_MARGIN_NS = 0.10
FACTORS = (-0.10, -0.05, 0.0, 0.05, 0.10)
BEHAVIOR_PATTERNS: tuple[int, ...] = ()


def load_module(name: str, path: Path):
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise ImportError(f"cannot load {path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


OPT = load_module("s27_ver2_optimizer", V2_OPTIMIZER)
V3 = load_module("s27_ver3_validator", V3_VALIDATOR)
BEHAVIOR_PATTERNS = tuple(V3.REPRESENTATIVE_PATTERNS)


def read_nominal() -> tuple[list, dict]:
    edges = OPT.read_edges(EDGE_FILE)
    summary_path = V2_DIR / "results" / "summary.json"
    with summary_path.open("r", encoding="utf-8") as stream:
        summary = json.load(stream)
    solution = {
        "T": float(summary["period_ns"]),
        "W": float(summary["window_ns"]),
        "skew": {str(k): float(v) for k, v in summary["skews_ns"].items()},
        "hold_margin": float(summary.get("hold_margin_ns", HOLD_MARGIN_NS)),
    }
    return edges, solution


def skew_map(values: Mapping[str, float]) -> dict[str, float]:
    return {node: float(values[node]) for node in ("IO", "G5", "G6", "G7")}


def static_report(edges: Sequence, T: float, W: float,
                  skews: Mapping[str, float], hold_margin: float) -> dict:
    rows = OPT.compute_edge_slacks(list(edges), dict(skews), T, W, hold_margin)
    minimum = min(
        min(float(row["setup_slack_ns"]), float(row["extended_setup_slack_ns"]),
            float(row["hold_slack_ns"])) for row in rows
    )
    window_slack = T / 2.0 - W
    valid = all(edge.min_delay >= -TOL and edge.min_delay <= edge.max_delay + TOL
                for edge in edges)
    passed = valid and window_slack >= -TOL and minimum >= -TOL
    worst = min(
        ((float(row["setup_slack_ns"]), "setup", row) for row in rows),
        key=lambda item: item[0],
    )
    for mode in ("extended_setup", "hold"):
        candidate = min(
            ((float(row[f"{mode}_slack_ns"]), mode, row) for row in rows),
            key=lambda item: item[0],
        )
        if candidate[0] < worst[0]:
            worst = candidate
    return {
        "static_pass": bool(passed),
        "min_edge_slack_ns": minimum,
        "window_slack_ns": window_slack,
        "worst_constraint": worst[1],
        "worst_edge": f"{worst[2]['source']}->{worst[2]['target']}",
        "delay_range_valid": valid,
    }


def solve_retuned(edges: Sequence, hold_margin: float) -> dict:
    nodes = sorted({edge.source for edge in edges} | {edge.target for edge in edges})
    arcs = OPT.make_arcs(edges, hold_margin)
    constraints, cycles = OPT.build_constraints(nodes, arcs)
    T, W = OPT.solve_min_period(constraints)
    skews = OPT.find_potentials(nodes, arcs, T, W)
    static = static_report(edges, T, W, skews, hold_margin)
    active = []
    for cycle in cycles:
        slack = sum(arc.a * T + arc.b * W - arc.c for arc in cycle)
        if abs(slack) <= 1e-7:
            active.append(" | ".join(arc.name for arc in cycle))
    return {
        "T": T,
        "W": W,
        "skew": skew_map(skews),
        "static": static,
        "active_cycle_count": len(active),
        "active_constraints": " || ".join(active),
    }


def scaled_edges(edges: Sequence, max_factor: float, min_factor: float) -> list:
    return [OPT.DelayEdge(edge.source, edge.target,
                          edge.max_delay * (1.0 + max_factor),
                          edge.min_delay * (1.0 + min_factor))
            for edge in edges]


def edge_delay_map(edges: Sequence, use_max: bool) -> dict[tuple[str, str], float]:
    key = "max_delay" if use_max else "min_delay"
    return {(edge.source, edge.target): float(getattr(edge, key)) for edge in edges}


def behavior_summary(T: float, W: float, skew: Mapping[str, float],
                     edge_delays: Mapping[tuple[str, str], float]) -> dict:
    rows = [V3.behavior_case(T, W, skew, mask, cycles=64, c0=16, c1=56,
                             edge_delays=edge_delays)
            for mask in BEHAVIOR_PATTERNS]
    return {
        "patterns": len(rows),
        "pass_count": sum(int(row["pass"]) for row in rows),
        "pass_rate": sum(int(row["pass"]) for row in rows) / len(rows),
        "min_state_match": min(row["state_match"] for row in rows),
    }


def perturbation_rows(edges: Sequence, nominal: Mapping[str, object]) -> tuple[list[dict], list[dict]]:
    fixed_T, fixed_W = float(nominal["T"]), float(nominal["W"])
    fixed_skew = skew_map(nominal["skew"])
    hold_margin = float(nominal.get("hold_margin", HOLD_MARGIN_NS))
    fixed_behavior = {}
    retuned_rows: list[dict] = []
    invalid_rows: list[dict] = []
    for max_factor in FACTORS:
        for min_factor in FACTORS:
            edges_p = scaled_edges(edges, max_factor, min_factor)
            invalid = [edge for edge in edges_p if edge.min_delay > edge.max_delay + TOL]
            base = {
                "max_delay_factor": max_factor,
                "min_delay_factor": min_factor,
                "delay_range_valid": not invalid,
                "invalid_edge_count": len(invalid),
            }
            if invalid:
                base["invalid_edges"] = ";".join(f"{e.source}->{e.target}" for e in invalid)
                invalid_rows.append(base)
                continue
            fixed = static_report(edges_p, fixed_T, fixed_W, fixed_skew, hold_margin)
            retuned = solve_retuned(edges_p, hold_margin)
            min_delay_map = edge_delay_map(edges_p, False)
            fixed_hold = V3.dynamic_hold_for_delay(
                fixed_T, fixed_W, fixed_skew, min_delay_map, hold_margin,
                cycles=96, c0=24, c1=80, seed=2701,
            )
            retuned_hold = V3.dynamic_hold_for_delay(
                retuned["T"], retuned["W"], retuned["skew"], min_delay_map,
                hold_margin, cycles=96, c0=24, c1=80, seed=2701,
            )
            fixed_behavior_key = (max_factor, min_factor)
            fixed_behavior[fixed_behavior_key] = behavior_summary(
                fixed_T, fixed_W, fixed_skew, edge_delay_map(edges_p, True))
            retuned_behavior = behavior_summary(
                retuned["T"], retuned["W"], retuned["skew"], edge_delay_map(edges_p, True))
            row = {
                **base,
                "fixed_T_ns": fixed_T,
                "fixed_W_ns": fixed_W,
                "fixed_min_edge_slack_ns": fixed["min_edge_slack_ns"],
                "fixed_window_slack_ns": fixed["window_slack_ns"],
                "fixed_static_pass": fixed["static_pass"],
                "fixed_worst_constraint": fixed["worst_constraint"],
                "fixed_worst_edge": fixed["worst_edge"],
                "fixed_dynamic_hold_pass": fixed_hold["pass"],
                "fixed_dynamic_hold_min_slack_ns": fixed_hold["min_slack_ns"],
                "retuned_T_ns": retuned["T"],
                "retuned_W_ns": retuned["W"],
                "delta_T_ns": retuned["T"] - fixed_T,
                "delta_W_ns": retuned["W"] - fixed_W,
                "retuned_skew_IO_ns": retuned["skew"]["IO"],
                "retuned_skew_G5_ns": retuned["skew"]["G5"],
                "retuned_skew_G6_ns": retuned["skew"]["G6"],
                "retuned_skew_G7_ns": retuned["skew"]["G7"],
                "retuned_min_edge_slack_ns": retuned["static"]["min_edge_slack_ns"],
                "retuned_window_slack_ns": retuned["static"]["window_slack_ns"],
                "retuned_static_pass": retuned["static"]["static_pass"],
                "retuned_worst_constraint": retuned["static"]["worst_constraint"],
                "retuned_worst_edge": retuned["static"]["worst_edge"],
                "retuned_active_constraints": retuned["active_constraints"],
                "retuned_dynamic_hold_pass": retuned_hold["pass"],
                "retuned_dynamic_hold_min_slack_ns": retuned_hold["min_slack_ns"],
                "retuned_dynamic_hold_worst_edge": retuned_hold["worst_edge"],
                "retuned_active_cycle_count": retuned["active_cycle_count"],
                "fixed_behavior_pass_count": fixed_behavior[fixed_behavior_key]["pass_count"],
                "fixed_behavior_min_state_match": fixed_behavior[fixed_behavior_key]["min_state_match"],
                "retuned_behavior_pass_count": retuned_behavior["pass_count"],
                "retuned_behavior_min_state_match": retuned_behavior["min_state_match"],
                "behavior_patterns": len(BEHAVIOR_PATTERNS),
            }
            retuned_rows.append(row)
    return retuned_rows, invalid_rows


def write_csv(path: Path, rows: Sequence[Mapping[str, object]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if not rows:
        path.write_text("", encoding="utf-8")
        return
    with path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)


def run(output_dir: Path = RESULTS_DIR) -> dict:
    edges, nominal = read_nominal()
    rows, invalid = perturbation_rows(edges, nominal)
    output_dir.mkdir(parents=True, exist_ok=True)
    write_csv(output_dir / "retuned_sensitivity.csv", rows)
    write_csv(output_dir / "invalid_perturbations.csv", invalid)
    hold_margin = float(nominal.get("hold_margin", HOLD_MARGIN_NS))
    nominal_static = static_report(edges, nominal["T"], nominal["W"], nominal["skew"], hold_margin)
    summary = {
        "version": "ver.4",
        "method": "retune T/W/skew for each valid Dmax/Dmin perturbation",
        "hold_margin_ns": hold_margin,
        "nominal_T_ns": nominal["T"],
        "nominal_W_ns": nominal["W"],
        "nominal_skew_ns": nominal["skew"],
        "nominal_static_pass": nominal_static["static_pass"],
        "perturbation_total": len(FACTORS) ** 2,
        "valid_perturbation_count": len(rows),
        "invalid_perturbation_count": len(invalid),
        "fixed_static_pass_count": sum(int(row["fixed_static_pass"]) for row in rows),
        "retuned_static_pass_count": sum(int(row["retuned_static_pass"]) for row in rows),
        "fixed_behavior_pass_count_total": sum(row["fixed_behavior_pass_count"] for row in rows),
        "retuned_behavior_pass_count_total": sum(row["retuned_behavior_pass_count"] for row in rows),
        "fixed_dynamic_hold_pass_count": sum(int(row["fixed_dynamic_hold_pass"]) for row in rows),
        "retuned_dynamic_hold_pass_count": sum(int(row["retuned_dynamic_hold_pass"]) for row in rows),
        "edge_data_sha256": hashlib.sha256(EDGE_FILE.read_bytes()).hexdigest(),
        "files": {"retuned": "retuned_sensitivity.csv", "invalid": "invalid_perturbations.csv"},
    }
    (output_dir / "summary.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return summary


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, default=RESULTS_DIR)
    args = parser.parse_args()
    print(json.dumps(run(args.output_dir), ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
