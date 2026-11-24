# Select the tree explicitly; trial runs can write to OPENROAD_RUN_DIR.
set cts_mode phi2_single2
if {[info exists ::env(COUNTER_CTS_MODE)]} {set cts_mode $::env(COUNTER_CTS_MODE)}
set cts_args [list -buf_list {sky130_fd_sc_hd__clkbuf_1 sky130_fd_sc_hd__clkbuf_2 sky130_fd_sc_hd__clkbuf_4} \
    -root_buf sky130_fd_sc_hd__clkbuf_2 -sink_clustering_enable \
    -sink_clustering_size 8 -sink_clustering_max_diameter 30 -repair_clock_nets]
if {$cts_mode eq "two_level"} {
    clock_tree_synthesis {*}$cts_args
} elseif {$cts_mode in {phi2_single2 phi2_single4}} {
    # Seven phi1 sinks keep TritonCTS. Four gated phi2 sinks share one buffer.
    clock_tree_synthesis {*}$cts_args -clk_nets {clk_1}
    set strength [string index $cts_mode end]
    set block [ord::get_db_block]
    set sx 0.0
    set sy 0.0
    foreach name {state_phi2_bit0 state_phi2_bit1 state_phi2_bit2 state_phi2_bit3} {
        set box [[$block findInst $name] getBBox]
        set sx [expr {$sx + ([$box xMin] + [$box xMax])/2.0}]
        set sy [expr {$sy + ([$box yMin] + [$box yMax])/2.0}]
    }
    set dbu [$block getDbUnitsPerMicron]
    set center [list [expr {$sx/(4*$dbu)}] [expr {$sy/(4*$dbu)}]]
    insert_buffer -net clk_2_gated -buffer_cell sky130_fd_sc_hd__clkbuf_$strength \
        -buffer_name clkbuf_phi2_single -net_name clknet_phi2_leaf -location $center
} else {
    error "Unsupported COUNTER_CTS_MODE: $cts_mode"
}
set fd [open [file join $reports clock_tree_mode.rpt] w]
puts $fd "COUNTER_CTS_MODE $cts_mode"
close $fd
