#!/usr/bin/env python3
"""Phase-allocation sweep for the all-latch design (constraint-level CSS-lite).

Answers: with a *different* A/B window allocation, can the all-latch design run
faster than the naive proportional allocation (A 6.25-31.25%, B 50-75%)?
"""
import csv
import subprocess
import sys
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
BUILD = WORK / "build"
RES = WORK / "results"
VIVADO = Path(r"D:\FDU\vivado\2026.1\Vivado\bin\vivado.bat")
TCL = WORK / "scripts" / "sta_phase_sweep.tcl"

# (name, a_open, a_close, b_open, b_close)  -- fractions of the period
COMBOS = [
    ("naive25",   0.0625, 0.3125, 0.50, 0.75),
    ("tile50",    0.0000, 0.5000, 0.50, 1.00),
    ("gap5",      0.0000, 0.4750, 0.50, 0.9750),
    ("gap10",     0.0000, 0.4500, 0.50, 0.95),
    ("gap20",     0.0000, 0.4000, 0.50, 0.90),
    ("a45",       0.0000, 0.4500, 0.45, 0.95),
    ("lateA",     0.1000, 0.5000, 0.55, 1.00),
    ("a40b90",    0.0000, 0.4000, 0.50, 0.90),
]

TS = [8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 16.0, 20.0]

DESIGNS = {
    "all_latch_b1": "all_latch_b1_T640_r40_w160",
    "all_latch_b2": "all_latch_b2_T640_r40_w160",
}


def run(item):
    name, tag = item
    dcp = BUILD / tag / "routed.dcp"
    if not dcp.exists():
        return name, "missing %s" % dcp
    out = RES / ("phase_sweep_%s.csv" % name)
    scratch = BUILD / "_scratch" / ("phase_" + name)
    scratch.mkdir(parents=True, exist_ok=True)
    log = WORK / "logs" / ("phase_sweep_%s.log" % name)
    args = []
    for T in TS:
        for _, ao, ac, bo, bc in COMBOS:
            args += ["%g" % T, "%g" % ao, "%g" % ac, "%g" % bo, "%g" % bc]
    cmd = ["cmd", "/c", str(VIVADO), "-mode", "batch", "-nojournal", "-nolog",
           "-source", str(TCL), "-tclargs", str(dcp), str(out)] + args
    with open(log, "w", encoding="utf-8", errors="replace") as fh:
        p = subprocess.run(cmd, cwd=str(scratch), stdout=fh,
                           stderr=subprocess.STDOUT)
    n = sum(1 for _ in open(out, encoding="utf-8")) if out.exists() else 0
    return name, "rc=%d rows=%d" % (p.returncode, n)


def main():
    with ThreadPoolExecutor(max_workers=2) as ex:
        for name, status in ex.map(run, list(DESIGNS.items())):
            print("  %-14s %s" % (name, status), flush=True)
    # analysis
    for name in DESIGNS:
        p = RES / ("phase_sweep_%s.csv.design.csv" % name)
        if not p.exists():
            continue
        rows = list(csv.DictReader(open(p, encoding="utf-8")))
        print("\n== %s ==" % name)
        print("| combo | allocation A | B | best Tmin | WNS@Tmin | WHS@Tmin | WPWS@Tmin |")
        print("|---|---|---|---:|---:|---:|---:|")
        by = defaultdict(dict)
        alloc = {}
        for r in rows:
            key = tuple(round(float(r[k]), 6) for k in ("ao", "ac", "bo", "bc"))
            alloc[key] = key
            by[key][float(r["period_ns"])] = (float(r["wns"]), float(r["whs"]),
                                              float(r["wpws"]))
        for combo, ao, ac, bo, bc in COMBOS:
            key = tuple(round(v, 6) for v in (ao, ac, bo, bc))
            data = by.get(key, {})
            if not data:
                continue
            ok = [T for T, (w, h, p_) in data.items() if w >= 0 and h >= 0 and p_ >= 0]
            tmin = min(ok) if ok else None
            if tmin is None:
                print("| %s | %.3f-%.3f | %.3f-%.3f | none | - | - | - |" % (
                    combo, ao, ac, bo, bc))
                continue
            w, h, p_ = data[tmin]
            print("| %s | %.3f-%.3f | %.3f-%.3f | **%.2f** | %.3f | %.3f | %.3f |" % (
                combo, ao, ac, bo, bc, tmin, w, h, p_))


if __name__ == "__main__":
    main()
