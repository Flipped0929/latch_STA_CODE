`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Three register architectures for the same two-stage datapath:
//
//   data_in -> B_in -> [d1 chain] -> R1 -> [d2 chain] -> R2 -> B_out -> result
//
//   arb_ff1   single-edge FF      : B_in, R1, R2, B_out all on posedge clk_reference
//   arb_ff2   two-phase FF        : R1 on posedge phase_a, R2 on posedge phase_b
//   arb_latch two-phase latch     : R1 transparent while phase_a high,
//                                   R2 transparent while phase_b high
//
// All three keep an FF boundary pair (B_in / B_out) so that the only variable is
// the register architecture of the two internal stages.
// -----------------------------------------------------------------------------

// ---------------------------------------------------------------- single-edge FF
module arb_ff1 #(parameter D1 = 2, parameter D2 = 8) (
    input  wire       clk_reference,
    input  wire       phase_a,
    input  wire       phase_b,
    input  wire       reset,
    input  wire [7:0] data_in,
    output wire [7:0] result
);
    reg  [7:0] b_in, r1, r2, b_out;
    wire [7:0] c1, c2;

    delay_chain #(.N(D1), .W(8)) u_d1 (.d(b_in), .q(c1));
    delay_chain #(.N(D2), .W(8)) u_d2 (.d(r1),   .q(c2));

    always @(posedge clk_reference or posedge reset) begin
        if (reset) begin
            b_in <= 8'h00; r1 <= 8'h00; r2 <= 8'h00; b_out <= 8'h00;
        end else begin
            b_in  <= data_in;
            r1    <= c1;
            r2    <= c2;
            b_out <= r2;
        end
    end

    assign result = b_out;
endmodule

// ---------------------------------------------------------------- two-phase FF
module arb_ff2 #(parameter D1 = 2, parameter D2 = 8) (
    input  wire       clk_reference,
    input  wire       phase_a,
    input  wire       phase_b,
    input  wire       reset,
    input  wire [7:0] data_in,
    output wire [7:0] result
);
    reg  [7:0] b_in, r1, r2, b_out;
    wire [7:0] c1, c2;

    delay_chain #(.N(D1), .W(8)) u_d1 (.d(b_in), .q(c1));
    delay_chain #(.N(D2), .W(8)) u_d2 (.d(r1),   .q(c2));

    always @(posedge clk_reference or posedge reset) begin
        if (reset) b_in <= 8'h00; else b_in <= data_in;
    end
    always @(posedge phase_a or posedge reset) begin
        if (reset) r1 <= 8'h00; else r1 <= c1;
    end
    always @(posedge phase_b or posedge reset) begin
        if (reset) r2 <= 8'h00; else r2 <= c2;
    end
    always @(posedge clk_reference or posedge reset) begin
        if (reset) b_out <= 8'h00; else b_out <= r2;
    end

    assign result = b_out;
endmodule

// ------------------------------------------------------------- two-phase latch
module arb_latch #(parameter D1 = 2, parameter D2 = 8) (
    input  wire       clk_reference,
    input  wire       phase_a,
    input  wire       phase_b,
    input  wire       reset,
    input  wire [7:0] data_in,
    output wire [7:0] result
);
    reg  [7:0] b_in, r1, r2, b_out;
    wire [7:0] c1, c2;

    delay_chain #(.N(D1), .W(8)) u_d1 (.d(b_in), .q(c1));
    delay_chain #(.N(D2), .W(8)) u_d2 (.d(r1),   .q(c2));

    always @(posedge clk_reference or posedge reset) begin
        if (reset) b_in <= 8'h00; else b_in <= data_in;
    end
    // level-sensitive: R1 transparent while phase_a is high
    always @(phase_a or c1 or reset) begin
        if (reset)      r1 = 8'h00;
        else if (phase_a) r1 = c1;
    end
    // level-sensitive: R2 transparent while phase_b is high
    always @(phase_b or c2 or reset) begin
        if (reset)      r2 = 8'h00;
        else if (phase_b) r2 = c2;
    end
    always @(posedge clk_reference or posedge reset) begin
        if (reset) b_out <= 8'h00; else b_out <= r2;
    end

    assign result = b_out;
endmodule
