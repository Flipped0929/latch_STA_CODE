// sch_path: /mnt/hgfs/LatchSTA_Code/code/examples/counter/counter_latch_mux_1/counter_yosys.sch
module counter_yosys
(
  output wire [3:0] count,
  input wire clk_1,
  input wire clk_2,
  input wire rst_n,
  input wire en
);
wire [3:1] _02_ ;
wire [2:1] _00_ ;
wire [0:0] _01_ ;
wire [3:0] phase_1 ;
wire _03_ ;
wire _04_ ;
wire _05_ ;
wire _06_ ;

\$_NOT_  _20_ ( .A(  count[0]  ), .Y(  _01_[0]  ) );
\$_MUX_  _12_ ( .A(  count[0]  ), .B(  _01_[0]  ), .S(  en  ), .Y(  _04_  ) );
\$_DFF_PN0_  state_phi1_bit0 ( .C(  clk_1  ), .D(  _04_  ), .Q(  phase_1[0]  ), .R(  rst_n  ) );
\$_DFF_PN0_  state_phi2_bit0 ( .C(  clk_2  ), .D(  phase_1[0]  ), .Q(  count[0]  ), .R(  rst_n  ) );
\$_XOR_  _17_ ( .A(  count[1]  ), .B(  count[0]  ), .Y(  _02_[1]  ) );
\$_MUX_  _11_ ( .A(  count[1]  ), .B(  _02_[1]  ), .S(  en  ), .Y(  _03_  ) );
\$_DFF_PN0_  state_phi1_bit1 ( .C(  clk_1  ), .D(  _03_  ), .Q(  phase_1[1]  ), .R(  rst_n  ) );
\$_DFF_PN0_  state_phi2_bit1 ( .C(  clk_2  ), .D(  phase_1[1]  ), .Q(  count[1]  ), .R(  rst_n  ) );
\$_XOR_  _18_ ( .A(  count[2]  ), .B(  _00_[1]  ), .Y(  _02_[2]  ) );
\$_AND_  _16_ ( .A(  count[1]  ), .B(  count[0]  ), .Y(  _00_[1]  ) );
\$_MUX_  _13_ ( .A(  count[2]  ), .B(  _02_[2]  ), .S(  en  ), .Y(  _05_  ) );
\$_DFF_PN0_  state_phi1_bit2 ( .C(  clk_1  ), .D(  _05_  ), .Q(  phase_1[2]  ), .R(  rst_n  ) );
\$_DFF_PN0_  state_phi2_bit2 ( .C(  clk_2  ), .D(  phase_1[2]  ), .Q(  count[2]  ), .R(  rst_n  ) );
\$_XOR_  _19_ ( .A(  count[3]  ), .B(  _00_[2]  ), .Y(  _02_[3]  ) );
\$_AND_  _15_ ( .A(  count[2]  ), .B(  _00_[1]  ), .Y(  _00_[2]  ) );
\$_MUX_  _14_ ( .A(  count[3]  ), .B(  _02_[3]  ), .S(  en  ), .Y(  _06_  ) );
\$_DFF_PN0_  state_phi1_bit3 ( .C(  clk_1  ), .D(  _06_  ), .Q(  phase_1[3]  ), .R(  rst_n  ) );
\$_DFF_PN0_  state_phi2_bit3 ( .C(  clk_2  ), .D(  phase_1[3]  ), .Q(  count[3]  ), .R(  rst_n  ) );
endmodule
