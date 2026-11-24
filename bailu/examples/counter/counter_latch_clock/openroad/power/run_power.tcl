set power_dir [file dirname [file normalize [info script]]]
set scenario $::env(COUNTER_POWER_SCENARIO)
if {$scenario ni {active mixed hold}} {error "Unknown power scenario"}
set reports [file join $power_dir reports $scenario]
set platform $::env(SKY130_PLATFORM)
set liberty $::env(COUNTER_POWER_LIBERTY)
file mkdir $reports
set_thread_count 2
read_lef [file join $platform lef sky130_fd_sc_hd.tlef]
read_lef [file join $platform lef sky130_fd_sc_hd_merged.lef]
read_liberty $liberty
read_verilog [file join $power_dir inputs counter_routed.v]
link_design counter
read_sdc [file join $power_dir inputs counter.sdc]
set_propagated_clock [all_clocks]
# Reset is inactive throughout the measured window. Do not case-constrain en:
# its measured activity must remain available to the clock-gating logic.
set_case_analysis 1 [get_ports rst_n]
read_spef [file join $power_dir inputs counter.spef]
if {[llength [get_cells *]] != 23} {error "Expected 23 routed timing cells"}
if {[llength [all_registers -level_sensitive -cells]] != 11} {error "Expected 11 latches"}
report_parasitic_annotation -report_unannotated > [file join $reports parasitic_annotation.rpt]
read_vcd -scope tb_power/dut [file join $power_dir activity $scenario.vcd]
report_activity_annotation -report_unannotated -report_annotated > [file join $reports activity_annotation.rpt]
report_power -digits 9 > [file join $reports power.rpt]
report_power -format json -digits 9 > [file join $reports power.json]
report_power -instances [get_cells *] -digits 9 > [file join $reports instances.rpt]
write_sdc -digits 9 -no_timestamp [file join $reports effective.sdc]
sta::redirect_file_begin [file join $reports units.rpt]
report_units
sta::redirect_file_end
set fd [open [file join $reports instances.tsv] w]
puts $fd "instance\tmaster\tinternal_W\tswitching_W\tleakage_W\ttotal_W"
foreach inst [get_cells *] {
    set p [sta::instance_power $inst [sta::cmd_scene]]
    puts $fd "[get_full_name $inst]\t[get_property $inst ref_name]\t[join $p \t]"
}
close $fd
set fd [open [file join $reports activities.tsv] w]
puts $fd "pin\tdensity_per_second\tduty\torigin"
foreach port [get_ports *] {
    puts $fd "[get_full_name $port]\t[join [get_property $port activity] \t]"
}
foreach inst [get_cells *] {
    foreach pin [get_pins -of_objects $inst] {
        puts $fd "[get_full_name $pin]\t[join [get_property $pin activity] \t]"
    }
}
close $fd
puts "POWER_COMPLETE: $scenario"
