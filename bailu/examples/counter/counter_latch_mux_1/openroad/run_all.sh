#!/usr/bin/env bash
set -euo pipefail
run_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd -- "$run_dir/.."
mkdir -p "$run_dir/logs"
openroad -no_init -exit "$run_dir/scripts/run_pnr.tcl" > "$run_dir/logs/pnr.log" 2>&1
openroad -no_init -exit "$run_dir/scripts/postroute_sta.tcl" > "$run_dir/logs/postroute_sta.log" 2>&1
if command -v sta >/dev/null 2>&1; then
    POSTROUTE_REPORT_SUBDIR=standalone_sta sta -no_init -exit "$run_dir/scripts/postroute_sta.tcl" > "$run_dir/logs/standalone_sta.log" 2>&1
fi
openroad -no_init -exit "$run_dir/scripts/check_layout.tcl" > "$run_dir/logs/layout_check.log" 2>&1
yosys -Q -T -s "$run_dir/scripts/check_equivalence.ys" > "$run_dir/logs/equivalence.log" 2>&1
python3 "$run_dir/scripts/summarize.py"
python3 "$run_dir/scripts/render_preview.py"
