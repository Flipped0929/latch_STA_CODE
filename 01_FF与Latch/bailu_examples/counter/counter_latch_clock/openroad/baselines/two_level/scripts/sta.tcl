source [file join [file dirname [info script]] common.tcl]
read_lef [file join $platform lef sky130_fd_sc_hd.tlef]
read_lef [file join $platform lef sky130_fd_sc_hd_merged.lef]
# A fresh process reads the routed netlist and SPEF, so the reports cannot use
# placement or global-routing parasitic estimates left over from PNR.
read_verilog [file join $results counter_routed.v]
link_design counter
read_sdc [file join $input_dir counter.sdc]
set_propagated_clock [all_clocks]
read_spef [file join $results counter.spef]
report_parasitic_annotation -report_unannotated > [file join $reports parasitic_annotation.rpt]
check_setup -verbose > [file join $reports check_setup.rpt]
report_clock_properties [all_clocks] > [file join $reports clocks.rpt]
report_clock_latency -digits 6 >> [file join $reports clocks.rpt]
report_checks -path_delay max -group_path_count 100 -endpoint_path_count 2 \
    -format full_clock_expanded -fields {slew capacitance fanout input_pin net} \
    -digits 6 > [file join $reports setup.rpt]
report_checks -path_delay min -group_path_count 100 -endpoint_path_count 2 \
    -format full_clock_expanded -fields {slew capacitance fanout input_pin net} \
    -digits 6 > [file join $reports hold.rpt]
report_check_types -max_delay -min_delay -recovery -removal \
    -clock_gating_setup -clock_gating_hold -min_pulse_width -min_period \
    -max_slew -max_capacitance -violators -format end -max_count 100 -digits 6 \
    > [file join $reports violations.rpt]
report_check_types -recovery -removal -clock_gating_setup -clock_gating_hold \
    -min_pulse_width -min_period -verbose -max_count 100 -digits 6 > [file join $reports special_checks.rpt]
report_check_types -max_slew -max_capacitance -max_fanout -violators -max_count 100 \
    -digits 6 > [file join $reports electrical_violations.rpt]
report_worst_slack -max -digits 6 > [file join $reports timing_summary.rpt]
report_worst_slack -min -digits 6 >> [file join $reports timing_summary.rpt]
report_tns -max -digits 6 >> [file join $reports timing_summary.rpt]
report_tns -min -digits 6 >> [file join $reports timing_summary.rpt]
report_power -digits 6 > [file join $reports power.rpt]
puts "POST_ROUTE_SPEF_STA_COMPLETE"
