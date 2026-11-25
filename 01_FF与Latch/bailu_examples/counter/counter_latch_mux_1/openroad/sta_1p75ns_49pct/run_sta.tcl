# Reanalyze the existing routed design using this scenario's SDC snapshot.
set scenario_dir [file dirname [file normalize [info script]]]
set engine standalone
if {[llength [info commands read_lef]]} {set engine openroad}
set ::env(COUNTER_STA_SDC) $scenario_dir/counter.sdc
set ::env(POSTROUTE_REPORT_DIR) $scenario_dir/reports/$engine
source $scenario_dir/../scripts/postroute_sta.tcl
