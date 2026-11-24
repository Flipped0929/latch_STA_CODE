set run_dir [file dirname [file dirname [file normalize [info script]]]]
set platform /home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd
if {[info exists ::env(SKY130HD_PLATFORM)]} {set platform [file normalize $::env(SKY130HD_PLATFORM)]}
set liberty $platform/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
set results $run_dir/results
set reports $run_dir/reports
file mkdir $results $reports $run_dir/logs
proc report_file {filename command} {
    sta::redirect_file_begin $filename
    try {uplevel 1 $command} finally {sta::redirect_file_end}
}
proc load_technology {} {
    global platform liberty
    read_lef $platform/lef/sky130_fd_sc_hd.tlef
    read_lef $platform/lef/sky130_fd_sc_hd_merged.lef
    read_liberty $liberty
}
proc power_connect {} {
    add_global_connection -net VDD -inst_pattern {.*} -pin_pattern {^VPWR$} -power
    add_global_connection -net VDD -inst_pattern {.*} -pin_pattern {^VPB$}
    add_global_connection -net VSS -inst_pattern {.*} -pin_pattern {^VGND$} -ground
    add_global_connection -net VSS -inst_pattern {.*} -pin_pattern {^VNB$}
    global_connect
}
proc timing_snapshot {name} {
    global reports
    report_checks -path_delay max -format full_clock_expanded -digits 6 -group_path_count 100 > $reports/${name}_max.rpt
    report_checks -path_delay min -format full_clock_expanded -digits 6 -group_path_count 100 > $reports/${name}_min.rpt
    report_worst_slack -max -digits 6 > $reports/${name}_summary.rpt
    report_worst_slack -min -digits 6 >> $reports/${name}_summary.rpt
    report_tns -max -digits 6 >> $reports/${name}_summary.rpt
    report_tns -min -digits 6 >> $reports/${name}_summary.rpt
}
proc guarded {command} {
    if {[catch {uplevel 1 $command} message options]} {
        puts stderr [dict get $options -errorinfo]
        exit 1
    }
}
