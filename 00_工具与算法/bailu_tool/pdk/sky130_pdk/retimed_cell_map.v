module \$_DFF_P_ (input C, D, output Q);
    sky130_fd_sc_hd__dlxtp_1 _TECHMAP_REPLACE_ (.GATE(C), .D(D), .Q(Q));
endmodule

module \$_DFF_PN0_ (input C, D, R, output Q);
    sky130_fd_sc_hd__dlrtp_1 _TECHMAP_REPLACE_ (.GATE(C), .D(D), .RESET_B(R), .Q(Q));
endmodule

module \$_DFF_PP0_ (input C, D, R, output Q);
    wire reset_n;
    \$_NOT_ invert_reset (.A(R), .Y(reset_n));
    sky130_fd_sc_hd__dlrtp_1 _TECHMAP_REPLACE_ (.GATE(C), .D(D), .RESET_B(reset_n), .Q(Q));
endmodule

// Invert D and Q so the clear-to-zero latch implements asynchronous set.
module \$_DFF_PN1_ (input C, D, R, output Q);
    wire d_n, q_n;
    \$_NOT_ invert_data (.A(D), .Y(d_n));
    \$_NOT_ invert_state (.A(q_n), .Y(Q));
    sky130_fd_sc_hd__dlrtp_1 _TECHMAP_REPLACE_ (.GATE(C), .D(d_n), .RESET_B(R), .Q(q_n));
endmodule

module \$_DFF_PP1_ (input C, D, R, output Q);
    wire d_n, q_n, reset_n;
    \$_NOT_ invert_reset (.A(R), .Y(reset_n));
    \$_NOT_ invert_data (.A(D), .Y(d_n));
    \$_NOT_ invert_state (.A(q_n), .Y(Q));
    sky130_fd_sc_hd__dlrtp_1 _TECHMAP_REPLACE_ (.GATE(C), .D(d_n), .RESET_B(reset_n), .Q(q_n));
endmodule

// Keep the phase-2 clock gate outside ABC's combinational mapping.
module \$_AND_ (input A, B, output Y);
    sky130_fd_sc_hd__and2_1 _TECHMAP_REPLACE_ (.A(A), .B(B), .X(Y));
endmodule
