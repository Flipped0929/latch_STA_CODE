#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Normalize the repository's s298 timing dump for the S298 reproduction.

The benchmark dump contains repeated INPUT rows and OUTPUT observation taps.
The optimizer consumes only internal timing edges, maps every INPUT source to
the common ``IO`` node, and aggregates duplicate pairs by max(Dmax)/min(Dmin).
Output taps are saved separately because they are observed but do not feed
back into the latch timing constraints.
"""

from __future__ import annotations

import argparse
import csv
import math
from collections import defaultdict
from pathlib import Path


HERE = Path(__file__).resolve().parent
DEFAULT_SOURCE = HERE.parents[1] / "benchmark" / "s298.blif.out"
DEFAULT_OUTPUT = HERE / "data"


def parse_dump(path: Path) -> tuple[dict[tuple[str, str], tuple[float, float]],
                                  dict[tuple[str, str], tuple[float, float]]]:
    internal: dict[tuple[str, str], list[float]] = {}
    taps: dict[tuple[str, str], list[float]] = {}
    for line_number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        fields = line.split()
        if len(fields) != 4:
            continue
        source, target = fields[:2]
        try:
            dmax, dmin = float(fields[2]), float(fields[3])
        except ValueError:
            continue
        if not all(math.isfinite(x) for x in (dmax, dmin)) or dmin < 0 or dmin > dmax:
            raise ValueError(f"invalid delay range at {path}:{line_number}")
        if target == "OUTPUT":
            key = (source, target)
            bucket = taps.setdefault(key, [float("-inf"), float("inf")])
        else:
            key = ("IO" if source == "INPUT" else source, target)
            bucket = internal.setdefault(key, [float("-inf"), float("inf")])
        bucket[0] = max(bucket[0], dmax)
        bucket[1] = min(bucket[1], dmin)
    if not internal:
        raise ValueError("no internal timing rows found")
    return ({key: (value[0], value[1]) for key, value in internal.items()},
            {key: (value[0], value[1]) for key, value in taps.items()})


def write_table(path: Path, rows: dict[tuple[str, str], tuple[float, float]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.writer(stream)
        writer.writerow(("source", "target", "max_delay_ns", "min_delay_ns"))
        for (source, target), (dmax, dmin) in sorted(rows.items()):
            writer.writerow((source, target, f"{dmax:.6f}", f"{dmin:.6f}"))


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=DEFAULT_SOURCE)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()
    internal, taps = parse_dump(args.source.resolve())
    write_table(args.output / "s298_edges.csv", internal)
    write_table(args.output / "s298_output_taps.csv", taps)
    print(f"internal_edges={len(internal)} output_taps={len(taps)}")


if __name__ == "__main__":
    main()
