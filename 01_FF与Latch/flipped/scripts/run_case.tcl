# -----------------------------------------------------------------------------
# Non-project Vivado flow for the all-latch experiment (E1-E4).
#
# Usage:
#   vivado -mode batch -nojournal -nolog -source scripts/run_case.tcl \
#          -tclargs <ff|latch_ff|all_latch> <blocks> <period_ns> <a_rise_ns> <a_width_ns>
#
#   ff        : FF core + FF IO boundary            (32 FDCE)
#   latch_ff  : latch core + FF IO boundary         (16 FDCE + 16 LDCE)
#   all_latch : latch core + latch-pair IO boundary (0 FDCE + 48 LDCE at BLOCKS=1)
#
# Outputs go to build/<tag>/. Nothing outside build/ and results/ is touched.
# -----------------------------------------------------------------------------

if {[llength $argv] < 5} {
    error "need 5 args: variant blocks period a_rise a_width [b_rise b_width] (got: $argv)"
}

set variant [lindex $argv 0]
set blocks  [lindex $argv 1]
set period  [lindex $argv 2]
set arise   [lindex $argv 3]
set awidth  [lindex $argv 4]
# optional B-phase override (defaults reproduce the original proportional plan)
if {[llength $argv] > 5} {
    set brise [lindex $argv 5]
} else {
    set brise [expr {double($period) * 0.50}]
}
if {[llength $argv] > 6} {
    set bwidth [lindex $argv 6]
} else {
    set bwidth [expr {double($period) * 0.25}]
}

if {[lsearch -exact {ff latch_ff all_latch} $variant] < 0} {
    error "variant must be ff, latch_ff or all_latch"
}

# ---- pretty number for the directory tag (640, 2.5, 0.875 ...) --------------
proc numtag {v} {
    set d [expr {double($v)}]
    if {$d == floor($d) && abs($d) < 1e9} {
        return [format %d [expr {int($d)}]]
    }
    set s [format %.4f $d]
    return [string trimright $s 0]
}

set here [file dirname [file normalize [info script]]]
set root [file normalize [file join $here ..]]

set tag [format "%s_b%s_T%s_r%s_w%s" $variant $blocks [numtag $period] [numtag $arise] [numtag $awidth]]
# only tag the B phase when it differs from the default proportional plan, so
# that existing directory names stay valid
set b_default [expr {double($period) * 0.50}]
if {abs(double($brise) - $b_default) > 1e-9 || \
    abs(double($bwidth) - double($period) * 0.25) > 1e-9} {
    append tag [format "_B%s_%s" [numtag $brise] [numtag $bwidth]]
}
set outdir [file join $root build $tag]
# Optional output redirection: when the project tree is not writable for the
# sandboxed tool but some other directory is, set DSH_OUTROOT to that directory.
if {[info exists ::env(DSH_OUTROOT)] && $::env(DSH_OUTROOT) ne ""} {
    set outdir [file join $::env(DSH_OUTROOT) build $tag]
}
file mkdir $outdir

set part xc7a35tcpg236-1

# ---- design selection -------------------------------------------------------
switch -- $variant {
    ff {
        set top ff_timing_top
        set rtl [list datapath_compare.v timing_boundaries.v ff_timing_top.v]
        set vdef {}
    }
    latch_ff {
        set top latch_timing_top
        set rtl [list datapath_compare.v timing_boundaries.v latch_timing_top.v]
        set vdef {}
    }
    all_latch {
        if {[lsearch -exact {1 2 4} $blocks] < 0} {
            error "all_latch supports blocks 1, 2 or 4 only"
        }
        set top latch_chain_top_$blocks
        set rtl [list datapath_compare.v latch_boundary_pair.v \
                      latch_chain_top.sv latch_chain_wrappers.v]
        set vdef {USE_LDCE_PRIMITIVES=1}
    }
}

# The first read_verilog of a session can fail with
#   ERROR: [Common 17-69] Command failed: 'tclapp::load_apps' failed
# when Vivado cannot write its Tcl-app cache (e.g. a sandboxed session).
# A retry succeeds, so every read goes through this helper.
proc safe_read {args} {
    for {set i 0} {$i < 3} {incr i} {
        if {![catch {eval read_verilog $args} err]} { return }
        if {[string match "*already*defined*" $err]} { return }
        if {$i == 2} { error "read_verilog failed: $err" }
        puts "WARNING: read_verilog retry $i after: [string range $err 0 120]"
    }
}

foreach f $rtl {
    set path [file join $root rtl $f]
    if {![file exists $path]} { error "missing RTL: $path" }
    if {[llength $vdef] > 0} {
        safe_read -sv -define $vdef $path
    } else {
        safe_read -sv $path
    }
}

# ---- generated XDC ----------------------------------------------------------
set xdc [file join $outdir constraints.xdc]
set fh [open $xdc w]
set half [expr {double($period) / 2.0}]
set b0   [expr {double($brise)}]
set b1   [expr {double($brise) + double($bwidth)}]
set a1   [expr {double($arise) + double($awidth)}]

