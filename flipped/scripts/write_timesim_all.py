#!/usr/bin/env python3
"""Regenerate timesim.v (timing-simulation netlist) for build dirs that lack it."""
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
BUILD = WORK / "build"
VIVADO = Path(r"D:\FDU\vivado\2026.1\Vivado\bin\vivado.bat")
TCL = WORK / "scripts" / "write_timesim.tcl"


def one(args):
    i, d = args
    scratch = BUILD / ("_cwd%d" % (i % 4 + 1))
    scratch.mkdir(parents=True, exist_ok=True)
    cmd = ["cmd", "/c", str(VIVADO), "-mode", "batch", "-nojournal", "-nolog",
           "-source", str(TCL), "-tclargs",
           str(d / "routed.dcp"), str(d / "timesim.v")]
    p = subprocess.run(cmd, cwd=str(scratch), capture_output=True, text=True,
                       errors="replace")
    ok = (d / "timesim.v").exists()
    return d.name, ok, p.returncode


def main():
    todo = [d for d in sorted(BUILD.iterdir())
            if d.is_dir() and not d.name.startswith("_")
            and (d / "routed.dcp").exists() and not (d / "timesim.v").exists()]
    if not todo:
        print("nothing to do")
        return
    print("%d builds need a timesim netlist" % len(todo))
    with ThreadPoolExecutor(max_workers=4) as ex:
        for name, ok, rc in ex.map(one, enumerate(todo)):
            print("  %-40s %s rc=%d" % (name, "ok" if ok else "FAIL", rc),
                  flush=True)


if __name__ == "__main__":
    main()
