// sch_path: /mnt/hgfs/LatchSTA_Code/code/examples/counter/counter_latch_mux_1/counter_postroute.sch
module counter_postroute
(
  output wire [3:0] count,
  inout wire VDD,
  inout wire VSS,
  input wire clk_1,
  input wire clk_2,
  input wire rst_n,
  input wire en
);
wire CK1_A ;
wire CK1_B ;
wire CK2_A ;
wire CK2_B ;
wire toggle2 ;
wire toggle3 ;
wire CK1_ROOT ;
wire [1:1] _02_ ;
wire carry3 ;
wire next_bit2 ;
wire next_bit3 ;
wire RST_BUF ;
wire CK2_ROOT ;
wire [0:0] _01_ ;
wire [3:0] phase_1 ;
wire phase_1_toggle2 ;
wire phase_1_toggle3 ;
wire _03_ ;
wire _04_ ;

sky130_fd_sc_hd__dlrtp_1
xstate_phi1_bit0 ( 
 .D( _04_ ),
 .GATE( CK1_A ),
 .RESET_B( RST_BUF ),
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


sky130_fd_sc_hd__dlrtp_4
xstate_phi2_bit0 ( 
 .D( phase_1[0] ),
 .GATE( CK2_A ),
 .RESET_B( RST_BUF ),
 .Q( count[0] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi1_bit1 ( 
 .D( _03_ ),
 .GATE( CK1_A ),
 .RESET_B( RST_BUF ),
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


sky130_fd_sc_hd__dlrtp_4
xstate_phi2_bit1 ( 
 .D( phase_1[1] ),
 .GATE( CK2_A ),
 .RESET_B( RST_BUF ),
 .Q( count[1] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi1_bit2 ( 
 .D( count[2] ),
 .GATE( CK1_A ),
 .RESET_B( RST_BUF ),
 .Q( phase_1[2] )
);


sky130_fd_sc_hd__xor2_1
x_18_ ( 
 .A( phase_1[2] ),
 .B( phase_1_toggle2 ),
 .X( next_bit2 )
);


sky130_fd_sc_hd__dlrtp_2
xstate_phi2_bit2 ( 
 .D( next_bit2 ),
 .GATE( CK2_B ),
 .RESET_B( RST_BUF ),
 .Q( count[2] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi1_toggle2 ( 
 .D( toggle2 ),
 .GATE( CK1_B ),
 .RESET_B( RST_BUF ),
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
 .GATE( CK1_B ),
 .RESET_B( RST_BUF ),
 .Q( phase_1[3] )
);


sky130_fd_sc_hd__xor2_1
x_19_ ( 
 .A( phase_1[3] ),
 .B( phase_1_toggle3 ),
 .X( next_bit3 )
);


sky130_fd_sc_hd__dlrtp_2
xstate_phi2_bit3 ( 
 .D( next_bit3 ),
 .GATE( CK2_B ),
 .RESET_B( RST_BUF ),
 .Q( count[3] )
);


sky130_fd_sc_hd__dlrtp_1
xstate_phi1_toggle3 ( 
 .D( toggle3 ),
 .GATE( CK1_B ),
 .RESET_B( RST_BUF ),
 .Q( phase_1_toggle3 )
);


sky130_fd_sc_hd__and3_1
x_15_ ( 
 .A( count[2] ),
 .B( count[1] ),
 .C( count[0] ),
 .X( carry3 )
);


sky130_fd_sc_hd__and2_4
xbit3_enable ( 
 .A( en ),
 .B( carry3 ),
 .X( toggle3 )
);


sky130_fd_sc_hd__clkbuf_4
xclkbuf_0_clk_1 ( 
 .A( clk_1 ),
 .X( CK1_ROOT )
);


sky130_fd_sc_hd__clkbuf_4
xclkbuf_1_0__f_clk_1 ( 
 .A( CK1_ROOT ),
 .X( CK1_A )
);


sky130_fd_sc_hd__clkbuf_4
xclkbuf_1_1__f_clk_1 ( 
 .A( CK1_ROOT ),
 .X( CK1_B )
);


sky130_fd_sc_hd__clkbuf_4
xclkbuf_0_clk_2 ( 
 .A( clk_2 ),
 .X( CK2_ROOT )
);


sky130_fd_sc_hd__clkbuf_4
xclkbuf_1_0__f_clk_2 ( 
 .A( CK2_ROOT ),
 .X( CK2_A )
);


sky130_fd_sc_hd__clkbuf_4
xclkbuf_1_1__f_clk_2 ( 
 .A( CK2_ROOT ),
 .X( CK2_B )
);


sky130_fd_sc_hd__buf_1
xreset_release_buf1 ( 
 .A( rst_n ),
 .X( RST_BUF )
);

endmodule
