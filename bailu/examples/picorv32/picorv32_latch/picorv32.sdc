# PicoRV32 two-phase latch netlist, SKY130 HD. Units are ns and pF.
# Read the Liberty, read picorv32_sky130.v and link_design picorv32 first.
set_units -time ns -capacitance pF

# Related external phases, period 10 ns, high time 4.9 ns (49%).
# Dead time is 0.1 ns at both phase handoffs, including the period boundary.
create_clock -name phi1 -period 10.0 -waveform {0.0 4.9} [get_ports clk_1]
create_clock -name phi2 -period 10.0 -waveform {5.0 9.9} [get_ports clk_2]

# Initial implementation assumptions. Replace these margins with clock-source
# jitter and skew budgets when available. Apply them to all four clock pairs.
set phase_clocks [get_clocks {phi1 phi2}]
set_clock_transition 0.10 $phase_clocks
set_clock_uncertainty -setup -from $phase_clocks -to $phase_clocks 0.05
set_clock_uncertainty -hold -from $phase_clocks -to $phase_clocks 0.05

# phi2 propagates through gate_phi2_*/A -> X. Pin B is the sampled enable.
# Require the enable to remain stable around the active phi2 window.
set_clock_gating_check -setup 0.05 -hold 0.05 [get_pins {gate_phi2_*/B}]

# Baseline external interface contract.
# Inputs launch relative to the phi1 rising edge. Outputs are captured by an
# external device at the next phi1 rising edge. Both max I/O budgets are 1 ns.
# resetn is a synchronous data input in this converted PicoRV32 netlist.
set data_inputs [get_ports {resetn irq* mem_ready mem_rdata* pcpi_wr pcpi_rd* pcpi_wait pcpi_ready}]
set data_outputs [all_outputs]
set_input_delay -clock phi1 -min 0.00 $data_inputs
set_input_delay -clock phi1 -max 1.00 $data_inputs
set_output_delay -clock phi1 -min 0.00 $data_outputs
set_output_delay -clock phi1 -max 1.00 $data_outputs
set_input_transition 0.10 $data_inputs
set_load 0.010 $data_outputs

# This file uses ideal clocks for pre-CTS implementation.
# After CTS, enable calculated clock-tree delays before STA with:
# set_propagated_clock [get_clocks {phi1 phi2}]
