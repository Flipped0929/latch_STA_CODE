source [file join [file dirname [info script]] common.tcl]
guarded {
    read_liberty $liberty
    read_db $results/counter_routed.odb
    check_placement -verbose
    if {![design_is_routed -verbose]} {error "Unrouted signal/clock nets"}
    check_power_grid -net VDD
    check_power_grid -net VSS
    set antennas [check_antennas -report_file $reports/antenna.rpt]
    set block [ord::get_db_block]
    set dbu [$block getDbUnitsPerMicron]
    set fd [open $reports/instances.tsv w]
    puts $fd "instance\tmaster\tx_um\ty_um\twidth_um\theight_um"
    set ff 0
    set cells [dict create]
    foreach inst [$block getInsts] {
        set master [[$inst getMaster] getName]
        if {[string match {*__dfrtp_*} $master]} {incr ff}
        dict incr cells $master
        set box [$inst getBBox]
        puts $fd "[$inst getName]\t$master\t[expr {[$box xMin]/double($dbu)}]\t[expr {[$box yMin]/double($dbu)}]\t[expr {[$box getDX]/double($dbu)}]\t[expr {[$box getDY]/double($dbu)}]"
    }
    close $fd
    set nets 0
    set fd [open $reports/nets.tsv w]
    puts $fd "net\ttype\titerms\tbterms\trouted"
    foreach net [$block getNets] {
        if {[$net getSigType] in {POWER GROUND}} {continue}
        incr nets
        if {[$net getWire] eq "NULL"} {error "No wire on [$net getName]"}
        puts $fd "[$net getName]\t[$net getSigType]\t[llength [$net getITerms]]\t[llength [$net getBTerms]]\t1"
    }
    close $fd
    set fd [open $reports/cell_counts.tsv w]
    puts $fd "master\tcount"
    dict for {master count} $cells {puts $fd "$master\t$count"}
    close $fd
    set fd [open $reports/audit.rpt w]
    puts $fd "PASS: reopened final ODB; placement legal; VDD/VSS connected."
    puts $fd "Routed signal/clock nets: $nets/$nets"
    puts $fd "D flip-flops: $ff"
    puts $fd "Antenna violations: $antennas"
    close $fd
    if {$ff != 4 || $antennas != 0} {error "Physical audit failed"}
    puts "AUDIT_COMPLETE"
}
