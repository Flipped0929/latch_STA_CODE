#!/usr/bin/env python3
"""Create native Xschem symbols and a cell-for-cell schematic of counter_mapped.v."""
from pathlib import Path

ROOT = Path(__file__).resolve().parent
HEADER = 'v {xschem version=3.4.8RC file_version=1.2}\nG {}\n'

def pin(x, y, name, direction):
    return f'B 5 {x-2.5} {y-2.5} {x+2.5} {y+2.5} {{name={name} dir={direction}}}'

def line(x1, y1, x2, y2):
    return f'L 4 {x1} {y1} {x2} {y2} {{}}'

def text(s, x, y, size=.25, props=''):
    return f'T {{{s}}} {x} {y} 0 0 {size} {size} {{{props}}}'

def symbol(filename, model, pins, drawing, title):
    fmt = f'{model} @name ( ' + ', '.join(f'.{n}( @@{n} )' for x,y,n,d in pins) + ' );'
    data = HEADER + f'K {{type=primitive\nverilog_format="{fmt}"\ntemplate="name=U1"}}\nV {{}}\nS {{}}\nE {{}}\n'
    name_y, title_y = (-100, -80) if filename == 'dff_pn0.sym' else (-85, -65)
    data += '\n'.join(drawing + [pin(*p) for p in pins] + [text('@name',-45,name_y), text(title,-45,title_y,.22)]) + '\n'
    (ROOT/'symbols'/filename).write_text(data)

