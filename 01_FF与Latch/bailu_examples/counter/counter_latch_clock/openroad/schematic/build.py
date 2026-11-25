"""Generate an editable xschem sheet from the actual post-route signal netlist."""
from pathlib import Path
import hashlib
import re

ROOT = Path(__file__).resolve().parents[2]
NETLIST = ROOT / 'openroad/results/counter_routed.v'
source = NETLIST.read_text()
cells = {name: (master.removeprefix('sky130_fd_sc_hd__'), dict(re.findall(
    r'\.(\w+)\s*\(\s*([^()]+?)\s*\)', body))) for master, name, body in re.findall(
    r'\b(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);', source, re.S)}
assert len(cells) == 23
PDK = Path('/home/bailufrost/eda/pdk/sky130A/libs.tech/xschem/sky130_stdcells')
SYMBOLS = ROOT / 'symbols/sky130_stdcells'
for stem in ['dlrtp_2', 'dlrtp_4']:
    text = (SYMBOLS / 'dlrtp_1.sym').read_text().replace('dlrtp_1', stem)
    (SYMBOLS / (stem + '.sym')).write_text(text)
for stem in ['clkbuf_2', 'clkinv_2']:
    text = (PDK / (stem + '.sym')).read_text()
    text = re.sub(r'T \{@name\}[^\n]+', 'T {@name} 0 -55 0 0 0.22 0.22 {hcenter=true}', text)
    text = re.sub(r'T \{@symname\}[^\n]+', 'T {@symname} 0 32 0 0 0.22 0.22 {hcenter=true}', text)
    (SYMBOLS / (stem + '.sym')).write_text(text)

lines = ['v {xschem version=3.4.8RC file_version=1.2}', 'G {}', 'K {}', 'V {}', 'S {}', 'E {}']
positions, pin_offsets = {}, {}
label_index = 0


def text(value, x, y, scale=.3, layer=4):
    lines.append(f'T {{{value}}} {x} {y} 0 0 {scale} {scale} {{layer={layer}}}')


def wire(points, net):
    for (x1, y1), (x2, y2) in zip(points, points[1:]):
        assert x1 == x2 or y1 == y2
        if (x1, y1) != (x2, y2):
            lines.append(f'N {x1} {y1} {x2} {y2} {{lab={net}}}')


def label(net, x, y, kind='lab_pin', mirror=0):
    global label_index
    label_index += 1
    lines.append(f'C {{devices/{kind}.sym}} {x} {y} 0 {mirror} {{name=l{label_index} lab={net}}}')


def canonical(net):
    return re.sub(r'^count_o\[(\d)\]$', r'count[\1]', net)


def cell(name, x, y):
    stem = cells[name][0]
    assert name not in positions
    positions[name] = (x, y)
    lines.append(f'C {{symbols/sky130_stdcells/{stem}.sym}} {x} {y} 0 0 '
                 f'{{name={name} VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__}}')
    if stem not in pin_offsets:
        pin_offsets[stem] = {pin: ((float(x1)+float(x2))/2, (float(y1)+float(y2))/2)
            for x1, y1, x2, y2, pin in re.findall(
                r'B 5 ([-\d.]+) ([-\d.]+) ([-\d.]+) ([-\d.]+) \{name=(\w+)',
                (SYMBOLS / (stem + '.sym')).read_text())}


def pin(name, port):
    x, y = positions[name]
    dx, dy = pin_offsets[cells[name][0]][port]
    return int(x+dx), int(y+dy)


def net(name, port):
    return canonical(cells[name][1][port])


def stub(name, port, start_x, output=False):
    end = pin(name, port)
    wire([(start_x, end[1]), end], net(name, port))
    label(net(name, port), start_x, end[1], mirror=int(output))


def direct(left, out, right, inp, via=None, lab_at=None):
    assert net(left, out) == net(right, inp), (left, right)
    wire([pin(left, out)] + (via or []) + [pin(right, inp)], net(left, out))
    if lab_at:
        label(net(left, out), *lab_at, kind='lab_wire')


