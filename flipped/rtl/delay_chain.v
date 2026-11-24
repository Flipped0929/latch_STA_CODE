`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Polarity-preserving LUT delay chain.
//
// N stages, W bits wide, one LUT1 buffer per bit per stage.  Every intermediate
// net carries keep="true" and every buffer instance carries dont_touch="true",
// otherwise synthesis folds the whole chain into a single LUT and the time
// borrowing experiment would measure nothing.
//
// LUT1 INIT = 2'b10 is a buffer (O = I0).  If synthesis ever removes these,
// switch INIT to 2'b01 (inverter) and keep N even; polarity is then preserved
// by the even number of inversions.
// -----------------------------------------------------------------------------
module delay_chain #(parameter N = 4, parameter W = 8) (
    input  wire [W-1:0] d,
    output wire [W-1:0] q
);
    (* keep = "true" *) wire [(N+1)*W-1:0] ch;

    assign ch[0 +: W] = d;

    genvar i, b;
    generate
        for (i = 0; i < N; i = i + 1) begin : g_stage
            for (b = 0; b < W; b = b + 1) begin : g_bit
                (* dont_touch = "true" *)
                LUT1 #(.INIT(2'b10)) u_buf (
                    .O  (ch[(i+1)*W + b]),
                    .I0 (ch[i*W + b])
                );
            end
        end
    endgenerate

    assign q = ch[N*W +: W];
endmodule
