# Write a timing-simulation netlist (with specify blocks) from a routed checkpoint.
# Usage: vivado -mode batch -source scripts/write_timesim.tcl -tclargs <routed.dcp> <timesim.v>
set dcp [lindex $argv 0]
set out [lindex $argv 1]
open_checkpoint $dcp
write_verilog -mode timesim -force $out
puts "WROTE: $out"
