// sch_path: /mnt/hgfs/LatchSTA_Code/code/examples/counter/counter_retiming/counter.sch
module counter
(
  output wire [3:0] count,
  input wire clk,
  input wire rst_n,
  input wire en
);
wire [3:1] _02_ ;
wire [2:1] _00_ ;
wire [0:0] _01_ ;
wire _03_ ;
wire _04_ ;
wire _05_ ;
wire _06_ ;

yosys_not  U20 ( .A(  count[0]  ), .Y(  _01_[0]  ) );
yosys_mux  U12 ( .A(  count[0]  ), .B(  _01_[0]  ), .S(  en  ), .Y(  _04_  ) );
yosys_dff_pn0  U7 ( .D(  _04_  ), .C(  clk  ), .R(  rst_n  ), .Q(  count[0]  ) );
yosys_xor  U17 ( .A(  count[1]  ), .B(  count[0]  ), .Y(  _02_[1]  ) );
yosys_mux  U11 ( .A(  count[1]  ), .B(  _02_[1]  ), .S(  en  ), .Y(  _03_  ) );
yosys_dff_pn0  U8 ( .D(  _03_  ), .C(  clk  ), .R(  rst_n  ), .Q(  count[1]  ) );
yosys_xor  U18 ( .A(  count[2]  ), .B(  _00_[1]  ), .Y(  _02_[2]  ) );
yosys_and  U16 ( .A(  count[1]  ), .B(  count[0]  ), .Y(  _00_[1]  ) );
yosys_mux  U13 ( .A(  count[2]  ), .B(  _02_[2]  ), .S(  en  ), .Y(  _05_  ) );
yosys_dff_pn0  U9 ( .D(  _05_  ), .C(  clk  ), .R(  rst_n  ), .Q(  count[2]  ) );
yosys_xor  U19 ( .A(  count[3]  ), .B(  _00_[2]  ), .Y(  _02_[3]  ) );
yosys_and  U15 ( .A(  count[2]  ), .B(  _00_[1]  ), .Y(  _00_[2]  ) );
yosys_mux  U14 ( .A(  count[3]  ), .B(  _02_[3]  ), .S(  en  ), .Y(  _06_  ) );
yosys_dff_pn0  U10 ( .D(  _06_  ), .C(  clk  ), .R(  rst_n  ), .Q(  count[3]  ) );
endmodule
