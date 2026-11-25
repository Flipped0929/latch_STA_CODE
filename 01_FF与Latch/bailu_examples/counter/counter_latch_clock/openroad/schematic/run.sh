#!/usr/bin/env bash
set -euo pipefail
SCHEMATIC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCHEMATIC_DIR/../.." && pwd)"
cd "$PROJECT_DIR"
python3 "$SCHEMATIC_DIR/build.py"
"${XSCHEM_EXE:-/home/bailufrost/.local/bin/xschem}" -x -q --rcfile "$PROJECT_DIR/xschemrc" \
  --script "$SCHEMATIC_DIR/export.tcl" "$PROJECT_DIR/counter_routed.sch" > "$SCHEMATIC_DIR/xschem.log" 2>&1
/usr/bin/python3 "$SCHEMATIC_DIR/render.py"
python3 "$SCHEMATIC_DIR/verify.py"
