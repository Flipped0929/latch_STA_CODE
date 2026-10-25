#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""S298 first generic theory reproduction.

This script reuses the difference-constraint model from S27, but checks a
fixed ``(T, W)`` using Bellman--Ford.  Parallel timing arcs are collapsed to
the minimum weight because that constraint dominates the other parallel arcs.
The model has an important monotonicity property: increasing ``W`` relaxes
extended setup but tightens hold, while the ordinary setup constraint is
unchanged.  Therefore a feasible point at ``W > 0`` is also feasible at
``W = 0`` for the same ``T``.  We can safely binary-search the minimum period
at ``W = 0`` and then the largest feasible window at that period.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import heapq
import json
import math
from dataclasses import dataclass
from pathlib import Path
from typing import Mapping, Sequence


HERE = Path(__file__).resolve().parent
EDGE_FILE = HERE / "data" / "s298_edges.csv"
TAP_FILE = HERE / "data" / "s298_output_taps.csv"
RESULTS_DIR = HERE / "results"
HOLD_MARGIN_NS = 0.10
TOL = 1e-8
NOMINAL_GOLD_T = 100.0


@dataclass(frozen=True)
class Edge:
    source: str
    target: str
    max_delay: float
    min_delay: float


def read_edges(path: Path = EDGE_FILE) -> list[Edge]:
    rows: list[Edge] = []
    with path.open(newline="", encoding="utf-8") as stream:
        for row in csv.DictReader(stream):
            rows.append(Edge(row["source"], row["target"],
                             float(row["max_delay_ns"]), float(row["min_delay_ns"])))
    if not rows:
        raise ValueError("edge table is empty")
    if any(e.min_delay < 0 or e.min_delay > e.max_delay for e in rows):
        raise ValueError("invalid Dmin/Dmax interval")
    return rows


def nodes_of(edges: Sequence[Edge]) -> list[str]:
    nodes = sorted({e.source for e in edges} | {e.target for e in edges})
    if "IO" not in nodes:
        raise ValueError("edge table must contain IO")
    return nodes


def arc_candidates(edge: Edge, T: float, W: float, hold: float) -> tuple[tuple[float, str], ...]:
    pair = f"{edge.source}->{edge.target}"
    return (
        (T - edge.max_delay, f"setup:{pair}"),
        (T + W - edge.max_delay, f"extended_setup:{pair}"),
        (edge.min_delay - hold - W, f"hold:{pair}"),
    )


def collapsed_arcs(edges: Sequence[Edge], T: float, W: float,
                   hold: float) -> list[tuple[str, str, float, str]]:
    """Keep the lowest-weight parallel timing arc for every directed edge."""
    result: dict[tuple[str, str], tuple[float, str]] = {}
    for edge in edges:
        candidates = arc_candidates(edge, T, W, hold)
        for source, target, (weight, name) in (
            (edge.target, edge.source, candidates[0]),
            (edge.target, edge.source, candidates[1]),
            (edge.source, edge.target, candidates[2]),
        ):
            key = (source, target)
            if key not in result or weight < result[key][0]:
                result[key] = (weight, name)
    return [(source, target, weight, name)
            for (source, target), (weight, name) in result.items()]


def feasible_potentials(edges: Sequence[Edge], nodes: Sequence[str], T: float,
                        W: float, hold: float) -> tuple[bool, dict[str, float], list[tuple[str, str, float, str]]]:
    """Check all parallel timing arcs through a negative-cycle test."""
    arcs = collapsed_arcs(edges, T, W, hold)
    distance = {node: 0.0 for node in nodes}
    predecessor: dict[str, tuple[str, str] | None] = {node: None for node in nodes}
    for iteration in range(len(nodes)):
        changed = False
        for source, target, weight, name in arcs:
            candidate = distance[source] + weight
            if distance[target] > candidate + TOL:
                distance[target] = candidate
                predecessor[target] = (source, name)
                changed = True
        if not changed:
            baseline = distance["IO"]
            return True, {node: distance[node] - baseline for node in nodes}, arcs
        if iteration == len(nodes) - 1:
            return False, {}, arcs
    return False, {}, arcs


def static_slacks(edges: Sequence[Edge], skews: Mapping[str, float], T: float,
                  W: float, hold: float) -> list[dict[str, object]]:
    rows = []
    for edge in edges:
        su, sv = skews[edge.source], skews[edge.target]
        rows.append({
            "source": edge.source, "target": edge.target,
            "max_delay_ns": edge.max_delay, "min_delay_ns": edge.min_delay,
            "setup_slack_ns": T - edge.max_delay - su + sv,
            "extended_setup_slack_ns": T + W - edge.max_delay - su + sv,
            "hold_slack_ns": edge.min_delay - hold - W + su - sv,
        })
    return rows


