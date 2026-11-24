`timescale 1ns/1fs

// Functional activity only: cell models have no SDF/physical delays.
module tb_power;
  `include "timing.vh"
  reg clk_1 = 0, clk_2 = 0, rst_n = 0, en = 0;
  wire [3:0] count, reference_count;
  counter dut (.clk_1(clk_1), .clk_2(clk_2), .rst_n(rst_n), .en(en), .count(count));
  counter_reference reference_dut (.clk_1(clk_1), .clk_2(clk_2),
                                 .rst_n(rst_n), .en(en), .count(reference_count));
  reg [3:0] expected = 0;
  integer cycle, scenario, fd;
  string vcd_path, window_path;
  realtime begin_ns, end_ns;

  task automatic run_cycle(input bit enable_value);
    en = enable_value;
    #(PHI1_RISE); clk_1 = 1;
    #(PHI1_FALL-PHI1_RISE); clk_1 = 0;
    #(PHI2_RISE-PHI1_FALL); clk_2 = 1;
    #(PHI2_FALL-PHI2_RISE); clk_2 = 0;
    #(PERIOD-PHI2_FALL);
    if (!rst_n) expected = 0;
    else if (enable_value) expected = expected + 1'b1;
    if (count !== expected || reference_count !== expected)
      $fatal(1, "Mismatch at %0t: routed=%h source=%h expected=%h",
             $realtime, count, reference_count, expected);
  endtask

  initial begin
    if (!$value$plusargs("SCENARIO=%d", scenario)) $fatal(1, "SCENARIO required");
    if (!$value$plusargs("VCD=%s", vcd_path)) $fatal(1, "VCD required");
    if (!$value$plusargs("WINDOW=%s", window_path)) $fatal(1, "WINDOW required");
    repeat (2) run_cycle(0);
    rst_n = 1;
    repeat (16) run_cycle(1); // Complete a full count period, returning to zero.
    // Active/mixed enter measurement with the gate already enabled and with
    // a periodic steady-state pipeline. Hold settles the disabled pipeline.
    if (scenario == 0) repeat (2) run_cycle(0);
    en = scenario != 0;
    #0.000001;
    begin_ns = $realtime;
    $dumpfile(vcd_path);
    $dumpvars(2, dut); // Include every standard cell port for pin annotation.
    for (cycle=0; cycle<MEASURED_CYCLES; cycle=cycle+1) begin
      case (scenario)
        0: run_cycle(0);
        1: run_cycle(1);
        2: run_cycle((cycle % 32) < 16);
        default: $fatal(1, "Unknown scenario");
      endcase
    end
    end_ns = $realtime;
    fd = $fopen(window_path, "w");
    $fdisplay(fd, "{\"begin_ns\": %.6f, \"end_ns\": %.6f, \"cycles\": %0d, \"period_ns\": %.9f}",
              begin_ns, end_ns, MEASURED_CYCLES, PERIOD);
    $fclose(fd);
    $display("PASS: scenario=%0d, %0d cycles, source/routed/expected counts match", scenario, MEASURED_CYCLES);
    $finish;
  end
endmodule
