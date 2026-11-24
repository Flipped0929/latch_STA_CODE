set dcp [lindex $argv 0]
set T [expr {double([lindex $argv 1])}]
open_checkpoint $dcp
create_clock -name transaction_clock -period $T -waveform [list 0.0 [expr {$T/2.0}]] [get_ports clk_reference]
if {[llength [get_ports -quiet phase_a]] > 0} {
    create_clock -name phase_a -period $T -waveform [list [expr {0.0625*$T}] [expr {0.3125*$T}]] [get_ports phase_a]
    create_clock -name phase_b -period $T -waveform [list [expr {0.5*$T}] [expr {0.75*$T}]] [get_ports phase_b]
    set_clock_uncertainty 0.200 [get_clocks {transaction_clock phase_a phase_b}]
} else {
    set_clock_uncertainty 0.200 [get_clocks transaction_clock]
}
update_timing -full
report_timing -delay_type max -max_paths 6 -nworst 1 -file _probe_top.rpt
set f [open _probe_top.rpt r]
set lines [split [read $f] "\n"]
close $f
set n 0
foreach ln $lines {
    if {[string match "Slack (*" $ln]} {
        puts "PATH: $ln"
        incr n
        if {$n > 6} { break }
    } elseif {$n > 0 && ([string match "  Source:*" $ln] || [string match "  Destination:*" $ln]
              || [string match "  Requirement:*" $ln] || [string match "  Data Path Delay:*" $ln]
              || [string match "  Path Group:*" $ln])} {
        puts "    [string trim $ln]"
    }
}
