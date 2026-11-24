#!/usr/bin/env bash
set -euo pipefail
TASK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$TASK_DIR"
export SKY130_PLATFORM="${SKY130_PLATFORM:-/home/bailufrost/eda/OpenROAD-flow-scripts-live/flow/platforms/sky130hd}"
OPENROAD_EXE="${OPENROAD_EXE:-/home/bailufrost/.local/bin/openroad}"
export OPENROAD_RUN_DIR="${OPENROAD_RUN_DIR:-$TASK_DIR}"
mkdir -p "$OPENROAD_RUN_DIR/results" "$OPENROAD_RUN_DIR/reports" "$OPENROAD_RUN_DIR/logs"
"$OPENROAD_EXE" -no_init -exit -log "$OPENROAD_RUN_DIR/logs/pnr.log" scripts/pnr.tcl
"$OPENROAD_EXE" -no_init -exit -log "$OPENROAD_RUN_DIR/logs/sta.log" scripts/sta.tcl
python3 scripts/summarize.py
