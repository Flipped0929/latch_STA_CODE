set flow_dir [file normalize [file join [file dirname [info script]] ..]]
set work_dir $flow_dir
if {[info exists ::env(OPENROAD_RUN_DIR)] && $::env(OPENROAD_RUN_DIR) ne ""} {
    set work_dir [file normalize $::env(OPENROAD_RUN_DIR)]
}
set input_dir [file dirname $flow_dir]
set platform $::env(SKY130_PLATFORM)
set liberty [file join $platform lib sky130_fd_sc_hd__tt_025C_1v80.lib]
set results [file join $work_dir results]
set reports [file join $work_dir reports]
set_thread_count 2
read_liberty $liberty

proc connect_power {} {
    add_global_connection -net VDD -inst_pattern {.*} -pin_pattern {^VPWR$} -power
    add_global_connection -net VDD -inst_pattern {.*} -pin_pattern {^VPB$}
    add_global_connection -net VSS -inst_pattern {.*} -pin_pattern {^VGND$} -ground
    add_global_connection -net VSS -inst_pattern {.*} -pin_pattern {^VNB$}
    global_connect
}
