source [file join [file dirname [info script]] common.tcl]
read_verilog [file join $input_dir counter_sky130.v]
link_design counter
read_counter_sdc

initialize_floorplan -site unithd -die_area {0 0 60 60} \
    -core_area {5.52 5.44 54.28 54.4}
source [file join $platform make_tracks.tcl]
tapcell -distance 14 -tapcell_master sky130_fd_sc_hd__tapvpwrvgnd_1
source [file join $platform pdn.tcl]
pdngen -failed_via_report [file join $reports pdn_failed_vias.rpt]
place_pins -hor_layers met3 -ver_layers met2 -corner_avoidance 3 -min_distance 3
source [file join $platform setRC.tcl]
global_placement -density 0.35
detailed_placement
check_placement -verbose

clock_tree_synthesis -clk_nets {clk_1} -root_buf sky130_fd_sc_hd__clkbuf_2 \
    -buf_list {sky130_fd_sc_hd__clkbuf_1 sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4} \
    -sink_clustering_enable -sink_clustering_size 8 -sink_clustering_max_diameter 30 -repair_clock_nets

# Drive the four gated latch sinks with one clock buffer near their centroid.
set block [ord::get_db_block]
set gated_net [$block findNet gated_clk_2_10]
set x_sum 0.0
set y_sum 0.0
set sink_count 0
foreach terminal [$gated_net getITerms] {
    if {[[$terminal getMTerm] getIoType] ne "INPUT"} {continue}
    set box [[$terminal getInst] getBBox]
    set x_sum [expr {$x_sum + ([$box xMin] + [$box xMax]) / 2.0}]
    set y_sum [expr {$y_sum + ([$box yMin] + [$box yMax]) / 2.0}]
    incr sink_count
}
if {$sink_count != 4} {error "Expected four gated clock sinks, got $sink_count"}
set scale [expr {double($sink_count * [$block getDbUnitsPerMicron])}]
set center [list [expr {$x_sum / $scale}] [expr {$y_sum / $scale}]]
insert_buffer -net gated_clk_2_10 -buffer_cell sky130_fd_sc_hd__clkbuf_2 \
    -buffer_name clkbuf_phi2 -net_name clknet_phi2 -location $center
detailed_placement
check_placement -verbose
report_cts -out_file [file join $reports cts_phi1.rpt]
global_connect
set_propagated_clock [all_clocks]

set_routing_layers -signal met1-met5 -clock met3-met5
set_global_routing_layer_adjustment met1-met5 0.20
global_route -guide_file [file join $results counter.guide] \
    -congestion_report_file [file join $reports congestion.rpt] -verbose
detailed_route -output_drc [file join $reports route_drc.rpt] -db_process_node 130 -verbose 1
if {![design_is_routed -verbose]} {error "Design contains unrouted nets"}
if {[file size [file join $reports route_drc.rpt]] != 0} {
    error "Detailed routing produced DRC markers"
}
if {[check_antennas -report_file [file join $reports antenna.rpt]]} {
    error "Antenna violations in detailed routing"
}
filler_placement {sky130_fd_sc_hd__fill_8 sky130_fd_sc_hd__fill_4 sky130_fd_sc_hd__fill_2 sky130_fd_sc_hd__fill_1}
global_connect
check_placement -verbose
check_power_grid -net VDD -error_file [file join $reports vdd_grid.rpt]
check_power_grid -net VSS -error_file [file join $reports vss_grid.rpt]
report_wire_length -detailed_route -summary
report_design_area

write_def [file join $results counter_routed.def]
write_verilog -include_pwr_gnd [file join $results counter_power.v]
set timing_netlist [file join $results counter_routed.v]
write_verilog -remove_cells {sky130_fd_sc_hd__fill_* sky130_fd_sc_hd__tapvpwrvgnd_*} $timing_netlist
# The Verilog writer retains the top-level supply ports in the timing view.
# Remove the port declarations after verifying they have no signal connections.
set fd [open $timing_netlist r]
set verilog [read $fd]
close $fd
if {![regsub {,\s*VSS,\s*VDD\);} $verilog {);} verilog]} {
    error "Unexpected supply port list in the timing netlist"
}
regsub -all {\n inout V(?:DD|SS);} $verilog {} verilog
if {[regexp {\m(VDD|VSS)\M} $verilog]} {
    error "Supply ports have references in the timing netlist"
}
set fd [open $timing_netlist w]
puts -nonewline $fd $verilog
close $fd

define_process_corner -ext_model_index 0 nominal
extract_parasitics -ext_model_file [file join $platform rcx_patterns.rules] \
    -max_res 50 -coupling_threshold 0.1
write_spef [file join $results counter.spef]
write_db [file join $results counter_routed.odb]
puts "PNR_AND_RCX_COMPLETE"
