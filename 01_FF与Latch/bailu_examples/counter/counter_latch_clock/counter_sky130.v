`timescale 1ns / 1ps
// Pedroso et al., Fig. 5(c), with bit 2 and bit 3 XORs retimed.
// Drive clk_1 then clk_2 with non-overlapping active-high phases.

module counter (
  input clk_1,
  input clk_2,
  input rst_n,
  input en,
  output [3:0] count
);
  wire en_phi1;
  wire clk_2_gated;
  wire [3:0] count_o;
  wire [3:0] next_count;
  wire [3:0] phase_1;
  wire carry_bit2;
  wire carry_bit3;
  wire phase_1_carry_bit2;
  wire phase_1_carry_bit3;

  // Keep the gate decision stable throughout phase 2, including during reset.
  sky130_fd_sc_hd__dlxtp_1 enable_phi1 (
    .GATE(clk_1),
    .D(en),
    .Q(en_phi1)
  );
  sky130_fd_sc_hd__and2_1 gate_phi2 (
    .A(clk_2),
    .B(en_phi1),
    .X(clk_2_gated)
  );

  // Phase 1 captures bits 0-1 and both operands of each retimed XOR.
  sky130_fd_sc_hd__dlrtp_1 state_phi1_bit0 (
    .GATE(clk_1),
    .D(next_count[0]),
    .Q(phase_1[0]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi1_bit1 (
    .GATE(clk_1),
    .D(next_count[1]),
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
  sky130_fd_sc_hd__dlrtp_1 state_phi1_carry_bit2 (
    .GATE(clk_1),
    .D(carry_bit2),
    .Q(phase_1_carry_bit2),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi1_carry_bit3 (
    .GATE(clk_1),
    .D(carry_bit3),
    .Q(phase_1_carry_bit3),
    .RESET_B(rst_n)
  );

  sky130_fd_sc_hd__xor2_1 increment_bit2 (
    .A(phase_1[2]),
    .B(phase_1_carry_bit2),
    .X(next_count[2])
  );
  sky130_fd_sc_hd__xor2_1 increment_bit3 (
    .A(phase_1[3]),
    .B(phase_1_carry_bit3),
    .X(next_count[3])
  );

  // Phase 2 publishes the count only when enabled. Reset bypasses the clock gate.
  sky130_fd_sc_hd__dlrtp_1 state_phi2_bit0 (
    .GATE(clk_2_gated),
    .D(phase_1[0]),
    .Q(count_o[0]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi2_bit1 (
    .GATE(clk_2_gated),
    .D(phase_1[1]),
    .Q(count_o[1]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi2_bit2 (
    .GATE(clk_2_gated),
    .D(next_count[2]),
    .Q(count_o[2]),
    .RESET_B(rst_n)
  );
  sky130_fd_sc_hd__dlrtp_1 state_phi2_bit3 (
    .GATE(clk_2_gated),
    .D(next_count[3]),
    .Q(count_o[3]),
    .RESET_B(rst_n)
  );

  // Compute bits 0-1 and the carries from the published count.
  sky130_fd_sc_hd__inv_1 increment_bit0 (
    .A(count_o[0]),
    .Y(next_count[0])
  );
  sky130_fd_sc_hd__and2_1 carry_into_bit2 (
    .A(count_o[1]),
    .B(count_o[0]),
    .X(carry_bit2)
  );
  sky130_fd_sc_hd__and2_1 carry_into_bit3 (
    .A(count_o[2]),
    .B(carry_bit2),
    .X(carry_bit3)
  );
  sky130_fd_sc_hd__xor2_1 increment_bit1 (
    .A(count_o[1]),
    .B(count_o[0]),
    .X(next_count[1])
  );

  assign count = count_o;
endmodule
