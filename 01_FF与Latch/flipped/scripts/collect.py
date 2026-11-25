#!/usr/bin/env python3
"""Collect all build/<tag>/ reports into tidy CSVs.

Outputs (under results/):
  all_latch_runs.csv   one row per run: params, cells, WNS/WHS/WPWS, borrow, hold details
  inter_clock.csv      one row per (run, from_clock, to_clock)
  path_details.csv     every parsed timing path (max and min reports)
  collect.json         nested dict used to write the report
"""
import csv
import json
import re
from pathlib import Path

WORK = Path(__file__).resolve().parent.parent
BUILD = WORK / "build"
OUT = WORK / "results"

SLACK_RE = re.compile(r'Slack \((MET|VIOLATED)\)\s*:\s*(-?\d+(?:\.\d+)?)ns')
SRC_RE = re.compile(r'^\s*Source:\s+(\S+)', re.M)
DST_RE = re.compile(r'^\s*Destination:\s+(\S+)', re.M)
GRP_RE = re.compile(r'^\s*Path Group:\s+(\S+)', re.M)
TYP_RE = re.compile(r'^\s*Path Type:\s+(.+?)\s*$', re.M)
REQ_RE = re.compile(r'Requirement:\s+(-?\d+(?:\.\d+)?)ns')
DPD_RE = re.compile(r'Data Path Delay:\s+(-?\d+(?:\.\d+)?)ns\s+'
                    r'\(logic\s+(-?\d+(?:\.\d+)?)ns.*?route\s+(-?\d+(?:\.\d+)?)ns')
MAXB_RE = re.compile(r'Computed max time borrow:\s+(-?\d+(?:\.\d+)?)ns')
BORROW_RE = re.compile(r'Time borrowed from endpoint:\s+(-?\d+(?:\.\d+)?)ns')
GIVEN_RE = re.compile(r'Time given to startpoint:\s+(-?\d+(?:\.\d+)?)ns')
PULSE_RE = re.compile(r'Nominal pulse width:\s+(-?\d+(?:\.\d+)?)ns')


def is_dash(line):
    s = line.strip()
    return bool(s) and "-" in s and set(s) <= set("- ")


def fnum(s):
    try:
        return float(s)
    except (TypeError, ValueError):
        return None


def read(path):
    try:
        return path.read_text(encoding="utf-8", errors="replace")
    except FileNotFoundError:
        return ""


def parse_design_summary(text):
    """First Design Timing Summary table row."""
    lines = text.splitlines()
    for i, ln in enumerate(lines):
        if "WNS(ns)" in ln and "WHS(ns)" in ln:
            j = i + 1
            while j < len(lines) and is_dash(lines[j]):
                j += 1
            if j >= len(lines):
                return {}
            vals = lines[j].split()
            names8 = ["wns", "tns", "tns_fep", "tns_tep",
                      "whs", "ths", "ths_fep", "ths_tep"]
            names12 = names8 + ["wpws", "tpws", "tpws_fep", "tpws_tep"]
            if len(vals) >= 12:
                return {k: fnum(v) for k, v in zip(names12, vals)}
            if len(vals) >= 8:
                return {k: fnum(v) for k, v in zip(names8, vals)}
    return {}


def parse_inter_clock(text):
    lines = text.splitlines()
    rows = []
    for si, ln in enumerate(lines):
        if "Inter Clock Table" in ln and ln.strip().startswith("|"):
            j = si
            while j < len(lines) and "From Clock" not in lines[j]:
                j += 1
            if j >= len(lines):
                break
            j += 1
            while j < len(lines) and is_dash(lines[j]):
                j += 1
            while j < len(lines):
                s = lines[j].strip()
                if not s or s.startswith("|") or is_dash(lines[j]):
                    break
                tok = s.split()
                if len(tok) >= 10:
                    rows.append([tok[0], tok[1]] + [fnum(t) for t in tok[2:10]])
                j += 1
            break
    return rows


def parse_util(text):
    out = {}
    m = re.search(r'\|\s+Register as Flip Flop\s+\|\s+(\d+)', text)
    out["ff_regs"] = int(m.group(1)) if m else None
    m = re.search(r'\|\s+Register as Latch\s+\|\s+(\d+)', text)
    out["latch_regs"] = int(m.group(1)) if m else None
    m = re.search(r'\|\s+LUT as Logic\s+\|\s+(\d+)', text)
    out["lut"] = int(m.group(1)) if m else None
    return out


def split_blocks(text):
    return [b for b in re.split(r'(?=^Slack \()', text, flags=re.M) if SLACK_RE.search(b)]


def parse_paths(text, tag, kind):
    rows = []
    for b in split_blocks(text):
        m = SLACK_RE.search(b)
        dpd = DPD_RE.search(b)
        rows.append({
            "run": tag, "report": kind,
            "slack_ns": fnum(m.group(2)), "status": m.group(1),
            "source": (SRC_RE.search(b).group(1) if SRC_RE.search(b) else ""),
            "destination": (DST_RE.search(b).group(1) if DST_RE.search(b) else ""),
            "path_group": (GRP_RE.search(b).group(1) if GRP_RE.search(b) else ""),
            "path_type": (TYP_RE.search(b).group(1).strip() if TYP_RE.search(b) else ""),
            "requirement_ns": fnum(REQ_RE.search(b).group(1)) if REQ_RE.search(b) else None,
            "data_path_ns": fnum(dpd.group(1)) if dpd else None,
            "logic_ns": fnum(dpd.group(2)) if dpd else None,
            "route_ns": fnum(dpd.group(3)) if dpd else None,
            "max_borrow_ns": fnum(MAXB_RE.search(b).group(1)) if MAXB_RE.search(b) else None,
            "borrowed_ns": fnum(BORROW_RE.search(b).group(1)) if BORROW_RE.search(b) else None,
            "given_ns": fnum(GIVEN_RE.search(b).group(1)) if GIVEN_RE.search(b) else None,
            "pulse_width_ns": fnum(PULSE_RE.search(b).group(1)) if PULSE_RE.search(b) else None,
        })
    return rows


