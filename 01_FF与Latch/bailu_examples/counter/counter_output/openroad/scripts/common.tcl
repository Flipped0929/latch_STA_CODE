set flow_dir [file normalize [file join [file dirname [info script]] ..]]
set input_dir [file dirname $flow_dir]
set results [file join $flow_dir results]
set reports [file join $flow_dir reports]
set platform $::env(SKY130_PLATFORM)
set_thread_count 2
read_liberty [file join $platform lib sky130_fd_sc_hd__tt_025C_1v80.lib]
read_lef [file join $platform lef sky130_fd_sc_hd.tlef]
read_lef [file join $platform lef sky130_fd_sc_hd_merged.lef]

proc read_counter_sdc {} {
    global input_dir reports
    set fd [open [file join $input_dir counter.sdc] r]
    set sdc [read $fd]
    close $fd
    if {[llength [get_pins -quiet gate_phi2_11/B]] != 1} {
        error "The gate enable pin gate_phi2_11/B is missing"
    }
    set sdc [string map {gate_phi2/ gate_phi2_11/ clk_2_gated gated_clk_2_10} $sdc]
    set sdc_path [file join $reports applied.sdc]
    set fd [open $sdc_path w]
    puts -nonewline $fd $sdc
    close $fd
    read_sdc $sdc_path
}
