v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 4 40 20 3400 2680 {dash=4 fill=false}
T {COUNTER  /  POST-ROUTE  /  SKY130 HD} 90 60 0 0 0.75 0.75 {layer=4}
T {Two-phase gated counter | Actual cell sizes and CTS connections | 23 signal-cell instances} 90 120 0 0 0.38 0.38 {layer=4}
T {Source: openroad/results/counter_routed.v   |   SHA-256: 5b40e31a101caa0d} 90 163 0 0 0.28 0.28 {layer=5}
L 4 90 205 3340 205 {}
T {01  PHI1 CLOCK TREE / TWO BUFFER LEVELS} 140 240 0 0 0.4 0.4 {layer=4}
T {02  ENABLE + PHI2 / ONE BUFFER LEVEL} 1970 240 0 0 0.4 0.4 {layer=4}
C {symbols/sky130_stdcells/clkbuf_2.sym} 390 500 0 0 {name=clkbuf_0_clk_1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
C {devices/ipin.sym} 180 500 0 0 {name=l1 lab=clk_1}
N 180 500 350 500 {lab=clk_1}
C {symbols/sky130_stdcells/clkbuf_2.sym} 910 370 0 0 {name=clkbuf_1_0__f_clk_1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
C {symbols/sky130_stdcells/clkbuf_2.sym} 910 650 0 0 {name=clkbuf_1_1__f_clk_1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 430 500 650 500 {lab=clknet_0_clk_1}
N 650 500 650 370 {lab=clknet_0_clk_1}
N 650 370 870 370 {lab=clknet_0_clk_1}
C {devices/lab_wire.sym} 620 500 0 0 {name=l2 lab=clknet_0_clk_1}
N 430 500 650 500 {lab=clknet_0_clk_1}
N 650 500 650 650 {lab=clknet_0_clk_1}
N 650 650 870 650 {lab=clknet_0_clk_1}
N 950 370 1760 370 {lab=clknet_1_0__leaf_clk_1}
C {devices/lab_wire.sym} 1190 370 0 0 {name=l3 lab=clknet_1_0__leaf_clk_1}
N 950 650 1760 650 {lab=clknet_1_1__leaf_clk_1}
C {devices/lab_wire.sym} 1190 650 0 0 {name=l4 lab=clknet_1_1__leaf_clk_1}
T {Drives: state_phi1_bit0, bit2, bit3,} 1130 420 0 0 0.27 0.27 {layer=5}
T {state_phi1_carry_bit2 and carry_bit3} 1130 455 0 0 0.27 0.27 {layer=5}
T {Drives: state_phi1_bit1, enable_phi1, clkload0} 1110 600 0 0 0.27 0.27 {layer=5}
C {symbols/sky130_stdcells/clkinv_2.sym} 1580 770 0 0 {name=clkload0 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 950 650 1460 650 {lab=clknet_1_1__leaf_clk_1}
N 1460 650 1460 770 {lab=clknet_1_1__leaf_clk_1}
N 1460 770 1540 770 {lab=clknet_1_1__leaf_clk_1}
N 1620 770 1720 770 {}
C {devices/noconn.sym} 1720 770 0 0 {name=nc_clkload0}
T {CTS load balancing; output intentionally open} 1110 840 0 0 0.26 0.26 {layer=5}
C {symbols/sky130_stdcells/dlxtp_1.sym} 2230 350 0 0 {name=enable_phi1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
C {devices/ipin.sym} 2030 340 0 0 {name=l5 lab=en}
N 2030 340 2140 340 {lab=en}
N 2110 360 2140 360 {lab=clknet_1_1__leaf_clk_1}
C {devices/lab_pin.sym} 2110 360 0 0 {name=l6 lab=clknet_1_1__leaf_clk_1}
C {symbols/sky130_stdcells/and2_1.sym} 2520 470 0 0 {name=gate_phi2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 2320 340 2410 340 {lab=en_phi1}
N 2410 340 2410 490 {lab=en_phi1}
N 2410 490 2460 490 {lab=en_phi1}
C {devices/lab_wire.sym} 2400 340 0 0 {name=l7 lab=en_phi1}
C {devices/ipin.sym} 2300 450 0 0 {name=l8 lab=clk_2}
N 2300 450 2460 450 {lab=clk_2}
C {symbols/sky130_stdcells/clkbuf_2.sym} 2940 470 0 0 {name=clkbuf_phi2_single1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 2580 470 2900 470 {lab=clknet_phi2_leaf1}
C {devices/lab_wire.sym} 2830 470 0 0 {name=l9 lab=clknet_phi2_leaf1}
N 2980 470 3200 470 {lab=clk_2_gated}
C {devices/lab_wire.sym} 3180 470 0 0 {name=l10 lab=clk_2_gated}
T {Drives all four state_phi2_bit[0..3]/GATE pins} 2480 565 0 0 0.28 0.28 {layer=5}
T {Enable is latched by the actual phi1 leaf clock} 1990 650 0 0 0.28 0.28 {layer=5}
T {MODULE INTERFACE} 2030 735 0 0 0.34 0.34 {layer=4}
C {devices/ipin.sym} 2150 800 0 0 {name=l11 lab=rst_n}
N 2150 800 2310 800 {lab=rst_n}
C {devices/lab_pin.sym} 2310 800 0 1 {name=l12 lab=rst_n}
N 2780 800 2960 800 {lab=count[3:0]}
C {devices/opin.sym} 2960 800 0 0 {name=l13 lab=count[3:0]}
T {Active-low asynchronous reset} 2030 850 0 0 0.26 0.26 {layer=5}
T {count_o[i] is the same net as count[i]} 2700 850 0 0 0.26 0.26 {layer=5}
L 4 90 920 3340 920 {}
T {03  NEXT / CARRY} 160 960 0 0 0.4 0.4 {layer=4}
T {04  PHI1 LATCHES} 1050 960 0 0 0.4 0.4 {layer=4}
T {05  RETIMED XOR} 1850 960 0 0 0.4 0.4 {layer=4}
T {06  OUTPUT LATCHES} 2690 960 0 0 0.4 0.4 {layer=4}
T {Feedback from published count} 160 1005 0 0 0.28 0.28 {layer=5}
T {Actual CTS leaf nets shown at GATE} 1030 1005 0 0 0.28 0.28 {layer=5}
T {Bits 2 and 3} 1850 1005 0 0 0.28 0.28 {layer=5}
T {Preserved strengths: 4 / 4 / 2 / 2} 2640 1005 0 0 0.28 0.28 {layer=5}
T {BIT 0} 110 1080 0 0 0.38 0.38 {layer=4}
C {symbols/sky130_stdcells/inv_1.sym} 400 1180 0 0 {name=increment_bit0 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 250 1180 360 1180 {lab=count[0]}
C {devices/lab_pin.sym} 250 1180 0 0 {name=l14 lab=count[0]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1200 1200 0 0 {name=state_phi1_bit0 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 440 1180 1110 1180 {lab=next_count[0]}
C {devices/lab_wire.sym} 700 1180 0 0 {name=l15 lab=next_count[0]}
N 930 1200 1110 1200 {lab=clknet_1_0__leaf_clk_1}
C {devices/lab_pin.sym} 930 1200 0 0 {name=l16 lab=clknet_1_0__leaf_clk_1}
N 1010 1220 1110 1220 {lab=rst_n}
C {devices/lab_pin.sym} 1010 1220 0 0 {name=l17 lab=rst_n}
C {symbols/sky130_stdcells/dlrtp_4.sym} 2800 1200 0 0 {name=state_phi2_bit0 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 1290 1180 2710 1180 {lab=phase_1[0]}
C {devices/lab_wire.sym} 1940 1180 0 0 {name=l18 lab=phase_1[0]}
N 2530 1200 2710 1200 {lab=clk_2_gated}
C {devices/lab_pin.sym} 2530 1200 0 0 {name=l19 lab=clk_2_gated}
N 2600 1220 2710 1220 {lab=rst_n}
C {devices/lab_pin.sym} 2600 1220 0 0 {name=l20 lab=rst_n}
N 3170 1180 2890 1180 {lab=count[0]}
C {devices/lab_pin.sym} 3170 1180 0 1 {name=l21 lab=count[0]}
T {count_o[0]} 3040 1235 0 0 0.25 0.25 {layer=5}
L 5 95 1335 3330 1335 {dash=6}
T {BIT 1} 110 1360 0 0 0.38 0.38 {layer=4}
C {symbols/sky130_stdcells/xor2_1.sym} 400 1460 0 0 {name=increment_bit1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 250 1440 340 1440 {lab=count[1]}
C {devices/lab_pin.sym} 250 1440 0 0 {name=l22 lab=count[1]}
N 250 1480 340 1480 {lab=count[0]}
C {devices/lab_pin.sym} 250 1480 0 0 {name=l23 lab=count[0]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1200 1480 0 0 {name=state_phi1_bit1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 460 1460 1110 1460 {lab=next_count[1]}
C {devices/lab_wire.sym} 700 1460 0 0 {name=l24 lab=next_count[1]}
N 930 1480 1110 1480 {lab=clknet_1_1__leaf_clk_1}
C {devices/lab_pin.sym} 930 1480 0 0 {name=l25 lab=clknet_1_1__leaf_clk_1}
N 1010 1500 1110 1500 {lab=rst_n}
C {devices/lab_pin.sym} 1010 1500 0 0 {name=l26 lab=rst_n}
C {symbols/sky130_stdcells/dlrtp_4.sym} 2800 1480 0 0 {name=state_phi2_bit1 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 1290 1460 2710 1460 {lab=phase_1[1]}
C {devices/lab_wire.sym} 1940 1460 0 0 {name=l27 lab=phase_1[1]}
N 2530 1480 2710 1480 {lab=clk_2_gated}
C {devices/lab_pin.sym} 2530 1480 0 0 {name=l28 lab=clk_2_gated}
N 2600 1500 2710 1500 {lab=rst_n}
C {devices/lab_pin.sym} 2600 1500 0 0 {name=l29 lab=rst_n}
N 3170 1460 2890 1460 {lab=count[1]}
C {devices/lab_pin.sym} 3170 1460 0 1 {name=l30 lab=count[1]}
T {count_o[1]} 3040 1515 0 0 0.25 0.25 {layer=5}
L 5 95 1615 3330 1615 {dash=6}
T {BIT 2} 110 1670 0 0 0.38 0.38 {layer=4}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1200 1770 0 0 {name=state_phi1_bit2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 930 1750 1110 1750 {lab=count[2]}
C {devices/lab_pin.sym} 930 1750 0 0 {name=l31 lab=count[2]}
N 930 1770 1110 1770 {lab=clknet_1_0__leaf_clk_1}
C {devices/lab_pin.sym} 930 1770 0 0 {name=l32 lab=clknet_1_0__leaf_clk_1}
N 1010 1790 1110 1790 {lab=rst_n}
C {devices/lab_pin.sym} 1010 1790 0 0 {name=l33 lab=rst_n}
C {symbols/sky130_stdcells/and2_1.sym} 400 1920 0 0 {name=carry_into_bit2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 250 1900 340 1900 {lab=count[1]}
C {devices/lab_pin.sym} 250 1900 0 0 {name=l34 lab=count[1]}
N 250 1940 340 1940 {lab=count[0]}
C {devices/lab_pin.sym} 250 1940 0 0 {name=l35 lab=count[0]}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1200 1940 0 0 {name=state_phi1_carry_bit2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 460 1920 1110 1920 {lab=carry_bit2}
C {devices/lab_wire.sym} 700 1920 0 0 {name=l36 lab=carry_bit2}
N 930 1940 1110 1940 {lab=clknet_1_0__leaf_clk_1}
C {devices/lab_pin.sym} 930 1940 0 0 {name=l37 lab=clknet_1_0__leaf_clk_1}
N 1010 1960 1110 1960 {lab=rst_n}
C {devices/lab_pin.sym} 1010 1960 0 0 {name=l38 lab=rst_n}
C {symbols/sky130_stdcells/xor2_1.sym} 2030 1830 0 0 {name=increment_bit2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 1290 1750 1810 1750 {lab=phase_1[2]}
N 1810 1750 1810 1810 {lab=phase_1[2]}
N 1810 1810 1970 1810 {lab=phase_1[2]}
C {devices/lab_wire.sym} 1430 1750 0 0 {name=l39 lab=phase_1[2]}
N 1290 1920 1810 1920 {lab=phase_1_carry_bit2}
N 1810 1920 1810 1850 {lab=phase_1_carry_bit2}
N 1810 1850 1970 1850 {lab=phase_1_carry_bit2}
C {devices/lab_wire.sym} 1420 1920 0 0 {name=l40 lab=phase_1_carry_bit2}
C {symbols/sky130_stdcells/dlrtp_2.sym} 2800 1850 0 0 {name=state_phi2_bit2 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 2090 1830 2710 1830 {lab=next_count[2]}
C {devices/lab_wire.sym} 2300 1830 0 0 {name=l41 lab=next_count[2]}
N 2530 1850 2710 1850 {lab=clk_2_gated}
C {devices/lab_pin.sym} 2530 1850 0 0 {name=l42 lab=clk_2_gated}
N 2600 1870 2710 1870 {lab=rst_n}
C {devices/lab_pin.sym} 2600 1870 0 0 {name=l43 lab=rst_n}
N 3170 1830 2890 1830 {lab=count[2]}
C {devices/lab_pin.sym} 3170 1830 0 1 {name=l44 lab=count[2]}
T {count_o[2]} 3040 1885 0 0 0.25 0.25 {layer=5}
L 5 95 2055 3330 2055 {dash=6}
T {BIT 3} 110 2090 0 0 0.38 0.38 {layer=4}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1200 2190 0 0 {name=state_phi1_bit3 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 930 2170 1110 2170 {lab=count[3]}
C {devices/lab_pin.sym} 930 2170 0 0 {name=l45 lab=count[3]}
N 930 2190 1110 2190 {lab=clknet_1_0__leaf_clk_1}
C {devices/lab_pin.sym} 930 2190 0 0 {name=l46 lab=clknet_1_0__leaf_clk_1}
N 1010 2210 1110 2210 {lab=rst_n}
C {devices/lab_pin.sym} 1010 2210 0 0 {name=l47 lab=rst_n}
C {symbols/sky130_stdcells/and2_1.sym} 400 2340 0 0 {name=carry_into_bit3 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 250 2320 340 2320 {lab=count[2]}
C {devices/lab_pin.sym} 250 2320 0 0 {name=l48 lab=count[2]}
N 250 2360 340 2360 {lab=carry_bit2}
C {devices/lab_pin.sym} 250 2360 0 0 {name=l49 lab=carry_bit2}
C {symbols/sky130_stdcells/dlrtp_1.sym} 1200 2360 0 0 {name=state_phi1_carry_bit3 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 460 2340 1110 2340 {lab=carry_bit3}
C {devices/lab_wire.sym} 700 2340 0 0 {name=l50 lab=carry_bit3}
N 930 2360 1110 2360 {lab=clknet_1_0__leaf_clk_1}
C {devices/lab_pin.sym} 930 2360 0 0 {name=l51 lab=clknet_1_0__leaf_clk_1}
N 1010 2380 1110 2380 {lab=rst_n}
C {devices/lab_pin.sym} 1010 2380 0 0 {name=l52 lab=rst_n}
C {symbols/sky130_stdcells/xor2_1.sym} 2030 2250 0 0 {name=increment_bit3 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 1290 2170 1810 2170 {lab=phase_1[3]}
N 1810 2170 1810 2230 {lab=phase_1[3]}
N 1810 2230 1970 2230 {lab=phase_1[3]}
C {devices/lab_wire.sym} 1430 2170 0 0 {name=l53 lab=phase_1[3]}
N 1290 2340 1810 2340 {lab=phase_1_carry_bit3}
N 1810 2340 1810 2270 {lab=phase_1_carry_bit3}
N 1810 2270 1970 2270 {lab=phase_1_carry_bit3}
C {devices/lab_wire.sym} 1420 2340 0 0 {name=l54 lab=phase_1_carry_bit3}
C {symbols/sky130_stdcells/dlrtp_2.sym} 2800 2270 0 0 {name=state_phi2_bit3 VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}
N 2090 2250 2710 2250 {lab=next_count[3]}
C {devices/lab_wire.sym} 2300 2250 0 0 {name=l55 lab=next_count[3]}
N 2530 2270 2710 2270 {lab=clk_2_gated}
C {devices/lab_pin.sym} 2530 2270 0 0 {name=l56 lab=clk_2_gated}
N 2600 2290 2710 2290 {lab=rst_n}
C {devices/lab_pin.sym} 2600 2290 0 0 {name=l57 lab=rst_n}
N 3170 2250 2890 2250 {lab=count[3]}
C {devices/lab_pin.sym} 3170 2250 0 1 {name=l58 lab=count[3]}
T {count_o[3]} 3040 2305 0 0 0.25 0.25 {layer=5}
L 5 95 2475 3330 2475 {dash=6}
T {READING THE SHEET} 110 2530 0 0 0.34 0.34 {layer=4}
T {Equal net labels are electrically connected. count_o[3:0] aliases count[3:0].} 110 2575 0 0 0.28 0.28 {layer=5}
T {Power pins: VPWR/VPB -> VDD; VGND/VNB -> VSS. Signal view omits filler/tap cells.} 110 2610 0 0 0.28 0.28 {layer=5}
T {Extracted wire R/C remains in openroad/results/counter.spef; this sheet shows the routed gate-level connectivity.} 110 2645 0 0 0.28 0.28 {layer=5}