def optimize(edges: Sequence[Edge], hold: float = HOLD_MARGIN_NS,
             period_tolerance: float = 1e-7) -> dict:
    nodes = nodes_of(edges)
    # At W=0, setup is the strongest setup condition and hold is easiest.
    # Thus feasibility in T is monotonic and can be binary-searched.
    low, high = 0.0, max(e.max_delay for e in edges) + 1.0
    for _ in range(80):
        if feasible_potentials(edges, nodes, high, 0.0, hold)[0]:
            break
        high *= 2.0
    else:
        raise RuntimeError("no feasible period found; a hold-only negative cycle may exist")
    for _ in range(70):
        mid = (low + high) / 2.0
        if feasible_potentials(edges, nodes, mid, 0.0, hold)[0]:
            high = mid
        else:
            low = mid
    T = high
    # At fixed T, W is feasible from zero up to its hold-limited upper bound.
    if not feasible_potentials(edges, nodes, T, 0.0, hold)[0]:
        raise RuntimeError("period search did not reach a feasible point")
    lo, hi = 0.0, T / 2.0
    for _ in range(70):
        mid = (lo + hi) / 2.0
        if feasible_potentials(edges, nodes, T, mid, hold)[0]:
            lo = mid
        else:
            hi = mid
    W = lo
    ok, skews, _ = feasible_potentials(edges, nodes, T, W, hold)
    if not ok:
        raise RuntimeError("window search did not reach a feasible point")
    rows = static_slacks(edges, skews, T, W, hold)
    minimum = min(min(float(r["setup_slack_ns"]), float(r["extended_setup_slack_ns"]),
                       float(r["hold_slack_ns"])) for r in rows)
    worst = min(rows, key=lambda r: min(float(r["setup_slack_ns"]),
                                         float(r["extended_setup_slack_ns"]),
                                         float(r["hold_slack_ns"])))
    # Report numerical boundary values cleanly.  Bellman--Ford uses ``TOL``
    # while comparing relaxations, so a boundary slack can be a tiny negative
    # value such as -1e-8 even though it is accepted by the model.
    if abs(minimum) <= 2.0 * TOL:
        minimum = 0.0
    if abs(W) <= 2.0 * TOL:
        W = 0.0
    return {"T": T, "W": W, "skews": skews, "nodes": len(nodes),
            "edges": len(edges), "minimum_edge_slack": minimum,
            "window_slack": T / 2.0 - W,
            "worst_edge": f"{worst['source']}->{worst['target']}",
            "edge_slacks": rows,
            "period_tolerance_ns": period_tolerance,
            "method": "collapsed-parallel-arcs Bellman-Ford + binary search"}


def periodic_stim(mask: int, cycles: int, width: int = 8) -> list[int]:
    bits = [(mask >> i) & 1 for i in range(width)]
    return [bits[i % width] for i in range(cycles + 64)]


