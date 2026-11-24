source [file join [file dirname [info script]] common.tcl]
read_liberty $liberty
read_db $results/counter_routed.odb
read_sdc $run_dir/inputs/counter.sdc
set_propagated_clock [all_clocks]
read_spef $results/counter.spef
gui::fit
