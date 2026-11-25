#!/usr/bin/env python3
"""Three real implementations that validate the phase-allocation finding.

At T = 12 ns (below the naive-allocation Tmin of 14 ns) on the same all-latch
BLOCKS=1 design:

  naive25 : A {0.75, 3.75}  B {6.0, 9.0}    <- proportional plan, should fail
  gap20   : A {0.0, 4.8}    B {6.0, 10.8}   <- same windows as the STA sweep's
                                                best combo, should pass
  tile50  : A {0.0, 6.0}    B {6.0, 12.0}   <- windows touch, setup ok but the
                                                sweep predicts a hold violation
"""
import os
import subprocess
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
BUILD = WORK / "build"
VIVADO = Path(r"D:\FDU\vivado\2026.1\Vivado\bin\vivado.bat")
TCL = WORK / "scripts" / "run_case.tcl"
# where run_case.tcl puts build/<tag>/ (env override for a non-writable tree)
OUTROOT = Path(os.environ.get("DSH_OUTROOT", str(WORK)))
SCRATCH = Path(os.environ.get("DSH_SCRATCH", str(BUILD / "_scratch")))
LOGROOT = Path(os.environ.get("DSH_LOGROOT", str(WORK / "logs")))

CASES = [
    ("naive25", ["all_latch", "1", "12", "0.75", "3.0"]),
    ("gap20",   ["all_latch", "1", "12", "0",    "4.8", "6.0", "4.8"]),
    ("tile50",  ["all_latch", "1", "12", "0",    "6.0", "6.0", "6.0"]),
]


def run(item):
    name, args = item
    scratch = SCRATCH / ("phase_case_" + name)
    scratch.mkdir(parents=True, exist_ok=True)
    LOGROOT.mkdir(parents=True, exist_ok=True)
    log = LOGROOT / ("phase_case_%s.log" % name)
    cmd = ["cmd", "/c", str(VIVADO), "-mode", "batch", "-nojournal", "-nolog",
           "-source", str(TCL), "-tclargs"] + args
    with open(log, "w", encoding="utf-8", errors="replace") as fh:
        p = subprocess.run(cmd, cwd=str(scratch), stdout=fh,
                           stderr=subprocess.STDOUT)
    return name, p.returncode


def main():
    with ThreadPoolExecutor(max_workers=3) as ex:
        for name, rc in ex.map(run, CASES):
            print("  %-8s rc=%d" % (name, rc), flush=True)


if __name__ == "__main__":
    main()
