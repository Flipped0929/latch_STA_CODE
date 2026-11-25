`timescale 1ns / 1ps
// Explicit BLOCKS wrappers so that synthesis never depends on -generic support.
module latch_chain_top_1 (
    input  wire       clk_reference,
    input  wire       phase_a,
    input  wire       phase_b,
    input  wire       reset,
    input  wire [7:0] data_in,
    output wire [7:0] result
);
    latch_chain_top #(.BLOCKS(1)) u_top (
        .clk_reference(clk_reference), .phase_a(phase_a), .phase_b(phase_b),
        .reset(reset), .data_in(data_in), .result(result)
    );
endmodule

module latch_chain_top_2 (
    input  wire       clk_reference,
    input  wire       phase_a,
    input  wire       phase_b,
    input  wire       reset,
    input  wire [7:0] data_in,
    output wire [7:0] result
);
    latch_chain_top #(.BLOCKS(2)) u_top (
        .clk_reference(clk_reference), .phase_a(phase_a), .phase_b(phase_b),
        .reset(reset), .data_in(data_in), .result(result)
    );
endmodule

module latch_chain_top_4 (
    input  wire       clk_reference,
    input  wire       phase_a,
    input  wire       phase_b,
    input  wire       reset,
    input  wire [7:0] data_in,
    output wire [7:0] result
);
    latch_chain_top #(.BLOCKS(4)) u_top (
        .clk_reference(clk_reference), .phase_a(phase_a), .phase_b(phase_b),
        .reset(reset), .data_in(data_in), .result(result)
    );
endmodule
