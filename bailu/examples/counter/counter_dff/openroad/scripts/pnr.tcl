source [file join [file dirname [info script]] common.tcl]
guarded {
    set_thread_count 2
    load_technology
    read_verilog $run_dir/inputs/counter_sky130.v
    link_design counter
    read_sdc $run_dir/inputs/counter.sdc
    if {[llength [all_registers -edge_triggered -cells]] != 4} {error "Expected 4 D flip-flops"}
    timing_snapshot 00_netlist
    initialize_floorplan -die_area {0 0 60 60} -core_area {10.12 10.88 49.68 48.96} -site unithd
    source $platform/make_tracks.tcl
    source $platform/setRC.tcl
    set_routing_layers -signal met1-met5 -clock met3-met5
    set_global_routing_layer_adjustment met1-met5 0.2
    set_io_pin_constraint -pin_names {clk} -region bottom:24-36
    set_io_pin_constraint -pin_names {en rst_n} -region left:15-45 -group -order
    set_io_pin_constraint -pin_names {count[0] count[1] count[2] count[3]} -region right:15-45 -group -order
    place_pins -hor_layers met3 -ver_layers met2 -corner_avoidance 8 -min_distance 2
    tapcell -distance 14 -tapcell_master sky130_fd_sc_hd__tapvpwrvgnd_1 -endcap_master sky130_fd_sc_hd__tapvpwrvgnd_1
    power_connect
    set_voltage_domain -name CORE -power VDD -ground VSS
    define_pdn_grid -name core_grid -voltage_domains CORE -pins {met5}
    add_pdn_ring -grid core_grid -layers {met4 met5} -widths {1.6 1.6} -spacings {1.7 1.7} -core_offsets {2.4 2.4}
    add_pdn_stripe -grid core_grid -layer met1 -width 0.48 -pitch 5.44 -offset 0 -followpins -extend_to_core_ring
    add_pdn_stripe -grid core_grid -layer met4 -width 1.6 -pitch 20 -offset 4 -snap_to_grid -extend_to_core_ring
    add_pdn_stripe -grid core_grid -layer met5 -width 1.6 -pitch 20 -offset 4 -snap_to_grid -extend_to_core_ring
    add_pdn_connect -grid core_grid -layers {met1 met4}
    add_pdn_connect -grid core_grid -layers {met4 met5}
    pdngen -failed_via_report $reports/pdn_failed_vias.rpt
    write_db $results/01_floorplan.odb
    global_placement -density 0.35
    detailed_placement
    check_placement -verbose
    estimate_parasitics -placement
    timing_snapshot 02_placed
    write_db $results/02_placed.odb
    clock_tree_synthesis -root_buf sky130_fd_sc_hd__clkbuf_4 -tree_buf sky130_fd_sc_hd__clkbuf_2 \
        -buf_list {sky130_fd_sc_hd__clkbuf_1 sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4} \
        -sink_clustering_enable -sink_clustering_size 4 -sink_clustering_max_diameter 20
    detailed_placement
    power_connect
    set_propagated_clock [all_clocks]
    estimate_parasitics -placement
    set_dont_use {sky130_fd_sc_hd__lpflow* sky130_fd_sc_hd__probe*}
    repair_timing -setup -setup_margin 0.03 -max_passes 10
    repair_timing -hold -hold_margin 0.03 -max_passes 10
    detailed_placement
    power_connect
    check_placement -verbose
    estimate_parasitics -placement
    report_cts -out_file $reports/cts.rpt
    timing_snapshot 03_cts
    write_db $results/03_cts.odb
    global_route -guide_file $results/counter.guide -congestion_report_file $reports/congestion.rpt
    estimate_parasitics -global_routing
    timing_snapshot 04_global_route
    write_db $results/04_global_route.odb
    detailed_route -output_drc $reports/route_drc.rpt -output_maze $run_dir/logs/route_maze.log \
        -output_guide_coverage $reports/guide_coverage.csv -or_seed 42
    set drvs [detailed_route_num_drvs]
    if {$drvs != 0} {error "Detailed route has $drvs DRC violations"}
    if {![design_is_routed -verbose]} {error "Unrouted nets remain"}
    filler_placement {sky130_fd_sc_hd__fill_8 sky130_fd_sc_hd__fill_4 sky130_fd_sc_hd__fill_2 sky130_fd_sc_hd__fill_1}
    power_connect
    check_placement -verbose
    check_power_grid -net VDD -error_file $reports/vdd_connectivity.rpt
    check_power_grid -net VSS -error_file $reports/vss_connectivity.rpt
    check_antennas -report_file $reports/antenna.rpt
    report_wire_length -detailed_route -net * -file $reports/wire_length.rpt
    report_wire_length -detailed_route -summary
    set fd [open $reports/route_status.rpt w]
    puts $fd "Detailed-route DRC violations: $drvs"
    puts $fd "All signal/clock nets routed: true"
    close $fd
    write_db $results/counter_routed.odb
    write_def $results/counter_routed.def
    write_verilog -remove_cells {sky130_fd_sc_hd__fill* sky130_fd_sc_hd__tapvpwrvgnd*} $results/counter_routed.v
    write_verilog -include_pwr_gnd $results/counter_routed_power.v
    write_sdc -no_timestamp -digits 9 $results/counter_propagated.sdc
    puts "PNR_COMPLETE"
}