lines.append('B 4 40 20 3400 2680 {dash=4 fill=false}')
text('COUNTER  /  POST-ROUTE  /  SKY130 HD', 90, 60, .75)
text('Two-phase gated counter | Actual cell sizes and CTS connections | 23 signal-cell instances', 90, 120, .38)
text('Source: openroad/results/counter_routed.v   |   SHA-256: ' + hashlib.sha256(source.encode()).hexdigest()[:16], 90, 163, .28, 5)
lines.append('L 4 90 205 3340 205 {}')
text('01  PHI1 CLOCK TREE / TWO BUFFER LEVELS', 140, 240, .4)
text('02  ENABLE + PHI2 / ONE BUFFER LEVEL', 1970, 240, .4)

# Original signal names are retained, including the upstream net created by
# insert_buffer. Named stubs connect to exactly the same labels below.
cell('clkbuf_0_clk_1', 390, 500)
label('clk_1', 180, 500, 'ipin')
wire([(180, 500), pin('clkbuf_0_clk_1', 'A')], 'clk_1')
cell('clkbuf_1_0__f_clk_1', 910, 370)
cell('clkbuf_1_1__f_clk_1', 910, 650)
direct('clkbuf_0_clk_1', 'X', 'clkbuf_1_0__f_clk_1', 'A', [(650, 500), (650, 370)], (620, 500))
direct('clkbuf_0_clk_1', 'X', 'clkbuf_1_1__f_clk_1', 'A', [(650, 500), (650, 650)])
for name, y in [('clkbuf_1_0__f_clk_1', 370), ('clkbuf_1_1__f_clk_1', 650)]:
    wire([pin(name, 'X'), (1760, y)], net(name, 'X'))
    label(net(name, 'X'), 1190, y, 'lab_wire')
text('Drives: state_phi1_bit0, bit2, bit3,', 1130, 420, .27, 5)
text('state_phi1_carry_bit2 and carry_bit3', 1130, 455, .27, 5)
text('Drives: state_phi1_bit1, enable_phi1, clkload0', 1110, 600, .27, 5)
cell('clkload0', 1580, 770)
direct('clkbuf_1_1__f_clk_1', 'X', 'clkload0', 'A', [(1460, 650), (1460, 770)])
lines.append('N 1620 770 1720 770 {}')
lines.append('C {devices/noconn.sym} 1720 770 0 0 {name=nc_clkload0}')
text('CTS load balancing; output intentionally open', 1110, 840, .26, 5)

cell('enable_phi1', 2230, 350)
label('en', 2030, 340, 'ipin')
wire([(2030, 340), pin('enable_phi1', 'D')], 'en')
stub('enable_phi1', 'GATE', 2110)
cell('gate_phi2', 2520, 470)
direct('enable_phi1', 'Q', 'gate_phi2', 'B', [(2410, 340), (2410, 490)], (2400, 340))
label('clk_2', 2300, 450, 'ipin')
wire([(2300, 450), pin('gate_phi2', 'A')], 'clk_2')
cell('clkbuf_phi2_single1', 2940, 470)
direct('gate_phi2', 'X', 'clkbuf_phi2_single1', 'A', lab_at=(2830, 470))
wire([pin('clkbuf_phi2_single1', 'X'), (3200, 470)], 'clk_2_gated')
label('clk_2_gated', 3180, 470, 'lab_wire')
text('Drives all four state_phi2_bit[0..3]/GATE pins', 2480, 565, .28, 5)
text('Enable is latched by the actual phi1 leaf clock', 1990, 650, .28, 5)
text('MODULE INTERFACE', 2030, 735, .34)
label('rst_n', 2150, 800, 'ipin')
wire([(2150, 800), (2310, 800)], 'rst_n')
label('rst_n', 2310, 800, mirror=1)
wire([(2780, 800), (2960, 800)], 'count[3:0]')
label('count[3:0]', 2960, 800, 'opin')
text('Active-low asynchronous reset', 2030, 850, .26, 5)
text('count_o[i] is the same net as count[i]', 2700, 850, .26, 5)
lines.append('L 4 90 920 3340 920 {}')
for title, x in [('03  NEXT / CARRY', 160), ('04  PHI1 LATCHES', 1050),
                 ('05  RETIMED XOR', 1850), ('06  OUTPUT LATCHES', 2690)]:
    text(title, x, 960, .4)
