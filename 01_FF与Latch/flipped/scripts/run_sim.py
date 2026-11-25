#!/usr/bin/env python3
"""Run XSim simulations for the FF / latch / all-latch designs.

Modes:
  rtl   behavioural RTL
  net   post-route functional netlist (funcsim.v, no SDF)
  sdf   post-route timing netlist (funcsim.v + routed.sdf annotation)

Designs:
  chain  all-latch chain (latch_chain_top, latch-pair IO boundary)
  ff     FF baseline      (ff_timing_top, FF IO boundary) -- TB is fixed at 640 ns

Two Vivado batch-wrapper quirks are worked around here:
  * bin/*.bat hands %* to cmd, which splits an unquoted argument at '=';
    therefore Verilog defines are passed through a .f file, and the SDF
    root=file argument is sent as one quoted token through a shell string.
  * XSim cannot annotate the LDCE setup/hold arcs of the unisims model
    (fatal 43-3462); --sdf-mode delays strips TIMINGCHECK before annotating.
"""
import argparse
import shutil
import subprocess
import sys
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
BIN = Path(r"D:\FDU\vivado\2026.1\Vivado\bin")
GLBL = Path(r"D:\FDU\vivado\2026.1\Vivado\data\verilog\src\glbl.v")

CHAIN_RTL = [WORK / "rtl" / n for n in
             ("datapath_compare.v", "latch_boundary_pair.v",
              "latch_chain_top.sv", "latch_chain_wrappers.v")]
CHAIN_TB = WORK / "sim" / "tb_latch_chain.sv"
FF_RTL = [WORK / "rtl" / n for n in
          ("datapath_compare.v", "timing_boundaries.v", "ff_timing_top.v")]
FF_TB = WORK / "sim" / "tb_ff_vivado.sv"


def run(cmd, cwd, log):
    with open(log, "a", encoding="utf-8", errors="replace") as fh:
        fh.write("\n$ " + " ".join(str(c) for c in cmd) + "\n")
        fh.flush()
        p = subprocess.run([str(c) for c in cmd], cwd=str(cwd),
                           stdout=fh, stderr=subprocess.STDOUT)
    return p.returncode


