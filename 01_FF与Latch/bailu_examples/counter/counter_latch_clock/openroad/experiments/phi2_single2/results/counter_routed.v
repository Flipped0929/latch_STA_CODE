module counter (clk_1,
    clk_2,
    en,
    rst_n,
    count);
 input clk_1;
 input clk_2;
 input en;
 input rst_n;
 output [3:0] count;

 wire carry_bit2;
 wire carry_bit3;
 wire clk_2_gated;
 wire en_phi1;
 wire phase_1_carry_bit2;
 wire phase_1_carry_bit3;
 wire clknet_0_clk_1;
 wire clknet_1_0__leaf_clk_1;
 wire clknet_1_1__leaf_clk_1;
 wire clknet_phi2_leaf1;
 wire [3:0] count_o;
 wire [3:0] next_count;
 wire [3:0] phase_1;

 sky130_fd_sc_hd__and2_1 carry_into_bit2 (.A(count_o[1]),
    .B(count_o[0]),
    .X(carry_bit2));
 sky130_fd_sc_hd__and2_1 carry_into_bit3 (.A(count_o[2]),
    .B(carry_bit2),
    .X(carry_bit3));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_0_clk_1 (.A(clk_1),
    .X(clknet_0_clk_1));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_0__f_clk_1 (.A(clknet_0_clk_1),
    .X(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_1__f_clk_1 (.A(clknet_0_clk_1),
    .X(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_phi2_single1 (.A(clknet_phi2_leaf1),
    .X(clk_2_gated));
 sky130_fd_sc_hd__clkinv_2 clkload0 (.A(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__dlxtp_1 enable_phi1 (.D(en),
    .Q(en_phi1),
    .GATE(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__and2_1 gate_phi2 (.A(clk_2),
    .B(en_phi1),
    .X(clknet_phi2_leaf1));
 sky130_fd_sc_hd__inv_1 increment_bit0 (.A(count_o[0]),
    .Y(next_count[0]));
 sky130_fd_sc_hd__xor2_1 increment_bit1 (.A(count_o[1]),
    .B(count_o[0]),
    .X(next_count[1]));
 sky130_fd_sc_hd__xor2_1 increment_bit2 (.A(phase_1[2]),
    .B(phase_1_carry_bit2),
    .X(next_count[2]));
 sky130_fd_sc_hd__xor2_1 increment_bit3 (.A(phase_1[3]),
    .B(phase_1_carry_bit3),
    .X(next_count[3]));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_bit0 (.D(next_count[0]),
    .Q(phase_1[0]),
    .RESET_B(rst_n),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_bit1 (.D(next_count[1]),
    .Q(phase_1[1]),
    .RESET_B(rst_n),
    .GATE(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_bit2 (.D(count_o[2]),
    .Q(phase_1[2]),
    .RESET_B(rst_n),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_bit3 (.D(count_o[3]),
    .Q(phase_1[3]),
    .RESET_B(rst_n),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_carry_bit2 (.D(carry_bit2),
    .Q(phase_1_carry_bit2),
    .RESET_B(rst_n),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_carry_bit3 (.D(carry_bit3),
    .Q(phase_1_carry_bit3),
    .RESET_B(rst_n),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_4 state_phi2_bit0 (.D(phase_1[0]),
    .Q(count_o[0]),
    .RESET_B(rst_n),
    .GATE(clk_2_gated));
 sky130_fd_sc_hd__dlrtp_4 state_phi2_bit1 (.D(phase_1[1]),
    .Q(count_o[1]),
    .RESET_B(rst_n),
    .GATE(clk_2_gated));
 sky130_fd_sc_hd__dlrtp_2 state_phi2_bit2 (.D(next_count[2]),
    .Q(count_o[2]),
    .RESET_B(rst_n),
    .GATE(clk_2_gated));
 sky130_fd_sc_hd__dlrtp_2 state_phi2_bit3 (.D(next_count[3]),
    .Q(count_o[3]),
    .RESET_B(rst_n),
    .GATE(clk_2_gated));
 assign count[0] = count_o[0];
 assign count[1] = count_o[1];
 assign count[2] = count_o[2];
 assign count[3] = count_o[3];
endmodule
