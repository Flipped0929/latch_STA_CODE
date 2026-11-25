#!/usr/bin/env python3
"""Real (place & route) Tmin points for the four designs.

The STA re-constraint sweep re-used a netlist routed for 640 ns, which is
pessimistic at small periods: re-implementing the all-latch design at 12 ns
passes even with the naive phase plan.  This script re-measures the small-period
points with a full synthesis/place/route so the Tmin comparison is fair.

Rows: variant, blocks, period, arise, awidth, brise, bwidth
(brise/bwidth may be "-" to use the default proportional B phase)
"""
import os
import subprocess
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
VIVADO = Path(r"D:\FDU\vivado\2026.1\Vivado\bin\vivado.bat")
TCL = WORK / "scripts" / "run_case.tcl"
SCRATCH = Path(os.environ.get("DSH_SCRATCH", str(WORK / "build" / "_scratch")))
LOGROOT = Path(os.environ.get("DSH_LOGROOT", str(WORK / "logs")))

CASES = []


def add(variant, blocks, T, brise="-", bwidth="-"):
    """naive proportional A phase: arise = 0.0625T, awidth = 0.25T"""
    CASES.append((variant, blocks, T, T * 0.0625, T * 0.25, brise, bwidth))


def add_gap(variant, blocks, T):
    """A {0, 0.4T}, B {0.5T, 0.9T}"""
    CASES.append((variant, blocks, T, 0.0, T * 0.4, T * 0.5, T * 0.4))


for T in (11.0, 10.0):
    add("ff", 1, T)
    add("latch_ff", 1, T)
    add("all_latch", 1, T)
    add_gap("all_latch", 1, T)


def run(item):
    variant, blocks, T, arise, awidth, brise, bwidth = item
    args = [variant, str(blocks), "%g" % T, "%g" % arise, "%g" % awidth]
    if brise != "-":
        args += ["%g" % brise, "%g" % bwidth]
    tag = "realtmin_%s_b%d_T%g" % (variant, blocks, T)
    if brise != "-":
        tag += "_gap"
    scratch = SCRATCH / tag
    scratch.mkdir(parents=True, exist_ok=True)
    LOGROOT.mkdir(parents=True, exist_ok=True)
    log = LOGROOT / (tag + ".log")
    cmd = ["cmd", "/c", str(VIVADO), "-mode", "batch", "-nojournal", "-nolog",
           "-source", str(TCL), "-tclargs"] + args
    with open(log, "w", encoding="utf-8", errors="replace") as fh:
        p = subprocess.run(cmd, cwd=str(scratch), stdout=fh,
                           stderr=subprocess.STDOUT)
    return tag, p.returncode


def main():
    with ThreadPoolExecutor(max_workers=2) as ex:
        for tag, rc in ex.map(run, CASES):
            print("  %-28s rc=%d" % (tag, rc), flush=True)


if __name__ == "__main__":
    main()
