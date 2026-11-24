`timescale 1ns / 1ps
// Two-phase recirculation MUX architecture from arXiv:2605.05374v1, Fig. 5(b).
// Source increment logic: ../counter_retiming_latch_mux_1/counter_yosys.v.
// Apply non-overlapping active-high clk_1 and clk_2 windows in that order.
// rst_n asynchronously clears all main and recirculation data latches.
// SKY130 HD cells. No retiming applied.

module counter(
  input clk_1,
  input clk_2,
  input rst_n,
  input en,
  output [3:0] count
);
  wire [3:0] count_o;
  wire [3:0] increment;
  wire [2:1] carry;
  wire [3:0] main_d_phi1, main_q_phi1;
  wire [3:0] main_d_phi2;
  wire [3:0] recirc_q_phi1, recirc_q_phi2;
  wire en_1;

  // Phase 1 samples en for use by the phase 2 MUX bank.
  sky130_fd_sc_hd__dlxtp_1 en_phi1 (
    .GATE(clk_1),
    .D(en),
    .Q(en_1)
  );

  // Phase 1 main bank selects new data or its phase 2 hold copy.
  sky130_fd_sc_hd__mux2_1 mux_phi1_bit0 (
    .A0(recirc_q_phi2[0]),
    .A1(increment[0]),
    .S(en),
    .X(main_d_phi1[0])
  );
  sky130_fd_sc_hd__dlrtp_1 main_phi1_bit0 (
    .GATE(clk_1),
    .D(main_d_phi1[0]),
    .Q(main_q_phi1[0]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__mux2_1 mux_phi1_bit1 (
    .A0(recirc_q_phi2[1]),
    .A1(increment[1]),
    .S(en),
    .X(main_d_phi1[1])
  );
  sky130_fd_sc_hd__dlrtp_1 main_phi1_bit1 (
    .GATE(clk_1),
    .D(main_d_phi1[1]),
    .Q(main_q_phi1[1]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__mux2_1 mux_phi1_bit2 (
    .A0(recirc_q_phi2[2]),
    .A1(increment[2]),
    .S(en),
    .X(main_d_phi1[2])
  );
  sky130_fd_sc_hd__dlrtp_1 main_phi1_bit2 (
    .GATE(clk_1),
    .D(main_d_phi1[2]),
    .Q(main_q_phi1[2]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__mux2_1 mux_phi1_bit3 (
    .A0(recirc_q_phi2[3]),
    .A1(increment[3]),
    .S(en),
    .X(main_d_phi1[3])
  );
  sky130_fd_sc_hd__dlrtp_1 main_phi1_bit3 (
    .GATE(clk_1),
    .D(main_d_phi1[3]),
    .Q(main_q_phi1[3]),
    .RESET_B(rst_n)
  );

  // Phase 1 recirculation bank stores the phase 2 main output.
  sky130_fd_sc_hd__dlrtp_1 recirc_phi1_bit0 (
    .GATE(clk_1),
    .D(count_o[0]),
    .Q(recirc_q_phi1[0]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 recirc_phi1_bit1 (
    .GATE(clk_1),
    .D(count_o[1]),
    .Q(recirc_q_phi1[1]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 recirc_phi1_bit2 (
    .GATE(clk_1),
    .D(count_o[2]),
    .Q(recirc_q_phi1[2]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 recirc_phi1_bit3 (
    .GATE(clk_1),
    .D(count_o[3]),
    .Q(recirc_q_phi1[3]),
    .RESET_B(rst_n)
  );

  // Phase 2 main bank selects new data or its phase 1 hold copy.
  sky130_fd_sc_hd__mux2_1 mux_phi2_bit0 (
    .A0(recirc_q_phi1[0]),
    .A1(main_q_phi1[0]),
    .S(en_1),
    .X(main_d_phi2[0])
  );
  sky130_fd_sc_hd__dlrtp_1 main_phi2_bit0 (
    .GATE(clk_2),
    .D(main_d_phi2[0]),
    .Q(count_o[0]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__mux2_1 mux_phi2_bit1 (
    .A0(recirc_q_phi1[1]),
    .A1(main_q_phi1[1]),
    .S(en_1),
    .X(main_d_phi2[1])
  );
  sky130_fd_sc_hd__dlrtp_1 main_phi2_bit1 (
    .GATE(clk_2),
    .D(main_d_phi2[1]),
    .Q(count_o[1]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__mux2_1 mux_phi2_bit2 (
    .A0(recirc_q_phi1[2]),
    .A1(main_q_phi1[2]),
    .S(en_1),
    .X(main_d_phi2[2])
  );
  sky130_fd_sc_hd__dlrtp_1 main_phi2_bit2 (
    .GATE(clk_2),
    .D(main_d_phi2[2]),
    .Q(count_o[2]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__mux2_1 mux_phi2_bit3 (
    .A0(recirc_q_phi1[3]),
    .A1(main_q_phi1[3]),
    .S(en_1),
    .X(main_d_phi2[3])
  );
  sky130_fd_sc_hd__dlrtp_1 main_phi2_bit3 (
    .GATE(clk_2),
    .D(main_d_phi2[3]),
    .Q(count_o[3]),
    .RESET_B(rst_n)
  );

  // Phase 2 recirculation bank stores the phase 1 main output.
  sky130_fd_sc_hd__dlrtp_1 recirc_phi2_bit0 (
    .GATE(clk_2),
    .D(main_q_phi1[0]),
    .Q(recirc_q_phi2[0]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 recirc_phi2_bit1 (
    .GATE(clk_2),
    .D(main_q_phi1[1]),
    .Q(recirc_q_phi2[1]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 recirc_phi2_bit2 (
    .GATE(clk_2),
    .D(main_q_phi1[2]),
    .Q(recirc_q_phi2[2]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 recirc_phi2_bit3 (
    .GATE(clk_2),
    .D(main_q_phi1[3]),
    .Q(recirc_q_phi2[3]),
    .RESET_B(rst_n)
  );

  // Increment logic reads the published phase 2 count.
  sky130_fd_sc_hd__and2_1 _15_ (
    .A(count_o[2]),
    .B(carry[1]),
    .X(carry[2])
  );
  sky130_fd_sc_hd__and2_1 _16_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .X(carry[1])
  );
  sky130_fd_sc_hd__xor2_1 _17_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .X(increment[1])
  );
  sky130_fd_sc_hd__xor2_1 _18_ (
    .A(count_o[2]),
    .B(carry[1]),
    .X(increment[2])
  );
  sky130_fd_sc_hd__xor2_1 _19_ (
    .A(count_o[3]),
    .B(carry[2]),
    .X(increment[3])
  );
  sky130_fd_sc_hd__inv_1 _20_ (
    .A(count_o[0]),
    .Y(increment[0])
  );

  assign count = count_o;
endmodule
