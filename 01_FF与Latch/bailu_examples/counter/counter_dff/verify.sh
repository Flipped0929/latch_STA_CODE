#!/usr/bin/env bash
set -euo pipefail
project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$project_dir"
counter_temp="$(mktemp -d /tmp/counter-xschem.XXXXXX)"
mkdir -p "$counter_temp/config" "$counter_temp/netlist"
# Export into /tmp before copying back: avoids file truncation issues on HGFS.
DISPLAY= xschem -x -r -q --rcfile "$project_dir/xschemrc" \
  --tcl "set USER_CONF_DIR {$counter_temp/config}" -w -n \
  -o "$counter_temp/netlist" -N counter_from_schematic.v counter.sch \
  > "$counter_temp/xschem.log" 2>&1
cp "$counter_temp/netlist/counter_from_schematic.v" verification/counter_from_schematic.v
python3 verification/check_connections.py > "$counter_temp/connections.log"
yosys -Q -T -s verification/equivalence.ys > "$counter_temp/equivalence.log" 2>&1
iverilog -g2012 -s counter_tb -o "$counter_temp/counter_sim" \
  verification/cells.v verification/counter_from_schematic.v verification/counter_tb.v
vvp "$counter_temp/counter_sim" > "$counter_temp/simulation.log"
cp "$counter_temp/xschem.log" "$counter_temp/connections.log" \
  "$counter_temp/equivalence.log" "$counter_temp/simulation.log" verification/
cat verification/connections.log
rg 'Equivalence successfully proven' verification/equivalence.log
cat verification/simulation.log
