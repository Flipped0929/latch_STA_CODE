v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
L 4 60 30 2320 30 {}
L 4 2320 30 2320 1660 {}
L 4 60 1660 2320 1660 {}
L 4 60 30 60 1660 {}
L 4 60 255 2320 255 {}
L 4 60 1570 2320 1570 {}
T {4-BIT TWO-PHASE LATCH COUNTER} 100 60 0 0 0.8 0.8 {layer=4}
T {SKY130 HD | Source: counter_sky130.v | 19 cells / 10 resettable latches} 100 115 0 0 0.4 0.4 {layer=4}
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
C {devices/ipin.sym} 1450 195 0 0 {name=p5 lab=VPWR}
N 1450 195 1520 195 {}
C {devices/lab_pin.sym} 1520 195 0 1 {name=l5 sig_type=std_logic lab=VPWR}
C {devices/ipin.sym} 1760 195 0 0 {name=p6 lab=VGND}
N 1760 195 1830 195 {}
C {devices/lab_pin.sym} 1830 195 0 1 {name=l6 sig_type=std_logic lab=VGND}
C {devices/opin.sym} 2140 195 0 0 {name=p7 lab=count[3:0]}
T {FEEDBACK / ENABLE LOGIC} 200 280 0 0 0.45 0.45 {layer=4}
T {PHASE 1: clk_1} 910 280 0 0 0.45 0.45 {layer=4}
T {RETIMED XOR} 1370 280 0 0 0.45 0.45 {layer=4}
T {PHASE 2: clk_2} 1750 280 0 0 0.45 0.45 {layer=4}
T {BIT 0} 100 325 0 0 0.45 0.45 {layer=4}
C {sky130_stdcells/dlrtp_1.sym} 1020 400 0 0 {name=xstate_phi1_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 890 400 930 400 {}
C {devices/lab_pin.sym} 890 400 0 0 {name=l7 sig_type=std_logic lab=clk_1}
N 890 420 930 420 {}
C {devices/lab_pin.sym} 890 420 0 0 {name=l8 sig_type=std_logic lab=rst_n}
C {sky130_stdcells/mux2_1.sym} 650 380 0 0 {name=x_12_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 560 360 610 360 {}
C {devices/lab_pin.sym} 560 360 0 0 {name=l9 sig_type=std_logic lab=count[0]}
N 560 440 610 440 {}
C {devices/lab_pin.sym} 560 440 0 0 {name=l10 sig_type=std_logic lab=en}
C {sky130_stdcells/inv_1.sym} 300 400 0 0 {name=x_20_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 210 400 260 400 {}
C {devices/lab_pin.sym} 210 400 0 0 {name=l11 sig_type=std_logic lab=count[0]}
N 340 400 610 400 {}
C {devices/lab_wire.sym} 455 400 0 0 {name=l12 sig_type=std_logic lab=_01_[0]}
N 690 380 930 380 {}
C {devices/lab_wire.sym} 785 380 0 0 {name=l13 sig_type=std_logic lab=_04_}
N 1110 380 1760 380 {}
C {devices/lab_wire.sym} 1300 380 0 0 {name=l14 sig_type=std_logic lab=phase_1[0]}
C {sky130_stdcells/dlrtp_1.sym} 1850 400 0 0 {name=xstate_phi2_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 1720 400 1760 400 {}
C {devices/lab_pin.sym} 1720 400 0 0 {name=l15 sig_type=std_logic lab=clk_2}
N 1720 420 1760 420 {}
C {devices/lab_pin.sym} 1720 420 0 0 {name=l16 sig_type=std_logic lab=rst_n}
N 1940 380 2230 380 {}
C {devices/lab_pin.sym} 2230 380 0 1 {name=l17 sig_type=std_logic lab=count[0]}
L 21 90 555 2290 555 {dash=4}
T {BIT 1} 100 595 0 0 0.45 0.45 {layer=4}
C {sky130_stdcells/dlrtp_1.sym} 1020 670 0 0 {name=xstate_phi1_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 890 670 930 670 {}
C {devices/lab_pin.sym} 890 670 0 0 {name=l18 sig_type=std_logic lab=clk_1}
N 890 690 930 690 {}
C {devices/lab_pin.sym} 890 690 0 0 {name=l19 sig_type=std_logic lab=rst_n}
C {sky130_stdcells/mux2_1.sym} 650 650 0 0 {name=x_11_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 560 630 610 630 {}
C {devices/lab_pin.sym} 560 630 0 0 {name=l20 sig_type=std_logic lab=count[1]}
N 560 710 610 710 {}
C {devices/lab_pin.sym} 560 710 0 0 {name=l21 sig_type=std_logic lab=en}
C {sky130_stdcells/xor2_1.sym} 300 670 0 0 {name=x_17_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 190 650 240 650 {}
C {devices/lab_pin.sym} 190 650 0 0 {name=l22 sig_type=std_logic lab=count[1]}
N 190 690 240 690 {}
C {devices/lab_pin.sym} 190 690 0 0 {name=l23 sig_type=std_logic lab=count[0]}
N 360 670 610 670 {}
C {devices/lab_wire.sym} 455 670 0 0 {name=l24 sig_type=std_logic lab=_02_[1]}
N 690 650 930 650 {}
C {devices/lab_wire.sym} 785 650 0 0 {name=l25 sig_type=std_logic lab=_03_}
N 1110 650 1760 650 {}
C {devices/lab_wire.sym} 1300 650 0 0 {name=l26 sig_type=std_logic lab=phase_1[1]}
C {sky130_stdcells/dlrtp_1.sym} 1850 670 0 0 {name=xstate_phi2_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 1720 670 1760 670 {}
C {devices/lab_pin.sym} 1720 670 0 0 {name=l27 sig_type=std_logic lab=clk_2}
N 1720 690 1760 690 {}
C {devices/lab_pin.sym} 1720 690 0 0 {name=l28 sig_type=std_logic lab=rst_n}
N 1940 650 2230 650 {}
C {devices/lab_pin.sym} 2230 650 0 1 {name=l29 sig_type=std_logic lab=count[1]}
L 21 90 855 2290 855 {dash=4}
T {BIT 2} 100 895 0 0 0.45 0.45 {layer=4}
C {sky130_stdcells/dlrtp_1.sym} 1020 970 0 0 {name=xstate_phi1_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 890 970 930 970 {}
C {devices/lab_pin.sym} 890 970 0 0 {name=l30 sig_type=std_logic lab=clk_1}
N 890 990 930 990 {}
C {devices/lab_pin.sym} 890 990 0 0 {name=l31 sig_type=std_logic lab=rst_n}
N 850 950 930 950 {}
C {devices/lab_pin.sym} 850 950 0 0 {name=l32 sig_type=std_logic lab=count[2]}
N 1110 950 1390 950 {}
C {devices/lab_wire.sym} 1290 950 0 0 {name=l33 sig_type=std_logic lab=phase_1[2]}
C {sky130_stdcells/xor2_1.sym} 1450 970 0 0 {name=x_18_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 1510 970 1760 970 {}
C {devices/lab_wire.sym} 1600 970 0 0 {name=l34 sig_type=std_logic lab=next_bit2}
C {sky130_stdcells/dlrtp_1.sym} 1850 990 0 0 {name=xstate_phi2_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 1720 990 1760 990 {}
C {devices/lab_pin.sym} 1720 990 0 0 {name=l35 sig_type=std_logic lab=clk_2}
N 1720 1010 1760 1010 {}
C {devices/lab_pin.sym} 1720 1010 0 0 {name=l36 sig_type=std_logic lab=rst_n}
C {sky130_stdcells/dlrtp_1.sym} 1020 1110 0 0 {name=xstate_phi1_toggle2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 890 1110 930 1110 {}
C {devices/lab_pin.sym} 890 1110 0 0 {name=l37 sig_type=std_logic lab=clk_1}
N 890 1130 930 1130 {}
C {devices/lab_pin.sym} 890 1130 0 0 {name=l38 sig_type=std_logic lab=rst_n}
N 1110 1090 1350 1090 {}
C {devices/lab_pin.sym} 1350 1040 0 0 {name=l39 sig_type=std_logic lab=phase_1_toggle2}
N 1350 1090 1350 990 {}
N 1350 990 1390 990 {}
C {sky130_stdcells/and3_1.sym} 650 1090 0 0 {name=x_16_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 540 1050 590 1050 {}
C {devices/lab_pin.sym} 540 1050 0 0 {name=l40 sig_type=std_logic lab=count[1]}
N 540 1090 590 1090 {}
C {devices/lab_pin.sym} 540 1090 0 0 {name=l41 sig_type=std_logic lab=count[0]}
N 540 1130 590 1130 {}
C {devices/lab_pin.sym} 540 1130 0 0 {name=l42 sig_type=std_logic lab=en}
N 710 1090 930 1090 {}
C {devices/lab_wire.sym} 790 1090 0 0 {name=l43 sig_type=std_logic lab=toggle2}
N 1940 970 2230 970 {}
C {devices/lab_pin.sym} 2230 970 0 1 {name=l44 sig_type=std_logic lab=count[2]}
L 21 90 1235 2290 1235 {dash=4}
T {BIT 3} 100 1275 0 0 0.45 0.45 {layer=4}
C {sky130_stdcells/dlrtp_1.sym} 1020 1350 0 0 {name=xstate_phi1_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 890 1350 930 1350 {}
C {devices/lab_pin.sym} 890 1350 0 0 {name=l45 sig_type=std_logic lab=clk_1}
N 890 1370 930 1370 {}
C {devices/lab_pin.sym} 890 1370 0 0 {name=l46 sig_type=std_logic lab=rst_n}
N 850 1330 930 1330 {}
C {devices/lab_pin.sym} 850 1330 0 0 {name=l47 sig_type=std_logic lab=count[3]}
N 1110 1330 1390 1330 {}
C {devices/lab_wire.sym} 1290 1330 0 0 {name=l48 sig_type=std_logic lab=phase_1[3]}
C {sky130_stdcells/xor2_1.sym} 1450 1350 0 0 {name=x_19_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 1510 1350 1760 1350 {}
C {devices/lab_wire.sym} 1600 1350 0 0 {name=l49 sig_type=std_logic lab=next_bit3}
C {sky130_stdcells/dlrtp_1.sym} 1850 1370 0 0 {name=xstate_phi2_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 1720 1370 1760 1370 {}
C {devices/lab_pin.sym} 1720 1370 0 0 {name=l50 sig_type=std_logic lab=clk_2}
N 1720 1390 1760 1390 {}
C {devices/lab_pin.sym} 1720 1390 0 0 {name=l51 sig_type=std_logic lab=rst_n}
C {sky130_stdcells/dlrtp_1.sym} 1020 1490 0 0 {name=xstate_phi1_toggle3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 890 1490 930 1490 {}
C {devices/lab_pin.sym} 890 1490 0 0 {name=l52 sig_type=std_logic lab=clk_1}
N 890 1510 930 1510 {}
C {devices/lab_pin.sym} 890 1510 0 0 {name=l53 sig_type=std_logic lab=rst_n}
N 1110 1470 1350 1470 {}
C {devices/lab_pin.sym} 1350 1420 0 0 {name=l54 sig_type=std_logic lab=phase_1_toggle3}
N 1350 1470 1350 1370 {}
N 1350 1370 1390 1370 {}
C {sky130_stdcells/and3_1.sym} 300 1470 0 0 {name=x_15_ VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 190 1430 240 1430 {}
C {devices/lab_pin.sym} 190 1430 0 0 {name=l55 sig_type=std_logic lab=count[2]}
N 190 1470 240 1470 {}
C {devices/lab_pin.sym} 190 1470 0 0 {name=l56 sig_type=std_logic lab=count[1]}
N 190 1510 240 1510 {}
C {devices/lab_pin.sym} 190 1510 0 0 {name=l57 sig_type=std_logic lab=count[0]}
N 360 1470 490 1470 {}
C {devices/lab_wire.sym} 420 1470 0 0 {name=l58 sig_type=std_logic lab=carry3}
N 490 1470 490 1490 {}
N 490 1490 590 1490 {}
C {sky130_stdcells/and2_1.sym} 650 1470 0 0 {name=xbit3_enable VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__ }
N 540 1450 590 1450 {}
C {devices/lab_pin.sym} 540 1450 0 0 {name=l59 sig_type=std_logic lab=en}
N 710 1470 930 1470 {}
C {devices/lab_wire.sym} 790 1470 0 0 {name=l60 sig_type=std_logic lab=toggle3}
N 1940 1350 2230 1350 {}
C {devices/lab_pin.sym} 2230 1350 0 1 {name=l61 sig_type=std_logic lab=count[3]}
T {clk_1 then clk_2: active-high, non-overlapping phases. rst_n = 0 asynchronously clears ALL 10 latches.} 100 1590 0 0 0.38 0.38 {layer=4}
T {en = 0 holds the count. Feedback uses count[n] = count_o[n]. All cells: VPB = VPWR, VNB = VGND.} 100 1620 0 0 0.38 0.38 {layer=4}
