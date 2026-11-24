#!/usr/bin/env bash
set -euo pipefail
TASK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$TASK_DIR"
export SKY130_PLATFORM="${SKY130_PLATFORM:-/home/bailufrost/eda/OpenROAD-flow-scripts-live/flow/platforms/sky130hd}"
OPENROAD_EXE="${OPENROAD_EXE:-/home/bailufrost/.local/bin/openroad}"
mkdir -p results reports logs
"$OPENROAD_EXE" -no_init -exit -log logs/pnr.log scripts/pnr.tcl
"$OPENROAD_EXE" -no_init -exit -log logs/sta.log scripts/sta.tcl
python3 scripts/summarize.py
