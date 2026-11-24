source [file join [file dirname [info script]] common.tcl]
guarded {
    set reports $reports/postroute
    if {[info exists ::env(STA_REPORT_SUBDIR)]} {set reports $run_dir/reports/$::env(STA_REPORT_SUBDIR)}
    file mkdir $reports
    if {[llength [info commands read_lef]]} {load_technology} else {read_liberty $liberty}
    read_verilog $results/counter_routed.v
    link_design counter
    read_sdc $run_dir/inputs/counter.sdc
    set_case_analysis 1 [get_ports VDD]
    set_case_analysis 0 [get_ports VSS]
    set_propagated_clock [all_clocks]
    read_spef $results/counter.spef
    if {[llength [all_registers -edge_triggered -cells]] != 4} {error "Expected 4 D flip-flops"}
    report_parasitic_annotation -report_unannotated > $reports/parasitic_annotation.rpt
    set constraints_ok [check_setup -verbose > $reports/check_setup.rpt]
    report_file $reports/units.rpt {report_units}
    report_file $reports/clocks.rpt {report_clock_properties [all_clocks]}
    report_clock_latency -digits 6 > $reports/clock_latency.rpt
    report_clock_skew -setup -digits 6 > $reports/clock_skew_setup.rpt
    report_clock_skew -hold -digits 6 > $reports/clock_skew_hold.rpt
    foreach mode {max min} label {setup hold} {
        set options [list -path_delay $mode -format full_clock_expanded -fields {slew capacitance input_pin net fanout} \
            -group_path_count 1000 -endpoint_path_count 1 -sort_by_slack -digits 6]
        report_checks {*}$options > $reports/$label.rpt
        report_checks {*}$options -slack_max 0 > $reports/${label}_violations.rpt
        foreach port {en rst_n} {report_checks {*}$options -from [get_ports $port] > $reports/${port}_${label}.rpt}
        report_checks {*}$options -to [get_ports {count*}] > $reports/output_${label}.rpt
        report_checks {*}$options -to [all_registers -data_pins] > $reports/data_${label}.rpt
    }
    set options {-max_delay -min_delay -recovery -removal -min_pulse_width -min_period -max_slew -max_capacitance -max_fanout}
    report_check_types {*}$options -format end -max_count 1000 -digits 6 > $reports/checks.rpt
    report_check_types {*}$options -violators -format end -max_count 1000 -digits 6 > $reports/violations.rpt
    foreach option {-recovery -removal -min_pulse_width -min_period -max_slew -max_capacitance -max_fanout} \
        label {recovery removal pulse_width min_period max_slew max_capacitance max_fanout} {
        report_check_types $option -format end -max_count 1000 -digits 6 > $reports/$label.rpt
    }
    write_sdc -no_timestamp -digits 9 $reports/effective.sdc
    write_sdf -digits 6 $results/counter.sdf
    set fd [open $reports/summary.rpt w]
    puts $fd "SKY130 HD TT / 25 C / 1.80 V; [get_property [get_clocks clk] period] ns clock; propagated clock; extracted SPEF"
    puts $fd "Constraint coverage passed: $constraints_ok"
    close $fd
    report_worst_slack -max -digits 6 >> $reports/summary.rpt
    report_worst_slack -min -digits 6 >> $reports/summary.rpt
    report_tns -max -digits 6 >> $reports/summary.rpt
    report_tns -min -digits 6 >> $reports/summary.rpt
    if {!$constraints_ok} {error "Constraint coverage check failed"}
    puts "POSTROUTE_STA_COMPLETE"
}
