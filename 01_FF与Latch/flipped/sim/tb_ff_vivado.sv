`timescale 1ns / 1ps
// Single-DUT testbench for post-route functional simulation of the FF variant.
module tb_ff_vivado;
    reg clk_reference = 1'b0;
    reg reset = 1'b1;
    reg [7:0] data_in = 8'd0;
    wire [7:0] result;
    reg [7:0] history0 = 8'd0, history1 = 8'd0, history2 = 8'd0;
    integer launches = 0, ff_checks = 0, checks = 0, errors = 0, value;
    // post-route SDF netlists need the clock-tree insertion delay before sampling
    localparam real CHK  = 96.0;
    localparam real RSTC = 32.0;

    reg test_done = 1'b0;

    ff_timing_top dut (
        .clk_reference(clk_reference), .reset(reset),
        .data_in(data_in), .result(result)
    );

    function [7:0] reference;
        input [7:0] sample;
        integer sum, rotated;
        begin
            sum = (sample + 57) % 256;
            rotated = ((sum * 8) + (sum / 32)) % 256;
            reference = rotated ^ 167;
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

    initial begin
        while (!test_done) begin
            #320;
            if (!test_done) clk_reference = !clk_reference;
        end
    end

    always @(posedge clk_reference) begin
        if (reset) begin
            launches = 0;
            history0 = 8'd0; history1 = 8'd0; history2 = 8'd0;
        end else begin
            #(CHK);
            if (launches >= 3 && ff_checks < 256) begin
                expect_true(result === reference(history2), "FF transaction");
                ff_checks = ff_checks + 1;
            end
            history2 = history1;
            history1 = history0;
            history0 = data_in;
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
        wait (ff_checks == 256);
        #2;
        expect_true(ff_checks == 256, "FF covers all 256 inputs");
        @(posedge clk_reference);
        reset = 1'b1;
        data_in = 8'h96;
        #(RSTC);
        expect_true(result === 8'h00, "FF asynchronous reset");
        @(negedge clk_reference); reset = 1'b0;
        repeat (4) @(posedge clk_reference);
        #(CHK);
        expect_true(result === reference(8'h96), "FF pipeline recovers");
        if (errors != 0) $fatal(1, "FF test failed: %0d errors", errors);
        $display("PASS: FF DUT; checks=%0d; errors=%0d", checks, errors);
        test_done = 1'b1;
    end

    initial begin
        #1000000;
        if (!test_done) $fatal(1, "FF test timeout");
    end
endmodule
