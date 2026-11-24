`timescale 1ns / 1ps
// Testbench for the all-latch chain.
//
// Overridable defines (pass with xvlog -d NAME=value):
//   BLOCKS  number of latch_datapath blocks (1/2/4)          default 1
//   PERIOD  reference clock period in ns                     default 640
//   ARISE   phase_a rising edge, ns from cycle start          default 40
//   AWIDTH  phase_a high time, ns                            default 160
//   BRISE   phase_b rising edge, ns from cycle start          default 320
//   BWIDTH  phase_b high time, ns                            default 160
//   NETLIST 1 = instantiate the post-route netlist wrapper (BLOCKS=1 only)
//
// Latency contract: with NB blocks and latch-pair boundaries the result at
// clock edge n equals f^NB(v[n-NB-1]), where v[k] is the data_in value driven
// at negedge k.  That is what the history shift register below checks.
module tb_latch_chain;

`ifdef BLOCKS
    localparam integer NB = `BLOCKS;
`else
    localparam integer NB = 1;
`endif
`ifdef PERIOD
    localparam real TP = `PERIOD;
`else
    localparam real TP = 640.0;
`endif
`ifdef ARISE
    localparam real AR = `ARISE;
`else
    localparam real AR = 40.0;
`endif
`ifdef AWIDTH
    localparam real AW = `AWIDTH;
`else
    localparam real AW = 160.0;
`endif
`ifdef BRISE
    localparam real BR = `BRISE;
`else
    localparam real BR = 320.0;
`endif
`ifdef BWIDTH
    localparam real BW = `BWIDTH;
`else
    localparam real BW = 160.0;
`endif

    // Delay from a clock edge to the sampling instant of the checker.  A
    // post-route SDF netlist has ~5 ns of clock-tree insertion before the
    // boundary latches see the edge, so the checker must wait for that.
    localparam real CHK  = TP * 0.15;
    localparam real RSTC = TP * 0.05;

    reg clk_reference = 1'b0;
    reg phase_a = 1'b0;
    reg phase_b = 1'b0;
    reg reset = 1'b1;
    reg [7:0] data_in = 8'd0;
    wire [7:0] result;

    reg [7:0] hist [0:31];
    integer launches = 0, chain_checks = 0, checks = 0, errors = 0, value, i;
    reg test_done = 1'b0;

`ifdef NETLIST
    latch_chain_top_1 dut (
        .clk_reference(clk_reference), .phase_a(phase_a), .phase_b(phase_b),
        .reset(reset), .data_in(data_in), .result(result)
    );
`else
    latch_chain_top #(.BLOCKS(NB)) dut (
        .clk_reference(clk_reference), .phase_a(phase_a), .phase_b(phase_b),
        .reset(reset), .data_in(data_in), .result(result)
    );
`endif

    // SDF annotation (post-route timing simulation). Copy routed.sdf into the
    // simulation run directory and pass -d SDF_FILE=routed.sdf to xvlog.
    function [7:0] ref_once;
        input [7:0] x;
        integer s, r;
        begin
            s = (x + 57) % 256;                       // x + 0x39
            r = ((s * 8) + (s / 32)) % 256;           // rotl8(s, 3)
            ref_once = r ^ 167;                       // XOR 0xA7
        end
    endfunction

    function [7:0] ref_pow;
        input [7:0] x;
        integer k;
        reg [7:0] t;
        begin
            t = x;
            for (k = 0; k < NB; k = k + 1) t = ref_once(t);
            ref_pow = t;
        end
    endfunction

    task expect_true;
        input condition;
        input [511:0] description;
        begin
            checks = checks + 1;
            if (condition !== 1'b1) begin
                errors = errors + 1;
                $display("FAIL: %0s at %0t", description, $time);
            end
        end
    endtask

    // reference clock: high 0..TP/2, low TP/2..TP
    initial begin
        clk_reference = 1'b1;
        while (!test_done) begin
            #(TP / 2.0) clk_reference = 1'b0;
            #(TP / 2.0) clk_reference = 1'b1;
        end
    end

    // phase pulse generator, one cycle scheduled on every rising edge
    always @(posedge clk_reference) begin
        phase_a <= #(AR)          1'b1;
        phase_a <= #(AR + AW)     1'b0;
        phase_b <= #(BR)          1'b1;
        phase_b <= #(BR + BW)     1'b0;
    end

    always @(posedge clk_reference) begin
        if (reset) begin
            launches = 0;
            for (i = 0; i < 32; i = i + 1) hist[i] = 8'd0;
        end else begin
            #(CHK);
            if (launches >= NB && chain_checks < 256) begin
                expect_true(result === ref_pow(hist[NB-1]), "latch chain transaction");
                chain_checks = chain_checks + 1;
            end
            for (i = 31; i > 0; i = i - 1) hist[i] = hist[i-1];
            hist[0] = data_in;
            launches = launches + 1;
        end
    end

    initial begin
        @(negedge clk_reference);
        reset = 1'b0;
        data_in = 8'd0;
        for (value = 1; value < 256; value = value + 1) begin
            @(negedge clk_reference);
            data_in = value[7:0];
        end
        wait (chain_checks == 256);
        #2;
        expect_true(chain_checks == 256, "latch chain covers all 256 inputs");
        @(posedge clk_reference);
        reset = 1'b1;
        data_in = 8'h96;
        #(RSTC);
        expect_true(result === 8'h00, "asynchronous reset");
        @(negedge clk_reference);
        reset = 1'b0;
        repeat (NB + 3) @(posedge clk_reference);
        #(CHK);
        expect_true(result === ref_pow(8'h96), "pipeline recovers");
        if (errors != 0) $fatal(1, "latch chain test failed: %0d errors", errors);
        $display("PASS: all-latch chain BLOCKS=%0d; checks=%0d; errors=%0d", NB, checks, errors);
        test_done = 1'b1;
    end

    initial begin
        #2000000;
        if (!test_done) $fatal(1, "latch chain test timeout");
    end
endmodule
