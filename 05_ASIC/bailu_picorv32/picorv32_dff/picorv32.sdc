# PicoRV32 DFF baseline, SKY130 HD. Units are ns and pF.
set_units -time ns -capacitance pF

# 100 MHz baseline; keep config.mk's ABC_CLOCK_PERIOD_IN_PS at 10000.
create_clock -name clk -period 10.0 -waveform {0.0 5.0} [get_ports clk]

# Initial implementation assumptions. Replace these margins with clock-source
# jitter and skew budgets when available.
set core_clock [get_clocks clk]
set_clock_transition 0.10 $core_clock
set_clock_uncertainty -setup 0.05 $core_clock
set_clock_uncertainty -hold 0.05 $core_clock

# Baseline external interface contract.
# Inputs launch relative to the clk rising edge. Outputs are captured by an
# external device at the next clk rising edge. Both max I/O budgets are 1 ns.
# resetn is synchronous and remains timed; do not false-path or tie it inactive.
set data_inputs [get_ports {resetn irq* mem_ready mem_rdata* pcpi_wr pcpi_rd* pcpi_wait pcpi_ready}]
set data_outputs [all_outputs]
set_input_delay -clock clk -min 0.00 $data_inputs
set_input_delay -clock clk -max 1.00 $data_inputs
set_output_delay -clock clk -min 0.00 $data_outputs
set_output_delay -clock clk -max 1.00 $data_outputs
set_input_transition 0.10 $data_inputs
set_load 0.010 $data_outputs

# This file uses ideal clocks for pre-CTS implementation.
# After CTS, enable calculated clock-tree delays before STA with:
# set_propagated_clock [get_clocks clk]
