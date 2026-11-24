module counter (clk_1,
    clk_2,
    en,
    rst_n,
    count);
 input clk_1;
 input clk_2;
 input en;
 input rst_n;
 output [3:0] count;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
 wire _06_;
 wire _07_;
 wire _08_;
 wire dup_en1_1;
 wire dup_q1_0;
 wire dup_q1_4;
 wire dup_q1_6;
 wire dup_q1_8;
 wire gated_clk_2_10;
 wire clknet_0_clk_1;
 wire clknet_1_0__leaf_clk_1;
 wire clknet_1_1__leaf_clk_1;
 wire clknet_phi21;

 sky130_fd_sc_hd__dlrtp_1 _12_ (.D(_04_),
    .Q(_05_),
    .RESET_B(rst_n),
    .GATE(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 _13_ (.D(_06_),
    .Q(_07_),
    .RESET_B(rst_n),
    .GATE(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 _14_ (.D(count[3]),
    .Q(_00_),
    .RESET_B(rst_n),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 _15_ (.D(_01_),
    .Q(_02_),
    .RESET_B(rst_n),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__clkinv_1 _16_ (.A(count[0]),
    .Y(_08_));
 sky130_fd_sc_hd__or2_0 _17_ (.A(_07_),
    .B(_05_),
    .X(dup_q1_6));
 sky130_fd_sc_hd__xor2_1 _18_ (.A(_02_),
    .B(_00_),
    .X(dup_q1_8));
 sky130_fd_sc_hd__and3_1 _19_ (.A(count[2]),
    .B(count[1]),
    .C(count[0]),
    .X(_01_));
 sky130_fd_sc_hd__a21boi_0 _20_ (.A1(count[1]),
    .A2(count[0]),
    .B1_N(count[2]),
    .Y(_06_));
 sky130_fd_sc_hd__and3b_1 _21_ (.A_N(count[2]),
    .B(count[1]),
    .C(count[0]),
    .X(_04_));
 sky130_fd_sc_hd__xor2_1 _22_ (.A(count[1]),
    .B(count[0]),
    .X(_03_));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_0_clk_1 (.A(clk_1),
    .X(clknet_0_clk_1));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_0__f_clk_1 (.A(clknet_0_clk_1),
    .X(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_1_1__f_clk_1 (.A(clknet_0_clk_1),
    .X(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__clkbuf_2 clkbuf_phi21 (.A(clknet_phi21),
    .X(gated_clk_2_10));
 sky130_fd_sc_hd__clkbuf_1 clkload0 (.A(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 \count_o_reg[0]  (.D(dup_q1_0),
    .Q(count[0]),
    .RESET_B(rst_n),
    .GATE(gated_clk_2_10));
 sky130_fd_sc_hd__dlrtp_1 \count_o_reg[1]  (.D(dup_q1_4),
    .Q(count[1]),
    .RESET_B(rst_n),
    .GATE(gated_clk_2_10));
 sky130_fd_sc_hd__dlrtp_1 \count_o_reg[2]  (.D(dup_q1_6),
    .Q(count[2]),
    .RESET_B(rst_n),
    .GATE(gated_clk_2_10));
 sky130_fd_sc_hd__dlrtp_1 \count_o_reg[3]  (.D(dup_q1_8),
    .Q(count[3]),
    .RESET_B(rst_n),
    .GATE(gated_clk_2_10));
 sky130_fd_sc_hd__dlxtp_1 dup_enable_2 (.D(en),
    .Q(dup_en1_1),
    .GATE(clknet_1_1__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 dup_q1_0_reg (.D(_08_),
    .Q(dup_q1_0),
    .RESET_B(rst_n),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__dlrtp_1 dup_q1_4_reg (.D(_03_),
    .Q(dup_q1_4),
    .RESET_B(rst_n),
    .GATE(clknet_1_0__leaf_clk_1));
 sky130_fd_sc_hd__and2_1 gate_phi2_11 (.A(clk_2),
    .B(dup_en1_1),
    .X(clknet_phi21));
endmodule
