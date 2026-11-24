`timescale 1ns / 1ps
// Two-phase recirculation MUX architecture from arXiv:2605.05374v1, Fig. 5(b).
// Source increment logic: ../counter_retiming_latch_mux_1/counter_yosys.v.
// Apply non-overlapping active-high clk_1 and clk_2 windows in that order.
// rst_n asynchronously clears all main and recirculation data latches.
// Yosys internal cells. No retiming applied.

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
  \$_DLATCH_P_  en_phi1 (
    .E(clk_1),
    .D(en),
    .Q(en_1)
  );

  // Phase 1 main bank selects new data or its phase 2 hold copy.
  \$_MUX_  mux_phi1_bit0 (
    .A(recirc_q_phi2[0]),
    .B(increment[0]),
    .S(en),
    .Y(main_d_phi1[0])
  );
  \$_DLATCH_PN0_  main_phi1_bit0 (
    .E(clk_1),
    .D(main_d_phi1[0]),
    .Q(main_q_phi1[0]),
    .R(rst_n)
  );
  \$_MUX_  mux_phi1_bit1 (
    .A(recirc_q_phi2[1]),
    .B(increment[1]),
    .S(en),
    .Y(main_d_phi1[1])
  );
  \$_DLATCH_PN0_  main_phi1_bit1 (
    .E(clk_1),
    .D(main_d_phi1[1]),
    .Q(main_q_phi1[1]),
    .R(rst_n)
  );
  \$_MUX_  mux_phi1_bit2 (
    .A(recirc_q_phi2[2]),
    .B(increment[2]),
    .S(en),
    .Y(main_d_phi1[2])
  );
  \$_DLATCH_PN0_  main_phi1_bit2 (
    .E(clk_1),
    .D(main_d_phi1[2]),
    .Q(main_q_phi1[2]),
    .R(rst_n)
  );
  \$_MUX_  mux_phi1_bit3 (
    .A(recirc_q_phi2[3]),
    .B(increment[3]),
    .S(en),
    .Y(main_d_phi1[3])
  );
  \$_DLATCH_PN0_  main_phi1_bit3 (
    .E(clk_1),
    .D(main_d_phi1[3]),
    .Q(main_q_phi1[3]),
    .R(rst_n)
  );

  // Phase 1 recirculation bank stores the phase 2 main output.
  \$_DLATCH_PN0_  recirc_phi1_bit0 (
    .E(clk_1),
    .D(count_o[0]),
    .Q(recirc_q_phi1[0]),
    .R(rst_n)
  );
  \$_DLATCH_PN0_  recirc_phi1_bit1 (
    .E(clk_1),
    .D(count_o[1]),
    .Q(recirc_q_phi1[1]),
    .R(rst_n)
  );
  \$_DLATCH_PN0_  recirc_phi1_bit2 (
    .E(clk_1),
    .D(count_o[2]),
    .Q(recirc_q_phi1[2]),
    .R(rst_n)
  );
  \$_DLATCH_PN0_  recirc_phi1_bit3 (
    .E(clk_1),
    .D(count_o[3]),
    .Q(recirc_q_phi1[3]),
    .R(rst_n)
  );

  // Phase 2 main bank selects new data or its phase 1 hold copy.
  \$_MUX_  mux_phi2_bit0 (
    .A(recirc_q_phi1[0]),
    .B(main_q_phi1[0]),
    .S(en_1),
    .Y(main_d_phi2[0])
  );
  \$_DLATCH_PN0_  main_phi2_bit0 (
    .E(clk_2),
    .D(main_d_phi2[0]),
    .Q(count_o[0]),
    .R(rst_n)
  );
  \$_MUX_  mux_phi2_bit1 (
    .A(recirc_q_phi1[1]),
    .B(main_q_phi1[1]),
    .S(en_1),
    .Y(main_d_phi2[1])
  );
  \$_DLATCH_PN0_  main_phi2_bit1 (
    .E(clk_2),
    .D(main_d_phi2[1]),
    .Q(count_o[1]),
    .R(rst_n)
  );
  \$_MUX_  mux_phi2_bit2 (
    .A(recirc_q_phi1[2]),
    .B(main_q_phi1[2]),
    .S(en_1),
    .Y(main_d_phi2[2])
  );
  \$_DLATCH_PN0_  main_phi2_bit2 (
    .E(clk_2),
    .D(main_d_phi2[2]),
    .Q(count_o[2]),
    .R(rst_n)
  );
  \$_MUX_  mux_phi2_bit3 (
    .A(recirc_q_phi1[3]),
    .B(main_q_phi1[3]),
    .S(en_1),
    .Y(main_d_phi2[3])
  );
  \$_DLATCH_PN0_  main_phi2_bit3 (
    .E(clk_2),
    .D(main_d_phi2[3]),
    .Q(count_o[3]),
    .R(rst_n)
  );

  // Phase 2 recirculation bank stores the phase 1 main output.
  \$_DLATCH_PN0_  recirc_phi2_bit0 (
    .E(clk_2),
    .D(main_q_phi1[0]),
    .Q(recirc_q_phi2[0]),
    .R(rst_n)
  );
  \$_DLATCH_PN0_  recirc_phi2_bit1 (
    .E(clk_2),
    .D(main_q_phi1[1]),
    .Q(recirc_q_phi2[1]),
    .R(rst_n)
  );
  \$_DLATCH_PN0_  recirc_phi2_bit2 (
    .E(clk_2),
    .D(main_q_phi1[2]),
    .Q(recirc_q_phi2[2]),
    .R(rst_n)
  );
  \$_DLATCH_PN0_  recirc_phi2_bit3 (
    .E(clk_2),
    .D(main_q_phi1[3]),
    .Q(recirc_q_phi2[3]),
    .R(rst_n)
  );

  // Increment logic reads the published phase 2 count.
  \$_AND_  _15_ (
    .A(count_o[2]),
    .B(carry[1]),
    .Y(carry[2])
  );
  \$_AND_  _16_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .Y(carry[1])
  );
  \$_XOR_  _17_ (
    .A(count_o[1]),
    .B(count_o[0]),
    .Y(increment[1])
  );
  \$_XOR_  _18_ (
    .A(count_o[2]),
    .B(carry[1]),
    .Y(increment[2])
  );
  \$_XOR_  _19_ (
    .A(count_o[3]),
    .B(carry[2]),
    .Y(increment[3])
  );
  \$_NOT_  _20_ (
    .A(count_o[0]),
    .Y(increment[0])
  );

  assign count = count_o;
endmodule
