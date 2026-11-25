# -----------------------------------------------------------------------------
# One implementation of the borrow-arbitration circuit.
#
# Usage:
#   vivado -mode batch -nojournal -nolog -source scripts/arb_case.tcl \
#     -tclargs <ff1|ff2|lat> <period> <pa_rise> <pa_fall> <pb_rise> <pb_fall> <d1> <d2>
#
# Phase convention (all ns, one period = <period>):
#   ff1 : one clock only, every register on posedge clk_reference
#   ff2 : r1 on posedge phase_a (rise T/2), r2 on posedge phase_b (rise 0)
#   lat : r1 transparent while phase_a high {0, T/2},
#         r2 transparent while phase_b high {T/2, T}
#
# Build products go to $DSH_OUTROOT/build/<tag> when that variable is set,
# otherwise to <repo>/build/<tag>.
# -----------------------------------------------------------------------------

if {[llength $argv] < 8} {
    error "need 8 args: variant period pa_rise pa_fall pb_rise pb_fall d1 d2"
}
set variant [lindex $argv 0]
set period  [lindex $argv 1]
set pa_r    [lindex $argv 2]
set pa_f    [lindex $argv 3]
set pb_r    [lindex $argv 4]
set pb_f    [lindex $argv 5]
set d1      [lindex $argv 6]
set d2      [lindex $argv 7]

switch -- $variant {
    ff1 { set top arb_ff1 }
    ff2 { set top arb_ff2 }
    lat { set top arb_latch }
    default { error "variant must be ff1, ff2 or lat" }
}

proc numtag {v} {
    set d [expr {double($v)}]
    if {$d == floor($d) && abs($d) < 1e9} { return [format %d [expr {int($d)}]] }
    set s [format %.4f $d]
    return [string trimright $s 0]
}

set here [file dirname [file normalize [info script]]]
set root [file normalize [file join $here ..]]
set outroot $root
if {[info exists ::env(DSH_OUTROOT)] && $::env(DSH_OUTROOT) ne ""} {
    set outroot $::env(DSH_OUTROOT)
}
set tag [format "%s_T%s_A%s_%s_B%s_%s_D%s_%s" $variant [numtag $period] \
             [numtag $pa_r] [numtag $pa_f] [numtag $pb_r] [numtag $pb_f] \
             [numtag $d1] [numtag $d2]]
set outdir [file join $outroot build $tag]
file mkdir $outdir

# ---- source ----------------------------------------------------------------
proc safe_read {args} {
    for {set i 0} {$i < 3} {incr i} {
        if {![catch {eval read_verilog $args} err]} { return }
        if {[string match "*already*defined*" $err]} { return }
        if {$i == 2} { error "read_verilog failed: $err" }
        puts "WARNING: read_verilog retry $i"
    }
}
safe_read -sv [file join $root rtl delay_chain.v]
safe_read -sv [file join $root rtl arb_tops.v]

# ---- generated constraints --------------------------------------------------
set xdc [file join $outdir constraints.xdc]
set fh [open $xdc w]
set half [expr {double($period) / 2.0}]
puts $fh [format "create_clock -name transaction_clock -period %.6f -waveform {0.000000 %.6f} \[get_ports clk_reference\]" $period $half]
if {$variant ne "ff1"} {
    puts $fh [format "create_clock -name phase_a -period %.6f -waveform {%.6f %.6f} \[get_ports phase_a\]" $period $pa_r $pa_f]
    puts $fh [format "create_clock -name phase_b -period %.6f -waveform {%.6f %.6f} \[get_ports phase_b\]" $period $pb_r $pb_f]
    puts $fh "set_clock_uncertainty 0.200 \[get_clocks {transaction_clock phase_a phase_b}\]"
} else {
    puts $fh "set_clock_uncertainty 0.200 \[get_clocks transaction_clock\]"
}
puts $fh "set_input_delay  -clock transaction_clock -max 2.000 \[get_ports {data_in[*]}\]"
puts $fh "set_input_delay  -clock transaction_clock -min 0.200 \[get_ports {data_in[*]}\]"
puts $fh "set_output_delay -clock transaction_clock -max 2.000 \[get_ports {result[*]}\]"
puts $fh "set_output_delay -clock transaction_clock -min 0.200 \[get_ports {result[*]}\]"
puts $fh "set_property IOB FALSE \[get_ports {data_in[*] result[*]}\]"
puts $fh "set_false_path -from \[get_ports reset\]"
close $fh
read_xdc $xdc

