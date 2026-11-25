#!/usr/bin/env python3
"""Emit the markdown tables used by the E1-E4 reports, straight from the CSVs."""
import csv
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
R = WORK / "results"


def rows(name):
    with open(R / name, newline="", encoding="utf-8") as fh:
        return list(csv.DictReader(fh))


def f(v, nd=3):
    if v in (None, "", "None"):
        return "-"
    try:
        return ("%." + str(nd) + "f") % float(v)
    except ValueError:
        return v


def runs():
    out = []
    for r in rows("all_latch_runs.csv"):
        try:
            for k in ("period_ns", "arise_ns", "awidth_ns", "blocks"):
                r[k] = float(r[k])
            for k in ("wns", "whs", "wpws", "tns", "ths", "tns_fep",
                      "ths_fep", "max_borrow_ns", "max_given_ns",
                      "max_borrow_capacity_ns"):
                r[k] = None if r.get(k) in (None, "") else float(r[k])
        except (TypeError, ValueError):
            continue
        out.append(r)
    return out


def e1(rs):
    print("### E1 table (T=640 ns, A {40,200}, B {320,480})\n")
    print("| variant | BLOCKS | FDCE | LDCE | LUT | WNS | WHS | WPWS | max borrow | max given |")
    print("|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|")
    order = {"ff": 0, "latch_ff": 1, "all_latch": 2}
    sel = [x for x in rs if x["period_ns"] == 640.0
           and x["arise_ns"] == 40.0 and x["awidth_ns"] == 160.0]
    for r in sorted(sel, key=lambda x: (order.get(x["variant"], 9), x["blocks"])):
        print("| {} | {} | {} | {} | {} | {} | {} | {} | {} | {} |".format(
            r["variant"], int(r["blocks"]), r["fd_cells"], r["ld_cells"],
            r["lut_cells"], f(r["wns"]), f(r["whs"]), f(r["wpws"]),
            f(r["max_borrow_ns"]), f(r["max_given_ns"])))


def e2(rs):
    print("### E2 borrow / slack vs phase_a opening (T=640 ns, window 160 ns)\n")
    print("| BLOCKS | arise | A window | max borrow | max given | WNS phase_a | WNS phase_b | WNS tc | WHS |")
    print("|---:|---:|---|---:|---:|---:|---:|---:|---:|")
    for b in (1, 2, 4):
        pts = sorted([x for x in rs if x["variant"] == "all_latch"
                      and x["blocks"] == b and x["period_ns"] == 640.0],
                     key=lambda x: x["arise_ns"])
        for p in pts:
            print("| {} | {} | {}-{} | {} | {} | {} | {} | {} | {} |".format(
                b, f(p["arise_ns"], 0), f(p["arise_ns"], 0),
                f(p["arise_ns"] + p["awidth_ns"], 0), f(p["max_borrow_ns"]),
                f(p["max_given_ns"]), f(p.get("phase_a_max")),
                f(p.get("phase_b_max")), f(p.get("transaction_clock_max")),
                f(p["whs"])))


def e3(rs):
    print("### E3 period ladder (proportional phase: A = 6.25%-31.25% T, B = 50%-75% T)\n")
    print("| variant | BLOCKS | T (ns) | A window | WNS | WHS | WPWS | setup fails | hold fails | met |")
    print("|---|---:|---:|---|---:|---:|---:|---:|---:|---|")
    for variant, blocks in (("ff", 1), ("latch_ff", 1), ("all_latch", 1),
                            ("all_latch", 2)):
        pts = sorted([x for x in rs if x["variant"] == variant
                      and x["blocks"] == blocks], key=lambda x: x["period_ns"])
        for p in pts:
            print("| {} | {} | {} | {}-{} | {} | {} | {} | {} | {} | {} |".format(
                variant, blocks, f(p["period_ns"], 3),
                f(p["arise_ns"], 3), f(p["arise_ns"] + p["awidth_ns"], 3),
                f(p["wns"]), f(p["whs"]), f(p["wpws"]),
                f(p["tns_fep"], 0), f(p["ths_fep"], 0),
                "yes" if p.get("constraints_met") == "True" else "NO"))


def e4(rs, ic):
    print("### E4 hold: all-latch BLOCKS=1, worst hold path per period\n")
    print("| T (ns) | gap A->B | gap B->A | WHS | setup to hold failure | source | destination | grp | req | data |")
    print("|---:|---:|---:|---:|---|---|---|---|---:|---:|")
    for p in sorted([x for x in rs if x["variant"] == "all_latch"
                     and x["blocks"] == 1], key=lambda x: x["period_ns"]):
        T = p["period_ns"]
        gap_ab = 0.5 * T - (p["arise_ns"] + p["awidth_ns"])
        gap_ba = T - 0.75 * T + p["arise_ns"]
        print("| {} | {} | {} | {} | {} | {} | {} | {} | {} | {} |".format(
            f(T, 3), f(gap_ab, 3), f(gap_ba, 3), f(p["whs"]),
            "both-fail" if (p["wns"] or 0) < 0 else "setup-first",
            p.get("worst_hold_source", "-"), p.get("worst_hold_destination", "-"),
            p.get("worst_hold_group", "-"), f(p.get("worst_hold_requirement_ns")),
            f(p.get("worst_hold_datapath_ns"))))
    print("\n### E4 hold: inter-clock WNS / WHS for all-latch BLOCKS=1\n")
    print("| run | from | to | WNS | WHS |")
    print("|---|---|---|---:|---:|")
    m = {r["run"]: r for r in rs}
    for r in ic:
        run = m.get(r["run"])
        if not run or run["variant"] != "all_latch" or run["blocks"] != 1.0:
            continue
        T = float(r["period_ns"])
        if T not in (640.0, 320.0, 160.0, 80.0, 40.0, 20.0, 10.0):
            continue
        print("| {} | {} | {} | {} | {} |".format(
            "T=%s" % f(T, 0), r["from_clock"], r["to_clock"],
            f(r["wns"]), f(r["whs"])))


def main():
    rs = runs()
    ic = rows("inter_clock.csv")
    e1(rs)
    print()
    e2(rs)
    print()
    e3(rs)
    print()
    e4(rs, ic)


if __name__ == "__main__":
    main()
