# Re-constrain an already routed checkpoint with a series of clock periods and
# report the worst slack per path group.  No re-implementation is done: the
# routed netlist (and therefore every cell/net delay) stays identical, only the
# create_clock periods change.  This gives an exact slack-vs-period curve for
# the *timing structure* of the design, at a tiny fraction of the cost of
# re-running place & route for every period.
#
# Usage:
#   vivado -mode batch -nojournal -nolog -source scripts/sta_sweep.tcl \
#          -tclargs <routed.dcp> <out.csv> <T1> <T2> ...
#
# Phase mapping is the same proportional scheme used by run_case.tcl:
#   transaction_clock {0, T/2}   phase_a {0.0625T, 0.3125T}   phase_b {0.5T, 0.75T}

set dcp   [lindex $argv 0]
set out   [lindex $argv 1]
set tlist [lrange $argv 2 end]

if {![file exists $dcp]} { error "missing checkpoint: $dcp" }

open_checkpoint $dcp
set has_ab [expr {[llength [get_ports -quiet phase_a]] > 0}]

set fh [open $out w]
puts $fh "period_ns,scope,check,slack_ns,requirement_ns,source,destination"
set dfh [open "${out}.design.csv" w]
puts $dfh "period_ns,wns,whs,wpws"
# per-design temp reports: several sweeps run in parallel and must not share
# a file name
set tmp "${out}.tmp.rpt"
set sum "${out}.sum.rpt"

foreach T $tlist {
    set T [expr {double($T)}]
    # Re-declaring a clock with the same name overrides it.  (delete_clock on a
    # checkpoint-opened design raises a spurious 12-811 "clock_network results
    # not found" error and must be avoided.)
    create_clock -name transaction_clock -period $T \
        -waveform [list 0.0 [expr {$T / 2.0}]] [get_ports clk_reference]
    if {$has_ab} {
        create_clock -name phase_a -period $T \
            -waveform [list [expr {0.0625 * $T}] [expr {0.3125 * $T}]] [get_ports phase_a]
        create_clock -name phase_b -period $T \
            -waveform [list [expr {0.5 * $T}] [expr {0.75 * $T}]] [get_ports phase_b]
        set_clock_uncertainty 0.200 [get_clocks {transaction_clock phase_a phase_b}]
    } else {
        set_clock_uncertainty 0.200 [get_clocks transaction_clock]
    }
    # the path groups are named after the clocks, so they must be rebuilt
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
                              {Requirement:\s+(-?\d+(?:\.\d+)?)ns} \
                              {Source:\s+(\S+)} {Destination:\s+(\S+)}] {
                if {![regexp $pat $txt -> v]} { set ok 0; break }
                lappend vals $v
            }
            if {$ok} {
                puts $fh "$T,$grp,$chk,[lindex $vals 0],[lindex $vals 1],[lindex $vals 2],[lindex $vals 3]"
            }
        }
    }

    # design-level summary (gives WPWS, the pulse-width check)
    if {![catch {report_timing_summary -delay_type min_max -max_paths 1 \
                     -file $sum} err]} {
        set txt ""
        set f [open $sum r]; set txt [read $f]; close $f
        set lines [split $txt "\n"]
        # locate the "Design Timing Summary" section first: the Intra Clock
        # Table has the same WNS/WHS column names and would be picked instead.
        set start 0
        for {set i 0} {$i < [llength $lines]} {incr i} {
            if {[string match "*Design Timing Summary*" [lindex $lines $i]]} {
                set start $i
                break
            }
        }
        set hdr -1
        for {set i $start} {$i < [llength $lines]} {incr i} {
            if {[string match "WNS(ns)*WHS(ns)*" [string trim [lindex $lines $i]]]} {
                set hdr $i
                break
            }
        }
        if {$hdr >= 0} {
            set j [expr {$hdr + 1}]
            while {$j < [llength $lines] && [string trim [lindex $lines $j]] ne "" \
                   && [regexp {^[\s-]+$} [lindex $lines $j]]} { incr j }
            if {$j < [llength $lines]} {
                set v [regexp -all -inline {\S+} [lindex $lines $j]]
                if {[llength $v] >= 12} {
                    puts $dfh "$T,[lindex $v 0],[lindex $v 4],[lindex $v 8]"
                }
            }
        }
    }
    puts "SWEEP: T=$T done"
}
close $fh
puts "DONE: $out"
