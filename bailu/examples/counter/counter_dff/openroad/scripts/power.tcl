# Run the complete postroute STA first, then annotate steady-state activity.
source [file join [file dirname [info script]] sta.tcl]
guarded {
    # These constants describe the power workload only. Timing reports above
    # retain the original enable and asynchronous-reset constraints.
    set_case_analysis 1 [get_ports {en rst_n}]
    read_vcd -scope counter_power_tb/dut $run_dir/inputs/counter_counting.vcd
    report_activity_annotation -report_unannotated > $reports/power_activity.rpt
    report_activity_annotation -report_annotated > $reports/power_activity_annotated.rpt
    report_power -digits 9 > $reports/power.rpt
    report_power -instances [get_cells *] -digits 9 > $reports/power_instances.rpt
    puts "POWER_ANALYSIS_COMPLETE: continuous counting, en=1, rst_n=1; report_power units W"
}
