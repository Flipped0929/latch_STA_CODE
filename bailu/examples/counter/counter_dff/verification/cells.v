// Behavioral definitions of the generic Yosys cells drawn in counter.sch.
module yosys_and(input A, B, output Y);
  assign Y = A & B;
endmodule
module yosys_xor(input A, B, output Y);
  assign Y = A ^ B;
endmodule
module yosys_not(input A, output Y);
  assign Y = ~A;
endmodule
module yosys_mux(input A, B, S, output Y);
  assign Y = S ? B : A;
endmodule
module yosys_dff_pn0(input D, C, R, output reg Q);
  always @(posedge C or negedge R)
    if (!R) Q <= 1'b0;
    else Q <= D;
endmodule