def parse_meta(path):
    meta = {}
    for line in read(path).splitlines():
        if "," in line:
            k, v = line.split(",", 1)
            meta[k.strip()] = v.strip()
    return meta


def parse_vivado_version(*texts):
    m = re.search(r'Vivado v\.(\S+)', read(BUILD / "ff_b1_T640_r40_w160" / "timing_summary.rpt"))
    return m.group(1) if m else ""


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    run_rows, ic_rows, path_rows = [], [], []
    raw = {}

    for d in sorted(BUILD.iterdir()):
        if not d.is_dir() or d.name.startswith("_"):
            continue
        meta_path = d / "run_meta.csv"
        if not meta_path.exists():
            continue
        meta = parse_meta(meta_path)
        tag = d.name

        ts = read(d / "timing_summary.rpt")
        ds = parse_design_summary(ts)
        ic = parse_inter_clock(ts)
        util = parse_util(read(d / "utilization.rpt"))
        grp = {}
        for line in read(d / "summary.csv").splitlines()[1:]:
            parts = line.split(",")
            if len(parts) >= 8:
                key = "{}_{}".format(parts[5], parts[6])
                grp[key] = fnum(parts[7])

        max_rows = parse_paths(read(d / "paths_max.rpt"), tag, "max")
        min_rows = parse_paths(read(d / "paths_min.rpt"), tag, "min")
        path_rows.extend(max_rows)
        path_rows.extend(min_rows)

        borrow = [r["borrowed_ns"] for r in max_rows if r["borrowed_ns"] is not None]
        given = [r["given_ns"] for r in max_rows if r["given_ns"] is not None]
        maxb = [r["max_borrow_ns"] for r in max_rows if r["max_borrow_ns"] is not None]

        worst_hold = min(min_rows, key=lambda r: r["slack_ns"]) if min_rows else {}

        row = {
            "run": tag,
            "variant": meta.get("variant", ""),
            "blocks": int(meta.get("blocks", 0) or 0),
            "period_ns": fnum(meta.get("period_ns")),
            "arise_ns": fnum(meta.get("arise_ns")),
            "awidth_ns": fnum(meta.get("awidth_ns")),
            "fd_cells": int(meta.get("fd_cells", 0) or 0),
            "ld_cells": int(meta.get("ld_cells", 0) or 0),
            "lut_cells": int(meta.get("lut_cells", 0) or 0),
            "bufg_cells": int(meta.get("bufg_cells", 0) or 0),
            "ff_regs": util.get("ff_regs"),
            "latch_regs": util.get("latch_regs"),
        }
        row.update({k: ds.get(k) for k in
                    ["wns", "tns", "tns_fep", "whs", "ths", "ths_fep",
                     "wpws", "tpws", "tpws_fep"]})
        row.update(grp)
        row["max_borrow_ns"] = max(borrow) if borrow else None
        row["max_given_ns"] = max(given) if given else None
        row["max_borrow_capacity_ns"] = max(maxb) if maxb else None
        row["paths_with_borrow"] = len(borrow)
        row["failing_setup_paths"] = sum(1 for r in max_rows if (r["slack_ns"] or 0) < 0)
        row["failing_hold_paths"] = sum(1 for r in min_rows if (r["slack_ns"] or 0) < 0)
        row["worst_hold_source"] = worst_hold.get("source")
        row["worst_hold_destination"] = worst_hold.get("destination")
        row["worst_hold_group"] = worst_hold.get("path_group")
        row["worst_hold_type"] = worst_hold.get("path_type")
        row["worst_hold_requirement_ns"] = worst_hold.get("requirement_ns")
        row["worst_hold_datapath_ns"] = worst_hold.get("data_path_ns")
        row["worst_hold_slack_ns"] = worst_hold.get("slack_ns")
        row["constraints_met"] = ("All user specified timing constraints are met" in ts)
        row["sdf_written"] = (d / "routed.sdf").exists()
        run_rows.append(row)

        for r in ic:
            ic_rows.append({"run": tag, "variant": row["variant"],
                            "blocks": row["blocks"], "period_ns": row["period_ns"],
                            "arise_ns": row["arise_ns"],
                            "from_clock": r[0], "to_clock": r[1],
                            "wns": r[2], "tns": r[3], "tns_fep": r[4], "tns_tep": r[5],
                            "whs": r[6], "ths": r[7], "ths_fep": r[8], "ths_tep": r[9]})
        raw[tag] = {"meta": meta, "design": ds, "inter_clock": ic,
                    "summary_csv": grp}

    def dump(name, rows, cols=None):
        if not rows:
            print("no rows for", name)
            return
        cols = cols or list(rows[0].keys())
        with open(OUT / name, "w", newline="", encoding="utf-8") as fh:
            wr = csv.DictWriter(fh, fieldnames=cols, extrasaction="ignore")
            wr.writeheader()
            wr.writerows(rows)
        print("wrote {} rows -> {}".format(len(rows), OUT / name))

    dump("all_latch_runs.csv", run_rows)
    dump("inter_clock.csv", ic_rows)
    dump("path_details.csv", path_rows)
    (OUT / "collect.json").write_text(
        json.dumps({"runs": raw, "vivado": parse_vivado_version()}, indent=1),
        encoding="utf-8")
    print("runs collected:", len(run_rows))


if __name__ == "__main__":
    main()
