#!/usr/bin/env bash
set -euo pipefail
scenario_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$scenario_dir/logs"
openroad -no_init -exit "$scenario_dir/run_sta.tcl" > "$scenario_dir/logs/openroad.log" 2>&1
sta -no_init -exit "$scenario_dir/run_sta.tcl" > "$scenario_dir/logs/standalone.log" 2>&1
python3 "$scenario_dir/summarize.py"
