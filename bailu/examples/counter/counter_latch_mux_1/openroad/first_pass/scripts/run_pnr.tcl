source [file join [file dirname [info script]] config.tcl]
proc run_flow {} {
    global run_dir design_dir platform liberty report_dir result_dir netlist sdc
    set_thread_count 2
    read_lef $platform/lef/sky130_fd_sc_hd.tlef
    read_lef $platform/lef/sky130_fd_sc_hd_merged.lef
    read_liberty $liberty
    read_verilog $netlist
    link_design counter
    read_sdc $sdc
    if {[llength [all_registers -level_sensitive -cells]] != 10} {error "Expected ten latches"}
    initialize_floorplan -die_area {0 0 80 80} -core_area {10.12 10.88 70 70} -site unithd
    source $platform/make_tracks.tcl
    source $platform/setRC.tcl
    set_routing_layers -signal met1-met5 -clock met3-met5
    set_global_routing_layer_adjustment met1-met5 0.2
    place_pins -hor_layers met3 -ver_layers met2
    tapcell -distance 14 -tapcell_master sky130_fd_sc_hd__tapvpwrvgnd_1
    source $platform/pdn.tcl
    pdngen -failed_via_report $report_dir/pdn_failed_vias.rpt
    write_db $result_dir/01_floorplan.odb
    global_placement -density 0.35
    detailed_placement
    check_placement -verbose
    estimate_parasitics -placement
    write_db $result_dir/02_placed.odb
    clock_tree_synthesis -root_buf sky130_fd_sc_hd__clkbuf_4 \
        -buf_list {sky130_fd_sc_hd__clkbuf_1 sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4 sky130_fd_sc_hd__clkbuf_8} \
        -clk_nets {clk_1 clk_2} -sink_clustering_enable -sink_clustering_size 5 \
        -sink_clustering_max_diameter 50
    report_cts -out_file $report_dir/cts.rpt
    set_propagated_clock [all_clocks]
    # Preserve external reset budgets while delaying reset release to track CTS insertion.
    insert_buffer -net rst_n -buffer_cell sky130_fd_sc_hd__buf_1 \
        -buffer_name reset_release_buf -net_name rst_n_buffered -location {40 40}
    detailed_placement
    global_connect
    check_placement -verbose
    estimate_parasitics -placement
    set_dont_use {sky130_fd_sc_hd__lpflow* sky130_fd_sc_hd__probe*}
    repair_timing -setup -setup_margin 0.03 -max_passes 10 -skip_buffer_removal
    detailed_placement
    global_connect
    check_placement -verbose
    write_db $result_dir/03_cts.odb
    global_route -guide_file $result_dir/counter.guide -congestion_report_file $report_dir/congestion.rpt
    estimate_parasitics -global_routing
    write_db $result_dir/04_global_route.odb
    detailed_route -output_drc $report_dir/route_drc.rpt \
        -output_maze $run_dir/logs/route_maze.log \
        -output_guide_coverage $report_dir/guide_coverage.csv
    set drvs [detailed_route_num_drvs]
    set f [open $report_dir/route_status.rpt w]
    puts $f "Detailed-route DRC violations: $drvs"
    close $f
    if {$drvs != 0} {error "Detailed route has $drvs DRC violations"}
    filler_placement {sky130_fd_sc_hd__fill_8 sky130_fd_sc_hd__fill_4 sky130_fd_sc_hd__fill_2 sky130_fd_sc_hd__fill_1}
    global_connect
    check_placement -verbose
    check_power_grid -net VDD -error_file $report_dir/vdd_connectivity.rpt
    check_power_grid -net VSS -error_file $report_dir/vss_connectivity.rpt
    write_db $result_dir/counter_routed.odb
    write_def $result_dir/counter_routed.def
    write_verilog -remove_cells {sky130_fd_sc_hd__fill_* sky130_fd_sc_hd__tapvpwrvgnd_*} \
        $result_dir/counter_routed.v
    write_sdc -no_timestamp -digits 9 $result_dir/counter_propagated.sdc
    define_process_corner -ext_model_index 0 typical
    extract_parasitics -ext_model_file $platform/rcx_patterns.rules -coupling_threshold 0.1
    write_spef $result_dir/counter.spef
    write_db $result_dir/counter_extracted.odb
    puts "PNR_RCX_COMPLETE: $result_dir"
}
if {[catch {run_flow} message options]} {
    puts stderr "PNR_RCX_FAILED: $message"
    puts stderr [dict get $options -errorinfo]
    exit 1
}
