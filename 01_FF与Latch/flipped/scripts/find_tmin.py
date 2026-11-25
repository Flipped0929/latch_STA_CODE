#!/usr/bin/env python3
"""Exact Tmin from the fine (0.125 ns) re-constraint sweeps."""
import csv
from collections import defaultdict
from pathlib import Path

RES = Path(r"D:\FDU\FDUROP\20261108\07_vivado_lab\all_latch_work\results")


def load(name):
    per = defaultdict(dict)
    for r in csv.DictReader(open(RES / ("sweep_%s_fine.csv" % name), encoding="utf-8")):
        T = float(r["period_ns"])
        per[T].setdefault(r["scope"], {})[r["check"]] = (
            float(r["slack_ns"]), float(r["requirement_ns"]),
            r["source"], r["destination"])
    design = {float(r["period_ns"]): r for r in
              csv.DictReader(open(RES / ("sweep_%s_fine.csv.design.csv" % name),
                                  encoding="utf-8"))}
    return per, design


def main():
    print("| design | Tmin_setup (ns) | first failing T | limiting group | req/data at Tmin | Tmin_hold | Tmin_wpws |")
    print("|---|---:|---:|---|---|---:|---:|")
    for name in ["ff", "latch_ff", "all_latch_b1", "all_latch_b2"]:
        per, design = load(name)
        ts = sorted(per)
        # per-group global slack
        g = {}
        for T in ts:
            g[T] = {grp: v for grp, v in per[T].items()}
        setup_ok = {T: min(v["max"][0] for v in g[T].values()) >= 0 for T in ts}
        hold_ok = {T: min(v["min"][0] for v in g[T].values()) >= 0 for T in ts}
        ok = [T for T in ts if setup_ok[T]]
        tmin = min(ok)
        fail = [T for T in ts if not setup_ok[T] and T < tmin]
        tfirstfail = max(fail) if fail else None
        # which group is worst at Tmin
        worst = min(g[tmin].items(), key=lambda kv: kv[1]["max"][0])
        slack, req, src, dst = worst[1]["max"]
        hold_t = [T for T in ts if hold_ok[T]]
        # pulse width
        wpws_ok = [T for T in ts if float(design[T]["wpws"]) >= 0]
        print("| %s | %.3f | %s | %s | req=%.3f src=%s dst=%s | %s | %s |" % (
            name, tmin, ("%.3f" % tfirstfail) if tfirstfail else "n/a",
            worst[0], req, src, dst,
            ("%.3f" % min(hold_t)) if hold_t else "n/a",
            ("%.3f" % min(wpws_ok)) if wpws_ok else "n/a"))
        # hold detail at the smallest T
        T0 = ts[0]
        hw = min(g[T0].items(), key=lambda kv: kv[1]["min"][0])
        print("    hold @T=%.3f: %s slack=%.3f req=%.3f data=%s" % (
            T0, hw[0], hw[1]["min"][0], hw[1]["min"][1], hw[1]["min"][3]))


if __name__ == "__main__":
    main()
