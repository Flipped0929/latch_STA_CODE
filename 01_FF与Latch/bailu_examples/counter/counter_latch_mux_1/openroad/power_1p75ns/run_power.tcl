# Analyze the existing routed signal netlist and extracted SPEF.
set power_dir [file dirname [file normalize [info script]]]
set project_dir [file dirname [file dirname $power_dir]]
set implementation_dir [file dirname $power_dir]
if {[info exists ::env(COUNTER_POWER_DIR)]} {set power_dir [file normalize $::env(COUNTER_POWER_DIR)]}
set platform /home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd
if {[info exists ::env(SKY130HD_PLATFORM)]} {set platform $::env(SKY130HD_PLATFORM)}
set liberty [file normalize $project_dir/../../../sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib]
if {[info exists ::env(COUNTER_POWER_LIBERTY)]} {set liberty $::env(COUNTER_POWER_LIBERTY)}
set scenario $::env(COUNTER_POWER_SCENARIO)
if {$scenario ni {active mixed hold}} {error "Unknown scenario $scenario"}
set reports $power_dir/reports/$scenario
file mkdir $reports

proc capture_report {path command} {
    sta::redirect_file_begin $path
    try {uplevel 1 $command} finally {sta::redirect_file_end}
}

proc analyze_power {} {
    global power_dir implementation_dir platform liberty scenario reports
    set_thread_count 2
    read_lef $platform/lef/sky130_fd_sc_hd.tlef
    read_lef $platform/lef/sky130_fd_sc_hd_merged.lef
    read_liberty $liberty
    read_verilog $implementation_dir/results/counter_routed.v
    link_design counter
    read_sdc $power_dir/inputs/counter.sdc
    set_propagated_clock [all_clocks]
    set_case_analysis 1 [get_ports {VDD rst_n}]
    set_case_analysis 0 [get_ports VSS]
    # en is NOT case-constrained: measured activities preserve the logic cone.
    read_spef $implementation_dir/results/counter.spef
    if {[llength [get_cells *]] != 26} {error "Expected 26 routed signal cells"}
    if {[llength [all_registers -level_sensitive -cells]] != 10} {error "Expected 10 latches"}
    if {[llength [all_clocks]] != 2} {error "Expected two phase clocks"}
    report_parasitic_annotation -report_unannotated > $reports/parasitic_annotation.rpt
    read_vcd -scope tb_power/dut $power_dir/activity/$scenario.vcd
    report_activity_annotation -report_unannotated -report_annotated > $reports/activity_annotation.rpt
    report_power -digits 9 > $reports/power.rpt
    report_power -format json -digits 9 > $reports/power.json
    report_power -instances [get_cells *] -digits 9 > $reports/instances.rpt
    report_clock_properties [all_clocks] > $reports/clocks.rpt
    capture_report $reports/units.rpt {report_units}
    write_sdc -no_timestamp -digits 9 $reports/effective.sdc
    set f [open $reports/instances.tsv w]
    puts $f "instance\tmaster\tinternal_W\tswitching_W\tleakage_W\ttotal_W"
    foreach inst [get_cells *] {
        set p [sta::instance_power $inst [sta::cmd_scene]]
        puts $f "[get_full_name $inst]\t[get_property $inst ref_name]\t[join $p \t]"
    }
    close $f
}
if {[catch analyze_power message options]} {
    puts stderr "POWER_FAILED: $message"
    puts stderr [dict get $options -errorinfo]
    exit 1
}
puts "POWER_COMPLETE: $scenario"
