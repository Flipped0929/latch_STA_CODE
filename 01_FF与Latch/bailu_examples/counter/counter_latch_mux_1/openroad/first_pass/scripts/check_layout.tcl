source [file join [file dirname [info script]] config.tcl]
read_liberty $liberty
read_db $result_dir/counter_routed.odb
check_placement -verbose
check_antennas -report_file $report_dir/antenna.rpt
set block [ord::get_db_block]
set f [open $report_dir/physical_inventory.tsv w]
puts $f "instance\tmaster\tx_um\ty_um\twidth_um\theight_um"
set dbu [$block getDbUnitsPerMicron]
foreach inst [$block getInsts] {
    set box [$inst getBBox]
    puts $f "[$inst getName]\t[[$inst getMaster] getName]\t[expr {[$box xMin]/double($dbu)}]\t[expr {[$box yMin]/double($dbu)}]\t[expr {[$box getDX]/double($dbu)}]\t[expr {[$box getDY]/double($dbu)}]"
}
close $f
set f [open $report_dir/net_inventory.tsv w]
puts $f "net\ttype\titerms\tbterms\thas_routing"
foreach net [$block getNets] {
    puts $f "[$net getName]\t[$net getSigType]\t[llength [$net getITerms]]\t[llength [$net getBTerms]]\t[expr {[$net getWire] ne "NULL"}]"
}
close $f
puts "LAYOUT_CHECK_COMPLETE"
