v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {4-BIT LATCH COUNTER | POST-ROUTE SCHEMATIC} 100 60 0 0 0.8 0.8 {layer=4}
T {SKY130 HD | openroad/results/counter_routed.v | 26 cells / 10 latches / 6 CTS buffers} 100 115 0 0 0.4 0.4 {layer=4}
C {devices/ipin.sym} 210 195 0 0 {name=p1 lab=clk_1}
N 210 195 280 195 {}
C {devices/lab_pin.sym} 280 195 0 1 {name=l1 sig_type=std_logic lab=clk_1}
C {devices/ipin.sym} 520 195 0 0 {name=p2 lab=clk_2}
N 520 195 590 195 {}
C {devices/lab_pin.sym} 590 195 0 1 {name=l2 sig_type=std_logic lab=clk_2}
C {devices/ipin.sym} 830 195 0 0 {name=p3 lab=rst_n}
N 830 195 900 195 {}
C {devices/lab_pin.sym} 900 195 0 1 {name=l3 sig_type=std_logic lab=rst_n}
C {devices/ipin.sym} 1140 195 0 0 {name=p4 lab=en}
N 1140 195 1210 195 {}
C {devices/lab_pin.sym} 1210 195 0 1 {name=l4 sig_type=std_logic lab=en}
C {devices/iopin.sym} 1450 195 0 0 {name=p5 lab=VDD}
N 1450 195 1520 195 {}
C {devices/lab_pin.sym} 1520 195 0 1 {name=l5 sig_type=std_logic lab=VDD}
C {devices/iopin.sym} 1760 195 0 0 {name=p6 lab=VSS}
N 1760 195 1830 195 {}
C {devices/lab_pin.sym} 1830 195 0 1 {name=l6 sig_type=std_logic lab=VSS}
C {devices/opin.sym} 2140 195 0 0 {name=p7 lab=count[3:0]}
T {FEEDBACK / ENABLE LOGIC} 200 830 0 0 0.45 0.45 {layer=4}
T {PHASE 1: CK1_A / CK1_B} 910 830 0 0 0.45 0.45 {layer=4}
T {RETIMED XOR} 1370 830 0 0 0.45 0.45 {layer=4}
T {PHASE 2: CK2_A / CK2_B} 1750 830 0 0 0.45 0.45 {layer=4}
T {BIT 0} 100 875 0 0 0.45 0.45 {layer=4}
C {sky130_stdcells/dlrtp_1.sym} 1020 950 0 0 {name=xstate_phi1_bit0 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 890 950 930 950 {}
C {devices/lab_pin.sym} 890 950 0 0 {name=l7 sig_type=std_logic lab=CK1_A}
N 890 970 930 970 {}
C {devices/lab_pin.sym} 890 970 0 0 {name=l8 sig_type=std_logic lab=RST_BUF}
C {sky130_stdcells/mux2_1.sym} 650 930 0 0 {name=x_12_ VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 560 910 610 910 {}
C {devices/lab_pin.sym} 560 910 0 0 {name=l9 sig_type=std_logic lab=count[0]}
N 560 990 610 990 {}
C {devices/lab_pin.sym} 560 990 0 0 {name=l10 sig_type=std_logic lab=en}
C {sky130_stdcells/inv_1.sym} 300 950 0 0 {name=x_20_ VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 210 950 260 950 {}
C {devices/lab_pin.sym} 210 950 0 0 {name=l11 sig_type=std_logic lab=count[0]}
N 340 950 610 950 {}
C {devices/lab_wire.sym} 455 950 0 0 {name=l12 sig_type=std_logic lab=_01_[0]}
N 690 930 930 930 {}
C {devices/lab_wire.sym} 785 930 0 0 {name=l13 sig_type=std_logic lab=_04_}
N 1110 930 1760 930 {}
C {devices/lab_wire.sym} 1300 930 0 0 {name=l14 sig_type=std_logic lab=phase_1[0]}
C {sky130_stdcells/dlrtp_4.sym} 1850 950 0 0 {name=xstate_phi2_bit0 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 1720 950 1760 950 {}
C {devices/lab_pin.sym} 1720 950 0 0 {name=l15 sig_type=std_logic lab=CK2_A}
N 1720 970 1760 970 {}
C {devices/lab_pin.sym} 1720 970 0 0 {name=l16 sig_type=std_logic lab=RST_BUF}
N 1940 930 2230 930 {}
C {devices/lab_pin.sym} 2230 930 0 1 {name=l17 sig_type=std_logic lab=count[0]}
L 21 90 1105 2290 1105 {dash=4}
T {BIT 1} 100 1145 0 0 0.45 0.45 {layer=4}
C {sky130_stdcells/dlrtp_1.sym} 1020 1220 0 0 {name=xstate_phi1_bit1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 890 1220 930 1220 {}
C {devices/lab_pin.sym} 890 1220 0 0 {name=l18 sig_type=std_logic lab=CK1_A}
N 890 1240 930 1240 {}
C {devices/lab_pin.sym} 890 1240 0 0 {name=l19 sig_type=std_logic lab=RST_BUF}
C {sky130_stdcells/mux2_1.sym} 650 1200 0 0 {name=x_11_ VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 560 1180 610 1180 {}
C {devices/lab_pin.sym} 560 1180 0 0 {name=l20 sig_type=std_logic lab=count[1]}
N 560 1260 610 1260 {}
C {devices/lab_pin.sym} 560 1260 0 0 {name=l21 sig_type=std_logic lab=en}
C {sky130_stdcells/xor2_1.sym} 300 1220 0 0 {name=x_17_ VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 190 1200 240 1200 {}
C {devices/lab_pin.sym} 190 1200 0 0 {name=l22 sig_type=std_logic lab=count[1]}
N 190 1240 240 1240 {}
C {devices/lab_pin.sym} 190 1240 0 0 {name=l23 sig_type=std_logic lab=count[0]}
N 360 1220 610 1220 {}
C {devices/lab_wire.sym} 455 1220 0 0 {name=l24 sig_type=std_logic lab=_02_[1]}
N 690 1200 930 1200 {}
C {devices/lab_wire.sym} 785 1200 0 0 {name=l25 sig_type=std_logic lab=_03_}
N 1110 1200 1760 1200 {}
C {devices/lab_wire.sym} 1300 1200 0 0 {name=l26 sig_type=std_logic lab=phase_1[1]}
C {sky130_stdcells/dlrtp_4.sym} 1850 1220 0 0 {name=xstate_phi2_bit1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 1720 1220 1760 1220 {}
C {devices/lab_pin.sym} 1720 1220 0 0 {name=l27 sig_type=std_logic lab=CK2_A}
N 1720 1240 1760 1240 {}
C {devices/lab_pin.sym} 1720 1240 0 0 {name=l28 sig_type=std_logic lab=RST_BUF}
N 1940 1200 2230 1200 {}
C {devices/lab_pin.sym} 2230 1200 0 1 {name=l29 sig_type=std_logic lab=count[1]}
L 21 90 1405 2290 1405 {dash=4}
T {BIT 2} 100 1445 0 0 0.45 0.45 {layer=4}
C {sky130_stdcells/dlrtp_1.sym} 1020 1520 0 0 {name=xstate_phi1_bit2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 890 1520 930 1520 {}
C {devices/lab_pin.sym} 890 1520 0 0 {name=l30 sig_type=std_logic lab=CK1_A}
N 890 1540 930 1540 {}
C {devices/lab_pin.sym} 890 1540 0 0 {name=l31 sig_type=std_logic lab=RST_BUF}
N 850 1500 930 1500 {}
C {devices/lab_pin.sym} 850 1500 0 0 {name=l32 sig_type=std_logic lab=count[2]}
N 1110 1500 1390 1500 {}
C {devices/lab_wire.sym} 1290 1500 0 0 {name=l33 sig_type=std_logic lab=phase_1[2]}
C {sky130_stdcells/xor2_1.sym} 1450 1520 0 0 {name=x_18_ VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 1510 1520 1760 1520 {}
C {devices/lab_wire.sym} 1600 1520 0 0 {name=l34 sig_type=std_logic lab=next_bit2}
C {sky130_stdcells/dlrtp_2.sym} 1850 1540 0 0 {name=xstate_phi2_bit2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 1720 1540 1760 1540 {}
C {devices/lab_pin.sym} 1720 1540 0 0 {name=l35 sig_type=std_logic lab=CK2_B}
N 1720 1560 1760 1560 {}
C {devices/lab_pin.sym} 1720 1560 0 0 {name=l36 sig_type=std_logic lab=RST_BUF}
C {sky130_stdcells/dlrtp_1.sym} 1020 1660 0 0 {name=xstate_phi1_toggle2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 890 1660 930 1660 {}
C {devices/lab_pin.sym} 890 1660 0 0 {name=l37 sig_type=std_logic lab=CK1_B}
N 890 1680 930 1680 {}
C {devices/lab_pin.sym} 890 1680 0 0 {name=l38 sig_type=std_logic lab=RST_BUF}
N 1110 1640 1350 1640 {}
C {devices/lab_pin.sym} 1350 1590 0 0 {name=l39 sig_type=std_logic lab=phase_1_toggle2}
N 1350 1640 1350 1540 {}
N 1350 1540 1390 1540 {}
C {sky130_stdcells/and3_1.sym} 650 1640 0 0 {name=x_16_ VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 540 1600 590 1600 {}
C {devices/lab_pin.sym} 540 1600 0 0 {name=l40 sig_type=std_logic lab=count[1]}
N 540 1640 590 1640 {}
C {devices/lab_pin.sym} 540 1640 0 0 {name=l41 sig_type=std_logic lab=count[0]}
N 540 1680 590 1680 {}
C {devices/lab_pin.sym} 540 1680 0 0 {name=l42 sig_type=std_logic lab=en}
N 710 1640 930 1640 {}
C {devices/lab_wire.sym} 790 1640 0 0 {name=l43 sig_type=std_logic lab=toggle2}
N 1940 1520 2230 1520 {}
C {devices/lab_pin.sym} 2230 1520 0 1 {name=l44 sig_type=std_logic lab=count[2]}
L 21 90 1785 2290 1785 {dash=4}
T {BIT 3} 100 1825 0 0 0.45 0.45 {layer=4}
C {sky130_stdcells/dlrtp_1.sym} 1020 1900 0 0 {name=xstate_phi1_bit3 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 890 1900 930 1900 {}
C {devices/lab_pin.sym} 890 1900 0 0 {name=l45 sig_type=std_logic lab=CK1_B}
N 890 1920 930 1920 {}
C {devices/lab_pin.sym} 890 1920 0 0 {name=l46 sig_type=std_logic lab=RST_BUF}
N 850 1880 930 1880 {}
C {devices/lab_pin.sym} 850 1880 0 0 {name=l47 sig_type=std_logic lab=count[3]}
N 1110 1880 1390 1880 {}
C {devices/lab_wire.sym} 1290 1880 0 0 {name=l48 sig_type=std_logic lab=phase_1[3]}
C {sky130_stdcells/xor2_1.sym} 1450 1900 0 0 {name=x_19_ VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 1510 1900 1760 1900 {}
C {devices/lab_wire.sym} 1600 1900 0 0 {name=l49 sig_type=std_logic lab=next_bit3}
C {sky130_stdcells/dlrtp_2.sym} 1850 1920 0 0 {name=xstate_phi2_bit3 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 1720 1920 1760 1920 {}
C {devices/lab_pin.sym} 1720 1920 0 0 {name=l50 sig_type=std_logic lab=CK2_B}
N 1720 1940 1760 1940 {}
C {devices/lab_pin.sym} 1720 1940 0 0 {name=l51 sig_type=std_logic lab=RST_BUF}
C {sky130_stdcells/dlrtp_1.sym} 1020 2040 0 0 {name=xstate_phi1_toggle3 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 890 2040 930 2040 {}
C {devices/lab_pin.sym} 890 2040 0 0 {name=l52 sig_type=std_logic lab=CK1_B}
N 890 2060 930 2060 {}
C {devices/lab_pin.sym} 890 2060 0 0 {name=l53 sig_type=std_logic lab=RST_BUF}
N 1110 2020 1350 2020 {}
C {devices/lab_pin.sym} 1350 1970 0 0 {name=l54 sig_type=std_logic lab=phase_1_toggle3}
N 1350 2020 1350 1920 {}
N 1350 1920 1390 1920 {}
C {sky130_stdcells/and3_1.sym} 300 2020 0 0 {name=x_15_ VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 190 1980 240 1980 {}
C {devices/lab_pin.sym} 190 1980 0 0 {name=l55 sig_type=std_logic lab=count[2]}
N 190 2020 240 2020 {}
C {devices/lab_pin.sym} 190 2020 0 0 {name=l56 sig_type=std_logic lab=count[1]}
N 190 2060 240 2060 {}
C {devices/lab_pin.sym} 190 2060 0 0 {name=l57 sig_type=std_logic lab=count[0]}
N 360 2020 490 2020 {}
C {devices/lab_wire.sym} 420 2020 0 0 {name=l58 sig_type=std_logic lab=carry3}
N 490 2020 490 2040 {}
N 490 2040 590 2040 {}
C {sky130_stdcells/and2_4.sym} 650 2020 0 0 {name=xbit3_enable VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 540 2000 590 2000 {}
C {devices/lab_pin.sym} 540 2000 0 0 {name=l59 sig_type=std_logic lab=en}
N 710 2020 930 2020 {}
C {devices/lab_wire.sym} 790 2020 0 0 {name=l60 sig_type=std_logic lab=toggle3}
N 1940 1900 2230 1900 {}
C {devices/lab_pin.sym} 2230 1900 0 1 {name=l61 sig_type=std_logic lab=count[3]}
T {Data flow: left to right. Named clock/reset labels connect to the buffered trees above.} 100 2140 0 0 0.38 0.38 {layer=4}
T {en = 0 holds count. count[n] = count_o[n]. All cells: VPWR = VPB = VDD; VGND = VNB = VSS.} 100 2170 0 0 0.38 0.38 {layer=4}
L 4 60 30 2320 30 {}
L 4 2320 30 2320 2250 {}
L 4 2320 2250 60 2250 {}
L 4 60 2250 60 30 {}
L 4 60 255 2320 255 {}
L 4 60 800 2320 800 {}
L 4 60 2120 2320 2120 {}
T {PROPAGATED CLOCK TREES AND BUFFERED RESET} 100 280 0 0 0.45 0.45 {layer=4}
C {sky130_stdcells/clkbuf_4.sym} 310 450 0 0 {name=xclkbuf_0_clk_1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 210 450 270 450 {}
C {devices/lab_pin.sym} 210 450 0 0 {name=pr_l10 lab=clk_1}
N 350 450 470 450 {}
C {devices/lab_pin.sym} 410 450 0 1 {name=pr_l12 lab=CK1_ROOT}
N 470 390 470 450 {}
N 470 450 470 510 {}
C {sky130_stdcells/clkbuf_4.sym} 690 390 0 0 {name=xclkbuf_1_0__f_clk_1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 470 390 650 390 {}
N 730 390 990 390 {}
C {devices/lab_pin.sym} 990 390 0 1 {name=pr_l18 lab=CK1_A}
C {sky130_stdcells/clkbuf_4.sym} 690 510 0 0 {name=xclkbuf_1_1__f_clk_1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 470 510 650 510 {}
N 730 510 990 510 {}
C {devices/lab_pin.sym} 990 510 0 1 {name=pr_l22 lab=CK1_B}
T {phi1: 3 x clkbuf_4} 210 335 0 0 0.36 0.36 {layer=4}
T {CK1_ROOT = clknet_0_clk_1} 210 570 0 0 0.29 0.29 {layer=4}
T {CK1_A = clknet_1_0__leaf_clk_1} 210 605 0 0 0.29 0.29 {layer=4}
T {CK1_B = clknet_1_1__leaf_clk_1} 210 635 0 0 0.29 0.29 {layer=4}
C {sky130_stdcells/clkbuf_4.sym} 1390 450 0 0 {name=xclkbuf_0_clk_2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 1290 450 1350 450 {}
C {devices/lab_pin.sym} 1290 450 0 0 {name=pr_l29 lab=clk_2}
N 1430 450 1550 450 {}
C {devices/lab_pin.sym} 1490 450 0 1 {name=pr_l31 lab=CK2_ROOT}
N 1550 390 1550 450 {}
N 1550 450 1550 510 {}
C {sky130_stdcells/clkbuf_4.sym} 1770 390 0 0 {name=xclkbuf_1_0__f_clk_2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 1550 390 1730 390 {}
N 1810 390 2070 390 {}
C {devices/lab_pin.sym} 2070 390 0 1 {name=pr_l37 lab=CK2_A}
C {sky130_stdcells/clkbuf_4.sym} 1770 510 0 0 {name=xclkbuf_1_1__f_clk_2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 1550 510 1730 510 {}
N 1810 510 2070 510 {}
C {devices/lab_pin.sym} 2070 510 0 1 {name=pr_l41 lab=CK2_B}
T {phi2: 3 x clkbuf_4} 1290 335 0 0 0.36 0.36 {layer=4}
T {CK2_ROOT = clknet_0_clk_2} 1290 570 0 0 0.29 0.29 {layer=4}
T {CK2_A = clknet_1_0__leaf_clk_2} 1290 605 0 0 0.29 0.29 {layer=4}
T {CK2_B = clknet_1_1__leaf_clk_2} 1290 635 0 0 0.29 0.29 {layer=4}
C {sky130_stdcells/buf_1.sym} 310 710 0 0 {name=xreset_release_buf1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
N 210 710 270 710 {}
C {devices/lab_pin.sym} 210 710 0 0 {name=pr_l48 lab=rst_n}
N 350 710 660 710 {}
C {devices/lab_pin.sym} 660 710 0 1 {name=pr_l50 lab=RST_BUF}
T {RST_BUF = rst_n_buffered1; drives RESET_B of all 10 latches} 900 690 0 0 0.33 0.33 {layer=4}
T {Actual sizes: phi2 bit0/1 = dlrtp_4; bit2/3 = dlrtp_2; bit3_enable = and2_4} 900 730 0 0 0.33 0.33 {layer=4}
T {Cell connectivity drawing. Extracted interconnect RC is retained separately in counter.spef.} 100 2210 0 0 0.34 0.34 {layer=4}
