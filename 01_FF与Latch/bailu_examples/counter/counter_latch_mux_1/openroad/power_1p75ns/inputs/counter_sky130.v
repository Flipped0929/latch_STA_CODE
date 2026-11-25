`timescale 1ns / 1ps
// Source: counter_sky130_1.v
// Drive clk_1 and clk_2 with non-overlapping active-high phases, in that order.
// Both latch banks clear asynchronously when rst_n is low.
// SKY130 HD cells. Bit 2 and bit 3 XORs are between phi1 and phi2.

module counter(clk_1, clk_2, rst_n, en, count);
  input clk_1;
  input clk_2;
  input rst_n;
  wire rst_n;
  input en;
  wire en;
  output [3:0] count;
  wire [3:0] count;
  wire [3:0] _01_;
  wire [1:0] _02_;
  wire _03_;
  wire _04_;
  wire toggle2;
  wire phase_1_toggle2;
  wire next_bit2;
  wire carry3;
  wire toggle3;
  wire phase_1_toggle3;
  wire next_bit3;
  wire [3:0] count_o;
  wire [3:0] phase_1;

  // Phase 1 captures bits 0-1 and both operands for each retimed XOR.
  sky130_fd_sc_hd__dlrtp_1 state_phi1_bit0 (
    .GATE(clk_1),
    .D(_04_),
    .Q(phase_1[0]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi1_bit1 (
    .GATE(clk_1),
    .D(_03_),
    .Q(phase_1[1]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi1_bit2 (
    .GATE(clk_1),
    .D(count_o[2]),
    .Q(phase_1[2]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi1_bit3 (
    .GATE(clk_1),
    .D(count_o[3]),
    .Q(phase_1[3]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi1_toggle2 (
    .GATE(clk_1),
    .D(toggle2),
    .Q(phase_1_toggle2),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi1_toggle3 (
    .GATE(clk_1),
    .D(toggle3),
    .Q(phase_1_toggle3),
    .RESET_B(rst_n)
  );

  sky130_fd_sc_hd__xor2_1 _18_ (
    .A(phase_1[2]),
    .B(phase_1_toggle2),
    .X(next_bit2)
  );
  sky130_fd_sc_hd__xor2_1 _19_ (
    .A(phase_1[3]),
    .B(phase_1_toggle3),
    .X(next_bit3)
  );

  // Phase 2 publishes the count and drives the original feedback paths.
  sky130_fd_sc_hd__dlrtp_1 state_phi2_bit0 (
    .GATE(clk_2),
    .D(phase_1[0]),
    .Q(count_o[0]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi2_bit1 (
    .GATE(clk_2),
    .D(phase_1[1]),
    .Q(count_o[1]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi2_bit2 (
    .GATE(clk_2),
    .D(next_bit2),
    .Q(count_o[2]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi2_bit3 (
    .GATE(clk_2),
    .D(next_bit3),
    .Q(count_o[3]),
    .RESET_B(rst_n)
  );

  // Hold multiplexers and increment logic for bits 0-1.
  sky130_fd_sc_hd__mux2_1 _11_ (
    .A0(count_o[1]),
    .A1(_02_[1]),
    .S(en),
    .X(_03_)
  );
  sky130_fd_sc_hd__mux2_1 _12_ (
    .A0(count_o[0]),
    .A1(_01_[0]),
    .S(en),
    .X(_04_)
  );
  sky130_fd_sc_hd__xor2_1 _17_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .X(_02_[1])
  );
  sky130_fd_sc_hd__inv_1 _20_ (
    .A(count_o[0]),
    .Y(_01_[0])
  );
  // A disabled count produces a zero toggle, so the XOR keeps the old bit.
  sky130_fd_sc_hd__and3_1 _16_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .C(en),
    .X(toggle2)
  );
  sky130_fd_sc_hd__and3_1 _15_ (
    .A(count_o[2]),
    .B(count_o[1]),
    .C(count_o[0]),
    .X(carry3)
  );
  sky130_fd_sc_hd__and2_1 bit3_enable (
    .A(en),
    .B(carry3),
    .X(toggle3)
  );

  assign _01_[3:1] = count_o[3:1];
  assign _02_[0] = _01_[0];
  assign count = count_o;
endmodule
