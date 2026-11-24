#!/usr/bin/env python3
"""Turn the STA re-constraint sweeps into Tmin / hold-boundary tables.

Reads results/sweep_<design>.csv (+ .design.csv) and cross-checks the sweep
against the fully re-implemented points in results/all_latch_runs.csv.
"""
import csv
from collections import defaultdict
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
RES = WORK / "results"

DESIGNS = ["ff", "latch_ff", "all_latch_b1", "all_latch_b2"]


def load_sweep(name):
    per = defaultdict(dict)     # T -> {group: {max: x, min: y}}
    with open(RES / ("sweep_%s.csv" % name), newline="", encoding="utf-8") as fh:
        for r in csv.DictReader(fh):
            T = float(r["period_ns"])
            per[T].setdefault(r["scope"], {})[r["check"]] = float(r["slack_ns"])
    design = {}
    p = RES / ("sweep_%s.csv.design.csv" % name)
    if p.exists():
        with open(p, newline="", encoding="utf-8") as fh:
            for r in csv.DictReader(fh):
                design[float(r["period_ns"])] = {
                    "wns": float(r["wns"]), "whs": float(r["whs"]),
                    "wpws": float(r["wpws"])}
    return per, design


def main():
    print("| design | Tmin_setup | Tmin_hold | Tmin_all | limiting check | WNS@Tmin | WHS@Tmin | WPWS@Tmin |")
    print("|---|---:|---:|---:|---|---:|---:|---:|")
    rows_out = []
    for name in DESIGNS:
        per, design = load_sweep(name)
        ts = sorted(per)
        ok = []
        info = {}
        for T in ts:
            g = per[T]
            wns = min(v.get("max", 1e9) for v in g.values())
            whs = min(v.get("min", 1e9) for v in g.values())
            d = design.get(T, {})
            wpws = d.get("wpws", 1e9)
            setup_ok = wns >= 0
            hold_ok = whs >= 0
            pw_ok = wpws >= 0
            info[T] = (wns, whs, wpws, setup_ok, hold_ok, pw_ok)
            if setup_ok and hold_ok and pw_ok:
                ok.append(T)
        tmin = min(ok) if ok else None
        tmin_setup = min([T for T in ts if info[T][3]], default=None)
        tmin_hold = min([T for T in ts if info[T][4] and info[T][5]], default=None)
        lim = "-"
        if tmin is not None:
            w, h, p, so, ho, po = info[tmin]
            if w <= 0.001:
                lim = "setup (borrow/IO)"
            if h <= 0.001:
                lim = "hold"
            if p <= 0.001:
                lim = "pulse width"
            if max(w, h, p) <= 0.001:
                lim = "several (<=1ps)"
            print("| %s | %s | %s | %s | %s | %.3f | %.3f | %.3f |" % (
                name, fmt(tmin_setup), fmt(tmin_hold), fmt(tmin), lim, w, h, p))
        rows_out.append((name, tmin_setup, tmin_hold, tmin))

    print("\n### measured vs swept WNS (validation)\n")
    print("| run | T | measured WNS | swept WNS | delta | measured WHS | swept WHS |")
    print("|---|---:|---:|---:|---:|---:|---:|")
    measured = {}
    with open(RES / "all_latch_runs.csv", newline="", encoding="utf-8") as fh:
        for r in csv.DictReader(fh):
            try:
                measured[(r["variant"], int(float(r["blocks"])),
                          float(r["period_ns"]))] = (float(r["wns"]), float(r["whs"]))
            except (TypeError, ValueError):
                continue
    keymap = {("ff", 1): "ff", ("latch_ff", 1): "latch_ff",
              ("all_latch", 1): "all_latch_b1", ("all_latch", 2): "all_latch_b2"}
    for (variant, blocks, T), (mwns, mwhs) in sorted(
            measured.items(), key=lambda kv: (kv[0][0], kv[0][1], kv[0][2])):
        name = keymap.get((variant, blocks))
        if not name:
            continue
        per, design = load_sweep(name)
        if T not in per:
            continue
        swns = min(v.get("max", 1e9) for v in per[T].values())
        swhs = min(v.get("min", 1e9) for v in per[T].values())
        print("| %s | %.3f | %.3f | %.3f | %+.3f | %.3f | %.3f |" % (
            "%s b%d" % (variant, blocks), T, mwns, swns, swns - mwns, mwhs, swhs))


def fmt(v):
    return "n/a" if v is None else ("%.2f" % v)


if __name__ == "__main__":
    main()
