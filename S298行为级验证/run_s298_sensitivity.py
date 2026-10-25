#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""S298 delay-interval sensitivity and retuning experiment.

The experiment mirrors the S27 ver.4 question: after Dmax/Dmin change, does
the original schedule remain valid, and can an offline re-optimization find a
new valid schedule?  It is intentionally separate from ``run_s298_v1.py`` so
the nominal reproduction remains easy to audit.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import importlib.util
import json
import math
import sys
from pathlib import Path
from typing import Mapping, Sequence


HERE = Path(__file__).resolve().parent
RESULTS_DIR = HERE / "results"
TOL = 1.0e-7
FACTORS = (-0.10, -0.05, 0.0, 0.05, 0.10)
REPRESENTATIVE_PATTERNS = (0, 1, 3, 15, 51, 85, 127, 128,
                            170, 192, 204, 240, 254, 255)
BEHAVIOR_CYCLES = 64


def load_v1():
    spec = importlib.util.spec_from_file_location("s298_v1_for_sensitivity", HERE / "run_s298_v1.py")
    if spec is None or spec.loader is None:
        raise ImportError("cannot load run_s298_v1.py")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


V1 = load_v1()


def scale_edges(edges: Sequence[object], dmax_factor: float, dmin_factor: float):
    """Return copied Edge records with independently scaled delay bounds."""
    return [V1.Edge(
        edge.source,
        edge.target,
        edge.max_delay * (1.0 + dmax_factor),
        edge.min_delay * (1.0 + dmin_factor),
    ) for edge in edges]


def invalid_edges(edges: Sequence[object]) -> list[str]:
    return [f"{edge.source}->{edge.target}"
            for edge in edges if edge.min_delay > edge.max_delay + TOL]


def static_summary(edges: Sequence[object], solution: Mapping[str, object]) -> dict[str, object]:
    T = float(solution["T"])
    W = float(solution["W"])
    skews = solution["skews"]
    rows = V1.static_slacks(edges, skews, T, W, V1.HOLD_MARGIN_NS)
    minimum = min(min(float(row["setup_slack_ns"]),
                      float(row["extended_setup_slack_ns"]),
                      float(row["hold_slack_ns"])) for row in rows)
    parameter_valid = math.isfinite(T + W) and T > 0 and W >= -TOL and W <= T / 2.0 + TOL
    return {
        "static_min_slack_ns": minimum,
        "parameter_valid": parameter_valid,
        "static_pass": bool(parameter_valid and minimum >= -TOL),
        "worst_edge": min(
            rows,
            key=lambda row: min(float(row["setup_slack_ns"]),
                                float(row["extended_setup_slack_ns"]),
                                float(row["hold_slack_ns"])),
        ),
    }


def behavior_summary(edges: Sequence[object], solution: Mapping[str, object]) -> dict[str, object]:
    results = [V1.run_xor_behavior(
        edges, float(solution["T"]), float(solution["W"]), solution["skews"],
        mask, cycles=BEHAVIOR_CYCLES
    ) for mask in REPRESENTATIVE_PATTERNS]
    return {
        "patterns": len(results),
        "pass_count": sum(int(item["pass"]) for item in results),
        "pass_rate": sum(int(item["pass"]) for item in results) / len(results),
        "min_state_match": min(float(item["state_match"]) for item in results),
        "io_failures": sum(int(not item["io_ok"]) for item in results),
    }


def clean(value: float) -> float:
    return 0.0 if abs(value) < 5e-10 else round(value, 9)


