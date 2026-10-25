#!/usr/bin/env python3
"""Jointly optimize S27 latch period and transparency window."""

from __future__ import annotations

import argparse
import csv
import hashlib
import itertools
import json
import math
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable


ROOT = Path(__file__).resolve().parent
DEFAULT_EDGE_FILE = ROOT / "data" / "s27_edges.csv"
DEFAULT_RESULTS_DIR = ROOT / "results"
HOLD_MARGIN_NS = 0.10
TOL = 1e-8


@dataclass(frozen=True)
class DelayEdge:
    source: str
    target: str
    max_delay: float
    min_delay: float


@dataclass(frozen=True)
class Constraint:
    """Half-plane a*T + b*W >= c."""

    a: float
    b: float
    c: float
    name: str


@dataclass(frozen=True)
class GraphArc:
    source: str
    target: str
    mode: str
    a: float
    b: float
    c: float
    name: str


def read_edges(path: Path) -> list[DelayEdge]:
    edges: list[DelayEdge] = []
    with path.open(newline="", encoding="utf-8") as stream:
        reader = csv.DictReader(stream)
        required = {"source", "target", "max_delay_ns", "min_delay_ns"}
        if reader.fieldnames is None or not required.issubset(reader.fieldnames):
            raise ValueError(f"{path} must contain columns {sorted(required)}")
        for row_number, row in enumerate(reader, start=2):
            source = row["source"].strip()
            target = row["target"].strip()
            dmax = float(row["max_delay_ns"])
            dmin = float(row["min_delay_ns"])
            if not source or not target or not math.isfinite(dmax + dmin):
                raise ValueError(f"invalid edge on CSV row {row_number}")
            if dmin < 0 or dmax < dmin:
                raise ValueError(f"invalid delay range on CSV row {row_number}")
            edges.append(DelayEdge(source, target, dmax, dmin))
    if not edges:
        raise ValueError("the edge file is empty")
    return edges


def make_arcs(edges: Iterable[DelayEdge], hold_margin: float) -> list[GraphArc]:
    arcs: list[GraphArc] = []
    for edge in edges:
        pair = f"{edge.source}->{edge.target}"
        # ELL difference constraints: setup, extended setup, and hold.
        arcs.append(GraphArc(edge.target, edge.source, "setup", 1.0, 0.0,
                             edge.max_delay, f"setup:{pair}"))
        arcs.append(GraphArc(edge.target, edge.source, "extended_setup", 1.0, 1.0,
                             edge.max_delay, f"extended_setup:{pair}"))
        arcs.append(GraphArc(edge.source, edge.target, "hold", 0.0, -1.0,
                             hold_margin - edge.min_delay, f"hold:{pair}"))
    return arcs


def enumerate_simple_cycles(nodes: list[str], arcs: list[GraphArc]) -> list[list[GraphArc]]:
    outgoing: dict[str, list[GraphArc]] = {node: [] for node in nodes}
    order = {node: index for index, node in enumerate(nodes)}
    for arc in arcs:
        outgoing[arc.source].append(arc)

    cycles: list[list[GraphArc]] = []
    for start_index, start in enumerate(nodes):
        def visit(current: str, visited: set[str], path: list[GraphArc]) -> None:
            for arc in outgoing[current]:
                nxt = arc.target
                if nxt == start:
                    cycles.append(path + [arc])
                elif nxt not in visited and order[nxt] >= start_index:
                    visit(nxt, visited | {nxt}, path + [arc])

        visit(start, {start}, [])
    return cycles


def build_constraints(nodes: list[str], arcs: list[GraphArc]) -> tuple[list[Constraint], list[list[GraphArc]]]:
    cycles = enumerate_simple_cycles(nodes, arcs)
    constraints = [
        Constraint(1.0, 0.0, 0.0, "T>=0"),
        Constraint(0.0, 1.0, 0.0, "W>=0"),
        Constraint(1.0, -2.0, 0.0, "W<=T/2"),
    ]
    for cycle in cycles:
        a = sum(arc.a for arc in cycle)
        b = sum(arc.b for arc in cycle)
        c = sum(arc.c for arc in cycle)
        label = " | ".join(arc.name for arc in cycle)
        constraints.append(Constraint(a, b, c, label))
    return constraints, cycles


def satisfies(point: tuple[float, float], constraints: list[Constraint], tol: float = TOL) -> bool:
    t_value, w_value = point
    return all(item.a * t_value + item.b * w_value >= item.c - tol for item in constraints)


def solve_min_period(constraints: list[Constraint]) -> tuple[float, float]:
    candidates: list[tuple[float, float]] = []
    for first, second in itertools.combinations(constraints, 2):
        determinant = first.a * second.b - second.a * first.b
        if abs(determinant) <= 1e-12:
            continue
        t_value = (first.c * second.b - second.c * first.b) / determinant
        w_value = (first.a * second.c - second.a * first.c) / determinant
        if math.isfinite(t_value + w_value) and satisfies((t_value, w_value), constraints):
            candidates.append((t_value, w_value))
    if not candidates:
        raise ValueError("no feasible finite solution found")
    # Primary objective: minimize T. Secondary objective: maximize W.
    best_t = min(point[0] for point in candidates)
    best_w = max(point[1] for point in candidates if abs(point[0] - best_t) <= 1e-9)
    return best_t, best_w


def arc_weight(arc: GraphArc, t_value: float, w_value: float) -> float:
    return arc.a * t_value + arc.b * w_value - arc.c