text('Feedback from published count', 160, 1005, .28, 5)
text('Actual CTS leaf nets shown at GATE', 1030, 1005, .28, 5)
text('Bits 2 and 3', 1850, 1005, .28, 5)
text('Preserved strengths: 4 / 4 / 2 / 2', 2640, 1005, .28, 5)

# The data path is organized by counter bit; clock/reset labels use the
# actual buffer-leaf signal names, not the ideal input clocks.
for bit, y in [(0, 1200), (1, 1480)]:
    text(f'BIT {bit}', 110, y-120, .38)
    increment, first, second = f'increment_bit{bit}', f'state_phi1_bit{bit}', f'state_phi2_bit{bit}'
    cell(increment, 400, y-20)
    for port in cells[increment][1]:
        if port not in {'Y', 'X'}: stub(increment, port, 250)
    cell(first, 1200, y)
    direct(increment, 'Y' if bit == 0 else 'X', first, 'D', lab_at=(700, y-20))
    stub(first, 'GATE', 930)
    stub(first, 'RESET_B', 1010)
    cell(second, 2800, y)
    direct(first, 'Q', second, 'D', lab_at=(1940, y-20))
    stub(second, 'GATE', 2530)
    stub(second, 'RESET_B', 2600)
    stub(second, 'Q', 3170, output=True)
    text(f'count_o[{bit}]', 3040, y+35, .25, 5)
    lines.append(f'L 5 95 {y+135} 3330 {y+135} {{dash=6}}')

for bit, y in [(2, 1770), (3, 2190)]:
    text(f'BIT {bit}', 110, y-100, .38)
    first, carry_first = f'state_phi1_bit{bit}', f'state_phi1_carry_bit{bit}'
    carry, increment, second = f'carry_into_bit{bit}', f'increment_bit{bit}', f'state_phi2_bit{bit}'
    cell(first, 1200, y)
    stub(first, 'D', 930)
    stub(first, 'GATE', 930)
    stub(first, 'RESET_B', 1010)
    cell(carry, 400, y+150)
    stub(carry, 'A', 250)
    stub(carry, 'B', 250)
    cell(carry_first, 1200, y+170)
    direct(carry, 'X', carry_first, 'D', lab_at=(700, y+150))
    stub(carry_first, 'GATE', 930)
    stub(carry_first, 'RESET_B', 1010)
    cell(increment, 2030, y+60)
    direct(first, 'Q', increment, 'A', [(1810, y-20), (1810, y+40)], (1430, y-20))
    direct(carry_first, 'Q', increment, 'B', [(1810, y+150), (1810, y+80)], (1420, y+150))
    cell(second, 2800, y+80)
    direct(increment, 'X', second, 'D', lab_at=(2300, y+60))
    stub(second, 'GATE', 2530)
    stub(second, 'RESET_B', 2600)
    stub(second, 'Q', 3170, output=True)
    text(f'count_o[{bit}]', 3040, y+115, .25, 5)
    lines.append(f'L 5 95 {y+285} 3330 {y+285} {{dash=6}}')

text('READING THE SHEET', 110, 2530, .34)
text('Equal net labels are electrically connected. count_o[3:0] aliases count[3:0].', 110, 2575, .28, 5)
text('Power pins: VPWR/VPB -> VDD; VGND/VNB -> VSS. Signal view omits filler/tap cells.', 110, 2610, .28, 5)
text('Extracted wire R/C remains in openroad/results/counter.spef; this sheet shows the routed gate-level connectivity.', 110, 2645, .28, 5)
assert set(positions) == set(cells), set(cells)-set(positions)
(ROOT / 'counter_routed.sch').write_text('\n'.join(lines) + '\n')
print(f'Generated counter_routed.sch: {len(positions)} actual post-route instances.')
