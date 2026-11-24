`timescale 1ns / 1ps
// One-to-one SKY130 HD mapping of counter_mapped.v.
// The rising-edge state flops clear asynchronously when rst_n is low.

module counter(clk, rst_n, en, count);
  input clk;
  wire clk;
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
  sky130_fd_sc_hd__dfrtp_1 \count_o_reg[0]  /* _07_ */ (
    .CLK(clk),
    .D(_04_),
    .Q(count_o[0]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dfrtp_1 \count_o_reg[1]  /* _08_ */ (
    .CLK(clk),
    .D(_03_),
    .Q(count_o[1]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dfrtp_1 \count_o_reg[2]  /* _09_ */ (
    .CLK(clk),
    .D(_05_),
    .Q(count_o[2]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dfrtp_1 \count_o_reg[3]  /* _10_ */ (
    .CLK(clk),
    .D(_06_),
    .Q(count_o[3]),
    .RESET_B(rst_n)
  );
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
  sky130_fd_sc_hd__mux2_1 _13_ (
    .A0(count_o[2]),
    .A1(_02_[2]),
    .S(en),
    .X(_05_)
  );
  sky130_fd_sc_hd__mux2_1 _14_ (
    .A0(count_o[3]),
    .A1(_02_[3]),
    .S(en),
    .X(_06_)
  );
  sky130_fd_sc_hd__and2_1 _15_ (
    .A(count_o[2]),
    .B(_00_[1]),
    .X(_00_[2])
  );
  sky130_fd_sc_hd__and2_1 _16_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .X(_00_[1])
  );
  sky130_fd_sc_hd__xor2_1 _17_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .X(_02_[1])
  );
  sky130_fd_sc_hd__xor2_1 _18_ (
    .A(count_o[2]),
    .B(_00_[1]),
    .X(_02_[2])
  );
  sky130_fd_sc_hd__xor2_1 _19_ (
    .A(count_o[3]),
    .B(_00_[2]),
    .X(_02_[3])
  );
  sky130_fd_sc_hd__inv_1 _20_ (
    .A(count_o[0]),
    .Y(_01_[0])
  );
  assign _01_[3:1] = count_o[3:1];
  assign _02_[0] = _01_[0];
  assign _00_[0] = count_o[0];
  assign count = count_o;
endmodule
