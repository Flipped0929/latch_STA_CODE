#!/usr/bin/env python3
"""Collect the borrow-arbitration runs into a tidy CSV.

For every build directory under $DSH_OUTROOT/build this reads
  run_meta.csv   variant, period, phases, d1, d2, cell counts
  summary.csv    per-group worst slack (max = setup, min = hold)
  paths_max.rpt  every path block: source, destination, requirement,
                 data path delay, time borrowed from endpoint
and writes results/arb_runs.csv + results/arb_paths.csv.
"""
import csv
import os
import re
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
BUILD = Path(os.environ.get("DSH_OUTROOT", str(WORK))) / "build"
OUT = Path(os.environ.get("DSH_RESULTS", str(WORK / "results")))

SLACK_RE = re.compile(r'Slack \((MET|VIOLATED)\)\s*:\s*(-?\d+(?:\.\d+)?)ns')
SRC_RE = re.compile(r'^\s*Source:\s+(\S+)', re.M)
DST_RE = re.compile(r'^\s*Destination:\s+(\S+)', re.M)
GRP_RE = re.compile(r'^\s*Path Group:\s+(\S+)', re.M)
REQ_RE = re.compile(r'Requirement:\s+(-?\d+(?:\.\d+)?)ns')
DPD_RE = re.compile(r'Data Path Delay:\s+(-?\d+(?:\.\d+)?)ns\s+\(logic\s+(-?\d+(?:\.\d+)?)ns')
BORROW_RE = re.compile(r'Time borrowed from endpoint:\s+(-?\d+(?:\.\d+)?)ns')
PULSE_RE = re.compile(r'Nominal pulse width:\s+(-?\d+(?:\.\d+)?)ns')
MAXB_RE = re.compile(r'Computed max time borrow:\s+(-?\d+(?:\.\d+)?)ns')


def read(p):
    try:
        return Path(p).read_text(encoding="utf-8", errors="replace")
    except FileNotFoundError:
        return ""


def meta(path):
    out = {}
    for line in read(path).splitlines():
        if "," in line:
            k, v = line.split(",", 1)
            out[k.strip()] = v.strip()
    return out


def paths(text):
    blocks = [b for b in re.split(r'(?=^Slack \()', text, flags=re.M) if SLACK_RE.search(b)]
    out = []
    for b in blocks:
        m = SLACK_RE.search(b)
        dpd = DPD_RE.search(b)
        rec = {"slack": float(m.group(2)), "status": m.group(1),
               "src": (SRC_RE.search(b).group(1) if SRC_RE.search(b) else ""),
               "dst": (DST_RE.search(b).group(1) if DST_RE.search(b) else ""),
               "group": (GRP_RE.search(b).group(1) if GRP_RE.search(b) else ""),
               "req": float(REQ_RE.search(b).group(1)) if REQ_RE.search(b) else None,
               "data": float(dpd.group(1)) if dpd else None,
               "borrow": float(BORROW_RE.search(b).group(1)) if BORROW_RE.search(b) else None,
               "maxborrow": float(MAXB_RE.search(b).group(1)) if MAXB_RE.search(b) else None,
               "pulse": float(PULSE_RE.search(b).group(1)) if PULSE_RE.search(b) else None}
        out.append(rec)
    return out


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    rows, allpaths = [], []
    for d in sorted(BUILD.iterdir()):
        if not d.is_dir() or not (d / "run_meta.csv").exists():
            continue
        m = meta(d / "run_meta.csv")
        setup = {}
        hold = {}
        for line in read(d / "summary.csv").splitlines()[1:]:
            p = line.split(",")
            if len(p) >= 7:
                (setup if p[5] == "max" else hold)[p[4]] = float(p[6])
        ps = paths(read(d / "paths_max.rpt"))
        for p in ps:
            allpaths.append({"tag": d.name, "variant": m.get("variant"),
                             "T": m.get("period_ns"), "d2": m.get("d2"), **p})
        # the interesting path: the one ending at r2 (the d2 chain), max borrow
        r2 = [p for p in ps if p["dst"].startswith("r2_reg")]
        best = max(r2, key=lambda p: p["borrow"] or 0) if r2 else None
        r1 = [p for p in ps if p["dst"].startswith("r1_reg")]
        best1 = max(r1, key=lambda p: p["borrow"] or 0) if r1 else None
        rows.append({
            "tag": d.name,
            "variant": m.get("variant"),
            "T_ns": float(m.get("period_ns", 0)),
            "pa_rise": float(m.get("pa_rise_ns", 0)),
            "pa_fall": float(m.get("pa_fall_ns", 0)),
            "pb_rise": float(m.get("pb_rise_ns", 0)),
            "pb_fall": float(m.get("pb_fall_ns", 0)),
            "d1": int(m.get("d1", 0)),
            "d2": int(m.get("d2", 0)),
            "lut": int(m.get("lut_cells", 0)),
            "ff": int(m.get("fd_cells", 0)),
            "latch": int(m.get("ld_cells", 0)),
            "wns": min(setup.values()) if setup else None,
            "whs": min(hold.values()) if hold else None,
            "wns_group": min(setup, key=setup.get) if setup else "",
            "borrow_r2": (best["borrow"] if best else None),
            "borrow_r2_data": (best["data"] if best else None),
            "borrow_r2_req": (best["req"] if best else None),
            "borrow_r1": (best1["borrow"] if best1 else None),
            "borrow_r1_data": (best1["data"] if best1 else None),
        })

    rows.sort(key=lambda r: (r["variant"], r["T_ns"], r["d2"]))
    cols = list(rows[0].keys()) if rows else []
    with open(OUT / "arb_runs.csv", "w", newline="", encoding="utf-8") as fh:
        wr = csv.DictWriter(fh, fieldnames=cols)
        wr.writeheader()
        wr.writerows(rows)
    with open(OUT / "arb_paths.csv", "w", newline="", encoding="utf-8") as fh:
        wr = csv.DictWriter(fh, fieldnames=list(allpaths[0].keys()))
        wr.writeheader()
        wr.writerows(allpaths)
    print("runs=%d paths=%d -> %s" % (len(rows), len(allpaths), OUT / "arb_runs.csv"))

    print("\n| variant | T | W | d2 | LUT | WNS | WNS group | borrow(r1->r2) | d2 data |")
    print("|---|---:|---:|---:|---:|---:|---|---:|---:|")
    for r in rows:
        print("| %s | %g | %g | %d | %d | %s | %s | %s | %s |" % (
            r["variant"], r["T_ns"], r["pa_fall"], r["d2"], r["lut"],
            ("%.3f" % r["wns"]) if r["wns"] is not None else "-",
            r["wns_group"],
            ("%.3f" % r["borrow_r2"]) if r["borrow_r2"] is not None else "-",
            ("%.3f" % r["borrow_r2_data"]) if r["borrow_r2_data"] is not None else "-"))


if __name__ == "__main__":
    main()
