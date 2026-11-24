# Read the SKY130 HD Liberty and counter_sky130_1.v, then link_design counter.
# Units: ns and pF. Both phases come from the same external clock reference.

# Period 2.319 ns; each phase high for 1.13631 ns (49%).
# The phases have 0.02319 ns port dead time per handoff.
create_clock -name phi1 -period 2.319 -waveform {0.011595 1.147905} [get_ports clk_1]
create_clock -name phi2 -period 2.319 -waveform {1.171095 2.307405} [get_ports clk_2]

# Ideal clocks for pre-CTS STA. Keep both directions of interphase timing.
set_clock_transition 0.06 [get_clocks {phi1 phi2}]
set_input_transition 0.06 [get_ports {clk_1 clk_2 en rst_n}]
set_clock_uncertainty 0.05 [get_clocks {phi1 phi2}]
set_clock_uncertainty -from [get_clocks phi1] -to [get_clocks phi2] 0.05
set_clock_uncertainty -from [get_clocks phi2] -to [get_clocks phi1] 0.05

# Baseline I/O budgets, referenced to the phi1 falling edge.
set_input_delay -clock phi1 -clock_fall -min 0.20 [get_ports en]
set_input_delay -clock phi1 -clock_fall -max 1.00 [get_ports en]
set_output_delay -clock phi1 -clock_fall -min -0.05 [get_ports {count*}]
set_output_delay -clock phi1 -clock_fall -max 1.00 [get_ports {count*}]
set_load 0.010 [get_ports {count*}]

# Reset release assumption: rst_n rises 0.20-0.50 ns after phi2 falls.
# Keep recovery/removal checks active. Update this budget for the reset source.
set_input_delay -clock phi2 -clock_fall -rise -min 0.20 [get_ports rst_n]
set_input_delay -clock phi2 -clock_fall -rise -max 0.50 [get_ports rst_n]
