# Run: sta -no_init -exit sta_sky130_2/run_sta.tcl
# Optional: COUNTER_STA_LIBERTY=/absolute/path/to/library.lib
set script_dir [file dirname [file normalize [info script]]]
set design_dir [file dirname $script_dir]
set report_dir $script_dir/reports
file mkdir $report_dir
set liberty [file normalize $design_dir/../../../sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib]
if {[info exists ::env(COUNTER_STA_LIBERTY)]} {
    set liberty [file normalize $::env(COUNTER_STA_LIBERTY)]
}
proc run_analysis {} {
    global script_dir design_dir report_dir liberty
    read_liberty $liberty
    read_verilog $design_dir/counter_sky130_2.v
    if {![link_design counter]} {error "Cannot link counter"}
    if {[llength [get_cells *]] != 19} {error "Expected 19 cells"}
    if {[llength [all_registers -level_sensitive -cells]] != 10} {
        error "Expected 10 level-sensitive latches"
    }
    read_sdc $design_dir/counter.sdc
    if {[llength [get_clocks *]] != 2} {error "Expected 2 clocks"}
    # Keep the original SDC and ideal clocks. No wire-load model is selected.
    # No SPEF/SDF is provided: only pin capacitance and SDC loads are included.
    write_sdc -digits 9 -no_timestamp $script_dir/effective.sdc
    log_begin $report_dir/units.rpt
    report_units
    log_end
    log_begin $report_dir/clocks.rpt
    report_clock_properties [get_clocks *]
    log_end
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
    log_begin $report_dir/net_loads.rpt
    foreach net [get_nets *] {report_net -digits 6 [get_full_name $net]}
    log_end
    log_begin $report_dir/summary.rpt
    puts "Netlist: $design_dir/counter_sky130_2.v"
    puts "SDC: $design_dir/counter.sdc"
    puts "Liberty: $liberty"
    puts "Cells: [llength [get_cells *]]; latches: [llength [all_registers -level_sensitive -cells]]"
    puts "Constraint sanity checks passed: $constraints_ok"
    puts "Pre-layout STA; ideal clocks; no SPEF/SDF or selected wire-load model."
    puts "Loads: library pin capacitance plus SDC output loads; interconnect delay is zero."
    report_worst_slack -max -digits 6
    report_worst_slack -min -digits 6
    report_tns -max -digits 6
    report_tns -min -digits 6
    log_end
    if {!$constraints_ok} {error "Constraint sanity checks failed; inspect check_setup.rpt"}
}
if {[catch {run_analysis} message options]} {
    puts stderr "STA_FAILED: $message"
    puts stderr [dict get $options -errorinfo]
    exit 1
}
puts "STA_COMPLETE: $report_dir"
