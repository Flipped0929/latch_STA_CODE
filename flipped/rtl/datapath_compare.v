`timescale 1ns / 1ps
// Reconstructed from the documented contract:
//   result = rotl8((data_in + 0x39) mod 256, 3) XOR 0xA7
// The original ../single_latch/rtl/datapath_compare.v is NOT in the snapshot.
module ff_datapath (
    input  wire       clk,
    input  wire       reset,
    input  wire       sample_enable,
    input  wire [7:0] data_in,
    output wire [7:0] result
);
    reg [7:0] stage_one;
    reg [7:0] stage_two;

    wire [7:0] sum     = data_in + 8'h39;
    wire [7:0] rotated = {stage_one[4:0], stage_one[7:5]} ^ 8'hA7;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            stage_one <= 8'h00;
            stage_two <= 8'h00;
        end else if (sample_enable) begin
            stage_one <= sum;
            stage_two <= rotated;
        end
    end

    assign result = stage_two;
endmodule

module latch_datapath (
    input  wire       reset,
    input  wire       phase_a,
    input  wire       phase_b,
    input  wire [7:0] data_in,
    output wire [7:0] result
);
    reg [7:0] stage_one;
    reg [7:0] stage_two;

    wire [7:0] sum     = data_in + 8'h39;
    wire [7:0] rotated = {stage_one[4:0], stage_one[7:5]} ^ 8'hA7;

    always @(phase_a or data_in or reset) begin
        if (reset)
            stage_one = 8'h00;
        else if (phase_a)
            stage_one = sum;
    end

    always @(phase_b or stage_one or reset) begin
        if (reset)
            stage_two = 8'h00;
        else if (phase_b)
            stage_two = rotated;
    end

    assign result = stage_two;
endmodule
