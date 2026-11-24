v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
L 4 40 30 2300 30 {}
L 4 2300 30 2300 1530 {}
L 4 2300 1530 40 1530 {}
L 4 40 1530 40 30 {}
L 4 40 255 2300 255 {}
L 4 40 1380 2300 1380 {}
T {4-BIT TWO-PHASE COUNTER | YOSYS GATE NETLIST} 80 60 0 0 0.73 0.73 {layer=4}
T {counter_yosys.v  /  18 cells: 8 DFF_PN0 + 4 MUX + 2 AND + 3 XOR + 1 NOT} 80 115 0 0 0.36 0.36 {layer=4}
C {devices/ipin.sym} 220 200 0 0 {name=p1 lab=clk_1}
N 220 200 280 200 {}
C {devices/lab_pin.sym} 280 200 0 1 {name=l1 sig_type=std_logic lab=clk_1}
C {devices/ipin.sym} 550 200 0 0 {name=p2 lab=clk_2}
N 550 200 610 200 {}
C {devices/lab_pin.sym} 610 200 0 1 {name=l2 sig_type=std_logic lab=clk_2}
C {devices/ipin.sym} 880 200 0 0 {name=p3 lab=rst_n}
N 880 200 940 200 {}
C {devices/lab_pin.sym} 940 200 0 1 {name=l3 sig_type=std_logic lab=rst_n}
C {devices/ipin.sym} 1210 200 0 0 {name=p4 lab=en}
N 1210 200 1270 200 {}
C {devices/lab_pin.sym} 1270 200 0 1 {name=l4 sig_type=std_logic lab=en}
C {devices/opin.sym} 2110 200 0 0 {name=p5 lab=count[3:0]}
T {CARRY CHAIN} 190 280 0 0 0.4 0.4 {layer=4}
T {INCREMENT} 620 280 0 0 0.4 0.4 {layer=4}
T {HOLD / ENABLE} 950 280 0 0 0.4 0.4 {layer=4}
T {PHASE 1  /  clk_1} 1330 280 0 0 0.4 0.4 {layer=4}
T {PHASE 2  /  clk_2} 1760 280 0 0 0.4 0.4 {layer=4}
T {OUTPUT} 2120 280 0 0 0.4 0.4 {layer=4}
T {BIT 0} 80 320 0 0 0.4 0.4 {layer=4}
C {yosys_cells/not.sym} 700 410 0 0 {name=_20_ }
N 610 410 660 410 {}
C {devices/lab_pin.sym} 610 410 0 0 {name=l5 sig_type=std_logic lab=count[0]}
N 740 410 1010 410 {}
C {devices/lab_wire.sym} 840 410 0 0 {name=l6 sig_type=std_logic lab=_01_[0]}
T {count[0] ^ 1} 600 500 0 0 0.3 0.3 {layer=9}
C {yosys_cells/mux2.sym} 1070 390 0 0 {name=_12_ }
N 960 370 1010 370 {}
C {devices/lab_pin.sym} 960 370 0 0 {name=l7 sig_type=std_logic lab=count[0]}
N 1070 470 1070 490 {}
C {devices/lab_pin.sym} 1070 490 0 1 {name=l8 sig_type=std_logic lab=en}
N 1130 390 1340 390 {}
C {devices/lab_wire.sym} 1200 390 0 0 {name=l9 sig_type=std_logic lab=_04_}
C {yosys_cells/dff_pn0.sym} 1440 410 0 0 {name=state_phi1_bit0 }
N 1290 430 1340 430 {}
C {devices/lab_pin.sym} 1290 430 0 0 {name=l10 sig_type=std_logic lab=clk_1}
N 1440 490 1440 510 {}
C {devices/lab_pin.sym} 1440 510 0 1 {name=l11 sig_type=std_logic lab=rst_n}
N 1540 390 1770 390 {}
C {devices/lab_wire.sym} 1600 390 0 0 {name=l12 sig_type=std_logic lab=phase_1[0]}
C {yosys_cells/dff_pn0.sym} 1870 410 0 0 {name=state_phi2_bit0 }
N 1720 430 1770 430 {}
C {devices/lab_pin.sym} 1720 430 0 0 {name=l13 sig_type=std_logic lab=clk_2}
N 1870 490 1870 510 {}
C {devices/lab_pin.sym} 1870 510 0 1 {name=l14 sig_type=std_logic lab=rst_n}
N 1970 390 2200 390 {}
C {devices/lab_pin.sym} 2200 390 0 1 {name=l15 sig_type=std_logic lab=count[0]}
T {BIT 1} 80 580 0 0 0.4 0.4 {layer=4}
L 21 65 530 2275 530 {dash=4}
C {yosys_cells/xor2.sym} 700 670 0 0 {name=_17_ }
N 590 650 640 650 {}
C {devices/lab_pin.sym} 590 650 0 0 {name=l16 sig_type=std_logic lab=count[1]}
N 590 690 640 690 {}
C {devices/lab_pin.sym} 590 690 0 0 {name=l17 sig_type=std_logic lab=count[0]}
N 760 670 1010 670 {}
C {devices/lab_wire.sym} 840 670 0 0 {name=l18 sig_type=std_logic lab=_02_[1]}
T {count[1] ^ count[0]} 580 760 0 0 0.27 0.27 {layer=9}
C {yosys_cells/mux2.sym} 1070 650 0 0 {name=_11_ }
N 960 630 1010 630 {}
C {devices/lab_pin.sym} 960 630 0 0 {name=l19 sig_type=std_logic lab=count[1]}
N 1070 730 1070 750 {}
C {devices/lab_pin.sym} 1070 750 0 1 {name=l20 sig_type=std_logic lab=en}
N 1130 650 1340 650 {}
C {devices/lab_wire.sym} 1200 650 0 0 {name=l21 sig_type=std_logic lab=_03_}
C {yosys_cells/dff_pn0.sym} 1440 670 0 0 {name=state_phi1_bit1 }
N 1290 690 1340 690 {}
C {devices/lab_pin.sym} 1290 690 0 0 {name=l22 sig_type=std_logic lab=clk_1}
N 1440 750 1440 770 {}
C {devices/lab_pin.sym} 1440 770 0 1 {name=l23 sig_type=std_logic lab=rst_n}
N 1540 650 1770 650 {}
C {devices/lab_wire.sym} 1600 650 0 0 {name=l24 sig_type=std_logic lab=phase_1[1]}
C {yosys_cells/dff_pn0.sym} 1870 670 0 0 {name=state_phi2_bit1 }
N 1720 690 1770 690 {}
C {devices/lab_pin.sym} 1720 690 0 0 {name=l25 sig_type=std_logic lab=clk_2}
N 1870 750 1870 770 {}
C {devices/lab_pin.sym} 1870 770 0 1 {name=l26 sig_type=std_logic lab=rst_n}
N 1970 650 2200 650 {}
C {devices/lab_pin.sym} 2200 650 0 1 {name=l27 sig_type=std_logic lab=count[1]}
T {BIT 2} 80 850 0 0 0.4 0.4 {layer=4}
L 21 65 800 2275 800 {dash=4}
C {yosys_cells/xor2.sym} 700 940 0 0 {name=_18_ }
N 590 920 640 920 {}
C {devices/lab_pin.sym} 590 920 0 0 {name=l28 sig_type=std_logic lab=count[2]}
C {yosys_cells/and2.sym} 300 960 0 0 {name=_16_ }
N 190 940 240 940 {}
C {devices/lab_pin.sym} 190 940 0 0 {name=l29 sig_type=std_logic lab=count[1]}
N 190 980 240 980 {}
C {devices/lab_pin.sym} 190 980 0 0 {name=l30 sig_type=std_logic lab=count[0]}
N 360 960 640 960 {}
C {devices/lab_wire.sym} 440 960 0 0 {name=l31 sig_type=std_logic lab=_00_[1]}
N 760 940 1010 940 {}
C {devices/lab_wire.sym} 840 940 0 0 {name=l32 sig_type=std_logic lab=_02_[2]}
T {count[2] ^ (count[1] & count[0])} 580 1030 0 0 0.27 0.27 {layer=9}
C {yosys_cells/mux2.sym} 1070 920 0 0 {name=_13_ }
N 960 900 1010 900 {}
C {devices/lab_pin.sym} 960 900 0 0 {name=l33 sig_type=std_logic lab=count[2]}
N 1070 1000 1070 1020 {}
C {devices/lab_pin.sym} 1070 1020 0 1 {name=l34 sig_type=std_logic lab=en}
N 1130 920 1340 920 {}
C {devices/lab_wire.sym} 1200 920 0 0 {name=l35 sig_type=std_logic lab=_05_}
C {yosys_cells/dff_pn0.sym} 1440 940 0 0 {name=state_phi1_bit2 }
N 1290 960 1340 960 {}
C {devices/lab_pin.sym} 1290 960 0 0 {name=l36 sig_type=std_logic lab=clk_1}
N 1440 1020 1440 1040 {}
C {devices/lab_pin.sym} 1440 1040 0 1 {name=l37 sig_type=std_logic lab=rst_n}
N 1540 920 1770 920 {}
C {devices/lab_wire.sym} 1600 920 0 0 {name=l38 sig_type=std_logic lab=phase_1[2]}
C {yosys_cells/dff_pn0.sym} 1870 940 0 0 {name=state_phi2_bit2 }
N 1720 960 1770 960 {}
C {devices/lab_pin.sym} 1720 960 0 0 {name=l39 sig_type=std_logic lab=clk_2}
N 1870 1020 1870 1040 {}
C {devices/lab_pin.sym} 1870 1040 0 1 {name=l40 sig_type=std_logic lab=rst_n}
N 1970 920 2200 920 {}
C {devices/lab_pin.sym} 2200 920 0 1 {name=l41 sig_type=std_logic lab=count[2]}
T {BIT 3} 80 1120 0 0 0.4 0.4 {layer=4}
L 21 65 1070 2275 1070 {dash=4}
C {yosys_cells/xor2.sym} 700 1210 0 0 {name=_19_ }
N 590 1190 640 1190 {}
C {devices/lab_pin.sym} 590 1190 0 0 {name=l42 sig_type=std_logic lab=count[3]}
C {yosys_cells/and2.sym} 300 1230 0 0 {name=_15_ }
N 190 1210 240 1210 {}
C {devices/lab_pin.sym} 190 1210 0 0 {name=l43 sig_type=std_logic lab=count[2]}
N 190 1250 240 1250 {}
C {devices/lab_pin.sym} 190 1250 0 0 {name=l44 sig_type=std_logic lab=_00_[1]}
N 360 1230 640 1230 {}
C {devices/lab_wire.sym} 440 1230 0 0 {name=l45 sig_type=std_logic lab=_00_[2]}
N 760 1210 1010 1210 {}
C {devices/lab_wire.sym} 840 1210 0 0 {name=l46 sig_type=std_logic lab=_02_[3]}
T {count[3] ^ (count[2] & count[1] & count[0])} 580 1300 0 0 0.27 0.27 {layer=9}
C {yosys_cells/mux2.sym} 1070 1190 0 0 {name=_14_ }
N 960 1170 1010 1170 {}
C {devices/lab_pin.sym} 960 1170 0 0 {name=l47 sig_type=std_logic lab=count[3]}
N 1070 1270 1070 1290 {}
C {devices/lab_pin.sym} 1070 1290 0 1 {name=l48 sig_type=std_logic lab=en}
N 1130 1190 1340 1190 {}
C {devices/lab_wire.sym} 1200 1190 0 0 {name=l49 sig_type=std_logic lab=_06_}
C {yosys_cells/dff_pn0.sym} 1440 1210 0 0 {name=state_phi1_bit3 }
N 1290 1230 1340 1230 {}
C {devices/lab_pin.sym} 1290 1230 0 0 {name=l50 sig_type=std_logic lab=clk_1}
N 1440 1290 1440 1310 {}
C {devices/lab_pin.sym} 1440 1310 0 1 {name=l51 sig_type=std_logic lab=rst_n}
N 1540 1190 1770 1190 {}
C {devices/lab_wire.sym} 1600 1190 0 0 {name=l52 sig_type=std_logic lab=phase_1[3]}
C {yosys_cells/dff_pn0.sym} 1870 1210 0 0 {name=state_phi2_bit3 }
N 1720 1230 1770 1230 {}
C {devices/lab_pin.sym} 1720 1230 0 0 {name=l53 sig_type=std_logic lab=clk_2}
N 1870 1290 1870 1310 {}
C {devices/lab_pin.sym} 1870 1310 0 1 {name=l54 sig_type=std_logic lab=rst_n}
N 1970 1190 2200 1190 {}
C {devices/lab_pin.sym} 2200 1190 0 1 {name=l55 sig_type=std_logic lab=count[3]}
T {CLOCKING: rising edge clk_1 captures next count; rising edge clk_2 updates count and feedback.} 80 1405 0 0 0.34 0.34 {layer=4}
T {RESET: rst_n = 0 asynchronously clears all 8 DFFs.  ENABLE: en = 0 holds; en = 1 increments modulo 16.} 80 1440 0 0 0.34 0.34 {layer=4}
T {Connected labels share a net. count[n] = count_o[n]; unused assign aliases add no gates. No PDK required.} 80 1475 0 0 0.32 0.32 {layer=9}
