source [file join [file dirname [info script]] config.tcl]
set report_dir $run_dir/reports/postroute
if {[info exists ::env(POSTROUTE_REPORT_SUBDIR)]} {set report_dir $run_dir/reports/$::env(POSTROUTE_REPORT_SUBDIR)}
if {[info exists ::env(POSTROUTE_REPORT_DIR)]} {set report_dir [file normalize $::env(POSTROUTE_REPORT_DIR)]}
set sdc $run_dir/inputs/counter.sdc
if {[info exists ::env(COUNTER_STA_SDC)]} {set sdc [file normalize $::env(COUNTER_STA_SDC)]}
file mkdir $report_dir
proc report_to_file {filename command} {
    sta::redirect_file_begin $filename
    try {uplevel 1 $command} finally {sta::redirect_file_end}
}
proc run_analysis {} {
    global run_dir design_dir report_dir result_dir liberty platform sdc
    if {[llength [info commands read_lef]]} {
        read_lef $platform/lef/sky130_fd_sc_hd.tlef
        read_lef $platform/lef/sky130_fd_sc_hd_merged.lef
    }
    read_liberty $liberty
    read_verilog $result_dir/counter_routed.v
    link_design counter
    if {[llength [all_registers -level_sensitive -cells]] != 10} {
        error "Expected 10 level-sensitive latches"
    }
    read_sdc $sdc
    # Power terminals are not timed signal interfaces.
    set_case_analysis 1 [get_ports VDD]
    set_case_analysis 0 [get_ports VSS]
    if {[llength [get_clocks *]] != 2} {error "Expected 2 clocks"}
    set_propagated_clock [all_clocks]
    read_spef $result_dir/counter.spef
    report_parasitic_annotation -report_unannotated > $report_dir/parasitic_annotation.rpt
    write_sdc -digits 9 -no_timestamp $report_dir/effective.sdc
    report_to_file $report_dir/units.rpt {report_units}
    report_to_file $report_dir/clocks.rpt {report_clock_properties [get_clocks *]}
    report_clock_latency -digits 6 > $report_dir/clock_latency.rpt
    report_clock_skew -setup -digits 6 > $report_dir/clock_skew_setup.rpt
    report_clock_skew -hold -digits 6 > $report_dir/clock_skew_hold.rpt
    set constraints_ok [check_setup -verbose > $report_dir/check_setup.rpt]
    foreach mode {max min} label {setup hold} {
        set options [list -path_delay $mode -format full_clock_expanded \
            -fields {slew capacitance input_pin net fanout} \
            -group_path_count 1000 -endpoint_path_count 1 -sort_by_slack -digits 6]
        report_checks {*}$options > $report_dir/$label.rpt
        report_checks {*}$options -slack_max 0 > $report_dir/${label}_violations.rpt
        foreach source {en rst_n} {
            report_checks {*}$options -from [get_ports $source] > $report_dir/${source}_${label}.rpt
        }
        report_checks {*}$options -to [get_ports {count*}] > $report_dir/output_${label}.rpt
        report_checks {*}$options -to [get_pins state_*/D] > $report_dir/data_${label}.rpt
        foreach launch {phi1 phi2} capture {phi2 phi1} {
            report_checks {*}$options -from [get_cells state_${launch}_*] \
                -to [get_pins state_${capture}_*/D] \
                > $report_dir/${launch}_to_${capture}_${label}.rpt
        }
    }
    set checks {-max_delay -min_delay -recovery -removal -min_pulse_width -min_period -max_slew -max_capacitance -max_fanout}
    report_check_types {*}$checks -format end -max_count 1000 -digits 6 > $report_dir/checks.rpt
    report_check_types {*}$checks -violators -format end -max_count 1000 -digits 6 > $report_dir/violations.rpt
    foreach option {-recovery -removal -min_pulse_width -min_period -max_slew -max_capacitance -max_fanout} \
        label {recovery removal pulse_width min_period max_slew max_capacitance max_fanout} {
        report_check_types $option -format end -max_count 1000 -digits 6 > $report_dir/$label.rpt
    }
    set fd [open $report_dir/endpoint_slacks.tsv w]
    puts $fd "analysis\tendpoint\tstartpoint\tslack_ns"
    foreach mode {max min} {
        foreach path [find_timing_paths -path_delay $mode -group_path_count 1000 \
                          -endpoint_path_count 1 -sort_by_slack] {
            puts $fd "$mode\t[get_full_name [get_property $path endpoint]]\t[get_full_name [get_property $path startpoint]]\t[get_property $path slack]"
        }
    }
    close $fd
    close [open $report_dir/net_loads.rpt w]
    foreach net [get_nets *] {report_net -digits 6 [get_full_name $net] >> $report_dir/net_loads.rpt}
    set sf [open $report_dir/summary.rpt w]
    puts $sf "Netlist: $result_dir/counter_routed.v"
    puts $sf "SDC: $sdc"
    puts $sf "Liberty: $liberty"
    puts $sf "Cells: [llength [get_cells *]]; latches: [llength [all_registers -level_sensitive -cells]]"
    puts $sf "Constraint sanity checks passed: $constraints_ok"
    puts $sf "Post-route STA; propagated phi1/phi2 clocks; OpenRCX extracted SPEF."
    puts $sf "SPEF: $result_dir/counter.spef"
    close $sf
    report_worst_slack -max -digits 6 >> $report_dir/summary.rpt
    report_worst_slack -min -digits 6 >> $report_dir/summary.rpt
    report_tns -max -digits 6 >> $report_dir/summary.rpt
    report_tns -min -digits 6 >> $report_dir/summary.rpt
    if {!$constraints_ok} {error "Constraint sanity checks failed; inspect check_setup.rpt"}
}
if {[catch {run_analysis} message options]} {
    puts stderr "STA_FAILED: $message"
    puts stderr [dict get $options -errorinfo]
    exit 1
}
puts "POSTROUTE_STA_COMPLETE: $report_dir"
