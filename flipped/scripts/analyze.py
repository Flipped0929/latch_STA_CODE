#!/usr/bin/env python3
"""Analyse collected runs: Tmin brackets per design, and the next bisection cases.

Usage:
  python analyze.py            # print the table
  python analyze.py --suggest  # also write results/cases_bisect.csv
"""
import argparse
import csv
from collections import defaultdict
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
RESULTS = WORK / "results"


def load():
    rows = []
    with open(RESULTS / "all_latch_runs.csv", newline="", encoding="utf-8") as fh:
        for r in csv.DictReader(fh):
            try:
                r["period_ns"] = float(r["period_ns"])
            except (TypeError, ValueError):
                continue
            for k in ("wns", "whs", "wpws", "tns", "ths", "max_borrow_ns"):
                try:
                    r[k] = float(r[k])
                except (TypeError, ValueError, KeyError):
                    r[k] = None
            rows.append(r)
    return rows


def passes(r, hold=True):
    ok = r["wns"] is not None and r["wns"] >= 0
    if hold and r["whs"] is not None:
        ok = ok and r["whs"] >= 0
    return ok


def key(r):
    return "{}_b{}".format(r["variant"], r["blocks"])


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--suggest", action="store_true")
    ap.add_argument("--tol", type=float, default=0.1)
    args = ap.parse_args()

    rows = load()
    groups = defaultdict(list)
    for r in rows:
        groups[key(r)].append(r)

    print("{:16s} {:>8s} {:>8s} {:>8s} {:>8s}  {}".format(
        "design", "TlastOK", "TfirstKO", "wns@last", "whs@last", "note"))
    suggestions = []
    for k in sorted(groups):
        rs = sorted(groups[k], key=lambda r: r["period_ns"])
        ok = [r for r in rs if passes(r)]
        ko = [r for r in rs if not passes(r)]
        tlast = max((r["period_ns"] for r in ok), default=None)
        tfirst = min((r["period_ns"] for r in ko
                      if tlast is None or r["period_ns"] < tlast), default=None)
        note = ""
        if tlast is not None:
            r = [x for x in ok if x["period_ns"] == tlast][0]
            wns = "%8.3f" % r["wns"] if r["wns"] is not None else "     n/a"
            whs = "%8.3f" % r["whs"] if r["whs"] is not None else "     n/a"
            # which check limits: setup vs hold
            if r["whs"] is not None and r["whs"] < 0.5:
                note = "hold-margin<0.5ns"
        else:
            wns = whs = "     n/a"
        if tfirst is not None and tlast is not None and tfirst - tlast > args.tol:
            mid = round((tfirst + tlast) / 2.0, 3)
            note += " bisect@%.3f" % mid
            suggestions.append((k, mid))
        elif tfirst is None and tlast is not None:
            note += " no failing point yet - extend ladder down"
        print("{:16s} {:>8s} {:>8s} {:>8s} {:>8s}  {}".format(
            k, str(tlast), str(tfirst), wns, whs, note))

    if args.suggest and suggestions:
        out = RESULTS / "cases_bisect.csv"
        existing = set()
        if out.exists():
            with open(out, newline="", encoding="utf-8") as fh:
                for row in csv.reader(fh):
                    if len(row) >= 5:
                        existing.add(tuple(row))
        lines = []
        for k, T in suggestions:
            variant, blocks = k.rsplit("_b", 1)
            arise = round(T * 0.0625, 6)
            awidth = round(T * 0.25, 6)
            row = (variant, blocks, str(T), str(arise), str(awidth))
            if row in existing:
                continue
            lines.append(row)
        if lines:
            newfile = not out.exists()
            with open(out, "a", newline="", encoding="utf-8") as fh:
                wr = csv.writer(fh)
                if newfile:
                    wr.writerow(["variant", "blocks", "period", "arise", "awidth"])
                wr.writerows(lines)
            print("\nappended %d bisection cases to %s" % (len(lines), out))
        else:
            print("\nno new bisection cases")


if __name__ == "__main__":
    main()
