// sch_path: /mnt/hgfs/LatchSTA_Code/code/examples/counter/counter_latch_mux_1/counter_sky130.sch
module counter_sky130
(
  output wire [3:0] count,
  input wire clk_1,
  input wire clk_2,
  input wire rst_n,
  input wire en,
  input wire VPWR,
  input wire VGND
);
wire toggle2 ;
wire toggle3 ;
wire [1:1] _02_ ;
wire carry3 ;
wire next_bit2 ;
wire next_bit3 ;
wire [0:0] _01_ ;
wire [3:0] phase_1 ;
wire phase_1_toggle2 ;
wire phase_1_toggle3 ;
wire _03_ ;
wire _04_ ;

sky130_fd_sc_hd__dlrtp_1
xstate_phi1_bit0 ( 
 .D( _04_ ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1[0] )
);


sky130_fd_sc_hd__mux2_1
x_12_ ( 
 .A0( count[0] ),
 .A1( _01_[0] ),
 .S( en ),
 .X( _04_ )
);


sky130_fd_sc_hd__inv_1
x_20_ ( 
 .A( count[0] ),
 .Y( _01_[0] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi2_bit0 ( 
 .D( phase_1[0] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( count[0] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi1_bit1 ( 
 .D( _03_ ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1[1] )
);


sky130_fd_sc_hd__mux2_1
x_11_ ( 
 .A0( count[1] ),
 .A1( _02_[1] ),
 .S( en ),
 .X( _03_ )
);


sky130_fd_sc_hd__xor2_1
x_17_ ( 
 .A( count[1] ),
 .B( count[0] ),
 .X( _02_[1] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi2_bit1 ( 
 .D( phase_1[1] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( count[1] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi1_bit2 ( 
 .D( count[2] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1[2] )
);


sky130_fd_sc_hd__xor2_1
x_18_ ( 
 .A( phase_1[2] ),
 .B( phase_1_toggle2 ),
 .X( next_bit2 )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi2_bit2 ( 
 .D( next_bit2 ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( count[2] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi1_toggle2 ( 
 .D( toggle2 ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1_toggle2 )
);


sky130_fd_sc_hd__and3_1
x_16_ ( 
 .A( count[1] ),
 .B( count[0] ),
 .C( en ),
 .X( toggle2 )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi1_bit3 ( 
 .D( count[3] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1[3] )
);


sky130_fd_sc_hd__xor2_1
x_19_ ( 
 .A( phase_1[3] ),
 .B( phase_1_toggle3 ),
 .X( next_bit3 )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi2_bit3 ( 
 .D( next_bit3 ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( count[3] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi1_toggle3 ( 
 .D( toggle3 ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( phase_1_toggle3 )
);


sky130_fd_sc_hd__and3_1
x_15_ ( 
 .A( count[2] ),
 .B( count[1] ),
 .C( count[0] ),
 .X( carry3 )
);


sky130_fd_sc_hd__and2_1
xbit3_enable ( 
 .A( en ),
 .B( carry3 ),
 .X( toggle3 )
);

endmodule
