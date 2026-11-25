`timescale 1ns / 1ps
// All-latch chain: latch boundary pair -> BLOCKS x latch_datapath -> latch boundary pair.
// BLOCKS=1 is 2 latch stages (16 latches), BLOCKS=2 is 4 stages, BLOCKS=4 is 8 stages.
module latch_chain_top #(parameter BLOCKS = 1) (
    input  wire       clk_reference,
    input  wire       phase_a,
    input  wire       phase_b,
    input  wire       reset,
    input  wire [7:0] data_in,
    output wire [7:0] result
);

    wire [7:0] core_input;
    wire [7:0] chain [0:BLOCKS];

    assign chain[0] = core_input;

    genvar i;
    generate
        for (i = 0; i < BLOCKS; i = i + 1) begin : g_chain
            latch_datapath u_core (
                .reset   (reset),
                .phase_a (phase_a),
                .phase_b (phase_b),
                .data_in (chain[i]),
                .result  (chain[i+1])
            );
        end
    endgenerate

    latch_boundary_pair #(.W(8)) u_in (
        .clk_reference (clk_reference),
        .reset         (reset),
        .d             (data_in),
        .q             (core_input)
    );

    latch_boundary_pair #(.W(8)) u_out (
        .clk_reference (clk_reference),
        .reset         (reset),
        .d             (chain[BLOCKS]),
        .q             (result)
    );
endmodule
