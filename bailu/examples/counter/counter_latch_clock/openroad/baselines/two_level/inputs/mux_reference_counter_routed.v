module counter (clk_1,
    clk_2,
    en,
    rst_n,
    count,
    VSS,
    VDD);
 input clk_1;
 input clk_2;
 input en;
 input rst_n;
 output [3:0] count;
 inout VSS;
 inout VDD;

 wire _03_;
 wire _04_;
 wire carry3;
 wire next_bit2;
 wire next_bit3;
 wire phase_1_toggle2;
 wire phase_1_toggle3;
 wire rst_n_buffered1;
 wire toggle2;
 wire toggle3;
 wire clknet_0_clk_1;
 wire clknet_1_0__leaf_clk_1;
 wire clknet_1_1__leaf_clk_1;
 wire clknet_0_clk_2;
 wire clknet_1_0__leaf_clk_2;
 wire clknet_1_1__leaf_clk_2;
 wire [0:0] _01_;
 wire [1:0] _02_;
 wire [3:0] count_o;
 wire [3:0] phase_1;

 sky130_fd_sc_hd__mux2_1 _11_ (.A0(count_o[1]),
    .A1(_02_[1]),
    .S(en),
    .X(_03_));
 sky130_fd_sc_hd__mux2_1 _12_ (.A0(count_o[0]),
    .A1(_01_[0]),
    .S(en),
    .X(_04_));
 sky130_fd_sc_hd__and3_1 _15_ (.A(count_o[2]),
    .B(count_o[1]),
    .C(count_o[0]),
    .X(carry3));
 sky130_fd_sc_hd__and3_1 _16_ (.A(count_o[1]),
    .B(count_o[0]),
    .C(en),
    .X(toggle2));
 sky130_fd_sc_hd__xor2_1 _17_ (.A(count_o[1]),
    .B(count_o[0]),
    .X(_02_[1]));
 sky130_fd_sc_hd__xor2_1 _18_ (.A(phase_1[2]),
    .B(phase_1_toggle2),
    .X(next_bit2));
 sky130_fd_sc_hd__xor2_1 _19_ (.A(phase_1[3]),
    .B(phase_1_toggle3),
    .X(next_bit3));
 sky130_fd_sc_hd__inv_1 _20_ (.A(count_o[0]),
    .Y(_01_[0]));
 sky130_fd_sc_hd__and2_4 bit3_enable (.A(en),
    .B(carry3),
    .X(toggle3));
 sky130_fd_sc_hd__clkbuf_4 clkbuf_0_clk_1 (.A(clk_1),
    .X(clknet_0_clk_1));
 sky130_fd_sc_hd__clkbuf_4 clkbuf_0_clk_2 (.A(clk_2),
    .X(clknet_0_clk_2));
 sky130_fd_sc_hd__clkbuf_4 clkbuf_1_0__f_clk_1 (.A(clknet_0_clk_1),
    .X(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__clkbuf_4 clkbuf_1_0__f_clk_2 (.A(clknet_0_clk_2),
    .X(clknet_1_0__leaf_clk_2));
 sky130_fd_sc_hd__clkbuf_4 clkbuf_1_1__f_clk_1 (.A(clknet_0_clk_1),
    .X(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__clkbuf_4 clkbuf_1_1__f_clk_2 (.A(clknet_0_clk_2),
    .X(clknet_1_1__leaf_clk_2));
 sky130_fd_sc_hd__buf_1 reset_release_buf1 (.A(rst_n),
    .X(rst_n_buffered1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_bit0 (.D(_04_),
    .Q(phase_1[0]),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_bit1 (.D(_03_),
    .Q(phase_1[1]),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_bit2 (.D(count_o[2]),
    .Q(phase_1[2]),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_bit3 (.D(count_o[3]),
    .Q(phase_1[3]),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_toggle2 (.D(toggle2),
    .Q(phase_1_toggle2),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 state_phi1_toggle3 (.D(toggle3),
    .Q(phase_1_toggle3),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_4 state_phi2_bit0 (.D(phase_1[0]),
    .Q(count_o[0]),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_0__leaf_clk_2));
 sky130_fd_sc_hd__dlrtp_4 state_phi2_bit1 (.D(phase_1[1]),
    .Q(count_o[1]),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_0__leaf_clk_2));
 sky130_fd_sc_hd__dlrtp_2 state_phi2_bit2 (.D(next_bit2),
    .Q(count_o[2]),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_1__leaf_clk_2));
 sky130_fd_sc_hd__dlrtp_2 state_phi2_bit3 (.D(next_bit3),
    .Q(count_o[3]),
    .RESET_B(rst_n_buffered1),
    .GATE(clknet_1_1__leaf_clk_2));
 assign count[0] = count_o[0];
 assign count[1] = count_o[1];
 assign count[2] = count_o[2];
 assign count[3] = count_o[3];
endmodule
