#!/usr/bin/env bash
set -euo pipefail

flow_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export SKY130_PLATFORM="${SKY130_PLATFORM:-$HOME/eda/OpenROAD-flow-scripts-live/flow/platforms/sky130hd}"
openroad_exe="${OPENROAD_EXE:-openroad}"
cd "$flow_dir"
mkdir -p results reports logs
"$openroad_exe" -no_init -exit -log logs/pnr.log scripts/pnr.tcl
"$openroad_exe" -no_init -exit -log logs/sta.log scripts/sta.tcl
