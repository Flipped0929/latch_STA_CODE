###############################################################################
# Created by write_sdc
# Mon Nov  9 14:52:21 2026
###############################################################################
current_design counter
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name phi1 -period 1.7500 -waveform {0.0088 0.8662} [get_ports {clk_1}]
set_clock_transition 0.0600 [get_clocks {phi1}]
set_clock_uncertainty 0.0500 phi1
set_propagated_clock [get_clocks {phi1}]
create_clock -name phi2 -period 1.7500 -waveform {0.8837 1.7412} [get_ports {clk_2}]
set_clock_transition 0.0600 [get_clocks {phi2}]
set_clock_uncertainty 0.0500 phi2
set_propagated_clock [get_clocks {phi2}]
set_clock_uncertainty -from [get_clocks {phi1}] -to [get_clocks {phi2}] 0.0500
set_clock_uncertainty -from [get_clocks {phi2}] -to [get_clocks {phi1}] 0.0500
set_input_delay 0.2000 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {en}]
set_input_delay 1.0000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {en}]
set_input_delay 0.2000 -clock [get_clocks {phi2}] -clock_fall -rise -min -add_delay [get_ports {rst_n}]
set_input_delay 0.5000 -clock [get_clocks {phi2}] -clock_fall -rise -max -add_delay [get_ports {rst_n}]
set_output_delay -0.0500 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {count[0]}]
set_output_delay 1.0000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {count[0]}]
set_output_delay -0.0500 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {count[1]}]
set_output_delay 1.0000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {count[1]}]
set_output_delay -0.0500 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {count[2]}]
set_output_delay 1.0000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {count[2]}]
set_output_delay -0.0500 -clock [get_clocks {phi1}] -clock_fall -min -add_delay [get_ports {count[3]}]
set_output_delay 1.0000 -clock [get_clocks {phi1}] -clock_fall -max -add_delay [get_ports {count[3]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0100 [get_ports {count[3]}]
set_load -pin_load 0.0100 [get_ports {count[2]}]
set_load -pin_load 0.0100 [get_ports {count[1]}]
set_load -pin_load 0.0100 [get_ports {count[0]}]
set_input_transition 0.0600 [get_ports {clk_1}]
set_input_transition 0.0600 [get_ports {clk_2}]
set_input_transition 0.0600 [get_ports {en}]
set_input_transition 0.0600 [get_ports {rst_n}]
###############################################################################
# Design Rules
###############################################################################
