`timescale 1ns/1ps
module counter_tb;
  reg clk = 0, rst_n = 1, en = 0;
  wire [3:0] count;
  reg [3:0] expected = 0;
  integer i, checks = 0;
  counter dut(.clk(clk), .rst_n(rst_n), .en(en), .count(count));

  task check;
    begin
      if (count !== expected)
        $fatal(1, "time %0t: got %h, expected %h", $time, count, expected);
      checks = checks + 1;
    end
  endtask

  task cycle;
    input enable;
    begin
      en = enable;
      #3;
      check;
      clk = 1;
      if (!rst_n) expected = 0;
      else if (en) expected = expected + 1'b1;
      #1;
      check;
      #2;
      clk = 0;
      #1;
      check;
    end
  endtask

  initial begin
    // Assert reset while the clock is stopped, then release without a clock edge.
    #2; rst_n = 0; #1; check;
    rst_n = 1; #1; check;
    // Visit every count value, test hold at every value, and overflow repeatedly.
    for (i = 0; i < 48; i = i + 1) begin
      cycle(1);
      cycle(0);
    end
    // Nonzero state -> asynchronous clear with clk low and en high.
    cycle(1); cycle(1); cycle(1);
    en = 1; #2; rst_n = 0; expected = 0; #1; check;
    cycle(1);
    rst_n = 1; #1; check;
    cycle(1);
    // Asynchronous clear while clk is high, with enable low.
    en = 0; #1; clk = 1; #1; check;
    rst_n = 0; expected = 0; #1; check;
    rst_n = 1; #1; check;
    clk = 0;
    cycle(0); cycle(1);
    $display("PASS: %0d checks covering count, hold, overflow and asynchronous reset.", checks);
    $finish;
  end
endmodule
