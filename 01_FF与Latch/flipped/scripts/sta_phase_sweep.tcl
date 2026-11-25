# Phase-allocation sweep on an already routed checkpoint.
#
# Same idea as sta_sweep.tcl, but the two latch windows are given explicitly as
# fractions of the period, so the A/B window allocation can be optimised:
#   phase_a : {ao*T, ac*T}
#   phase_b : {bo*T, bc*T}
#   transaction_clock : {0, T/2}
#
# Usage:
#   vivado -mode batch -nojournal -nolog -source scripts/sta_phase_sweep.tcl \
#          -tclargs <routed.dcp> <out.csv> <T> <ao> <ac> <bo> <bc> [<T> <ao> <ac> <bo> <bc> ...]
#
# The routed netlist (every cell/net delay) is unchanged; only create_clock
# changes.  This is a constraint-level phase exploration, not physical skew.

set dcp [lindex $argv 0]
set out [lindex $argv 1]
set combos [lrange $argv 2 end]

if {![file exists $dcp]} { error "missing checkpoint: $dcp" }
if {[llength $combos] % 5 != 0} { error "args must be groups of 5: T ao ac bo bc" }

open_checkpoint $dcp
if {[llength [get_ports -quiet phase_a]] == 0} {
    error "design has no phase_a/phase_b ports; nothing to sweep"
}

set fh [open $out w]
puts $fh "period_ns,ao,ac,bo,bc,scope,check,slack_ns,requirement_ns"
set dfh [open "${out}.design.csv" w]
puts $dfh "period_ns,ao,ac,bo,bc,wns,whs,wpws"
set tmp "${out}.tmp.rpt"
set sum "${out}.sum.rpt"

for {set i 0} {$i + 4 < [llength $combos]} {incr i 5} {
    set T  [expr {double([lindex $combos $i])}]
    set ao [expr {double([lindex $combos [expr {$i+1}]])}]
    set ac [expr {double([lindex $combos [expr {$i+2}]])}]
    set bo [expr {double([lindex $combos [expr {$i+3}]])}]
    set bc [expr {double([lindex $combos [expr {$i+4}]])}]

    create_clock -name transaction_clock -period $T \
        -waveform [list 0.0 [expr {$T / 2.0}]] [get_ports clk_reference]
    create_clock -name phase_a -period $T \
        -waveform [list [expr {$ao * $T}] [expr {$ac * $T}]] [get_ports phase_a]
    create_clock -name phase_b -period $T \
        -waveform [list [expr {$bo * $T}] [expr {$bc * $T}]] [get_ports phase_b]
    set_clock_uncertainty 0.200 [get_clocks {transaction_clock phase_a phase_b}]
    update_timing -full

    foreach grp {phase_a phase_b transaction_clock} {
        if {[llength [get_clocks -quiet $grp]] == 0} { continue }
        foreach chk {max min} {
            if {[catch {
                report_timing -group $grp -delay_type $chk -max_paths 1 -nworst 1 \
                    -file $tmp
            } err]} { continue }
            set txt ""
            if {[file exists $tmp]} {
                set f [open $tmp r]; set txt [read $f]; close $f
            }
            set ok 1
            set vals {}
            foreach pat [list {Slack \((?:MET|VIOLATED)\)\s*:\s*(-?\d+(?:\.\d+)?)ns} \
                              {Requirement:\s+(-?\d+(?:\.\d+)?)ns}] {
                if {![regexp $pat $txt -> v]} { set ok 0; break }
                lappend vals $v
            }
            if {$ok} {
                puts $fh "$T,$ao,$ac,$bo,$bc,$grp,$chk,[lindex $vals 0],[lindex $vals 1]"
            }
        }
    }

    if {![catch {report_timing_summary -delay_type min_max -max_paths 1 \
                     -file $sum} err]} {
        set f [open $sum r]; set txt [read $f]; close $f
        set lines [split $txt "\n"]
        set start 0
        for {set k 0} {$k < [llength $lines]} {incr k} {
            if {[string match "*Design Timing Summary*" [lindex $lines $k]]} {
                set start $k; break
            }
        }
        set hdr -1
        for {set k $start} {$k < [llength $lines]} {incr k} {
            if {[string match "WNS(ns)*WHS(ns)*" [string trim [lindex $lines $k]]]} {
                set hdr $k; break
            }
        }
        if {$hdr >= 0} {
            set j [expr {$hdr + 1}]
            while {$j < [llength $lines] && [string trim [lindex $lines $j]] ne "" \
                   && [regexp {^[\s-]+$} [lindex $lines $j]]} { incr j }
            if {$j < [llength $lines]} {
                set v [regexp -all -inline {\S+} [lindex $lines $j]]
                if {[llength $v] >= 12} {
                    puts $dfh "$T,$ao,$ac,$bo,$bc,[lindex $v 0],[lindex $v 4],[lindex $v 8]"
                }
            }
        }
    }
    puts "PHASE SWEEP: T=$T A={$ao,$ac} B={$bo,$bc}"
}
close $fh
close $dfh
puts "DONE: $out"
