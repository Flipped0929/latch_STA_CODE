#!/usr/bin/env python3
"""Parse Vivado report_timing text reports into CSV.

Usage:
    python parse_reports.py build/*/paths_max.rpt -o results/timing_paths.csv
"""
import argparse
import csv
import re
from pathlib import Path

SLACK_RE = re.compile(r'Slack \((MET|VIOLATED)\)\s*:\s*(-?\d+(?:\.\d+)?)ns')
SOURCE_RE = re.compile(r'Source:\s+(\S+)')
DEST_RE = re.compile(r'Destination:\s+(\S+)')
GROUP_RE = re.compile(r'Path Group:\s+(\S+)')
REQ_RE = re.compile(r'Requirement:\s+(-?\d+(?:\.\d+)?)ns')
DPD_RE = re.compile(
    r'Data Path Delay:\s+(-?\d+(?:\.\d+)?)ns\s+'
    r'\(logic\s+(-?\d+(?:\.\d+)?)ns.*?route\s+(-?\d+(?:\.\d+)?)ns'
)
MAXB_RE = re.compile(r'Computed max time borrow:\s+(-?\d+(?:\.\d+)?)ns')
BORROW_RE = re.compile(r'Time borrowed from endpoint:\s+(-?\d+(?:\.\d+)?)ns')
GIVEN_RE = re.compile(r'Time given to startpoint:\s+(-?\d+(?:\.\d+)?)ns')


def field(regex, block):
    m = regex.search(block)
    return m.group(1) if m else ''


def parse_report(path):
    text = Path(path).read_text(encoding='utf-8', errors='ignore')
    blocks = re.split(r'(?=^Slack \()', text, flags=re.MULTILINE)
    rows = []
    for block in blocks:
        m = SLACK_RE.search(block)
        if not m:
            continue
        dpd = DPD_RE.search(block)
        rows.append({
            'report': str(Path(path)),
            'slack_ns': m.group(2),
            'status': m.group(1),
            'source': field(SOURCE_RE, block),
            'destination': field(DEST_RE, block),
            'path_group': field(GROUP_RE, block),
            'requirement_ns': field(REQ_RE, block),
            'data_path_ns': dpd.group(1) if dpd else '',
            'logic_ns': dpd.group(2) if dpd else '',
            'route_ns': dpd.group(3) if dpd else '',
            'max_borrow_ns': field(MAXB_RE, block),
            'borrowed_ns': field(BORROW_RE, block),
            'given_ns': field(GIVEN_RE, block),
        })
    return rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('reports', nargs='+')
    ap.add_argument('-o', '--output', default='timing_paths.csv')
    ap.add_argument('--dedupe', action='store_true')
    args = ap.parse_args()

    all_rows = []
    for r in args.reports:
        all_rows.extend(parse_report(r))

    if args.dedupe:
        seen = set()
        unique = []
        for row in all_rows:
            key = (row['report'], row['source'], row['destination'],
                   row['path_group'], row['slack_ns'], row['data_path_ns'],
                   row['borrowed_ns'])
            if key in seen:
                continue
            seen.add(key)
            unique.append(row)
        all_rows = unique

    out = Path(args.output)
    out.parent.mkdir(parents=True, exist_ok=True)
    columns = ['report', 'slack_ns', 'status', 'source', 'destination',
               'path_group', 'requirement_ns', 'data_path_ns', 'logic_ns',
               'route_ns', 'max_borrow_ns', 'borrowed_ns', 'given_ns']
    with out.open('w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=columns)
        writer.writeheader()
        writer.writerows(all_rows)
    print(f'wrote {len(all_rows)} paths to {out}')


if __name__ == '__main__':
    main()
