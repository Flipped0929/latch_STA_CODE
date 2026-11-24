set gate_enable_pins [get_pins -quiet {gate_phi2_*/B}]

if {[llength $gate_enable_pins] == 0} {
    error "No gate_phi2 enable pins found"
}

set_clock_gating_check \
    -setup 0.05 \
    -hold 0.05 \
    $gate_enable_pins

puts "gating_check: pins=[llength $gate_enable_pins] setup=0.05ns hold=0.05ns"