#!/usr/bin/env python3
"""Parallel driver for the all-latch Vivado experiment matrix (E1-E4).

Cases come from a CSV with columns: variant,blocks,period,arise,awidth
Each case is run by scripts/run_case.tcl in a fresh scratch working
directory (so concurrent Vivado runs do not share .Xil), and the Vivado
console output is written to logs/<tag>.log.

Idempotent: a case whose build/<tag>/run_meta.csv already exists is skipped
unless --force is given.
"""
import argparse
import csv
import os
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
VIVADO = Path(r"D:\FDU\vivado\2026.1\Vivado\bin\vivado.bat")
TCL = WORK / "scripts" / "run_case.tcl"
LOGS = WORK / "logs"
BUILD = WORK / "build"


def numtag(v: float) -> str:
    d = float(v)
    if abs(d - round(d)) < 1e-9:
        return str(int(round(d)))
    return ("%.4f" % d).rstrip("0").rstrip(".")


def tag_of(variant, blocks, period, arise, awidth) -> str:
    return "{}_b{}_T{}_r{}_w{}".format(
        variant, blocks, numtag(period), numtag(arise), numtag(awidth))


def run_case(case, slot, force):
    variant, blocks, period, arise, awidth = case
    tag = tag_of(*case)
    outdir = BUILD / tag
    meta = outdir / "run_meta.csv"
    if meta.exists() and not force:
        return tag, "skip", 0.0
    # one private scratch directory per case: concurrent Vivado runs must not
    # share a .Xil directory, otherwise they can stall or crash
    scratch = BUILD / "_scratch" / tag
    scratch.mkdir(parents=True, exist_ok=True)
    LOGS.mkdir(parents=True, exist_ok=True)
    log = LOGS / (tag + ".log")
    cmd = ["cmd", "/c", str(VIVADO), "-mode", "batch", "-nojournal", "-nolog",
           "-source", str(TCL), "-tclargs",
           variant, str(blocks), str(period), str(arise), str(awidth)]
    t0 = time.time()
    with open(log, "w", encoding="utf-8", errors="replace") as fh:
        proc = subprocess.run(cmd, cwd=str(scratch), stdout=fh,
                              stderr=subprocess.STDOUT)
    dt = time.time() - t0
    ok = meta.exists() and proc.returncode == 0
    return tag, ("ok" if ok else "FAIL(rc=%d)" % proc.returncode), dt


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("cases", help="CSV file: variant,blocks,period,arise,awidth")
    ap.add_argument("--workers", type=int, default=4)
    ap.add_argument("--force", action="store_true")
    args = ap.parse_args()

    cases = []
    with open(args.cases, newline="", encoding="utf-8") as fh:
        for row in csv.reader(fh):
            if not row or row[0].strip().startswith("#"):
                continue
            if row[0].strip() == "variant":
                continue
            cases.append((row[0].strip(), int(row[1]), float(row[2]),
                          float(row[3]), float(row[4])))

    print("{} cases, {} workers".format(len(cases), args.workers))
    t0 = time.time()
    done = 0
    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        futs = [ex.submit(run_case, c, i % args.workers, args.force)
                for i, c in enumerate(cases)]
        for f in futs:
            tag, status, dt = f.result()
            done += 1
            print("[{:3d}/{:3d}] {:9s} {:6.1f}s  {}".format(
                done, len(cases), status, dt, tag), flush=True)
    print("total wall time: %.1f s" % (time.time() - t0))


if __name__ == "__main__":
    main()