def find_potentials(nodes: list[str], arcs: list[GraphArc], t_value: float,
                    w_value: float, reference: str = "IO") -> dict[str, float]:
    """Return feasible difference-constraint potentials, normalized at IO."""
    distance = {node: 0.0 for node in nodes}
    for iteration in range(len(nodes)):
        changed = False
        for arc in arcs:
            candidate = distance[arc.source] + arc_weight(arc, t_value, w_value)
            if distance[arc.target] > candidate + 1e-10:
                distance[arc.target] = candidate
                changed = True
        if not changed:
            break
        if iteration == len(nodes) - 1:
            raise ValueError("negative cycle remains at the reported solution")
    baseline = distance[reference]
    return {node: distance[node] - baseline for node in nodes}


def compute_edge_slacks(edges: list[DelayEdge], skews: dict[str, float],
                        t_value: float, w_value: float,
                        hold_margin: float) -> list[dict[str, float | str]]:
    rows: list[dict[str, float | str]] = []
    for edge in edges:
        source_skew = skews[edge.source]
        target_skew = skews[edge.target]
        setup_slack = t_value - edge.max_delay - source_skew + target_skew
        extended_setup_slack = t_value + w_value - edge.max_delay - source_skew + target_skew
        hold_slack = edge.min_delay - hold_margin - w_value + source_skew - target_skew
        rows.append({
            "source": edge.source,
            "target": edge.target,
            "max_delay_ns": edge.max_delay,
            "min_delay_ns": edge.min_delay,
            "setup_slack_ns": setup_slack,
            "extended_setup_slack_ns": extended_setup_slack,
            "hold_slack_ns": hold_slack,
        })
    return rows


def write_csv(path: Path, rows: list[dict[str, object]], fieldnames: list[str]) -> None:
    with path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def clean_number(value: float) -> float:
    if abs(value) < 5e-10:
        return 0.0
    return round(value, 9)


def run(edge_path: Path, results_dir: Path, hold_margin: float) -> dict[str, object]:
    edges = read_edges(edge_path)
    nodes = sorted({edge.source for edge in edges} | {edge.target for edge in edges})
    if "IO" not in nodes:
        raise ValueError("the graph must include the IO reference node")
    arcs = make_arcs(edges, hold_margin)
    constraints, cycles = build_constraints(nodes, arcs)
    t_value, w_value = solve_min_period(constraints)
    skews = find_potentials(nodes, arcs, t_value, w_value)
    edge_slacks = compute_edge_slacks(edges, skews, t_value, w_value, hold_margin)

    minimum_slack = min(
        min(float(row["setup_slack_ns"]), float(row["extended_setup_slack_ns"]),
            float(row["hold_slack_ns"]))
        for row in edge_slacks
    )
    if minimum_slack < -1e-7:
        raise ValueError(f"reported skew schedule violates a constraint by {-minimum_slack:.3g} ns")

    active_cycles: list[dict[str, object]] = []
    for cycle in cycles:
        lhs = sum(arc.a * t_value + arc.b * w_value for arc in cycle)
        rhs = sum(arc.c for arc in cycle)
        slack = lhs - rhs
        if abs(slack) <= 1e-7:
            active_cycles.append({
                "cycle": " | ".join(arc.name for arc in cycle),
                "period_coefficient": sum(arc.a for arc in cycle),
                "window_coefficient": sum(arc.b for arc in cycle),
                "required_ns": clean_number(rhs),
                "actual_ns": clean_number(lhs),
                "slack_ns": clean_number(slack),
            })

    digest = hashlib.sha256(edge_path.read_bytes()).hexdigest()
    summary: dict[str, object] = {
        "method": "enumerate_simple_cycles_then_solve_2d_halfplanes",
        "objective": "minimize T; among minimum-T solutions, maximize W",
        "hold_margin_ns": hold_margin,
        "period_ns": clean_number(t_value),
        "window_ns": clean_number(w_value),
        "skews_ns": {node: clean_number(skew) for node, skew in skews.items()},
        "edge_count": len(edges),
        "difference_constraint_arc_count": len(arcs),
        "simple_cycle_count": len(cycles),
        "active_cycle_count": len(active_cycles),
        "minimum_edge_slack_ns": clean_number(minimum_slack),
        "edge_data_sha256": digest,
        "edge_data_file": str(edge_path.relative_to(ROOT)) if edge_path.is_relative_to(ROOT) else str(edge_path),
    }

    results_dir.mkdir(parents=True, exist_ok=True)
    (results_dir / "summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    clean_edge_slacks = [
        {key: clean_number(value) if isinstance(value, float) else value
         for key, value in row.items()}
        for row in edge_slacks
    ]
    write_csv(
        results_dir / "edge_slacks.csv",
        clean_edge_slacks,
        ["source", "target", "max_delay_ns", "min_delay_ns", "setup_slack_ns",
         "extended_setup_slack_ns", "hold_slack_ns"],
    )
    write_csv(
        results_dir / "skews.csv",
        [{"node": node, "skew_ns": clean_number(skew)} for node, skew in skews.items()],
        ["node", "skew_ns"],
    )
    write_csv(
        results_dir / "active_cycles.csv",
        active_cycles,
        ["cycle", "period_coefficient", "window_coefficient", "required_ns",
         "actual_ns", "slack_ns"],
    )
    return summary


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--edges", type=Path, default=DEFAULT_EDGE_FILE)
    parser.add_argument("--results", type=Path, default=DEFAULT_RESULTS_DIR)
    parser.add_argument("--hold-margin", type=float, default=HOLD_MARGIN_NS)
    args = parser.parse_args()
    if args.hold_margin < 0:
        parser.error("--hold-margin must be non-negative")
    summary = run(args.edges.resolve(), args.results.resolve(), args.hold_margin)
    print(json.dumps(summary, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
