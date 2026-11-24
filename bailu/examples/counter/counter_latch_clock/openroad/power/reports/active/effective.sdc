###############################################################################
# Created by write_sdc
###############################################################################
current_design counter
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name phi1 -period 1.730000019 -waveform {0.008650000 0.856350005} [get_ports {clk_1}]
set_clock_transition 0.059999999 [get_clocks {phi1}]
set_clock_uncertainty 0.049999997 phi1
set_propagated_clock [get_clocks {phi1}]
create_clock -name phi2 -period 1.730000019 -waveform {0.873650014 1.721349955} [get_ports {clk_2}]
set_clock_transition 0.059999999 [get_clocks {phi2}]
set_clock_uncertainty 0.049999997 phi2
set_propagated_clock [get_clocks {phi2}]
set_clock_uncertainty -from [get_clocks {phi1}] -to [get_clocks {phi2}] 0.049999997
set_clock_uncertainty -from [get_clocks {phi2}] -to [get_clocks {phi1}] 0.049999997
set_input_delay 0.199999988 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {en}]
set_input_delay 1.000000000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {en}]
set_input_delay 0.199999988 -clock [get_clocks {phi2}] -clock_fall -rise -min -add_delay [get_ports {rst_n}]
set_input_delay 0.500000000 -clock [get_clocks {phi2}] -clock_fall -rise -max -add_delay [get_ports {rst_n}]
set_output_delay -0.049999997 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {count[0]}]
set_output_delay 1.000000000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {count[0]}]
set_output_delay -0.049999997 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {count[1]}]
set_output_delay 1.000000000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {count[1]}]
set_output_delay -0.049999997 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {count[2]}]
set_output_delay 1.000000000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {count[2]}]
set_output_delay -0.049999997 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {count[3]}]
set_output_delay 1.000000000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {count[3]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.010000000 [get_ports {count[3]}]
set_load -pin_load 0.010000000 [get_ports {count[2]}]
set_load -pin_load 0.010000000 [get_ports {count[1]}]
set_load -pin_load 0.010000000 [get_ports {count[0]}]
set_input_transition 0.059999999 [get_ports {clk_1}]
set_input_transition 0.059999999 [get_ports {clk_2}]
set_input_transition 0.059999999 [get_ports {en}]
set_input_transition 0.059999999 [get_ports {rst_n}]
set_case_analysis 1 [get_ports {rst_n}]
###############################################################################
# Design Rules
###############################################################################