def run_shell(cmdline, cwd, log):
    with open(log, "a", encoding="utf-8", errors="replace") as fh:
        fh.write("\n$ " + cmdline + "\n")
        fh.flush()
        p = subprocess.run(cmdline, cwd=str(cwd), shell=True,
                           stdout=fh, stderr=subprocess.STDOUT)
    return p.returncode


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--tag", required=True)
    ap.add_argument("--mode", choices=["rtl", "net", "sdf"], required=True)
    ap.add_argument("--design", choices=["chain", "ff"], default="chain")
    ap.add_argument("--blocks", type=int, default=1)
    ap.add_argument("--period", default="640")
    ap.add_argument("--arise", default="40")
    ap.add_argument("--awidth", default="160")
    ap.add_argument("--brise", default=None)
    ap.add_argument("--bwidth", default=None)
    ap.add_argument("--sdf-min", action="store_true",
                    help="annotate the SDF with MINIMUM delays instead of MAXIMUM")
    ap.add_argument("--sdf-mode", choices=["full", "delays"], default="delays",
                    help="full: annotate routed.sdf as written by Vivado; "
                         "delays: drop TIMINGCHECK / CLR->Q arcs first")
    ap.add_argument("--wdb", action="store_true",
                    help="also write a waveform database (tb.wdb) for the GUI viewer")
    args = ap.parse_args()

    build = WORK / "build" / args.tag
    if not build.exists():
        sys.exit("missing build dir: %s" % build)
    brise = args.brise if args.brise else str(float(args.period) / 2.0)
    bwidth = args.bwidth if args.bwidth else args.awidth

    chain = (args.design == "chain")
    tb = CHAIN_TB if chain else FF_TB
    top = "tb_latch_chain" if chain else "tb_ff_vivado"
    dutname = "latch_chain_top_1" if chain else "ff_timing_top"

    rundir = WORK / "build" / ("_sim_{}_{}".format(args.tag, args.mode))
    if rundir.exists():
        shutil.rmtree(rundir)
    rundir.mkdir(parents=True)
    log = WORK / "logs" / ("sim_{}_{}.log".format(args.tag, args.mode))
    if log.exists():
        log.unlink()

    defines = []
    if chain:
        defines += ["-d BLOCKS=%d" % args.blocks,
                    "-d PERIOD=%s" % args.period,
                    "-d ARISE=%s" % args.arise,
                    "-d AWIDTH=%s" % args.awidth,
                    "-d BRISE=%s" % brise,
                    "-d BWIDTH=%s" % bwidth]

    if args.mode in ("net", "sdf"):
        if chain:
            defines.append("-d NETLIST")
        netlist = (build / "timesim.v") if args.mode == "sdf" else (build / "funcsim.v")
        if not netlist.exists():
            sys.exit("missing netlist: %s" % netlist)
        sources = [netlist, tb, GLBL]
        elab = ["-sv", "work.%s" % top, "work.glbl", "-s", "snap",
                "-L", "unisims_ver"]
        sdf = None
        if args.mode == "sdf":
            sdf = build / "routed.sdf"
            if not sdf.exists():
                sys.exit("missing SDF: %s" % sdf)
            if args.sdf_mode == "delays":
                filt = build / "routed_delays_only.sdf"
                if not filt.exists() or filt.stat().st_mtime < sdf.stat().st_mtime:
                    subprocess.run([sys.executable,
                                    str(WORK / "scripts" / "filter_sdf.py"),
                                    str(sdf), str(filt)], check=True)
                sdf = filt
            print("annotating:", sdf)
    else:
        sources = (CHAIN_RTL if chain else FF_RTL) + [tb]
        elab = ["-sv", "work.%s" % top, "-s", "snap"]
        sdf = None

    with open(rundir / "cmd.f", "w", encoding="utf-8") as fh:
        fh.write("-sv\n")
        for d in defines:
            fh.write(d + "\n")
        for s in sources:
            fh.write(str(s) + "\n")

    rc = run([BIN / "xvlog.bat", "-f", "cmd.f"], rundir, log)
    if rc != 0:
        sys.exit("xvlog failed (rc=%d), see %s" % (rc, log))

    if args.mode == "sdf":
        sdfarg = "%s/dut=%s" % (top, sdf)
        opt = "-sdfmin" if args.sdf_min else "-sdfmax"
        cmdline = ('"{}" -sv work.{} work.glbl -s snap -L unisims_ver '
                   '{} "{}"').format(BIN / "xelab.bat", top, opt, sdfarg)
        if sdf.name.endswith("_delays_only.sdf"):
            # nothing left to check in the filtered file, only delays to map
            cmdline += " -sdfnoerror -sdfnowarn"
        if args.wdb:
            cmdline += " -debug typical"
        rc = run_shell(cmdline, rundir, log)
    else:
        if args.wdb:
            elab += ["-debug", "typical"]
        rc = run([BIN / "xelab.bat"] + elab, rundir, log)
    if rc != 0:
        sys.exit("xelab failed (rc=%d), see %s" % (rc, log))

    if args.wdb:
        # batch waveform capture: log_wave needs a Tcl script, -wdb alone writes nothing
        wtcl = rundir / "wave.tcl"
        wtcl.write_text("log_wave -recursive *\nrun all\nexit\n", encoding="utf-8")
        rc = run([BIN / "xsim.bat", "snap", "-tclbatch", "wave.tcl",
                  "-wdb", str(rundir / "tb.wdb")], rundir, log)
    else:
        rc = run([BIN / "xsim.bat", "snap", "-R"], rundir, log)
    print("xsim rc =", rc)
    text = log.read_text(encoding="utf-8", errors="replace")
    shown = 0
    for line in text.splitlines():
        if any(k in line for k in ("PASS:", "FAIL:", "ERROR:", "FATAL",
                                   "Simulation completed", "SDF",
                                   "$setup", "$hold", "Timing check",
                                   "timing check")):
            print("   ", line.strip()[:200])
            shown += 1
            if shown > 25:
                break
    sys.exit(rc)


if __name__ == "__main__":
    main()
