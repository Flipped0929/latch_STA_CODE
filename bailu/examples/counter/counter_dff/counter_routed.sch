v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
E {}

T {COUNTER | POST-ROUTE GATE SCHEMATIC} 70 25 0 0 0.65 0.65 {layer=4}
T {Source: openroad/results/counter_routed.v   |   17 cells   |   library: sky130_fd_sc_hd__} 70 88 0 0 0.33 0.33 {layer=4}
T {4-bit counter: posedge CLK; en=1 increments, en=0 holds; rst_n=0 asynchronously clears all Q.} 70 130 0 0 0.3 0.3 {layer=4}
C {devices/ipin.sym} 210 210 0 0 {name=p1 lab=clk embed=true}
[
v {xschem version=3.4.8RC file_version=1.3
*
* This file is part of XSCHEM,
* a schematic capture and Spice/Vhdl/Verilog netlisting tool for circuit
* simulation.
* Copyright (C) 1998-2026 Stefan Frederik Schippers
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
}
G {}
K {type=ipin
format="*.ipin @lab"
spectre_format="//.ipin @lab"
template="name=p1 lab=xxx"
}
V {}
S {}
F {}
E {}
L 5 -5 0 0 0 {}
B 5 -1.25 -1.25 1.25 1.25 {name=p dir=out}
P 5 7 -5 0 -8.75 -5 -17.5 -5 -13.75 0 -17.5 5 -8.75 5 -5 0 {fill=true}
T {@lab} -18.75 -8.75 0 1 0.33 0.33 {}
T {@spice_get_voltage} 1.875 3.90625 0 0 0.2 0.2 {layer=15}
]
N 210 210 270 210 {}
C {devices/ipin.sym} 490 210 0 0 {name=p2 lab=en}
N 490 210 550 210 {}
C {devices/ipin.sym} 760 210 0 0 {name=p3 lab=rst_n}
N 760 210 820 210 {}
C {devices/opin.sym} 1250 210 0 0 {name=p4 lab=count[3:0] embed=true}
[
v {xschem version=3.4.8RC file_version=1.3
*
* This file is part of XSCHEM,
* a schematic capture and Spice/Vhdl/Verilog netlisting tool for circuit
* simulation.
* Copyright (C) 1998-2026 Stefan Frederik Schippers
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
}
G {}
K {type=opin
format="*.opin @lab"
spectre_format="//.opin @lab"
template="name=p1 lab=xxx"
}
V {}
S {}
F {}
E {}
L 5 0 0 8.75 0 {}
B 5 -1.25 -1.25 1.25 1.25 {name=p dir=in}
P 5 7 17.5 0 13.75 -5 5 -5 8.75 0 5 5 13.75 5 17.5 0 {fill=true}
T {@lab} 20 -8.75 0 0 0.33 0.33 {}
T {@spice_get_voltage} -1.875 3.90625 0 1 0.2 0.2 {layer=15}
]
N 1190 210 1250 210 {}
C {devices/iopin.sym} 1650 210 0 0 {name=p5 lab=VDD embed=true}
[
v {xschem version=3.4.8RC file_version=1.3
*
* This file is part of XSCHEM,
* a schematic capture and Spice/Vhdl/Verilog netlisting tool for circuit
* simulation.
* Copyright (C) 1998-2026 Stefan Frederik Schippers
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
}
G {}
K {type=iopin
format="*.iopin @lab"
spectre_format="//.iopin @lab"
template="name=p1 lab=xxx"
}
V {}
S {}
F {}
E {}
L 5 -0 -0 3.125 0 {}
B 5 -1.25 -1.25 1.25 1.25 {name=p dir=inout}
P 5 7 13.75 5 17.5 0 13.75 -5 6.875 -5 3.125 0 6.875 5 13.75 5 {fill=true}
T {@lab} 19.8438 -9.375 0 0 0.33 0.33 {}
T {@spice_get_voltage} -1.875 3.90625 0 1 0.2 0.2 {layer=15}
]
N 1590 210 1650 210 {}
C {devices/iopin.sym} 1930 210 0 0 {name=p6 lab=VSS}
N 1870 210 1930 210 {}
T {CLOCK TREE / 3 ROUTED CLOCK BUFFERS} 70 285 0 0 0.34 0.34 {layer=4}
C {counter_routed_clkbuf_4.sym} 450 440 0 0 {name=clkbuf_0_clk embed=true}
[
v {xschem version=3.4.8RC file_version=1.2}
G {}
K {type=primitive
verilog_format="sky130_fd_sc_hd__clkbuf_4 @name ( .A( @@A ), .X( @@X ) );"
template="name=clkbuf"}
V {}
S {}
E {}
L 4 -70 0 -40 0 {}
P 4 4 -40 -35 -40 35 40 0 -40 -35 {}
L 4 40 0 70 0 {}
B 5 -72.5 -2.5 -67.5 2.5 {name=A dir=in}
B 5 67.5 -2.5 72.5 2.5 {name=X dir=out}
T {@name} -45 -85 0 0 0.25 0.25 {}
T {clkbuf_4} -45 -65 0 0 0.22 0.22 {}
]
N 320 440 380 440 {}
C {devices/lab_pin.sym} 320 440 0 0 {name=p7 lab=clk embed=true}
[
v {xschem version=3.4.4 file_version=1.2
*
* This file is part of XSCHEM,
* a schematic capture and Spice/Vhdl/Verilog netlisting tool for circuit
* simulation.
* Copyright (C) 1998-2026 Stefan Frederik Schippers
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
}
G {}
K {type=label
format="*.alias @lab"
template="name=p1 sig_type=std_logic lab=xxx"
}
V {}
S {}
E {}
B 5 -1.25 -1.25 1.25 1.25 {name=p dir=in}
T {@lab} -7.5 -8.125 0 1 0.33 0.33 {}
T {@spice_get_voltage} 1.875 3.90625 0 0 0.2 0.2 {layer=15}
]
N 520 440 690 440 {}
C {devices/lab_wire.sym} 660 440 0 0 {name=p8 lab=clknet_0_clk embed=true}
[
v {xschem version=3.4.4 file_version=1.2
*
* This file is part of XSCHEM,
* a schematic capture and Spice/Vhdl/Verilog netlisting tool for circuit
* simulation.
* Copyright (C) 1998-2026 Stefan Frederik Schippers
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
}
G {}
K {type=label
format="*.alias @lab"
template="name=p1 sig_type=std_logic lab=xxx"
}
V {}
S {}
E {}
B 5 -1.25 -1.25 1.25 1.25 {name=p dir=in}
T {@lab} -2.5 -1.25 2 0 0.27 0.27 {}
T {@spice_get_voltage} 1.875 10.15625 0 0 0.2 0.2 {vcenter=true layer=15}
]
N 690 360 690 540 {}
N 690 360 880 360 {}
N 690 540 880 540 {}
C {counter_routed_clkbuf_4.sym} 950 360 0 0 {name=clkbuf_1_0__f_clk}
N 1020 360 1130 360 {}
C {devices/lab_pin.sym} 1130 360 0 1 {name=p9 lab=clknet_1_0__leaf_clk}
T {-> CLK of bits 0, 1} 1630 352 0 0 0.28 0.28 {layer=4}
C {counter_routed_clkbuf_4.sym} 950 540 0 0 {name=clkbuf_1_1__f_clk}
N 1020 540 1130 540 {}
C {devices/lab_pin.sym} 1130 540 0 1 {name=p10 lab=clknet_1_1__leaf_clk}
T {-> CLK of bits 2, 3} 1630 532 0 0 0.28 0.28 {layer=4}
T {Cell captions omit the common sky130_fd_sc_hd__ prefix. Equal net labels connect electrically.} 70 625 0 0 0.3 0.3 {layer=4}
L 4 70 675 2150 675 {dash=4}
T {CARRY} 220 700 0 0 0.3 0.3 {layer=4}
T {INCREMENT} 730 700 0 0 0.3 0.3 {layer=4}
T {ENABLE / HOLD} 1190 700 0 0 0.3 0.3 {layer=4}
T {REGISTER / Q} 1710 700 0 0 0.3 0.3 {layer=4}
T {BIT 0} 70 770 0 0 0.4 0.4 {layer=4}
C {counter_routed_inv_1.sym} 800 880 0 0 {name=_20_ embed=true}
[
v {xschem version=3.4.8RC file_version=1.2}
G {}
K {type=primitive
verilog_format="sky130_fd_sc_hd__inv_1 @name ( .A( @@A ), .Y( @@Y ) );"
template="name=U1"}
V {}
S {}
E {}
L 4 -70 0 -40 0 {}
P 4 4 -40 -35 -40 35 35 0 -40 -35 {}
A 4 41 0 6 0 360 {}
L 4 47 0 70 0 {}
B 5 -72.5 -2.5 -67.5 2.5 {name=A dir=in}
B 5 67.5 -2.5 72.5 2.5 {name=Y dir=out}
T {@name} -45 -85 0 0 0.25 0.25 {}
T {inv_1} -45 -65 0 0 0.22 0.22 {}
]
N 670 880 730 880 {}
C {devices/lab_pin.sym} 670 880 0 0 {name=p11 lab=count_o[0]}
C {counter_routed_mux2_1.sym} 1250 880 0 0 {name=_12_ embed=true}
[
v {xschem version=3.4.8RC file_version=1.2}
G {}
K {type=primitive
verilog_format="sky130_fd_sc_hd__mux2_1 @name ( .A0( @@A0 ), .A1( @@A1 ), .S( @@S ), .X( @@X ) );"
template="name=U1"}
V {}
S {}
E {}
P 4 5 -40 -55 40 -35 40 35 -40 55 -40 -55 {}
L 4 -70 -30 -40 -30 {}
L 4 -70 30 -40 30 {}
L 4 40 0 70 0 {}
L 4 0 45 0 80 {}
T {0} -28 -42 0 0 0.25 0.25 {}
T {1} -28 19 0 0 0.25 0.25 {}
T {S} 8 47 0 0 0.25 0.25 {}
B 5 -72.5 -32.5 -67.5 -27.5 {name=A0 dir=in}
B 5 -72.5 27.5 -67.5 32.5 {name=A1 dir=in}
B 5 -2.5 77.5 2.5 82.5 {name=S dir=in}
B 5 67.5 -2.5 72.5 2.5 {name=X dir=out}
T {@name} -45 -85 0 0 0.25 0.25 {}
T {mux2_1} -45 -65 0 0 0.22 0.22 {}
]
N 870 880 1000 880 {}
N 1000 880 1000 910 {}
N 1000 910 1180 910 {}
C {devices/lab_wire.sym} 1010 910 0 0 {name=p12 lab=_01_[0]}
N 1250 960 1250 995 {}
C {devices/lab_pin.sym} 1250 995 0 1 {name=p13 lab=en}
N 1320 880 1660 880 {}
C {devices/lab_wire.sym} 1430 880 0 0 {name=p14 lab=_04_}
C {counter_routed_dfrtp_1.sym} 1740 880 0 0 {name=count_o_reg[0] embed=true}
[
v {xschem version=3.4.8RC file_version=1.2}
G {}
K {type=primitive
verilog_format="sky130_fd_sc_hd__dfrtp_1 @name ( .D( @@D ), .CLK( @@CLK ), .RESET_B( @@RESET_B ), .Q( @@Q ) );"
template="name=U1"}
V {}
S {}
E {}
L 4 -50 -60 50 -60 {}
L 4 50 -60 50 60 {}
L 4 50 60 -50 60 {}
L 4 -50 60 -50 -60 {}
L 4 -80 0 -50 0 {}
L 4 -80 -40 -50 -40 {}
L 4 -80 40 -62 40 {}
A 4 -56 40 6 0 360 {}
L 4 50 0 80 0 {}
P 4 3 -50 -48 -38 -40 -50 -32 {}
T {D} -39 -10 0 0 0.25 0.25 {}
T {Q} 28 -10 0 0 0.25 0.25 {}
T {RN} -39 29 0 0 0.25 0.25 {}
T {DFF} -17 -40 0 0 0.23 0.23 {}
B 5 -82.5 -2.5 -77.5 2.5 {name=D dir=in}
B 5 -82.5 -42.5 -77.5 -37.5 {name=CLK dir=in}
B 5 -82.5 37.5 -77.5 42.5 {name=RESET_B dir=in}
B 5 77.5 -2.5 82.5 2.5 {name=Q dir=out}
T {@name} -45 -105 0 0 0.25 0.25 {}
T {dfrtp_1} -45 -80 0 0 0.22 0.22 {}
]
N 1620 840 1660 840 {}
C {devices/lab_pin.sym} 1620 840 0 0 {name=p15 lab=clknet_1_0__leaf_clk}
N 1600 920 1660 920 {}
C {devices/lab_pin.sym} 1600 920 0 0 {name=p16 lab=rst_n}
N 1820 880 1930 880 {}
N 1930 880 2000 880 {}
C {devices/lab_pin.sym} 2000 880 0 1 {name=p17 lab=count_o[0]}
N 1930 880 1930 750 {}
N 1130 750 1930 750 {}
N 1130 750 1130 850 {}
N 1130 850 1180 850 {}
L 4 70 1050 2150 1050 {dash=4}
T {BIT 1} 70 1090 0 0 0.4 0.4 {layer=4}
C {counter_routed_xor2_1.sym} 800 1200 0 0 {name=_17_ embed=true}
[
v {xschem version=3.4.8RC file_version=1.2}
G {}
K {type=primitive
verilog_format="sky130_fd_sc_hd__xor2_1 @name ( .A( @@A ), .B( @@B ), .X( @@X ) );"
template="name=U1"}
V {}
S {}
E {}
L 4 -70 -20 -35 -20 {}
L 4 -70 20 -35 20 {}
L 4 50 0 70 0 {}
P 4 21 -45 -40 -42.15 -36 -39.6 -32 -37.35 -28 -35.4 -24 -33.75 -20 -32.4 -16 -31.35 -12 -30.6 -8 -30.15 -4 -30 0 -30.15 4 -30.6 8 -31.35 12 -32.4 16 -33.75 20 -35.4 24 -37.35 28 -39.6 32 -42.15 36 -45 40 {}
P 4 21 -55 -40 -52.15 -36 -49.6 -32 -47.35 -28 -45.4 -24 -43.75 -20 -42.4 -16 -41.35 -12 -40.6 -8 -40.15 -4 -40 0 -40.15 4 -40.6 8 -41.35 12 -42.4 16 -43.75 20 -45.4 24 -47.35 28 -49.6 32 -52.15 36 -55 40 {}
P 4 21 -45 -40 -40.25 -38.9872 -35.5 -37.9473 -30.75 -36.8782 -26 -35.7771 -21.25 -34.641 -16.5 -33.4664 -11.75 -32.249 -7 -30.9839 -2.25 -29.6648 2.5 -28.2843 7.25 -26.8328 12 -25.2982 16.75 -23.6643 21.5 -21.9089 26.25 -20 31 -17.8885 35.75 -15.4919 40.5 -12.6491 45.25 -8.94427 50 -0 {}
P 4 21 -45 40 -40.25 38.9872 -35.5 37.9473 -30.75 36.8782 -26 35.7771 -21.25 34.641 -16.5 33.4664 -11.75 32.249 -7 30.9839 -2.25 29.6648 2.5 28.2843 7.25 26.8328 12 25.2982 16.75 23.6643 21.5 21.9089 26.25 20 31 17.8885 35.75 15.4919 40.5 12.6491 45.25 8.94427 50 0 {}
B 5 -72.5 -22.5 -67.5 -17.5 {name=A dir=in}
B 5 -72.5 17.5 -67.5 22.5 {name=B dir=in}
B 5 67.5 -2.5 72.5 2.5 {name=X dir=out}
T {@name} -45 -85 0 0 0.25 0.25 {}
T {xor2_1} -45 -65 0 0 0.22 0.22 {}
]
N 670 1180 730 1180 {}
C {devices/lab_pin.sym} 670 1180 0 0 {name=p18 lab=count_o[1]}
N 670 1220 730 1220 {}
C {devices/lab_pin.sym} 670 1220 0 0 {name=p19 lab=count_o[0]}
C {counter_routed_mux2_1.sym} 1250 1200 0 0 {name=_11_}
N 870 1200 1000 1200 {}
N 1000 1200 1000 1230 {}
N 1000 1230 1180 1230 {}
C {devices/lab_wire.sym} 1010 1230 0 0 {name=p20 lab=_02_[1]}
N 1250 1280 1250 1315 {}
C {devices/lab_pin.sym} 1250 1315 0 1 {name=p21 lab=en}
N 1320 1200 1660 1200 {}
C {devices/lab_wire.sym} 1430 1200 0 0 {name=p22 lab=_03_}
C {counter_routed_dfrtp_1.sym} 1740 1200 0 0 {name=count_o_reg[1]}
N 1620 1160 1660 1160 {}
C {devices/lab_pin.sym} 1620 1160 0 0 {name=p23 lab=clknet_1_0__leaf_clk}
N 1600 1240 1660 1240 {}
C {devices/lab_pin.sym} 1600 1240 0 0 {name=p24 lab=rst_n}
N 1820 1200 1930 1200 {}
N 1930 1200 2000 1200 {}
C {devices/lab_pin.sym} 2000 1200 0 1 {name=p25 lab=count_o[1]}
N 1930 1200 1930 1070 {}
N 1130 1070 1930 1070 {}
N 1130 1070 1130 1170 {}
N 1130 1170 1180 1170 {}
L 4 70 1370 2150 1370 {dash=4}
T {BIT 2} 70 1410 0 0 0.4 0.4 {layer=4}
C {counter_routed_xor2_1.sym} 800 1520 0 0 {name=_18_}
N 670 1500 730 1500 {}
C {devices/lab_pin.sym} 670 1500 0 0 {name=p26 lab=count_o[2]}
C {counter_routed_and2_1.sym} 400 1540 0 0 {name=_16_ embed=true}
[
v {xschem version=3.4.8RC file_version=1.2}
G {}
K {type=primitive
verilog_format="sky130_fd_sc_hd__and2_1 @name ( .A( @@A ), .B( @@B ), .X( @@X ) );"
template="name=U1"}
V {}
S {}
E {}
L 4 -70 -20 -40 -20 {}
L 4 -70 20 -40 20 {}
L 4 -40 -40 -40 40 {}
L 4 -40 -40 0 -40 {}
L 4 -40 40 0 40 {}
A 4 0 0 40 270 180 {}
L 4 40 0 70 0 {}
B 5 -72.5 -22.5 -67.5 -17.5 {name=A dir=in}
B 5 -72.5 17.5 -67.5 22.5 {name=B dir=in}
B 5 67.5 -2.5 72.5 2.5 {name=X dir=out}
T {@name} -45 -85 0 0 0.25 0.25 {}
T {and2_1} -45 -65 0 0 0.22 0.22 {}
]
N 270 1520 330 1520 {}
C {devices/lab_pin.sym} 270 1520 0 0 {name=p27 lab=count_o[1]}
N 270 1560 330 1560 {}
C {devices/lab_pin.sym} 270 1560 0 0 {name=p28 lab=count_o[0]}
N 470 1540 730 1540 {}
C {devices/lab_wire.sym} 500 1540 0 0 {name=p29 lab=_00_[1]}
C {counter_routed_mux2_1.sym} 1250 1520 0 0 {name=_13_}
N 870 1520 1000 1520 {}
N 1000 1520 1000 1550 {}
N 1000 1550 1180 1550 {}
C {devices/lab_wire.sym} 1010 1550 0 0 {name=p30 lab=_02_[2]}
N 1250 1600 1250 1635 {}
C {devices/lab_pin.sym} 1250 1635 0 1 {name=p31 lab=en}
N 1320 1520 1660 1520 {}
C {devices/lab_wire.sym} 1430 1520 0 0 {name=p32 lab=_05_}
C {counter_routed_dfrtp_1.sym} 1740 1520 0 0 {name=count_o_reg[2]}
N 1620 1480 1660 1480 {}
C {devices/lab_pin.sym} 1620 1480 0 0 {name=p33 lab=clknet_1_1__leaf_clk}
N 1600 1560 1660 1560 {}
C {devices/lab_pin.sym} 1600 1560 0 0 {name=p34 lab=rst_n}
N 1820 1520 1930 1520 {}
N 1930 1520 2000 1520 {}
C {devices/lab_pin.sym} 2000 1520 0 1 {name=p35 lab=count_o[2]}
N 1930 1520 1930 1390 {}
N 1130 1390 1930 1390 {}
N 1130 1390 1130 1490 {}
N 1130 1490 1180 1490 {}
L 4 70 1690 2150 1690 {dash=4}
T {BIT 3} 70 1730 0 0 0.4 0.4 {layer=4}
C {counter_routed_xor2_1.sym} 800 1840 0 0 {name=_19_}
N 670 1820 730 1820 {}
C {devices/lab_pin.sym} 670 1820 0 0 {name=p36 lab=count_o[3]}
C {counter_routed_and2_1.sym} 400 1860 0 0 {name=_15_}
N 270 1840 330 1840 {}
C {devices/lab_pin.sym} 270 1840 0 0 {name=p37 lab=count_o[2]}
N 270 1880 330 1880 {}
C {devices/lab_pin.sym} 270 1880 0 0 {name=p38 lab=_00_[1]}
N 470 1860 730 1860 {}
C {devices/lab_wire.sym} 500 1860 0 0 {name=p39 lab=_00_[2]}
C {counter_routed_mux2_1.sym} 1250 1840 0 0 {name=_14_}
N 870 1840 1000 1840 {}
N 1000 1840 1000 1870 {}
N 1000 1870 1180 1870 {}
C {devices/lab_wire.sym} 1010 1870 0 0 {name=p40 lab=_02_[3]}
N 1250 1920 1250 1955 {}
C {devices/lab_pin.sym} 1250 1955 0 1 {name=p41 lab=en}
N 1320 1840 1660 1840 {}
C {devices/lab_wire.sym} 1430 1840 0 0 {name=p42 lab=_06_}
C {counter_routed_dfrtp_1.sym} 1740 1840 0 0 {name=count_o_reg[3]}
N 1620 1800 1660 1800 {}
C {devices/lab_pin.sym} 1620 1800 0 0 {name=p43 lab=clknet_1_1__leaf_clk}
N 1600 1880 1660 1880 {}
C {devices/lab_pin.sym} 1600 1880 0 0 {name=p44 lab=rst_n}
N 1820 1840 1930 1840 {}
N 1930 1840 2000 1840 {}
C {devices/lab_pin.sym} 2000 1840 0 1 {name=p45 lab=count_o[3]}
N 1930 1840 1930 1710 {}
N 1130 1710 1930 1710 {}
N 1130 1710 1130 1810 {}
N 1130 1810 1180 1810 {}
L 4 70 2020 2150 2020 {dash=4}
T {OUTPUT ALIASES / exact assignments from routed netlist} 70 2060 0 0 0.32 0.32 {layer=4}
C {counter_routed_aliases.sym} 100 2140 0 0 {name=OUTPUT_ALIASES only_toplevel=false value="assign count[0] = count_o[0];
assign count[1] = count_o[1];
assign count[2] = count_o[2];
assign count[3] = count_o[3];" embed=true}
[
v {xschem version=3.4.4 file_version=1.2
*
* This file is part of XSCHEM,
* a schematic capture and Spice/Vhdl/Verilog netlisting tool for circuit
* simulation.
* Copyright (C) 1998-2026 Stefan Frederik Schippers
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
}
G {}
K {type=netlist_commands
template="name=s1 only_toplevel=false value=blabla"
format="
@value
"
verilog_format="@value"
spectre_format="
@value
"}
V {}
S {}
E {}
L 4 0 -10 70 -10 {}
L 4 0 -10 0 10 {}
T {@name} 5 -30 0 0 0.3 0.3 {}
T {@value} 15 -5 0 0 0.3 0.3 {font=Monospace}
]
T {VDD / VSS: top-level inout ports retained.} 1000 2100 0 0 0.29 0.29 {layer=4}
T {Cell power pins are omitted in the source Verilog.} 1000 2145 0 0 0.29 0.29 {layer=4}
T {This is routed logical connectivity; no metal geometry} 1000 2190 0 0 0.29 0.29 {layer=4}
T {or extracted wire RC is present in this .v file.} 1000 2235 0 0 0.29 0.29 {layer=4}
T {Embedded symbols / editable native Xschem schematic / no external PDK required to view.} 70 2330 0 0 0.27 0.27 {layer=4}
