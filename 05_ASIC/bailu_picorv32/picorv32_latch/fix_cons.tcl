insert_tiecells sky130_fd_sc_hd__conb_1/LO -prefix TIELO_
insert_tiecells sky130_fd_sc_hd__conb_1/HI -prefix TIEHI_
source [file join [file dirname [info script]] gating_checks.tcl]