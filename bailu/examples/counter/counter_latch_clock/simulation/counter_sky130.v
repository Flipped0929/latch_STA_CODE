// sch_path: /mnt/hgfs/LatchSTA_Code/code/examples/counter/counter_latch_clock/counter_sky130.sch
module counter_sky130
(
  output wire [3:0] count,
  input wire en,
  input wire clk_1,
  input wire clk_2,
  input wire rst_n
);
wire clk_2_gated ;
wire en_phi1 ;
wire phase_1_carry_bit2 ;
wire phase_1_carry_bit3 ;
wire [3:0] next_count ;
wire [3:0] phase_1 ;
wire carry_bit2 ;
wire carry_bit3 ;

sky130_fd_sc_hd__dlxtp_1
enable_phi1 ( 
 .D( en ),
 .GATE( clk_1 ),
 .Q( en_phi1 )
);


sky130_fd_sc_hd__and2_1
gate_phi2 ( 
 .A( clk_2 ),
 .B( en_phi1 ),
 .X( clk_2_gated )
);


sky130_fd_sc_hd__inv_1
increment_bit0 ( 
 .A( count[0] ),
 .Y( next_count[0] )
);


sky130_fd_sc_hd__dlrtp_1
state_phi1_bit0 ( 
 .D( next_count[0] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1[0] )
);


sky130_fd_sc_hd__dlrtp_1
state_phi2_bit0 ( 
 .D( phase_1[0] ),
 .GATE( clk_2_gated ),
 .RESET_B( rst_n ),
 .Q( count[0] )
);


sky130_fd_sc_hd__xor2_1
increment_bit1 ( 
 .A( count[1] ),
 .B( count[0] ),
 .X( next_count[1] )
);


sky130_fd_sc_hd__dlrtp_1
state_phi1_bit1 ( 
 .D( next_count[1] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1[1] )
);


sky130_fd_sc_hd__dlrtp_1
state_phi2_bit1 ( 
 .D( phase_1[1] ),
 .GATE( clk_2_gated ),
 .RESET_B( rst_n ),
 .Q( count[1] )
);


sky130_fd_sc_hd__dlrtp_1
state_phi1_bit2 ( 
 .D( count[2] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1[2] )
);


sky130_fd_sc_hd__and2_1
carry_into_bit2 ( 
 .A( count[1] ),
 .B( count[0] ),
 .X( carry_bit2 )
);


sky130_fd_sc_hd__dlrtp_1
state_phi1_carry_bit2 ( 
 .D( carry_bit2 ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1_carry_bit2 )
);


sky130_fd_sc_hd__xor2_1
increment_bit2 ( 
 .A( phase_1[2] ),
 .B( phase_1_carry_bit2 ),
 .X( next_count[2] )
);


sky130_fd_sc_hd__dlrtp_1
state_phi2_bit2 ( 
 .D( next_count[2] ),
 .GATE( clk_2_gated ),
 .RESET_B( rst_n ),
 .Q( count[2] )
);


sky130_fd_sc_hd__dlrtp_1
state_phi1_bit3 ( 
 .D( count[3] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1[3] )
);


sky130_fd_sc_hd__and2_1
carry_into_bit3 ( 
 .A( count[2] ),
 .B( carry_bit2 ),
 .X( carry_bit3 )
);


sky130_fd_sc_hd__dlrtp_1
state_phi1_carry_bit3 ( 
 .D( carry_bit3 ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1_carry_bit3 )
);


sky130_fd_sc_hd__xor2_1
increment_bit3 ( 
 .A( phase_1[3] ),
 .B( phase_1_carry_bit3 ),
 .X( next_count[3] )
);


sky130_fd_sc_hd__dlrtp_1
state_phi2_bit3 ( 
 .D( next_count[3] ),
 .GATE( clk_2_gated ),
 .RESET_B( rst_n ),
 .Q( count[3] )
);

endmodule
