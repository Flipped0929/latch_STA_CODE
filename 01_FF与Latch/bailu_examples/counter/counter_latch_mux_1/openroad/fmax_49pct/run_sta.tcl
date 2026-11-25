# Analyze the existing routed netlist/SPEF; do not change the physical design.
set scenario_dir [file dirname [file normalize [info script]]]
if {![info exists ::env(COUNTER_STA_SDC)] || ![info exists ::env(POSTROUTE_REPORT_DIR)]} {
    error "Run python3 openroad/fmax_49pct/run.py to select the period and report directory"
}
source $scenario_dir/../scripts/postroute_sta.tcl