def run(output_dir: Path = RESULTS_DIR, include_behavior: bool = True) -> dict[str, object]:
    output_dir.mkdir(parents=True, exist_ok=True)
    nominal_edges = V1.read_edges()
    nominal_solution = V1.optimize(nominal_edges)
    fixed_solution = {
        "T": nominal_solution["T"], "W": nominal_solution["W"],
        "skews": nominal_solution["skews"],
    }
    rows: list[dict[str, object]] = []
    invalid_rows: list[dict[str, object]] = []
    retuned_details: list[dict[str, object]] = []

    for dmax_factor in FACTORS:
        for dmin_factor in FACTORS:
            perturbed = scale_edges(nominal_edges, dmax_factor, dmin_factor)
            bad = invalid_edges(perturbed)
            label = f"dmax_{dmax_factor:+.2f}_dmin_{dmin_factor:+.2f}"
            base = {
                "case": label,
                "dmax_factor": dmax_factor,
                "dmin_factor": dmin_factor,
                "delay_range_valid": not bad,
                "invalid_edge_count": len(bad),
                "invalid_edges": ";".join(bad),
                "fixed_T_ns": clean(float(fixed_solution["T"])),
                "fixed_W_ns": clean(float(fixed_solution["W"])),
                "fixed_skews_json": json.dumps(fixed_solution["skews"], sort_keys=True),
            }
            if bad:
                invalid_rows.append({
                    "case": label,
                    "dmax_factor": dmax_factor,
                    "dmin_factor": dmin_factor,
                    "invalid_edge_count": len(bad),
                    "invalid_edges": ";".join(bad),
                })
                base.update({
                    "fixed_static_pass": False,
                    "fixed_behavior_pass_count": "",
                    "fixed_behavior_patterns": "",
                    "retuned_T_ns": "", "retuned_W_ns": "",
                    "retuned_skews_json": "",
                    "retuned_static_pass": False,
                    "retuned_static_min_slack_ns": "",
                    "retuned_behavior_pass_count": "",
                    "retuned_behavior_patterns": "",
                })
                rows.append(base)
                continue

            fixed_static = static_summary(perturbed, fixed_solution)
            fixed_behavior = behavior_summary(perturbed, fixed_solution) if include_behavior else {}
            retuned = V1.optimize(perturbed)
            retuned_static = static_summary(perturbed, retuned)
            retuned_behavior = behavior_summary(perturbed, retuned) if include_behavior else {}
            retuned_details.append({
                "case": label,
                "dmax_factor": dmax_factor,
                "dmin_factor": dmin_factor,
                "period_ns": clean(float(retuned["T"])),
                "window_ns": clean(float(retuned["W"])),
                "skews_ns": {key: clean(float(value)) for key, value in retuned["skews"].items()},
            })
            base.update({
                "fixed_static_pass": fixed_static["static_pass"],
                "fixed_static_min_slack_ns": clean(float(fixed_static["static_min_slack_ns"])),
                "fixed_worst_edge": f"{fixed_static['worst_edge']['source']}->{fixed_static['worst_edge']['target']}",
                "fixed_behavior_pass_count": fixed_behavior.get("pass_count", ""),
                "fixed_behavior_patterns": fixed_behavior.get("patterns", ""),
                "retuned_T_ns": clean(float(retuned["T"])),
                "retuned_W_ns": clean(float(retuned["W"])),
                "retuned_skews_json": json.dumps(
                    {key: clean(float(value)) for key, value in retuned["skews"].items()},
                    sort_keys=True,
                ),
                "retuned_static_pass": retuned_static["static_pass"],
                "retuned_static_min_slack_ns": clean(float(retuned_static["static_min_slack_ns"])),
                "retuned_worst_edge": f"{retuned_static['worst_edge']['source']}->{retuned_static['worst_edge']['target']}",
                "retuned_behavior_pass_count": retuned_behavior.get("pass_count", ""),
                "retuned_behavior_patterns": retuned_behavior.get("patterns", ""),
            })
            rows.append(base)

    fields = list(rows[0].keys())
    with (output_dir / "sensitivity.csv").open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)
    invalid_fields = list(invalid_rows[0].keys()) if invalid_rows else [
        "case", "dmax_factor", "dmin_factor", "invalid_edge_count", "invalid_edges"
    ]
    with (output_dir / "invalid_perturbations.csv").open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=invalid_fields)
        writer.writeheader()
        writer.writerows(invalid_rows)
    (output_dir / "retuned_solutions.json").write_text(
        json.dumps(retuned_details, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )

    valid_rows = [row for row in rows if row["delay_range_valid"]]
    summary = {
        "version": "S298-sensitivity-v1",
        "hold_margin_ns": V1.HOLD_MARGIN_NS,
        "factors": list(FACTORS),
        "total_cases": len(rows),
        "valid_cases": len(valid_rows),
        "invalid_cases": len(invalid_rows),
        "fixed_static_pass_count": sum(int(row["fixed_static_pass"]) for row in valid_rows),
        "retuned_static_pass_count": sum(int(row["retuned_static_pass"]) for row in valid_rows),
        "behavior_patterns": len(REPRESENTATIVE_PATTERNS) if include_behavior else 0,
        "fixed_behavior_pass_total": sum(int(row["fixed_behavior_pass_count"]) for row in valid_rows) if include_behavior else None,
        "retuned_behavior_pass_total": sum(int(row["retuned_behavior_pass_count"]) for row in valid_rows) if include_behavior else None,
        "edge_data_sha256": hashlib.sha256(V1.EDGE_FILE.read_bytes()).hexdigest(),
        "files": {
            "sensitivity": "sensitivity.csv",
            "invalid_perturbations": "invalid_perturbations.csv",
            "retuned_solutions": "retuned_solutions.json",
        },
    }
    (output_dir / "sensitivity_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    return summary


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, default=RESULTS_DIR)
    parser.add_argument("--skip-behavior", action="store_true")
    args = parser.parse_args()
    print(json.dumps(run(args.output_dir.resolve(), not args.skip_behavior), ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
