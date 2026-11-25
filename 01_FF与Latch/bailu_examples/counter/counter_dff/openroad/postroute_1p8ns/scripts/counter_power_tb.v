`timescale 1ns/1ps
// Zero-delay functional gate simulation; Liberty/SPEF supply the power model.
module counter_power_tb;
    reg clk = 0;
    reg en = 1;
    reg rst_n = 1;
    supply1 VDD;
    supply0 VSS;
    wire [3:0] count;
    reg [3:0] expected = 0;
    integer checks = 0;
    counter dut(.clk(clk), .en(en), .rst_n(rst_n), .count(count),
                .VDD(VDD), .VSS(VSS));

    task cycle;
        begin
            #0.900; clk = 1;
            expected = expected + 1'b1;
            #0.001;
            if (count !== expected)
                $fatal(1, "Counting mismatch: got %h, expected %h", count, expected);
            checks = checks + 1;
            #0.899; clk = 0;
        end
    endtask

    initial begin
        #0.100; rst_n = 0;
        #0.800; rst_n = 1;
        // Finish reset and one complete 16-state warm-up before recording.
        repeat (16) cycle;
        $dumpfile("inputs/counter_counting.vcd");
        // Include cell-port scopes so read_vcd annotates all instance pins.
        $dumpvars(0, dut);
        repeat (256) cycle;
        $dumpflush;
        $display("PASS: %0d counting checks; VCD records 256 cycles at 1.8 ns (460.8 ns).", checks);
        $finish;
    end
endmodule