def run_xor_behavior(edges: Sequence[Edge], T: float, W: float,
                     skews: Mapping[str, float], mask: int,
                     cycles: int = 64, gold_t: float = NOMINAL_GOLD_T) -> dict:
    """Small deterministic XOR timing-graph cross-check for S298.

    Outputs are intentionally excluded from the state graph.  This is a
    graph-level abstraction, not reconstruction of the original gate logic.
    """
    import bisect
    # Keep IO first in the event queue, matching the S27 reference simulator.
    # This matters when several zero-window open/close events share a time:
    # the input transition must be visible before internal latches sample it.
    all_nodes = nodes_of(edges)
    nodes = ["IO"] + [n for n in all_nodes if n != "IO"]
    state_nodes = [n for n in nodes if n != "IO"]
    fanin = {n: [] for n in nodes}; fanout = {n: [] for n in nodes}
    for e in edges:
        fanin[e.target].append(e); fanout[e.source].append(e)
    for n in nodes:
        fanin[n].sort(key=lambda e: (e.source, e.target))
    stim = periodic_stim(mask, cycles + 80)
    def simulate(period: float, run_cycles: int):
        # A negative skew can open a latch before t=-1.  The initial value
        # must therefore live at -infinity, keeping each history sorted and
        # making every pre-transition read return the initial zero value.
        times = {n: [float("-inf")] for n in nodes}; vals = {n: [0] for n in nodes}; out = {n: 0 for n in nodes}
        caps = {n: [] for n in nodes}; opens = {n: False for n in nodes}; heap = []; seq = 0
        def push(t, priority, kind, node):
            nonlocal seq; seq += 1; heapq.heappush(heap, (t, priority, seq, kind, node))
        for c in range(run_cycles):
            for n in nodes:
                o = (float(skews.get(n, 0.0)) + c * period)
                push(o, 1, "open", n); push(o + W, 2, "close", n)
        def value(n, t):
            return vals[n][bisect.bisect_right(times[n], t + 1e-6) - 1]
        def evaluate(n, t):
            if n == "IO": return stim[max(0, min(len(stim)-1, int(math.floor(t / period + 1e-9))))]
            result = 0
            for e in fanin[n]: result ^= value(e.source, t - e.max_delay)
            return result
        def change(n, t, v):
            if v == out[n]: return
            out[n] = v; times[n].append(t); vals[n].append(v)
            for e in fanout[n]: push(t + e.max_delay, 0, "arrive", e.target)
        while heap:
            t, _, _, kind, n = heapq.heappop(heap)
            if kind == "open": opens[n] = True; change(n, t, evaluate(n, t))
            elif kind == "arrive":
                if opens[n]: change(n, t, evaluate(n, t))
            else:
                opens[n] = False
                caps[n].append(evaluate(n, t))
        return caps
    fast, gold = simulate(T, cycles), simulate(gold_t, cycles + 32)
    c0, c1 = cycles // 4, cycles - 8
    best = 0.0; best_off = None
    for off in range(-4, 25):
        vals = []
        for n in state_nodes:
            samples = [(fast[n][c], gold[n][c + off])
                       for c in range(c0, c1)] if 0 <= c0 + off < c1 + off <= len(gold[n]) else []
            vals.append(sum(a == b for a, b in samples) / len(samples)
                        if samples else 0.0)
        score = min(vals) if vals else 0.0
        if score > best: best, best_off = score, off
    # IO is checked independently against the original stimulus; it is not
    # an internal state node and must not inflate the state-match score.
    io_ok = all(fast_io == stim[c]
                for c, fast_io in enumerate(fast["IO"][:cycles]))
    return {"mask": mask, "pass": bool(best >= 0.995 and io_ok),
            "state_match": best, "io_ok": io_ok, "offset": best_off,
            "cycles": cycles, "node_count": len(nodes),
            "state_node_count": len(state_nodes)}


def write_csv(path: Path, rows: Sequence[Mapping[str, object]], fields: Sequence[str]) -> None:
    with path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields); writer.writeheader(); writer.writerows(rows)


def run(output_dir: Path = RESULTS_DIR) -> dict:
    edges = read_edges(); result = optimize(edges)
    output_dir.mkdir(parents=True, exist_ok=True)
    edge_rows = result.pop("edge_slacks")
    write_csv(output_dir / "edge_slacks.csv", edge_rows,
              ["source", "target", "max_delay_ns", "min_delay_ns", "setup_slack_ns",
               "extended_setup_slack_ns", "hold_slack_ns"])
    representative_patterns = (0, 1, 3, 15, 51, 85, 127, 128,
                                170, 192, 204, 240, 254, 255)
    behavior = [run_xor_behavior(edges, result["T"], result["W"], result["skews"], m)
                for m in representative_patterns]
    (output_dir / "behavior_crosscheck.json").write_text(
        json.dumps(behavior, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    tap_count = max(0, sum(1 for _ in TAP_FILE.open(encoding="utf-8")) - 1) if TAP_FILE.exists() else 0
    summary = {"version": "S298-v1", "circuit": "s298", "model_scope": "S27-v2-style internal-edge ELL migration",
               "output_taps_feedback": False, "hold_margin_ns": HOLD_MARGIN_NS,
               "period_ns": result["T"], "window_ns": result["W"], "skews_ns": result["skews"],
               "node_count": result["nodes"], "edge_count": result["edges"],
               "minimum_edge_slack_ns": result["minimum_edge_slack"],
               "window_slack_ns": result["window_slack"], "worst_edge": result["worst_edge"],
               "method": result["method"], "edge_data_sha256": hashlib.sha256(EDGE_FILE.read_bytes()).hexdigest(),
               "output_tap_count": tap_count,
               "output_tap_data_sha256": hashlib.sha256(TAP_FILE.read_bytes()).hexdigest() if TAP_FILE.exists() else "",
               "original_cpp_reference_baseline_ns": 11.364250421524048,
               "behavior_patterns": len(behavior), "behavior_pass_count": sum(int(x["pass"]) for x in behavior),
               "files": {"edges": "../data/s298_edges.csv", "edge_slacks": "edge_slacks.csv",
                         "behavior": "behavior_crosscheck.json",
                         "original_cpp_reference": "original_cpp_reference.csv"}}
    (output_dir / "summary.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return summary


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, default=RESULTS_DIR)
    args = parser.parse_args(); print(json.dumps(run(args.output_dir), ensure_ascii=False, indent=2))


if __name__ == "__main__": main()
