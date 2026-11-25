v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {4-BIT COUNTER | MAPPED GATE SCHEMATIC} 70 25 0 0 0.6 0.6 {layer=4}
T {Source: counter_mapped.v  |  14 Yosys generic cells  |  four bit slices} 70 80 0 0 0.32 0.32 {layer=4}
T {posedge clk: en = 1 -> count + 1; en = 0 -> hold.   rst_n = 0: asynchronous clear.} 70 120 0 0 0.3 0.3 {layer=4}
C {devices/ipin.sym} 230 190 0 0 {name=p1 lab=clk}
N 230 190 300 190 {}
C {devices/ipin.sym} 540 190 0 0 {name=p2 lab=rst_n}
N 540 190 610 190 {}
C {devices/ipin.sym} 850 190 0 0 {name=p3 lab=en}
N 850 190 920 190 {}
C {devices/opin.sym} 1250 190 0 0 {name=p4 lab=count[3:0]}
N 1180 190 1250 190 {}
T {CARRY / INCREMENT} 220 245 0 0 0.28 0.28 {layer=4}
T {SUM BIT} 660 245 0 0 0.28 0.28 {layer=4}
T {ENABLE / HOLD} 1010 245 0 0 0.28 0.28 {layer=4}
T {STATE / OUTPUT} 1360 245 0 0 0.28 0.28 {layer=4}
T {BIT 0} 70 280 0 0 0.36 0.36 {layer=4}
C {symbols/not.sym} 730 390 0 0 {name=U20}
N 590 390 660 390 {}
C {devices/lab_pin.sym} 590 390 0 0 {name=p5 lab=count[0]}
C {symbols/mux2.sym} 1070 390 0 0 {name=U12}
N 800 390 880 390 {}
N 880 390 880 420 {}
N 880 420 1000 420 {}
C {devices/lab_wire.sym} 905 420 0 0 {name=p6 lab=_01_[0]}
N 1070 470 1070 500 {}
C {devices/lab_pin.sym} 1070 500 0 1 {name=p7 lab=en}
N 1140 390 1340 390 {}
C {devices/lab_wire.sym} 1210 390 0 0 {name=p8 lab=_04_}
C {symbols/dff_pn0.sym} 1420 390 0 0 {name=U7}
N 1340 350 1280 350 {}
C {devices/lab_pin.sym} 1280 350 0 0 {name=p9 lab=clk}
N 1340 430 1280 430 {}
C {devices/lab_pin.sym} 1280 430 0 0 {name=p10 lab=rst_n}
N 1500 390 1560 390 {}
N 1560 390 1670 390 {}
C {devices/lab_pin.sym} 1670 390 0 1 {name=p11 lab=count[0]}
N 1560 390 1560 280 {}
N 960 280 1560 280 {}
N 960 280 960 360 {}
N 960 360 1000 360 {}
L 4 70 540 1810 540 {dash=4}
T {BIT 1} 70 570 0 0 0.36 0.36 {layer=4}
C {symbols/xor2.sym} 730 680 0 0 {name=U17}
N 590 660 660 660 {}
C {devices/lab_pin.sym} 590 660 0 0 {name=p12 lab=count[1]}
N 590 700 660 700 {}
C {devices/lab_pin.sym} 590 700 0 0 {name=p13 lab=count[0]}
C {symbols/mux2.sym} 1070 680 0 0 {name=U11}
N 800 680 880 680 {}
N 880 680 880 710 {}
N 880 710 1000 710 {}
C {devices/lab_wire.sym} 905 710 0 0 {name=p14 lab=_02_[1]}
N 1070 760 1070 790 {}
C {devices/lab_pin.sym} 1070 790 0 1 {name=p15 lab=en}
N 1140 680 1340 680 {}
C {devices/lab_wire.sym} 1210 680 0 0 {name=p16 lab=_03_}
C {symbols/dff_pn0.sym} 1420 680 0 0 {name=U8}
N 1340 640 1280 640 {}
C {devices/lab_pin.sym} 1280 640 0 0 {name=p17 lab=clk}
N 1340 720 1280 720 {}
C {devices/lab_pin.sym} 1280 720 0 0 {name=p18 lab=rst_n}
N 1500 680 1560 680 {}
N 1560 680 1670 680 {}
C {devices/lab_pin.sym} 1670 680 0 1 {name=p19 lab=count[1]}
N 1560 680 1560 570 {}
N 960 570 1560 570 {}
N 960 570 960 650 {}
N 960 650 1000 650 {}
L 4 70 830 1810 830 {dash=4}
T {BIT 2} 70 860 0 0 0.36 0.36 {layer=4}
C {symbols/xor2.sym} 730 970 0 0 {name=U18}
N 590 950 660 950 {}
C {devices/lab_pin.sym} 590 950 0 0 {name=p20 lab=count[2]}
C {symbols/and2.sym} 380 990 0 0 {name=U16}
N 240 970 310 970 {}
C {devices/lab_pin.sym} 240 970 0 0 {name=p21 lab=count[1]}
N 240 1010 310 1010 {}
C {devices/lab_pin.sym} 240 1010 0 0 {name=p22 lab=count[0]}
N 450 990 660 990 {}
C {devices/lab_wire.sym} 500 990 0 0 {name=p23 lab=_00_[1]}
C {symbols/mux2.sym} 1070 970 0 0 {name=U13}
N 800 970 880 970 {}
N 880 970 880 1000 {}
N 880 1000 1000 1000 {}
C {devices/lab_wire.sym} 905 1000 0 0 {name=p24 lab=_02_[2]}
N 1070 1050 1070 1080 {}
C {devices/lab_pin.sym} 1070 1080 0 1 {name=p25 lab=en}
N 1140 970 1340 970 {}
C {devices/lab_wire.sym} 1210 970 0 0 {name=p26 lab=_05_}
C {symbols/dff_pn0.sym} 1420 970 0 0 {name=U9}
N 1340 930 1280 930 {}
C {devices/lab_pin.sym} 1280 930 0 0 {name=p27 lab=clk}
N 1340 1010 1280 1010 {}
C {devices/lab_pin.sym} 1280 1010 0 0 {name=p28 lab=rst_n}
N 1500 970 1560 970 {}
N 1560 970 1670 970 {}
C {devices/lab_pin.sym} 1670 970 0 1 {name=p29 lab=count[2]}
N 1560 970 1560 860 {}
N 960 860 1560 860 {}
N 960 860 960 940 {}
N 960 940 1000 940 {}
L 4 70 1120 1810 1120 {dash=4}
T {BIT 3} 70 1150 0 0 0.36 0.36 {layer=4}
C {symbols/xor2.sym} 730 1260 0 0 {name=U19}
N 590 1240 660 1240 {}
C {devices/lab_pin.sym} 590 1240 0 0 {name=p30 lab=count[3]}
C {symbols/and2.sym} 380 1280 0 0 {name=U15}
N 240 1260 310 1260 {}
C {devices/lab_pin.sym} 240 1260 0 0 {name=p31 lab=count[2]}
N 240 1300 310 1300 {}
C {devices/lab_pin.sym} 240 1300 0 0 {name=p32 lab=_00_[1]}
N 450 1280 660 1280 {}
C {devices/lab_wire.sym} 500 1280 0 0 {name=p33 lab=_00_[2]}
C {symbols/mux2.sym} 1070 1260 0 0 {name=U14}
N 800 1260 880 1260 {}
N 880 1260 880 1290 {}
N 880 1290 1000 1290 {}
C {devices/lab_wire.sym} 905 1290 0 0 {name=p34 lab=_02_[3]}
N 1070 1340 1070 1370 {}
C {devices/lab_pin.sym} 1070 1370 0 1 {name=p35 lab=en}
N 1140 1260 1340 1260 {}
C {devices/lab_wire.sym} 1210 1260 0 0 {name=p36 lab=_06_}
C {symbols/dff_pn0.sym} 1420 1260 0 0 {name=U10}
N 1340 1220 1280 1220 {}
C {devices/lab_pin.sym} 1280 1220 0 0 {name=p37 lab=clk}
N 1340 1300 1280 1300 {}
C {devices/lab_pin.sym} 1280 1300 0 0 {name=p38 lab=rst_n}
N 1500 1260 1560 1260 {}
N 1560 1260 1670 1260 {}
C {devices/lab_pin.sym} 1670 1260 0 1 {name=p39 lab=count[3]}
N 1560 1260 1560 1150 {}
N 960 1150 1560 1150 {}
N 960 1150 960 1230 {}
N 960 1230 1000 1230 {}
T {CELL MAP: U7..U10 = count_o_reg[0..3]; U11..U20 = original _11_.._20_.} 70 1440 0 0 0.28 0.28 {layer=4}
T {NET ALIASES: count[n] = count_o[n]; _00_[0] = count[0]; _02_[0] = _01_[0].} 70 1480 0 0 0.28 0.28 {layer=4}
T {_01_[3:1] = count[3:1]. Equal net labels connect electrically. MUX: S=0 -> A; S=1 -> B.} 70 1520 0 0 0.28 0.28 {layer=4}
T {DFF: positive-edge clock, active-low asynchronous reset to 0. Generic logical cells; no physical power pins.} 70 1560 0 0 0.28 0.28 {layer=4}
