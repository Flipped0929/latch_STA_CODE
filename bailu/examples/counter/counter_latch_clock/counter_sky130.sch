v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 4 40 20 2310 1910 {dash=4 fill=false}
T {COUNTER / SKY130 HD / RETIMED} 80 50 0 0 0.75 0.75 {layer=4}
T {4-bit modulo-16 counter  |  Bit 2 and bit 3 XORs moved after phase-1 latches} 80 105 0 0 0.38 0.38 {layer=4}
T {Source: counter_sky130.v   /   module counter   /   18 standard-cell instances} 80 145 0 0 0.3 0.3 {layer=5}
L 4 80 185 2270 185 {}
T {CLOCK AND ENABLE} 100 210 0 0 0.4 0.4 {layer=4}
C {symbols/sky130_stdcells/dlxtp_1.sym} 570 280 0 0 {name=enable_phi1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {devices/ipin.sym} 390 270 0 0 {name=p_en lab=en}
N 390 270 480 270 {lab=en}
C {devices/ipin.sym} 390 330 0 0 {name=p_clk_1 lab=clk_1}
N 390 330 440 330 {lab=clk_1}
N 440 290 440 330 {lab=clk_1}
N 440 290 480 290 {lab=clk_1}
N 660 270 760 270 {lab=en_phi1}
C {devices/lab_wire.sym} 705 270 0 0 {name=l1 lab=en_phi1}
N 760 270 760 310 {lab=en_phi1}
N 760 310 880 310 {lab=en_phi1}
C {symbols/sky130_stdcells/and2_1.sym} 940 290 0 0 {name=gate_phi2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
C {devices/ipin.sym} 830 270 0 0 {name=p_clk_2 lab=clk_2}
N 830 270 880 270 {lab=clk_2}
N 1000 290 1190 290 {lab=clk_2_gated}
C {devices/lab_pin.sym} 1190 290 0 1 {name=l2 lab=clk_2_gated}
T {en captured while clk_1 = 1} 450 355 0 0 0.28 0.28 {layer=4}
T {clk_2_gated = clk_2 & en_phi1} 885 355 0 0 0.28 0.28 {layer=4}
T {MODULE PORTS} 1790 210 0 0 0.38 0.38 {layer=4}
N 1840 260 1910 260 {lab=count[3:0]}
C {devices/opin.sym} 1910 260 0 0 {name=p_count lab=count[3:0]}
C {devices/ipin.sym} 1900 320 0 0 {name=p_rst_n lab=rst_n}
N 1900 320 1970 320 {lab=rst_n}
T {asynchronous reset, active low} 1790 355 0 0 0.28 0.28 {layer=4}
L 4 80 400 2270 400 {}
T {01  NEXT / CARRY} 160 430 0 0 0.42 0.42 {layer=4}
T {02  PHASE 1} 755 430 0 0 0.42 0.42 {layer=4}
T {03  RETIMED XOR} 1270 430 0 0 0.42 0.42 {layer=4}
T {04  PHASE 2} 1750 430 0 0 0.42 0.42 {layer=4}
T {from published count} 160 470 0 0 0.29 0.29 {layer=4}
T {transparent while clk_1 = 1} 755 470 0 0 0.29 0.29 {layer=4}
T {bits 2 and 3 only} 1270 470 0 0 0.29 0.29 {layer=4}
T {transparent while clk_2_gated = 1} 1750 470 0 0 0.29 0.29 {layer=4}
T {BIT 0} 100 525 0 0 0.37 0.37 {layer=4}
C {symbols/sky130_stdcells/inv_1.sym} 400 580 0 0 {name=increment_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 280 580 360 580 {lab=count[0]}
C {devices/lab_pin.sym} 280 580 0 0 {name=l3 lab=count[0]}
N 440 580 810 580 {lab=next_count[0]}
T {next_count[0] = ~count[0]} 180 680 0 0 0.28 0.28 {layer=5}
C {devices/lab_wire.sym} 650 580 0 0 {name=l4 lab=next_count[0]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 900 600 0 0 {name=state_phi1_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 750 600 810 600 {lab=clk_1}
C {devices/lab_pin.sym} 750 600 0 0 {name=l5 lab=clk_1}
N 750 620 810 620 {lab=rst_n}
C {devices/lab_pin.sym} 750 620 0 0 {name=l6 lab=rst_n}
N 990 580 1810 580 {lab=phase_1[0]}
C {devices/lab_wire.sym} 1400 580 0 0 {name=l7 lab=phase_1[0]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1900 600 0 0 {name=state_phi2_bit0 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 1750 600 1810 600 {lab=clk_2_gated}
C {devices/lab_pin.sym} 1750 600 0 0 {name=l8 lab=clk_2_gated}
N 1750 620 1810 620 {lab=rst_n}
C {devices/lab_pin.sym} 1750 620 0 0 {name=l9 lab=rst_n}
N 1990 580 2180 580 {lab=count[0]}
C {devices/lab_pin.sym} 2180 580 0 1 {name=l10 lab=count[0]}
T {count_o[0]} 2040 620 0 0 0.26 0.26 {layer=5}
L 5 95 740 2260 740 {dash=6}
T {BIT 1} 100 755 0 0 0.37 0.37 {layer=4}
C {symbols/sky130_stdcells/xor2_1.sym} 400 810 0 0 {name=increment_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 280 790 340 790 {lab=count[1]}
C {devices/lab_pin.sym} 280 790 0 0 {name=l11 lab=count[1]}
N 280 830 340 830 {lab=count[0]}
C {devices/lab_pin.sym} 280 830 0 0 {name=l12 lab=count[0]}
N 460 810 810 810 {lab=next_count[1]}
T {next_count[1] = count[1] ^ count[0]} 180 910 0 0 0.28 0.28 {layer=5}
C {devices/lab_wire.sym} 650 810 0 0 {name=l13 lab=next_count[1]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 900 830 0 0 {name=state_phi1_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 750 830 810 830 {lab=clk_1}
C {devices/lab_pin.sym} 750 830 0 0 {name=l14 lab=clk_1}
N 750 850 810 850 {lab=rst_n}
C {devices/lab_pin.sym} 750 850 0 0 {name=l15 lab=rst_n}
N 990 810 1810 810 {lab=phase_1[1]}
C {devices/lab_wire.sym} 1400 810 0 0 {name=l16 lab=phase_1[1]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1900 830 0 0 {name=state_phi2_bit1 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 1750 830 1810 830 {lab=clk_2_gated}
C {devices/lab_pin.sym} 1750 830 0 0 {name=l17 lab=clk_2_gated}
N 1750 850 1810 850 {lab=rst_n}
C {devices/lab_pin.sym} 1750 850 0 0 {name=l18 lab=rst_n}
N 1990 810 2180 810 {lab=count[1]}
C {devices/lab_pin.sym} 2180 810 0 1 {name=l19 lab=count[1]}
T {count_o[1]} 2040 850 0 0 0.26 0.26 {layer=5}
L 5 95 970 2260 970 {dash=6}
T {BIT 2 / RETIMED} 100 1015 0 0 0.37 0.37 {layer=4}
T {data operand} 700 1005 0 0 0.27 0.27 {layer=5}
N 690 1070 810 1070 {lab=count[2]}
C {devices/lab_pin.sym} 690 1070 0 0 {name=l20 lab=count[2]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 900 1090 0 0 {name=state_phi1_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 750 1090 810 1090 {lab=clk_1}
C {devices/lab_pin.sym} 750 1090 0 0 {name=l21 lab=clk_1}
N 750 1110 810 1110 {lab=rst_n}
C {devices/lab_pin.sym} 750 1110 0 0 {name=l22 lab=rst_n}
N 990 1070 1160 1070 {lab=phase_1[2]}
C {devices/lab_wire.sym} 1080 1070 0 0 {name=l23 lab=phase_1[2]}
N 1160 1070 1160 1140 {lab=phase_1[2]}
N 1160 1140 1340 1140 {lab=phase_1[2]}
T {carry operand} 700 1170 0 0 0.27 0.27 {layer=5}
C {symbols/sky130_stdcells/and2_1.sym} 400 1250 0 0 {name=carry_into_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 280 1230 340 1230 {lab=count[1]}
C {devices/lab_pin.sym} 280 1230 0 0 {name=l24 lab=count[1]}
N 280 1270 340 1270 {lab=count[0]}
C {devices/lab_pin.sym} 280 1270 0 0 {name=l25 lab=count[0]}
N 460 1250 810 1250 {lab=carry_bit2}
C {devices/lab_wire.sym} 650 1250 0 0 {name=l26 lab=carry_bit2}
C {symbols/sky130_stdcells/dlrtp_1.sym} 900 1270 0 0 {name=state_phi1_carry_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 750 1270 810 1270 {lab=clk_1}
C {devices/lab_pin.sym} 750 1270 0 0 {name=l27 lab=clk_1}
N 750 1290 810 1290 {lab=rst_n}
C {devices/lab_pin.sym} 750 1290 0 0 {name=l28 lab=rst_n}
N 990 1250 1250 1250 {lab=phase_1_carry_bit2}
C {devices/lab_wire.sym} 1210 1250 0 0 {name=l29 lab=phase_1_carry_bit2}
N 1250 1180 1250 1250 {lab=phase_1_carry_bit2}
N 1250 1180 1340 1180 {lab=phase_1_carry_bit2}
C {symbols/sky130_stdcells/xor2_1.sym} 1400 1160 0 0 {name=increment_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 1460 1160 1810 1160 {lab=next_count[2]}
C {devices/lab_wire.sym} 1640 1160 0 0 {name=l30 lab=next_count[2]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1900 1180 0 0 {name=state_phi2_bit2 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 1750 1180 1810 1180 {lab=clk_2_gated}
C {devices/lab_pin.sym} 1750 1180 0 0 {name=l31 lab=clk_2_gated}
N 1750 1200 1810 1200 {lab=rst_n}
C {devices/lab_pin.sym} 1750 1200 0 0 {name=l32 lab=rst_n}
N 1990 1160 2180 1160 {lab=count[2]}
C {devices/lab_pin.sym} 2180 1160 0 1 {name=l33 lab=count[2]}
T {count_o[2]} 2040 1200 0 0 0.26 0.26 {layer=5}
T {carry_bit2 also feeds carry_into_bit3 (same net label)} 180 1370 0 0 0.28 0.28 {layer=5}
L 5 95 1420 2260 1420 {dash=6}
T {BIT 3 / RETIMED} 100 1445 0 0 0.37 0.37 {layer=4}
T {data operand} 700 1435 0 0 0.27 0.27 {layer=5}
N 690 1500 810 1500 {lab=count[3]}
C {devices/lab_pin.sym} 690 1500 0 0 {name=l34 lab=count[3]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 900 1520 0 0 {name=state_phi1_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 750 1520 810 1520 {lab=clk_1}
C {devices/lab_pin.sym} 750 1520 0 0 {name=l35 lab=clk_1}
N 750 1540 810 1540 {lab=rst_n}
C {devices/lab_pin.sym} 750 1540 0 0 {name=l36 lab=rst_n}
N 990 1500 1160 1500 {lab=phase_1[3]}
C {devices/lab_wire.sym} 1080 1500 0 0 {name=l37 lab=phase_1[3]}
N 1160 1500 1160 1570 {lab=phase_1[3]}
N 1160 1570 1340 1570 {lab=phase_1[3]}
T {carry operand} 700 1600 0 0 0.27 0.27 {layer=5}
C {symbols/sky130_stdcells/and2_1.sym} 400 1680 0 0 {name=carry_into_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 280 1660 340 1660 {lab=count[2]}
C {devices/lab_pin.sym} 280 1660 0 0 {name=l38 lab=count[2]}
N 280 1700 340 1700 {lab=carry_bit2}
C {devices/lab_pin.sym} 280 1700 0 0 {name=l39 lab=carry_bit2}
N 460 1680 810 1680 {lab=carry_bit3}
C {devices/lab_wire.sym} 650 1680 0 0 {name=l40 lab=carry_bit3}
C {symbols/sky130_stdcells/dlrtp_1.sym} 900 1700 0 0 {name=state_phi1_carry_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 750 1700 810 1700 {lab=clk_1}
C {devices/lab_pin.sym} 750 1700 0 0 {name=l41 lab=clk_1}
N 750 1720 810 1720 {lab=rst_n}
C {devices/lab_pin.sym} 750 1720 0 0 {name=l42 lab=rst_n}
N 990 1680 1250 1680 {lab=phase_1_carry_bit3}
C {devices/lab_wire.sym} 1210 1680 0 0 {name=l43 lab=phase_1_carry_bit3}
N 1250 1610 1250 1680 {lab=phase_1_carry_bit3}
N 1250 1610 1340 1610 {lab=phase_1_carry_bit3}
C {symbols/sky130_stdcells/xor2_1.sym} 1400 1590 0 0 {name=increment_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 1460 1590 1810 1590 {lab=next_count[3]}
C {devices/lab_wire.sym} 1640 1590 0 0 {name=l44 lab=next_count[3]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1900 1610 0 0 {name=state_phi2_bit3 VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}
N 1750 1610 1810 1610 {lab=clk_2_gated}
C {devices/lab_pin.sym} 1750 1610 0 0 {name=l45 lab=clk_2_gated}
N 1750 1630 1810 1630 {lab=rst_n}
C {devices/lab_pin.sym} 1750 1630 0 0 {name=l46 lab=rst_n}
N 1990 1590 2180 1590 {lab=count[3]}
C {devices/lab_pin.sym} 2180 1590 0 1 {name=l47 lab=count[3]}
T {count_o[3]} 2040 1630 0 0 0.26 0.26 {layer=5}
L 4 80 1800 2270 1800 {}
T {CONNECTIVITY} 100 1825 0 0 0.31 0.31 {layer=4}
T {Matching labels are connected.  count_o[3:0] = count[3:0].  clk_1 and clk_2 must be non-overlapping, active-high phases.} 380 1825 0 0 0.28 0.28 {layer=4}
T {CELL POWER / RESET} 100 1865 0 0 0.31 0.31 {layer=4}
T {VPWR / VPB = VPWR; VGND / VNB = VGND.  rst_n connects directly to all 10 resettable latches, including both carry latches.} 430 1865 0 0 0.28 0.28 {layer=4}
