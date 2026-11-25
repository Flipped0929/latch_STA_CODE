// sch_path: /mnt/hgfs/LatchSTA_Code/code/examples/counter/counter_retiming_latch_mux_2/counter_sky130.sch
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
wire [3:0] increment ;
wire [3:0] recirc_q_phi1 ;
wire [3:0] recirc_q_phi2 ;
wire [3:0] main_q_phi1 ;
wire [2:1] carry ;
wire [3:0] main_d_phi1 ;
wire [3:0] main_d_phi2 ;
wire en_1 ;

sky130_fd_sc_hd__dlxtp_1
xen_phi1 ( 
 .D( en ),
 .GATE( clk_1 ),
 .Q( en_1 )
);


sky130_fd_sc_hd__inv_1
x_20_ ( 
 .A( count[0] ),
 .Y( increment[0] )
);


sky130_fd_sc_hd__mux2_1
xmux_phi1_bit0 ( 
 .A0( recirc_q_phi2[0] ),
 .A1( increment[0] ),
 .S( en ),
 .X( main_d_phi1[0] )
);


sky130_fd_sc_hd__dlrtp_1
xmain_phi1_bit0 ( 
 .D( main_d_phi1[0] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( main_q_phi1[0] )
);


sky130_fd_sc_hd__mux2_1
xmux_phi2_bit0 ( 
 .A0( recirc_q_phi1[0] ),
 .A1( main_q_phi1[0] ),
 .S( en_1 ),
 .X( main_d_phi2[0] )
);


sky130_fd_sc_hd__dlrtp_1
xmain_phi2_bit0 ( 
 .D( main_d_phi2[0] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( count[0] )
);


sky130_fd_sc_hd__dlrtp_1
xrecirc_phi1_bit0 ( 
 .D( count[0] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( recirc_q_phi1[0] )
);


sky130_fd_sc_hd__dlrtp_1
xrecirc_phi2_bit0 ( 
 .D( main_q_phi1[0] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( recirc_q_phi2[0] )
);


sky130_fd_sc_hd__xor2_1
x_17_ ( 
 .A( count[1] ),
 .B( count[0] ),
 .X( increment[1] )
);


sky130_fd_sc_hd__mux2_1
xmux_phi1_bit1 ( 
 .A0( recirc_q_phi2[1] ),
 .A1( increment[1] ),
 .S( en ),
 .X( main_d_phi1[1] )
);


sky130_fd_sc_hd__dlrtp_1
xmain_phi1_bit1 ( 
 .D( main_d_phi1[1] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( main_q_phi1[1] )
);


sky130_fd_sc_hd__mux2_1
xmux_phi2_bit1 ( 
 .A0( recirc_q_phi1[1] ),
 .A1( main_q_phi1[1] ),
 .S( en_1 ),
 .X( main_d_phi2[1] )
);


sky130_fd_sc_hd__dlrtp_1
xmain_phi2_bit1 ( 
 .D( main_d_phi2[1] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( count[1] )
);


sky130_fd_sc_hd__dlrtp_1
xrecirc_phi1_bit1 ( 
 .D( count[1] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( recirc_q_phi1[1] )
);


sky130_fd_sc_hd__dlrtp_1
xrecirc_phi2_bit1 ( 
 .D( main_q_phi1[1] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( recirc_q_phi2[1] )
);


sky130_fd_sc_hd__xor2_1
x_18_ ( 
 .A( count[2] ),
 .B( carry[1] ),
 .X( increment[2] )
);


sky130_fd_sc_hd__mux2_1
xmux_phi1_bit2 ( 
 .A0( recirc_q_phi2[2] ),
 .A1( increment[2] ),
 .S( en ),
 .X( main_d_phi1[2] )
);


sky130_fd_sc_hd__dlrtp_1
xmain_phi1_bit2 ( 
 .D( main_d_phi1[2] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( main_q_phi1[2] )
);


sky130_fd_sc_hd__mux2_1
xmux_phi2_bit2 ( 
 .A0( recirc_q_phi1[2] ),
 .A1( main_q_phi1[2] ),
 .S( en_1 ),
 .X( main_d_phi2[2] )
);


sky130_fd_sc_hd__dlrtp_1
xmain_phi2_bit2 ( 
 .D( main_d_phi2[2] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( count[2] )
);


sky130_fd_sc_hd__dlrtp_1
xrecirc_phi1_bit2 ( 
 .D( count[2] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( recirc_q_phi1[2] )
);


sky130_fd_sc_hd__dlrtp_1
xrecirc_phi2_bit2 ( 
 .D( main_q_phi1[2] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( recirc_q_phi2[2] )
);


sky130_fd_sc_hd__xor2_1
x_19_ ( 
 .A( count[3] ),
 .B( carry[2] ),
 .X( increment[3] )
);


sky130_fd_sc_hd__mux2_1
xmux_phi1_bit3 ( 
 .A0( recirc_q_phi2[3] ),
 .A1( increment[3] ),
 .S( en ),
 .X( main_d_phi1[3] )
);


sky130_fd_sc_hd__dlrtp_1
xmain_phi1_bit3 ( 
 .D( main_d_phi1[3] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( main_q_phi1[3] )
);


sky130_fd_sc_hd__mux2_1
xmux_phi2_bit3 ( 
 .A0( recirc_q_phi1[3] ),
 .A1( main_q_phi1[3] ),
 .S( en_1 ),
 .X( main_d_phi2[3] )
);


sky130_fd_sc_hd__dlrtp_1
xmain_phi2_bit3 ( 
 .D( main_d_phi2[3] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( count[3] )
);


sky130_fd_sc_hd__dlrtp_1
xrecirc_phi1_bit3 ( 
 .D( count[3] ),
 .GATE( clk_1 ),
 .RESET_B( rst_n ),
 .Q( recirc_q_phi1[3] )
);


sky130_fd_sc_hd__dlrtp_1
xrecirc_phi2_bit3 ( 
 .D( main_q_phi1[3] ),
 .GATE( clk_2 ),
 .RESET_B( rst_n ),
 .Q( recirc_q_phi2[3] )
);


sky130_fd_sc_hd__and2_1
x_16_ ( 
 .A( count[1] ),
 .B( count[0] ),
 .X( carry[1] )
);


sky130_fd_sc_hd__and2_1
x_15_ ( 
 .A( count[2] ),
 .B( carry[1] ),
 .X( carry[2] )
);

endmodule
