#!/usr/bin/env python3
"""Driver for the borrow-arbitration experiment.

Each case is one full implementation of arb_ff1 / arb_ff2 / arb_latch with a
parameterised LUT delay chain.  Build products go to $DSH_OUTROOT/build/<tag>
(the repository tree is not writable for sandboxed processes).

Case CSV columns: variant,period,pa_rise,pa_fall,pb_rise,pb_fall,d1,d2
"""
import csv
import os
import subprocess
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
VIVADO = Path(r"D:\FDU\vivado\2026.1\Vivado\bin\vivado.bat")
TCL = WORK / "scripts" / "arb_case.tcl"
OUTROOT = Path(os.environ.get("DSH_OUTROOT", str(WORK)))
SCRATCH = Path(os.environ.get("DSH_SCRATCH", str(OUTROOT / "_scratch")))
LOGROOT = Path(os.environ.get("DSH_LOGROOT", str(OUTROOT / "logs")))
OUTROOT.mkdir(parents=True, exist_ok=True)
SCRATCH.mkdir(parents=True, exist_ok=True)
LOGROOT.mkdir(parents=True, exist_ok=True)


def tag_of(case):
    v, T, par, paf, pbr, pbf, d1, d2 = case

    def nt(x):
        d = float(x)
        return str(int(d)) if abs(d - round(d)) < 1e-9 else ("%.4f" % d).rstrip("0").rstrip(".")
    return "%s_T%s_A%s_%s_B%s_%s_D%s_%s" % (v, nt(T), nt(par), nt(paf), nt(pbr), nt(pbf), nt(d1), nt(d2))


def run(case):
    tag = tag_of(case)
    outdir = OUTROOT / "build" / tag
    if (outdir / "run_meta.csv").exists():
        return tag, "skip"
    scratch = SCRATCH / tag
    scratch.mkdir(parents=True, exist_ok=True)
    log = LOGROOT / (tag + ".log")
    cmd = ["cmd", "/c", str(VIVADO), "-mode", "batch", "-nojournal", "-nolog",
           "-source", str(TCL), "-tclargs"] + [str(x) for x in case]
    with open(log, "w", encoding="utf-8", errors="replace") as fh:
        p = subprocess.run(cmd, cwd=str(scratch), stdout=fh, stderr=subprocess.STDOUT)
    ok = (outdir / "run_meta.csv").exists()
    return tag, ("ok" if ok else "FAIL(rc=%d)" % p.returncode)


def main():
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("cases")
    ap.add_argument("--workers", type=int, default=2)
    args = ap.parse_args()

    cases = []
    with open(args.cases, newline="", encoding="utf-8") as fh:
        for row in csv.reader(fh):
            if not row or row[0].strip().startswith("#") or row[0].strip() == "variant":
                continue
            cases.append(tuple(row[:8]))
    print("%d cases, %d workers" % (len(cases), args.workers), flush=True)
    with ThreadPoolExecutor(max_workers=args.workers) as ex:
        for tag, status in ex.map(run, cases):
            print("  %-52s %s" % (tag, status), flush=True)


if __name__ == "__main__":
    main()