# ---- implementation ---------------------------------------------------------
synth_design -top $top -part xc7a35tcpg236-1 -flatten_hierarchy none \
    -generic D1=$d1 -generic D2=$d2
opt_design
place_design
route_design

set n_lut [llength [get_cells -hier -quiet -filter {REF_NAME =~ LUT*}]]
set n_fd  [llength [get_cells -hier -quiet -filter {REF_NAME =~ FD*}]]
set n_ld  [llength [get_cells -hier -quiet -filter {REF_NAME =~ LD*}]]
puts "CHECK: LUT=$n_lut FF=$n_fd LATCH=$n_ld  (expect LUT=8*(D1+D2)=[expr {8*($d1+$d2)}])"

write_checkpoint -force [file join $outdir routed.dcp]
write_verilog    -mode funcsim -force [file join $outdir funcsim.v]
write_verilog    -mode timesim -force [file join $outdir timesim.v]
catch {write_sdf -force [file join $outdir routed.sdf]}

report_utilization    -file [file join $outdir utilization.rpt]
report_clocks         -file [file join $outdir clocks.rpt]
report_timing_summary -delay_type min_max -max_paths 64 -file [file join $outdir timing_summary.rpt]
report_timing -delay_type max -max_paths 64 -nworst 1 -sort_by slack -file [file join $outdir paths_max.rpt]
report_timing -delay_type min -max_paths 64 -nworst 1 -sort_by slack -file [file join $outdir paths_min.rpt]

set groups {}
foreach clk {phase_a phase_b transaction_clock} {
    if {[llength [get_clocks -quiet $clk]] > 0} {
        lappend groups $clk
        catch {report_timing -group $clk -delay_type max -max_paths 16 -sort_by slack \
                   -file [file join $outdir group_${clk}_max.rpt]}
        catch {report_timing -group $clk -delay_type min -max_paths 16 -sort_by slack \
                   -file [file join $outdir group_${clk}_min.rpt]}
    }
}

# ---- metadata ---------------------------------------------------------------
set mf [open [file join $outdir run_meta.csv] w]
puts $mf "key,value"
foreach {k v} [list \
        variant $variant top $top period_ns $period \
        pa_rise_ns $pa_r pa_fall_ns $pa_f pb_rise_ns $pb_r pb_fall_ns $pb_f \
        d1 $d1 d2 $d2 lut_cells $n_lut fd_cells $n_fd ld_cells $n_ld \
        groups [join $groups {|}] vivado [version -short] \
        utc [clock format [clock seconds] -format %Y-%m-%dT%H:%M:%SZ -gmt 1]] {
    puts $mf "$k,$v"
}
close $mf

set sf [open [file join $outdir summary.csv] w]
puts $sf "variant,period_ns,d1,d2,group,check,slack_ns"
foreach grp $groups {
    foreach chk {max min} {
        set f [file join $outdir group_${grp}_${chk}.rpt]
        if {![file exists $f]} { continue }
        set fh2 [open $f r]; set txt [read $fh2]; close $fh2
        if {[regexp {Slack \((?:MET|VIOLATED)\)\s*:\s*(-?\d+(?:\.\d+)?)ns} $txt -> s]} {
            puts $sf "$variant,$period,$d1,$d2,$grp,$chk,$s"
        }
    }
}
close $sf

puts "DONE: $tag -> $outdir"