def main():
    (ROOT/'symbols').mkdir(exist_ok=True)
    binary = [(-70,-20,'A','in'),(-70,20,'B','in'),(70,0,'Y','out')]
    and_d = [line(-70,-20,-40,-20),line(-70,20,-40,20),line(-40,-40,-40,40),line(-40,-40,0,-40),line(-40,40,0,40),'A 4 0 0 40 270 180 {}',line(40,0,70,0)]
    symbol('and2.sym','yosys_and',binary,and_d,'AND / $_AND_')
    # ANSI XOR shape represented by smooth sampled curves.
    def curve(points):
        return 'P 4 '+str(len(points))+' '+' '.join(f'{x:g} {y:g}' for x,y in points)+' {}'
    xor_d = [line(-70,-20,-35,-20),line(-70,20,-35,20),line(50,0,70,0)]
    xor_d += [curve([(-45+15*(1-t*t),40*t) for t in [i/10 for i in range(-10,11)]]),curve([(-55+15*(1-t*t),40*t) for t in [i/10 for i in range(-10,11)]]),curve([(-45+95*t, -40*(1-t)**.5) for t in [i/20 for i in range(21)]]),curve([(-45+95*t,40*(1-t)**.5) for t in [i/20 for i in range(21)]])]
    symbol('xor2.sym','yosys_xor',binary,xor_d,'XOR / $_XOR_')
    symbol('not.sym','yosys_not',[(-70,0,'A','in'),(70,0,'Y','out')],[line(-70,0,-40,0),'P 4 4 -40 -35 -40 35 35 0 -40 -35 {}','A 4 41 0 6 0 360 {}',line(47,0,70,0)],'NOT / $_NOT_')
    symbol('mux2.sym','yosys_mux',[(-70,-30,'A','in'),(-70,30,'B','in'),(0,80,'S','in'),(70,0,'Y','out')],['P 4 5 -40 -55 40 -35 40 35 -40 55 -40 -55 {}',line(-70,-30,-40,-30),line(-70,30,-40,30),line(40,0,70,0),line(0,45,0,80),text('0',-28,-42),text('1',-28,19),text('S',8,47)],'MUX / $_MUX_')
    symbol('dff_pn0.sym','yosys_dff_pn0',[(-80,0,'D','in'),(-80,-40,'C','in'),(-80,40,'R','in'),(80,0,'Q','out')],[line(-50,-60,50,-60),line(50,-60,50,60),line(50,60,-50,60),line(-50,60,-50,-60),line(-80,0,-50,0),line(-80,-40,-50,-40),line(-80,40,-62,40),'A 4 -56 40 6 0 360 {}',line(50,0,80,0),'P 4 3 -50 -48 -38 -40 -50 -32 {}',text('D',-39,-10),text('Q',28,-10),text('R',-39,29),text('DFF',-17,-40,.23)],'$_DFF_PN0_')
    s = [HEADER+'K {}\nV {}\nS {}\nE {}']
    serial = 0
    def comp(sym,x,y,props,flip=0):
        s.append(f'C {{{sym}}} {x} {y} 0 {flip} {{{props}}}')
    def wire(x1,y1,x2,y2):
        s.append(f'N {x1} {y1} {x2} {y2} {{}}')
    def lab(x,y,name,right=False,kind='lab_pin'):
        nonlocal serial
        serial += 1
        comp(f'devices/{kind}.sym',x,y,f'name=p{serial} lab={name}',int(right and kind=='lab_pin'))
    def inlet(x,y,name):
        wire(x-70,y,x,y); lab(x-70,y,name)
    s += [text('4-BIT COUNTER | MAPPED GATE SCHEMATIC',70,25,.6,'layer=4'),text('Source: counter_mapped.v  |  14 Yosys generic cells  |  four bit slices',70,80,.32,'layer=4'),text('posedge clk: en = 1 -> count + 1; en = 0 -> hold.   rst_n = 0: asynchronous clear.',70,120,.30,'layer=4')]
    for x,n in [(230,'clk'),(540,'rst_n'),(850,'en')]:
        lab(x,190,n,kind='ipin'); wire(x,190,x+70,190)
    lab(1250,190,'count[3:0]',kind='opin'); wire(1180,190,1250,190)
    s += [text('CARRY / INCREMENT',220,245,.28,'layer=4'),text('SUM BIT',660,245,.28,'layer=4'),text('ENABLE / HOLD',1010,245,.28,'layer=4'),text('STATE / OUTPUT',1360,245,.28,'layer=4')]
    for bit,y in enumerate([390,680,970,1260]):
        s.append(text(f'BIT {bit}',70,y-110,.36,'layer=4'))
        if bit==0:
            comp('symbols/not.sym',730,y,'name=U20'); inlet(660,y,'count[0]')
            summ='_01_[0]'
        else:
            comp('symbols/xor2.sym',730,y,f'name=U{16+bit}')
            inlet(660,y-20,f'count[{bit}]')
            if bit==1:
                inlet(660,y+20,'count[0]')
            else:
                comp('symbols/and2.sym',380,y+20,f'name=U{16 if bit==2 else 15}')
                inlet(310,y,f'count[{bit-1}]')
                inlet(310,y+40,'count[0]' if bit==2 else '_00_[1]')
                wire(450,y+20,660,y+20); lab(500,y+20,f'_00_[{bit-1}]',kind='lab_wire')
            summ=f'_02_[{bit}]'
        comp('symbols/mux2.sym',1070,y,f'name=U{[12,11,13,14][bit]}')
        wire(800,y,880,y); wire(880,y,880,y+30); wire(880,y+30,1000,y+30)
        lab(905,y+30,summ,kind='lab_wire')
        wire(1070,y+80,1070,y+110); lab(1070,y+110,'en',True)
        wire(1140,y,1340,y); lab(1210,y,f'_{[4,3,5,6][bit]:02d}_',kind='lab_wire')
        comp('symbols/dff_pn0.sym',1420,y,f'name=U{7+bit}')
        wire(1340,y-40,1280,y-40); lab(1280,y-40,'clk')
        wire(1340,y+40,1280,y+40); lab(1280,y+40,'rst_n')
        wire(1500,y,1560,y); wire(1560,y,1670,y); lab(1670,y,f'count[{bit}]',True)
        # Feedback wire explicitly connects Q to mux input A (hold path).
        wire(1560,y,1560,y-110); wire(960,y-110,1560,y-110)
        wire(960,y-110,960,y-30); wire(960,y-30,1000,y-30)
        if bit<3: s.append(f'L 4 70 {y+150} 1810 {y+150} {{dash=4}}')
    s += [text('CELL MAP: U7..U10 = count_o_reg[0..3]; U11..U20 = original _11_.._20_.',70,1440,.28,'layer=4'),text('NET ALIASES: count[n] = count_o[n]; _00_[0] = count[0]; _02_[0] = _01_[0].',70,1480,.28,'layer=4'),text('_01_[3:1] = count[3:1]. Equal net labels connect electrically. MUX: S=0 -> A; S=1 -> B.',70,1520,.28,'layer=4'),text('DFF: positive-edge clock, active-low asynchronous reset to 0. Generic logical cells; no physical power pins.',70,1560,.28,'layer=4')]
    (ROOT/'counter.sch').write_text('\n'.join(s)+'\n')

if __name__=='__main__':
    main()