puts $fh [format "create_clock -name transaction_clock -period %.6f -waveform {0.000000 %.6f} \[get_ports clk_reference\]" $period $half]
if {$variant ne "ff"} {
    puts $fh [format "create_clock -name phase_a -period %.6f -waveform {%.6f %.6f} \[get_ports phase_a\]" $period $arise $a1]
    puts $fh [format "create_clock -name phase_b -period %.6f -waveform {%.6f %.6f} \[get_ports phase_b\]" $period $b0 $b1]
    puts $fh "set_clock_uncertainty 0.200 \[get_clocks {transaction_clock phase_a phase_b}\]"
} else {
    puts $fh "set_clock_uncertainty 0.200 \[get_clocks {transaction_clock}\]"
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
if {[llength $vdef] > 0} {
    synth_design -top $top -part $part -flatten_hierarchy none -verilog_define $vdef
} else {
    synth_design -top $top -part $part -flatten_hierarchy none
}
opt_design
place_design
route_design

# ---- cell census ------------------------------------------------------------
set n_fd   [llength [get_cells -hier -quiet -filter {REF_NAME =~ FD*}]]
set n_ld   [llength [get_cells -hier -quiet -filter {REF_NAME =~ LD*}]]
set n_lut  [llength [get_cells -hier -quiet -filter {REF_NAME =~ LUT*}]]
set n_bufg [llength [get_cells -hier -quiet -filter {REF_NAME =~ BUFG*}]]
puts "CHECK: FD-flops=$n_fd LD-latches=$n_ld LUT=$n_lut BUFG=$n_bufg"
if {$variant eq "all_latch" && $n_fd > 0} {
    puts "WARNING: all_latch still contains FD* cells:"
    puts [get_cells -hier -filter {REF_NAME =~ FD*}]
}
if {$variant eq "ff" && $n_ld > 0} {
    puts "WARNING: ff variant contains LD* cells"
}

# ---- outputs ----------------------------------------------------------------
write_checkpoint -force [file join $outdir routed.dcp]
write_verilog    -mode funcsim -force [file join $outdir funcsim.v]
# timesim netlist keeps the specify blocks, which SDF annotation needs
write_verilog    -mode timesim -force [file join $outdir timesim.v]
if {[catch {write_sdf -force [file join $outdir routed.sdf]} sdf_err]} {
    puts "WARNING: write_sdf failed: $sdf_err"
}

report_utilization    -file [file join $outdir utilization.rpt]
report_clocks         -file [file join $outdir clocks.rpt]
report_timing_summary -delay_type min_max -max_paths 128 -file [file join $outdir timing_summary.rpt]
report_timing -delay_type max -max_paths 128 -nworst 1 -sort_by slack -file [file join $outdir paths_max.rpt]
report_timing -delay_type min -max_paths 128 -nworst 1 -sort_by slack -file [file join $outdir paths_min.rpt]

foreach grp {phase_a phase_b transaction_clock} {
    if {[llength [get_clocks -quiet $grp]] > 0} {
        catch {report_timing -group $grp -delay_type max -max_paths 32 -sort_by slack \
                   -file [file join $outdir group_${grp}_max.rpt]}
        catch {report_timing -group $grp -delay_type min -max_paths 32 -sort_by slack \
                   -file [file join $outdir group_${grp}_min.rpt]}
    }
}

# ---- machine-readable per-run metadata --------------------------------------
set mf [open [file join $outdir run_meta.csv] w]
puts $mf "key,value"
foreach {k v} [list \
        variant   $variant \
        blocks    $blocks \
        top       $top \
        period_ns $period \
        arise_ns  $arise \
        awidth_ns $awidth \
        brise_ns  $brise \
        bwidth_ns $bwidth \
        fd_cells  $n_fd \
        ld_cells  $n_ld \
        lut_cells $n_lut \
        bufg_cells $n_bufg \
        part      $part \
        vivado    [version -short] \
        utc       [clock format [clock seconds] -format %Y-%m-%dT%H:%M:%SZ -gmt 1]] {
    puts $mf "$k,$v"
}
close $mf

# ---- legacy compact summary (path-group worst slack via reports) ------------
set sf [open [file join $outdir summary.csv] w]
puts $sf "variant,blocks,period_ns,a_rise_ns,a_width_ns,group,check,slack_ns"
foreach grp {phase_a phase_b transaction_clock} {
    if {[llength [get_clocks -quiet $grp]] == 0} { continue }
    foreach check {max min} {
        set f [file join $outdir group_${grp}_${check}.rpt]
        if {![file exists $f]} { continue }
        set fh2 [open $f r]
        set txt [read $fh2]
        close $fh2
        if {[regexp {Slack \((?:MET|VIOLATED)\)\s*:\s*(-?\d+(?:\.\d+)?)ns} $txt -> slack]} {
            puts $sf "$variant,$blocks,$period,$arise,$awidth,$grp,$check,$slack"
        }
    }
}
close $sf

puts "DONE: $variant BLOCKS=$blocks T=$period arise=$arise awidth=$awidth -> $outdir"
