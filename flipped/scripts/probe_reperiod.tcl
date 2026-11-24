set dcp [lindex $argv 0]
open_checkpoint $dcp
set has_ab [expr {[llength [get_ports -quiet phase_a]] > 0}]
puts "STEP0 clocks=[get_clocks -quiet]"
if {[catch {update_timing -full} e]} { puts "STEPU ERR $e" } else { puts "STEPU ok" }
if {[catch {delete_clock [get_clocks -quiet]} e]} { puts "STEP1ERR $e" } else { puts "STEP1 ok" }
puts "STEP1 clocks=[get_clocks -quiet]"
foreach T {320.0 160.0} {
    if {[catch {
        create_clock -name transaction_clock -period $T -waveform [list 0.0 [expr {$T/2.0}]] [get_ports clk_reference]
        if {$has_ab} {
            create_clock -name phase_a -period $T -waveform [list [expr {0.0625*$T}] [expr {0.3125*$T}]] [get_ports phase_a]
            create_clock -name phase_b -period $T -waveform [list [expr {0.5*$T}] [expr {0.75*$T}]] [get_ports phase_b]
            set_clock_uncertainty 0.200 [get_clocks {transaction_clock phase_a phase_b}]
        } else {
            set_clock_uncertainty 0.200 [get_clocks transaction_clock]
        }
        update_timing -full
    } e]} { puts "CREATEERR T=$T $e"; continue }
    if {[catch {report_timing -delay_type max -max_paths 1 -file _p1.rpt} e]} { puts "RTERR $e" } else {
        set f [open _p1.rpt r]; set t [read $f]; close $f
        regexp {Slack \((?:MET|VIOLATED)\)\s*:\s*(-?\d+(?:\.\d+)?)ns} $t -> s
        puts "T=$T SLACK=$s"
    }
    if {[catch {report_timing -group phase_a -delay_type max -max_paths 1 -file _p3.rpt} e]} {
        puts "GRPERR $e"
    } else {
        set f [open _p3.rpt r]; set t [read $f]; close $f
        if {[regexp {Slack \((?:MET|VIOLATED)\)\s*:\s*(-?\d+(?:\.\d+)?)ns} $t -> s3]} { puts "T=$T GRP phase_a=$s3" }
    }
    delete_clock [get_clocks -quiet]
}
