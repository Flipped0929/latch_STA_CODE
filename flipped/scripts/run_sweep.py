#!/usr/bin/env python3
"""Run the STA re-constraint period sweep on already routed checkpoints.

For each design base checkpoint (routed at 640 ns) this produces
  results/sweep_<design><suffix>.csv          per-group worst slack vs period
  results/sweep_<design><suffix>.csv.design.csv   design WNS/WHS/WPWS vs period
"""
import argparse
import subprocess
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
BUILD = WORK / "build"
RES = WORK / "results"
VIVADO = Path(r"D:\FDU\vivado\2026.1\Vivado\bin\vivado.bat")
TCL = WORK / "scripts" / "sta_sweep.tcl"

DESIGNS = {
    "ff": "ff_b1_T640_r40_w160",
    "latch_ff": "latch_ff_b1_T640_r40_w160",
    "all_latch_b1": "all_latch_b1_T640_r40_w160",
    "all_latch_b2": "all_latch_b2_T640_r40_w160",
}

COARSE = ["2", "2.5", "3", "3.5", "4", "4.5", "5", "5.5", "6", "6.5", "7",
          "7.5", "8", "8.5", "9", "9.5", "10", "10.5", "11", "11.5", "12",
          "13", "14", "15", "16", "18", "20", "25", "30", "40", "60", "80",
          "120", "160", "240", "320", "480", "640"]

FINE = ["%.3f" % (9.0 + 0.125 * i) for i in range(57)]   # 9.000 .. 16.000


def run(item):
    (name, tag), ts, suffix = item
    dcp = BUILD / tag / "routed.dcp"
    if not dcp.exists():
        return name, "missing checkpoint %s" % dcp
    out = RES / ("sweep_%s%s.csv" % (name, suffix))
    scratch = BUILD / "_scratch" / ("sweep_" + name + suffix)
    scratch.mkdir(parents=True, exist_ok=True)
    log = WORK / "logs" / ("sweep_%s%s.log" % (name, suffix))
    cmd = ["cmd", "/c", str(VIVADO), "-mode", "batch", "-nojournal", "-nolog",
           "-source", str(TCL), "-tclargs", str(dcp), str(out)] + ts
    with open(log, "w", encoding="utf-8", errors="replace") as fh:
        p = subprocess.run(cmd, cwd=str(scratch), stdout=fh,
                           stderr=subprocess.STDOUT)
    n = sum(1 for _ in open(out, encoding="utf-8")) if out.exists() else 0
    return name, "rc=%d rows=%d" % (p.returncode, n)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--fine", action="store_true")
    args = ap.parse_args()
    ts = FINE if args.fine else COARSE
    suffix = "_fine" if args.fine else ""
    items = [(kv, ts, suffix) for kv in DESIGNS.items()]
    with ThreadPoolExecutor(max_workers=2) as ex:
        for name, status in ex.map(run, items):
            print("  %-14s %s" % (name, status), flush=True)


if __name__ == "__main__":
    main()
