set run_dir [file dirname [file dirname [file normalize [info script]]]]
set design_dir [file dirname [file dirname $run_dir]]
set platform /home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd
if {[info exists ::env(SKY130HD_PLATFORM)]} {set platform [file normalize $::env(SKY130HD_PLATFORM)]}
set liberty $design_dir/../../../sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib
set report_dir $run_dir/reports
set result_dir $run_dir/results
file mkdir $report_dir $result_dir

set netlist $run_dir/inputs/counter_sky130_2.v
set sdc $run_dir/inputs/counter.sdc
