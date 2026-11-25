# Synthesis-only probe: does -generic work for Verilog parameters, and does the
# delay chain survive synthesis?  Usage:
#   vivado -mode batch -source scripts/probe_synth.tcl -tclargs <top> <d1> <d2> <out.rpt>
set top   [lindex $argv 0]
set d1    [lindex $argv 1]
set d2    [lindex $argv 2]
set out   [lindex $argv 3]

set here [file dirname [file normalize [info script]]]
set root [file normalize [file join $here ..]]

# The first read_verilog of a session can abort with
#   ERROR: [Common 17-69] Command failed: 'tclapp::load_apps' failed
# when Vivado cannot write its Tcl-app cache (sandboxed session).  A retry works.
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

if {[catch {
    synth_design -top $top -part xc7a35tcpg236-1 -flatten_hierarchy none \
        -generic D1=$d1 -generic D2=$d2
} err]} {
    puts "GENERIC_FAILED: $err"
    exit 2
}

report_utilization -file $out
set n_lut  [llength [get_cells -hier -quiet -filter {REF_NAME =~ LUT*}]]
set n_reg  [llength [get_cells -hier -quiet -filter {REF_NAME =~ FD*}]]
set n_lat  [llength [get_cells -hier -quiet -filter {REF_NAME =~ LD*}]]
puts "PROBE: top=$top D1=$d1 D2=$d2 LUT=$n_lut FF=$n_reg LATCH=$n_lat"
puts "EXPECTED: LUT ~= 8*(D1+D2), FF=32 or LATCH=16 (+FF boundary)"
