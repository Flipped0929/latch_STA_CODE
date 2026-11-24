`timescale 1ns/1fs

// Functional switching stimulus. No SDF delays: not a glitch/timing simulation.
module tb_power;
  parameter realtime PERIOD_NS = 1.75;
  reg clk_1 = 0, clk_2 = 0, rst_n = 0, en = 0;
  wire [3:0] count, reference_count;
  supply1 VDD;
  supply0 VSS;
  counter dut (.clk_1(clk_1), .clk_2(clk_2), .rst_n(rst_n), .en(en),
               .count(count), .VDD(VDD), .VSS(VSS));
  counter_reference reference_dut (.clk_1(clk_1), .clk_2(clk_2),
               .rst_n(rst_n), .en(en), .count(reference_count));

  reg [3:0] expected = 0;
  integer cycle, scenario, fd;
  string vcd_path, window_path;
  realtime begin_ns, end_ns;

  task automatic run_cycle;
    input bit enable_value;
    begin
      en = enable_value;
      #(PERIOD_NS * 0.005); clk_1 = 1;
      #(PERIOD_NS * 0.49); clk_1 = 0;
      #(PERIOD_NS * 0.01); clk_2 = 1;
      #(PERIOD_NS * 0.49); clk_2 = 0;
      #(PERIOD_NS * 0.005);
      if (!rst_n) expected = 0;
      else if (enable_value) expected = expected + 1'b1;
      if (count !== expected || reference_count !== expected)
        $fatal(1, "Counter mismatch at %0t: route=%h source=%h expected=%h",
                  $realtime, count, reference_count, expected);
    end
  endtask

  initial begin
    if (!$value$plusargs("SCENARIO=%d", scenario)) $fatal(1, "SCENARIO required");
    if (!$value$plusargs("VCD=%s", vcd_path)) $fatal(1, "VCD required");
    if (!$value$plusargs("WINDOW=%s", window_path)) $fatal(1, "WINDOW required");
    repeat (2) run_cycle(0);
    rst_n = 1;
    // A complete counter period: all scenarios start measurement at count=0.
    repeat (16) run_cycle(1);
    repeat (2) run_cycle(0);
    en = (scenario != 0);
    // Allow all zero-delay combinational events to settle before dumping.
    #0.000001;
    begin_ns = $realtime;
    $dumpfile(vcd_path);
    // Include every cell's ports: this OpenROAD version matches VCD pins.
    $dumpvars(2, dut);
    for (cycle = 0; cycle < 4096; cycle = cycle + 1) begin
      case (scenario)
        0: run_cycle(0);
        1: run_cycle(1);
        2: run_cycle((cycle % 32) < 16);
        default: $fatal(1, "Unknown scenario");
      endcase
    end
    end_ns = $realtime;
    fd = $fopen(window_path, "w");
    $fdisplay(fd, "{\"begin_ns\": %.6f, \"end_ns\": %.6f, \"cycles\": 4096, \"period_ns\": %.6f}", begin_ns, end_ns, PERIOD_NS);
    $fclose(fd);
    $display("PASS: scenario=%0d, 4096 measured cycles; routed and source counters match expected sequence", scenario);
    $finish;
  end
endmodule
