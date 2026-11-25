source [file join [file dirname [info script]] common.tcl]
read_lef [file join $platform lef sky130_fd_sc_hd.tlef]
read_lef [file join $platform lef sky130_fd_sc_hd_merged.lef]
read_verilog [file join $input_dir counter_sky130.v]
link_design counter
read_sdc $sdc_file
# Apply the explicit output-latch sizes before placement so cell dimensions,
# clock loads, routing, RC extraction and STA all use the synchronized masters.
set fd [open [file join $flow_dir inputs output_latch_sizes.tsv] r]
set size_config [read $fd]
close $fd
foreach line [split $size_config \n] {
    set line [string trim $line]
    if {$line eq "" || [string match {#*} $line]} {continue}
    lassign $line instance target_master
    replace_cell $instance $target_master
}
sta::redirect_file_begin [file join $reports units.rpt]
report_units
sta::redirect_file_end
check_setup -verbose > [file join $reports input_constraints.rpt]

# Physical implementation of the supplied mapped netlist; no RTL resynthesis.
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
write_db [file join $results 1_placed.odb]

source [file join $flow_dir scripts clock_tree.tcl]
detailed_placement
set_propagated_clock [all_clocks]
estimate_parasitics -placement
report_cts -out_file [file join $reports cts.rpt]
if {$cts_mode ne "two_level"} {
    set fd [open [file join $reports cts.rpt] a]
    puts $fd "Additional explicit phi2 tree: one sky130_fd_sc_hd__clkbuf_$strength, four sinks."
    puts $fd "The TritonCTS counts above describe phi1 only; clock_endpoints.csv audits both physical trees."
    close $fd
}
check_placement -verbose
connect_power
write_db [file join $results 2_cts.odb]

set_routing_layers -signal met1-met5 -clock met3-met5
set_global_routing_layer_adjustment met1-met5 0.20
global_route -guide_file [file join $results counter.guide] \
    -congestion_report_file [file join $reports congestion.rpt] -verbose
detailed_route -output_drc [file join $reports route_drc.rpt] \
    -output_maze [file join $results maze.log] -drc_report_iter_step 5 \
    -db_process_node 130 -verbose 1
if {![design_is_routed]} {error "Design contains unrouted nets"}
check_antennas -report_file [file join $reports antenna.rpt]
filler_placement {sky130_fd_sc_hd__fill_8 sky130_fd_sc_hd__fill_4 sky130_fd_sc_hd__fill_2 sky130_fd_sc_hd__fill_1}
connect_power
check_placement -verbose
check_power_grid -net VDD -error_file [file join $reports vdd_grid.rpt]
check_power_grid -net VSS -error_file [file join $reports vss_grid.rpt]
write_db [file join $results counter_routed.odb]
write_def [file join $results counter_routed.def]
write_verilog -include_pwr_gnd [file join $results counter_power.v]
write_sdc [file join $results counter_propagated.sdc]
report_design_area

# Extract actual detailed-route geometry with the ORFS SKY130 RCX model.
define_process_corner -ext_model_index 0 nominal
extract_parasitics -ext_model_file [file join $platform rcx_patterns.rules] \
    -max_res 50 -coupling_threshold 0.1
write_spef [file join $results counter.spef]

# Export the timing view after saving the physical database and power netlist.
write_verilog -remove_cells {sky130_fd_sc_hd__fill_* sky130_fd_sc_hd__tapvpwrvgnd_*} \
    [file join $results counter_routed.v]
# This writer also emits unused supply ports even without -include_pwr_gnd.
# Remove only these isolated ports, verifying no supply references remain.
set timing_file [file join $results counter_routed.v]
set fd [open $timing_file r]
set timing_verilog [read $fd]
close $fd
if {![regsub {,\s*VSS,\s*VDD\);} $timing_verilog {);} timing_verilog]} {
    error "Unexpected supply port list in exported timing netlist"
}
regsub -all {\n inout V(?:DD|SS);} $timing_verilog {} timing_verilog
if {[regexp {\m(VDD|VSS)\M} $timing_verilog]} {
    error "Supply ports are not isolated in timing view"
}
set fd [open $timing_file w]
puts -nonewline $fd $timing_verilog
close $fd
puts "PNR_AND_RCX_COMPLETE"
