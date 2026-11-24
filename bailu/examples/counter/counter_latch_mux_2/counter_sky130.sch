v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {4-BIT TWO-PHASE RECIRCULATION COUNTER} 90 30 0 0 0.76 0.76 {layer=4}
T {SKY130 HD  |  counter_sky130.v  |  31 standard cells  |  no retiming} 90 105 0 0 0.4 0.4 {layer=4}
L 4 90 165 3370 165 {}
T {CONTROL / ENABLE SAMPLING} 90 185 0 0 0.32 0.32 {layer=4}
T {dlxtp_1: no reset} 1580 330 0 0 0.26 0.26 {layer=4}
T {All cells: VPB=VPWR, VNB=VGND} 2300 330 0 0 0.28 0.28 {layer=4}
T {Clock sequence: clk_1 then clk_2; active HIGH and non-overlapping.  rst_n=0 asynchronously clears all 16 data latches.} 90 390 0 0 0.34 0.34 {layer=4}
T {Matching net labels are electrically connected.  count_o[i] = count[i].  Cell instance names use an x prefix for SPICE.} 90 435 0 0 0.32 0.32 {layer=4}
L 4 90 505 3370 505 {}
T {CARRY} 160 530 0 0 0.35 0.35 {layer=4}
T {INCREMENT} 640 530 0 0 0.35 0.35 {layer=4}
T {MUX / en} 1090 530 0 0 0.35 0.35 {layer=4}
T {MAIN / clk_1} 1580 530 0 0 0.35 0.35 {layer=4}
T {MUX / en_1} 2310 530 0 0 0.35 0.35 {layer=4}
T {MAIN / clk_2} 2800 530 0 0 0.35 0.35 {layer=4}
T {OUTPUT} 3190 530 0 0 0.35 0.35 {layer=4}
T {BIT 0} 90 600 0 0 0.34 0.34 {layer=4}
T {RECIRCULATION / clk_1} 1580 905 0 0 0.26 0.26 {layer=4}
T {RECIRCULATION / clk_2} 2800 905 0 0 0.26 0.26 {layer=4}
L 21 90 950 3370 950 {}
T {BIT 1} 90 940 0 0 0.34 0.34 {layer=4}
T {RECIRCULATION / clk_1} 1580 1245 0 0 0.26 0.26 {layer=4}
T {RECIRCULATION / clk_2} 2800 1245 0 0 0.26 0.26 {layer=4}
L 21 90 1290 3370 1290 {}
T {BIT 2} 90 1280 0 0 0.34 0.34 {layer=4}
T {RECIRCULATION / clk_1} 1580 1585 0 0 0.26 0.26 {layer=4}
T {RECIRCULATION / clk_2} 2800 1585 0 0 0.26 0.26 {layer=4}
L 21 90 1630 3370 1630 {}
T {BIT 3} 90 1620 0 0 0.34 0.34 {layer=4}
T {RECIRCULATION / clk_1} 1580 1925 0 0 0.26 0.26 {layer=4}
T {RECIRCULATION / clk_2} 2800 1925 0 0 0.26 0.26 {layer=4}
L 21 90 1970 3370 1970 {}
T {en=1: advance modulo 16 after the two phases.  en=0: hold via recirculation.  Phase-2 selection uses en_1 sampled in phase 1.} 90 2025 0 0 0.34 0.34 {layer=4}
T {Cells: 16 x dlrtp_1  |  1 x dlxtp_1  |  8 x mux2_1  |  2 x and2_1  |  3 x xor2_1  |  1 x inv_1} 90 2075 0 0 0.32 0.32 {layer=4}
T {Standard-cell schematic.  Local symbols retain SKY130 pin maps and power attributes; no transistor-level simulation setup is included.} 90 2120 0 0 0.29 0.29 {layer=4}
N 300 270 370 270 {}
N 620 270 690 270 {}
N 940 270 1010 270 {}
N 1230 270 1300 270 {}
N 1540 270 1580 270 {}
N 1540 290 1580 290 {}
N 1760 270 1850 270 {}
N 2490 270 2560 270 {}
N 2910 270 2980 270 {}
N 3110 330 3190 330 {}
N 660 660 720 660 {}
N 800 660 1000 660 {}
N 1000 660 1000 680 {}
N 1000 680 1140 680 {}
N 1100 640 1140 640 {}
N 1100 720 1140 720 {}
N 1220 660 1580 660 {}
N 1540 680 1580 680 {}
N 1540 700 1580 700 {}
N 1760 660 2220 660 {}
N 2220 660 2220 680 {}
N 2220 680 2360 680 {}
N 2320 640 2360 640 {}
N 2320 720 2360 720 {}
N 2440 660 2800 660 {}
N 2760 680 2800 680 {}
N 2760 700 2800 700 {}
N 2980 660 3220 660 {}
N 1490 830 1580 830 {}
N 1540 850 1580 850 {}
N 1540 870 1580 870 {}
N 1760 830 1820 830 {}
N 2710 830 2800 830 {}
N 2760 850 2800 850 {}
N 2760 870 2800 870 {}
N 2980 830 3040 830 {}
N 660 980 700 980 {}
N 660 1020 700 1020 {}
N 820 1000 1000 1000 {}
N 1000 1000 1000 1020 {}
N 1000 1020 1140 1020 {}
N 1100 980 1140 980 {}
N 1100 1060 1140 1060 {}
N 1220 1000 1580 1000 {}
N 1540 1020 1580 1020 {}
N 1540 1040 1580 1040 {}
N 1760 1000 2220 1000 {}
N 2220 1000 2220 1020 {}
N 2220 1020 2360 1020 {}
N 2320 980 2360 980 {}
N 2320 1060 2360 1060 {}
N 2440 1000 2800 1000 {}
N 2760 1020 2800 1020 {}
N 2760 1040 2800 1040 {}
N 2980 1000 3220 1000 {}
N 1490 1170 1580 1170 {}
N 1540 1190 1580 1190 {}
N 1540 1210 1580 1210 {}
N 1760 1170 1820 1170 {}
N 2710 1170 2800 1170 {}
N 2760 1190 2800 1190 {}
N 2760 1210 2800 1210 {}
N 2980 1170 3040 1170 {}
N 660 1320 700 1320 {}
N 660 1360 700 1360 {}
N 820 1340 1000 1340 {}
N 1000 1340 1000 1360 {}
N 1000 1360 1140 1360 {}
N 1100 1320 1140 1320 {}
N 1100 1400 1140 1400 {}
N 1220 1340 1580 1340 {}
N 1540 1360 1580 1360 {}
N 1540 1380 1580 1380 {}
N 1760 1340 2220 1340 {}
N 2220 1340 2220 1360 {}
N 2220 1360 2360 1360 {}
N 2320 1320 2360 1320 {}
N 2320 1400 2360 1400 {}
N 2440 1340 2800 1340 {}
N 2760 1360 2800 1360 {}
N 2760 1380 2800 1380 {}
N 2980 1340 3220 1340 {}
N 1490 1510 1580 1510 {}
N 1540 1530 1580 1530 {}
N 1540 1550 1580 1550 {}
N 1760 1510 1820 1510 {}
N 2710 1510 2800 1510 {}
N 2760 1530 2800 1530 {}
N 2760 1550 2800 1550 {}
N 2980 1510 3040 1510 {}
N 660 1660 700 1660 {}
N 660 1700 700 1700 {}
N 820 1680 1000 1680 {}
N 1000 1680 1000 1700 {}
N 1000 1700 1140 1700 {}
N 1100 1660 1140 1660 {}
N 1100 1740 1140 1740 {}
N 1220 1680 1580 1680 {}
N 1540 1700 1580 1700 {}
N 1540 1720 1580 1720 {}
N 1760 1680 2220 1680 {}
N 2220 1680 2220 1700 {}
N 2220 1700 2360 1700 {}
N 2320 1660 2360 1660 {}
N 2320 1740 2360 1740 {}
N 2440 1680 2800 1680 {}
N 2760 1700 2800 1700 {}
N 2760 1720 2800 1720 {}
N 2980 1680 3220 1680 {}
N 1490 1850 1580 1850 {}
N 1540 1870 1580 1870 {}
N 1540 1890 1580 1890 {}
N 1760 1850 1820 1850 {}
N 2710 1850 2800 1850 {}
N 2760 1870 2800 1870 {}
N 2760 1890 2800 1890 {}
N 2980 1850 3040 1850 {}
N 200 1080 240 1080 {}
N 200 1120 240 1120 {}
N 360 1100 410 1100 {}
N 200 1420 240 1420 {}
N 200 1460 240 1460 {}
N 360 1440 410 1440 {}
C {devices/ipin.sym} 300 270 0 0 {name=p1 lab=clk_1}
C {devices/ipin.sym} 620 270 0 0 {name=p2 lab=clk_2}
C {devices/ipin.sym} 940 270 0 0 {name=p3 lab=rst_n}
C {devices/ipin.sym} 1230 270 0 0 {name=p4 lab=en}
C {symbols/sky130_stdcells/dlxtp_1.sym} 1670 280 0 0 {name=xen_phi1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1540 270 0 0 {name=l5 lab=en}
C {symbols/net_label.sym} 1540 290 0 0 {name=l6 lab=clk_1}
C {symbols/net_label.sym} 1850 270 0 1 {name=l7 lab=en_1}
C {devices/ipin.sym} 2490 270 0 0 {name=p8 lab=VPWR}
C {devices/ipin.sym} 2910 270 0 0 {name=p9 lab=VGND}
C {devices/opin.sym} 3190 330 0 0 {name=p10 lab=count[3:0]}
C {symbols/sky130_stdcells/inv_1.sym} 760 660 0 0 {name=x_20_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 660 660 0 0 {name=l11 lab=count[0]}
C {symbols/net_label.sym} 880 660 0 1 {name=l12 lab=increment[0]}
C {symbols/sky130_stdcells/mux2_1.sym} 1180 660 0 0 {name=xmux_phi1_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1100 640 0 0 {name=l13 lab=recirc_q_phi2[0]}
C {symbols/net_label.sym} 1100 720 0 0 {name=l14 lab=en}
C {symbols/net_label.sym} 1250 660 0 1 {name=l15 lab=main_d_phi1[0]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1670 680 0 0 {name=xmain_phi1_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1540 680 0 0 {name=l16 lab=clk_1}
C {symbols/net_label.sym} 1540 700 0 0 {name=l17 lab=rst_n}
C {symbols/net_label.sym} 1850 660 0 1 {name=l18 lab=main_q_phi1[0]}
C {symbols/sky130_stdcells/mux2_1.sym} 2400 660 0 0 {name=xmux_phi2_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2320 640 0 0 {name=l19 lab=recirc_q_phi1[0]}
C {symbols/net_label.sym} 2320 720 0 0 {name=l20 lab=en_1}
C {symbols/net_label.sym} 2470 660 0 1 {name=l21 lab=main_d_phi2[0]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 2890 680 0 0 {name=xmain_phi2_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2760 680 0 0 {name=l22 lab=clk_2}
C {symbols/net_label.sym} 2760 700 0 0 {name=l23 lab=rst_n}
C {symbols/net_label.sym} 3220 660 0 1 {name=l24 lab=count[0]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1670 850 0 0 {name=xrecirc_phi1_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1490 830 0 0 {name=l25 lab=count[0]}
C {symbols/net_label.sym} 1540 850 0 0 {name=l26 lab=clk_1}
C {symbols/net_label.sym} 1540 870 0 0 {name=l27 lab=rst_n}
C {symbols/net_label.sym} 1820 830 0 1 {name=l28 lab=recirc_q_phi1[0]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 2890 850 0 0 {name=xrecirc_phi2_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2710 830 0 0 {name=l29 lab=main_q_phi1[0]}
C {symbols/net_label.sym} 2760 850 0 0 {name=l30 lab=clk_2}
C {symbols/net_label.sym} 2760 870 0 0 {name=l31 lab=rst_n}
C {symbols/net_label.sym} 3040 830 0 1 {name=l32 lab=recirc_q_phi2[0]}
C {symbols/sky130_stdcells/xor2_1.sym} 760 1000 0 0 {name=x_17_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 660 980 0 0 {name=l33 lab=count[1]}
C {symbols/net_label.sym} 660 1020 0 0 {name=l34 lab=count[0]}
C {symbols/net_label.sym} 880 1000 0 1 {name=l35 lab=increment[1]}
C {symbols/sky130_stdcells/mux2_1.sym} 1180 1000 0 0 {name=xmux_phi1_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1100 980 0 0 {name=l36 lab=recirc_q_phi2[1]}
C {symbols/net_label.sym} 1100 1060 0 0 {name=l37 lab=en}
C {symbols/net_label.sym} 1250 1000 0 1 {name=l38 lab=main_d_phi1[1]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1670 1020 0 0 {name=xmain_phi1_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1540 1020 0 0 {name=l39 lab=clk_1}
C {symbols/net_label.sym} 1540 1040 0 0 {name=l40 lab=rst_n}
C {symbols/net_label.sym} 1850 1000 0 1 {name=l41 lab=main_q_phi1[1]}
C {symbols/sky130_stdcells/mux2_1.sym} 2400 1000 0 0 {name=xmux_phi2_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2320 980 0 0 {name=l42 lab=recirc_q_phi1[1]}
C {symbols/net_label.sym} 2320 1060 0 0 {name=l43 lab=en_1}
C {symbols/net_label.sym} 2470 1000 0 1 {name=l44 lab=main_d_phi2[1]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 2890 1020 0 0 {name=xmain_phi2_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2760 1020 0 0 {name=l45 lab=clk_2}
C {symbols/net_label.sym} 2760 1040 0 0 {name=l46 lab=rst_n}
C {symbols/net_label.sym} 3220 1000 0 1 {name=l47 lab=count[1]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1670 1190 0 0 {name=xrecirc_phi1_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1490 1170 0 0 {name=l48 lab=count[1]}
C {symbols/net_label.sym} 1540 1190 0 0 {name=l49 lab=clk_1}
C {symbols/net_label.sym} 1540 1210 0 0 {name=l50 lab=rst_n}
C {symbols/net_label.sym} 1820 1170 0 1 {name=l51 lab=recirc_q_phi1[1]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 2890 1190 0 0 {name=xrecirc_phi2_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2710 1170 0 0 {name=l52 lab=main_q_phi1[1]}
C {symbols/net_label.sym} 2760 1190 0 0 {name=l53 lab=clk_2}
C {symbols/net_label.sym} 2760 1210 0 0 {name=l54 lab=rst_n}
C {symbols/net_label.sym} 3040 1170 0 1 {name=l55 lab=recirc_q_phi2[1]}
C {symbols/sky130_stdcells/xor2_1.sym} 760 1340 0 0 {name=x_18_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 660 1320 0 0 {name=l56 lab=count[2]}
C {symbols/net_label.sym} 660 1360 0 0 {name=l57 lab=carry[1]}
C {symbols/net_label.sym} 880 1340 0 1 {name=l58 lab=increment[2]}
C {symbols/sky130_stdcells/mux2_1.sym} 1180 1340 0 0 {name=xmux_phi1_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1100 1320 0 0 {name=l59 lab=recirc_q_phi2[2]}
C {symbols/net_label.sym} 1100 1400 0 0 {name=l60 lab=en}
C {symbols/net_label.sym} 1250 1340 0 1 {name=l61 lab=main_d_phi1[2]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1670 1360 0 0 {name=xmain_phi1_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1540 1360 0 0 {name=l62 lab=clk_1}
C {symbols/net_label.sym} 1540 1380 0 0 {name=l63 lab=rst_n}
C {symbols/net_label.sym} 1850 1340 0 1 {name=l64 lab=main_q_phi1[2]}
C {symbols/sky130_stdcells/mux2_1.sym} 2400 1340 0 0 {name=xmux_phi2_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2320 1320 0 0 {name=l65 lab=recirc_q_phi1[2]}
C {symbols/net_label.sym} 2320 1400 0 0 {name=l66 lab=en_1}
C {symbols/net_label.sym} 2470 1340 0 1 {name=l67 lab=main_d_phi2[2]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 2890 1360 0 0 {name=xmain_phi2_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2760 1360 0 0 {name=l68 lab=clk_2}
C {symbols/net_label.sym} 2760 1380 0 0 {name=l69 lab=rst_n}
C {symbols/net_label.sym} 3220 1340 0 1 {name=l70 lab=count[2]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1670 1530 0 0 {name=xrecirc_phi1_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1490 1510 0 0 {name=l71 lab=count[2]}
C {symbols/net_label.sym} 1540 1530 0 0 {name=l72 lab=clk_1}
C {symbols/net_label.sym} 1540 1550 0 0 {name=l73 lab=rst_n}
C {symbols/net_label.sym} 1820 1510 0 1 {name=l74 lab=recirc_q_phi1[2]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 2890 1530 0 0 {name=xrecirc_phi2_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2710 1510 0 0 {name=l75 lab=main_q_phi1[2]}
C {symbols/net_label.sym} 2760 1530 0 0 {name=l76 lab=clk_2}
C {symbols/net_label.sym} 2760 1550 0 0 {name=l77 lab=rst_n}
C {symbols/net_label.sym} 3040 1510 0 1 {name=l78 lab=recirc_q_phi2[2]}
C {symbols/sky130_stdcells/xor2_1.sym} 760 1680 0 0 {name=x_19_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 660 1660 0 0 {name=l79 lab=count[3]}
C {symbols/net_label.sym} 660 1700 0 0 {name=l80 lab=carry[2]}
C {symbols/net_label.sym} 880 1680 0 1 {name=l81 lab=increment[3]}
C {symbols/sky130_stdcells/mux2_1.sym} 1180 1680 0 0 {name=xmux_phi1_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1100 1660 0 0 {name=l82 lab=recirc_q_phi2[3]}
C {symbols/net_label.sym} 1100 1740 0 0 {name=l83 lab=en}
C {symbols/net_label.sym} 1250 1680 0 1 {name=l84 lab=main_d_phi1[3]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1670 1700 0 0 {name=xmain_phi1_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1540 1700 0 0 {name=l85 lab=clk_1}
C {symbols/net_label.sym} 1540 1720 0 0 {name=l86 lab=rst_n}
C {symbols/net_label.sym} 1850 1680 0 1 {name=l87 lab=main_q_phi1[3]}
C {symbols/sky130_stdcells/mux2_1.sym} 2400 1680 0 0 {name=xmux_phi2_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2320 1660 0 0 {name=l88 lab=recirc_q_phi1[3]}
C {symbols/net_label.sym} 2320 1740 0 0 {name=l89 lab=en_1}
C {symbols/net_label.sym} 2470 1680 0 1 {name=l90 lab=main_d_phi2[3]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 2890 1700 0 0 {name=xmain_phi2_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2760 1700 0 0 {name=l91 lab=clk_2}
C {symbols/net_label.sym} 2760 1720 0 0 {name=l92 lab=rst_n}
C {symbols/net_label.sym} 3220 1680 0 1 {name=l93 lab=count[3]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1670 1870 0 0 {name=xrecirc_phi1_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 1490 1850 0 0 {name=l94 lab=count[3]}
C {symbols/net_label.sym} 1540 1870 0 0 {name=l95 lab=clk_1}
C {symbols/net_label.sym} 1540 1890 0 0 {name=l96 lab=rst_n}
C {symbols/net_label.sym} 1820 1850 0 1 {name=l97 lab=recirc_q_phi1[3]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 2890 1870 0 0 {name=xrecirc_phi2_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 2710 1850 0 0 {name=l98 lab=main_q_phi1[3]}
C {symbols/net_label.sym} 2760 1870 0 0 {name=l99 lab=clk_2}
C {symbols/net_label.sym} 2760 1890 0 0 {name=l100 lab=rst_n}
C {symbols/net_label.sym} 3040 1850 0 1 {name=l101 lab=recirc_q_phi2[3]}
C {symbols/sky130_stdcells/and2_1.sym} 300 1100 0 0 {name=x_16_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 200 1080 0 0 {name=l102 lab=count[1]}
C {symbols/net_label.sym} 200 1120 0 0 {name=l103 lab=count[0]}
C {symbols/net_label.sym} 410 1100 0 1 {name=l104 lab=carry[1]}
C {symbols/sky130_stdcells/and2_1.sym} 300 1440 0 0 {name=x_15_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {symbols/net_label.sym} 200 1420 0 0 {name=l105 lab=count[2]}
C {symbols/net_label.sym} 200 1460 0 0 {name=l106 lab=carry[1]}
C {symbols/net_label.sym} 410 1440 0 1 {name=l107 lab=carry[2]}
