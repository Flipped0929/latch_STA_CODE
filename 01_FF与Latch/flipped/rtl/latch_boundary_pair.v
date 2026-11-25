`timescale 1ns / 1ps
// All-latch IO boundary: master transparent when clk_reference is low,
// slave transparent when clk_reference is high.
//
// Functionally this behaves like a positive-edge FF (master closes on the
// rising edge, slave opens), but it is built from two level-sensitive latches
// so that the design contains zero FD* cells.
//
// Synthesis uses the LDCE primitive branch (define USE_LDCE_PRIMITIVES) so that
// Vivado cannot re-map the pair into an edge-triggered FDCE.
// RTL simulation uses the behavioural branch (no unisims dependency).
module latch_boundary_pair #(parameter W = 8) (
    input  wire         clk_reference,
    input  wire         reset,
    input  wire [W-1:0] d,
    output wire [W-1:0] q
);

`ifdef USE_LDCE_PRIMITIVES
    wire [W-1:0] master_q;
    genvar i;
    generate
        for (i = 0; i < W; i = i + 1) begin : g_bit
            LDCE #(.INIT(1'b0)) u_master (
                .Q  (master_q[i]),
                .D  (d[i]),
                .G  (~clk_reference),   // transparent when clk low
                .GE (1'b1),
                .CLR(reset)
            );
            LDCE #(.INIT(1'b0)) u_slave (
                .Q  (q[i]),
                .D  (master_q[i]),
                .G  (clk_reference),    // transparent when clk high
                .GE (1'b1),
                .CLR(reset)
            );
        end
    endgenerate
`else
    reg [W-1:0] master_q, slave_q;

    always @(clk_reference or d or reset) begin
        if (reset)
            master_q = {W{1'b0}};
        else if (!clk_reference)
            master_q = d;
    end

    always @(clk_reference or master_q or reset) begin
        if (reset)
            slave_q = {W{1'b0}};
        else if (clk_reference)
            slave_q = master_q;
    end

    assign q = slave_q;
`endif
endmodule
