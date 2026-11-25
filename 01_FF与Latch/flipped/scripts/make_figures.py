#!/usr/bin/env python3
"""Figures for the all-latch experiment."""
import csv
from collections import defaultdict
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

WORK = Path(__file__).resolve().parent.parent
RES = WORK / "results"
FIG = RES / "figures"
FIG.mkdir(parents=True, exist_ok=True)

DESIGNS = [("ff", "all-FF baseline", "o-"),
           ("latch_ff", "latch core + FF boundary", "s--"),
           ("all_latch_b1", "all-latch BLOCKS=1", "^-"),
           ("all_latch_b2", "all-latch BLOCKS=2", "v:")]


def num(v):
    try:
        return float(v)
    except (TypeError, ValueError):
        return None


def sweep_design(name):
    p = RES / ("sweep_%s.csv.design.csv" % name)
    out = []
    for r in csv.DictReader(open(p, encoding="utf-8")):
        out.append((num(r["period_ns"]), num(r["wns"]), num(r["whs"]), num(r["wpws"])))
    return sorted(out)


def sweep_groups(name):
    p = RES / ("sweep_%s.csv" % name)
    per = defaultdict(dict)
    for r in csv.DictReader(open(p, encoding="utf-8")):
        per[num(r["period_ns"])].setdefault(r["scope"], {})[r["check"]] = num(r["slack_ns"])
    return per


def runs():
    out = []
    for r in csv.DictReader(open(RES / "all_latch_runs.csv", encoding="utf-8")):
        try:
            out.append((r["variant"], int(float(r["blocks"])), num(r["period_ns"]),
                        num(r["arise_ns"]), num(r["max_borrow_ns"]),
                        num(r["wns"]), num(r["whs"])))
        except (TypeError, ValueError):
            continue
    return out


def fig_e2(rs):
    fig, ax = plt.subplots(figsize=(7.4, 4.4))
    for blocks, style in ((1, "o-"), (2, "s--"), (4, "^-.")):
        pts = sorted([r for r in rs if r[0] == "all_latch" and r[1] == blocks
                      and r[2] == 640.0 and r[4] is not None],
                     key=lambda r: r[3])
        if not pts:
            continue
        ax.plot([p[3] for p in pts], [p[4] for p in pts], style,
                label="BLOCKS=%d (%d latch stages)" % (blocks, 2 * blocks), ms=4)
    ax.set_xlabel("phase_a opening edge (ns)   [T = 640 ns, window = 160 ns]")
    ax.set_ylabel("max 'time borrowed from endpoint' (ns)")
    ax.set_title("E2: reported time borrowing vs phase_a opening\n"
                 "xc7a35tcpg236-1, Vivado 2026.1 post-route STA")
    ax.grid(alpha=0.3)
    ax.legend(fontsize=8)
    fig.tight_layout()
    out = FIG / "e2_borrow_vs_phase.png"
    fig.savefig(out, dpi=150)
    plt.close(fig)
    return out


def fig_e3():
    fig, ax = plt.subplots(figsize=(7.6, 4.6))
    for name, label, style in DESIGNS:
        d = sweep_design(name)
        ax.plot([x[0] for x in d], [x[1] for x in d], style, label=label, ms=4)
    ax.axhline(0.0, color="k", lw=0.8, ls=":")
    ax.set_xscale("log")
    ax.set_ylim(-4, 30)
    ax.set_xlabel("clock period T (ns, log scale)  [STA re-constraint of the routed netlist]")
    ax.set_ylabel("design WNS (ns)")
    ax.set_title("E3: setup slack vs period, all designs")
    ax.grid(which="both", alpha=0.3)
    ax.legend(fontsize=8)
    fig.tight_layout()
    out = FIG / "e3_wns_vs_period.png"
    fig.savefig(out, dpi=150)
    plt.close(fig)
    return out


def fig_e3_zoom():
    fig, ax = plt.subplots(figsize=(7.6, 4.6))
    for name, label, style in DESIGNS:
        d = sweep_design(name)
        pts = [x for x in d if x[0] <= 30.0]
        ax.plot([x[0] for x in pts], [x[1] for x in pts], style, label=label, ms=4)
    ax.axhline(0.0, color="k", lw=0.8, ls=":")
    ax.set_xlim(8, 30)
    ax.set_ylim(-6, 6)
    ax.set_xlabel("clock period T (ns)")
    ax.set_ylabel("design WNS (ns)")
    ax.set_title("E3: Tmin region (0.125 ns sweep step)")
    ax.grid(alpha=0.3)
    ax.legend(fontsize=8)
    fig.tight_layout()
    out = FIG / "e3_wns_zoom.png"
    fig.savefig(out, dpi=150)
    plt.close(fig)
    return out


def fig_e4():
    fig, axes = plt.subplots(1, 2, figsize=(11.4, 4.4))
    for name, label, style in DESIGNS:
        d = sweep_design(name)
        axes[0].plot([x[0] for x in d], [x[2] for x in d], style, label=label, ms=4)
    axes[0].axhline(0.0, color="k", lw=0.8, ls=":")
    axes[0].set_xscale("log")
    axes[0].set_xlabel("clock period T (ns, log)")
    axes[0].set_ylabel("design WHS (ns)")
    axes[0].set_title("E4a: worst hold slack is period independent\n(IO / same-clock short paths)")
    axes[0].grid(which="both", alpha=0.3)
    axes[0].legend(fontsize=7)

    per = sweep_groups("all_latch_b1")
    ts = sorted(per)
    pa = [(t, per[t]["phase_b"]["min"]) for t in ts if "phase_b" in per[t] and "min" in per[t]["phase_b"]]
    pb = [(t, per[t]["transaction_clock"]["min"]) for t in ts
          if "transaction_clock" in per[t] and "min" in per[t]["transaction_clock"]]
    axes[1].plot([x[0] for x in pa], [x[1] for x in pa], "o-",
                 label="path group phase_b (phase_a -> phase_b)", ms=4)
    axes[1].plot([x[0] for x in pb], [x[1] for x in pb], "s--",
                 label="path group transaction_clock (IO/boundary)", ms=4)
    axes[1].axhline(0.0, color="k", lw=0.8, ls=":")
    axes[1].set_xscale("log")
    axes[1].set_xlabel("clock period T (ns, log)")
    axes[1].set_ylabel("WHS of that clock pair (ns)")
    axes[1].set_title("E4b: all-latch BLOCKS=1, internal phase hold\n(requirement = 0.4375 T)")
    axes[1].grid(which="both", alpha=0.3)
    axes[1].legend(fontsize=7)
    fig.tight_layout()
    out = FIG / "e4_hold_vs_period.png"
    fig.savefig(out, dpi=150)
    plt.close(fig)
    return out


def main():
    rs = runs()
    for f in (fig_e2(rs), fig_e3(), fig_e3_zoom(), fig_e4()):
        print("wrote", f)


if __name__ == "__main__":
    main()
