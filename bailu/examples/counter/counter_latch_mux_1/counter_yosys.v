`timescale 1ns / 1ps
// Source: ../counter_retiming/counter_mapped.v
// Drive clk_1 and clk_2 with non-overlapping active-high phases, in that order.
// Both DFF banks clear asynchronously when rst_n is low.
// Yosys internal cells. Both DFF banks sample on rising clock edges.

module counter(clk_1, clk_2, rst_n, en, count);
  input clk_1;
  input clk_2;
  input rst_n;
  wire rst_n;
  input en;
  wire en;
  output [3:0] count;
  wire [3:0] count;
  wire [3:0] _00_;
  wire [3:0] _01_;
  wire [3:0] _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire [3:0] count_o;
  wire [3:0] phase_1;

  // The rising edge of clk_1 captures the next count.
  \$_DFF_PN0_  state_phi1_bit0 (
    .C(clk_1),
    .D(_04_),
    .Q(phase_1[0]),
    .R(rst_n)
  );
  \$_DFF_PN0_  state_phi1_bit1 (
    .C(clk_1),
    .D(_03_),
    .Q(phase_1[1]),
    .R(rst_n)
  );
  \$_DFF_PN0_  state_phi1_bit2 (
    .C(clk_1),
    .D(_05_),
    .Q(phase_1[2]),
    .R(rst_n)
  );
  \$_DFF_PN0_  state_phi1_bit3 (
    .C(clk_1),
    .D(_06_),
    .Q(phase_1[3]),
    .R(rst_n)
  );

  // The rising edge of clk_2 updates the count and feedback paths.
  \$_DFF_PN0_  state_phi2_bit0 (
    .C(clk_2),
    .D(phase_1[0]),
    .Q(count_o[0]),
    .R(rst_n)
  );
  \$_DFF_PN0_  state_phi2_bit1 (
    .C(clk_2),
    .D(phase_1[1]),
    .Q(count_o[1]),
    .R(rst_n)
  );
  \$_DFF_PN0_  state_phi2_bit2 (
    .C(clk_2),
    .D(phase_1[2]),
    .Q(count_o[2]),
    .R(rst_n)
  );
  \$_DFF_PN0_  state_phi2_bit3 (
    .C(clk_2),
    .D(phase_1[3]),
    .Q(count_o[3]),
    .R(rst_n)
  );

  // Original hold multiplexers and increment logic.
  \$_MUX_  _11_ (
    .A(count_o[1]),
    .B(_02_[1]),
    .S(en),
    .Y(_03_)
  );
  \$_MUX_  _12_ (
    .A(count_o[0]),
    .B(_01_[0]),
    .S(en),
    .Y(_04_)
  );
  \$_MUX_  _13_ (
    .A(count_o[2]),
    .B(_02_[2]),
    .S(en),
    .Y(_05_)
  );
  \$_MUX_  _14_ (
    .A(count_o[3]),
    .B(_02_[3]),
    .S(en),
    .Y(_06_)
  );
  \$_AND_  _15_ (
    .A(count_o[2]),
    .B(_00_[1]),
    .Y(_00_[2])
  );
  \$_AND_  _16_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .Y(_00_[1])
  );
  \$_XOR_  _17_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .Y(_02_[1])
  );
  \$_XOR_  _18_ (
    .A(count_o[2]),
    .B(_00_[1]),
    .Y(_02_[2])
  );
  \$_XOR_  _19_ (
    .A(count_o[3]),
    .B(_00_[2]),
    .Y(_02_[3])
  );
  \$_NOT_  _20_ (
    .A(count_o[0]),
    .Y(_01_[0])
  );
  assign _01_[3:1] = count_o[3:1];
  assign _02_[0] = _01_[0];
  assign _00_[0] = count_o[0];
  assign count = count_o;
endmodule
