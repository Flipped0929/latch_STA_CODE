# Load the SKY130 HD Liberty and counter_sky130.v, then link_design counter.
# Units are ns and pF. The clock is ideal for pre-layout STA.
create_clock -name clk -period 1.80 -waveform {0.00 0.90} [get_ports clk]
set_clock_transition 0.06 [get_clocks clk]
set_clock_uncertainty -setup 0.05 [get_clocks clk]
set_clock_uncertainty -hold 0.05 [get_clocks clk]
set_input_transition 0.06 [get_ports {clk en rst_n}]

# Baseline external timing and load budgets, referenced to the rising edge.
set_input_delay -clock clk -min 0.20 [get_ports en]
set_input_delay -clock clk -max 1.00 [get_ports en]
set_output_delay -clock clk -min -0.05 [get_ports {count*}]
set_output_delay -clock clk -max 1.00 [get_ports {count*}]
set_load 0.010 [get_ports {count*}]

# Model reset release 0.20-0.50 ns after the falling edge for recovery/removal.
set_input_delay -clock clk -clock_fall -rise -min 0.20 [get_ports rst_n]
set_input_delay -clock clk -clock_fall -rise -max 0.50 [get_ports rst_n]
