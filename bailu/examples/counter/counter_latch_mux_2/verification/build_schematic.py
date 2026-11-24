"""Build the editable, cell-for-cell xschem drawing from counter_sky130.v."""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent.parent
PDK = Path.home() / 'eda/pdk/sky130A/libs.tech/xschem/sky130_stdcells'
LIB = ROOT / 'symbols/sky130_stdcells'
LIB.mkdir(parents=True, exist_ok=True)
for cell in ['dlrtp_1', 'dlxtp_1', 'mux2_1', 'and2_1', 'xor2_1', 'inv_1']:
    text = (PDK / f'{cell}.sym').read_text()
    # Keep original pin positions, attributes, and license. Move long instance
    # names outside the shapes so all source instance names remain readable.
    if cell.startswith('dl'):
        pos = '-70 -65'
    elif cell == 'mux2_1':
        pos = '-20 85'
    elif cell == 'inv_1':
        pos = '-20 35'
    else:
        pos = '-30 45'
    text = re.sub(r'T \{@name\} [^\n]+',
                  f'T {{@name}} {pos} 0 0 0.25 0.25 {{}}', text)
    (LIB / f'{cell}.sym').write_text(text)

# A compact net label avoids crowding long vector names on the drawing.
(ROOT / 'symbols/net_label.sym').write_text('''v {xschem version=3.4.8RC file_version=1.2}
G {}
K {type=label format="*.alias @lab" template="name=l1 lab=net"}
V {}
S {}
E {}
B 5 -1.25 -1.25 1.25 1.25 {name=p dir=in}
T {@lab} -7.5 -9 0 1 0.28 0.28 {}
''')

source = re.sub(r'//[^\n]*', '', (ROOT / 'counter_sky130.v').read_text())
cells = {}
for kind, name, body in re.findall(r'(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);', source, re.S):
    pins = dict(re.findall(r'\.(\w+)\s*\(\s*([^()\s]+)\s*\)', body))
    cells[name] = (kind.removeprefix('sky130_fd_sc_hd__'),
                   {p: n.replace('count_o[', 'count[') for p, n in pins.items()})

graphics, wires, components = [], [], []
counter = 0
placed = set()


def note(text, x, y, scale=.32, layer=4):
    graphics.append(f'T {{{text}}} {x} {y} 0 0 {scale} {scale} {{layer={layer}}}')


def line(x1, y1, x2, y2, layer=21):
    graphics.append(f'L {layer} {x1} {y1} {x2} {y2} {{}}')


def wire(x1, y1, x2, y2):
    assert x1 == x2 or y1 == y2
    assert (x1, y1) != (x2, y2)
    wires.append(f'N {x1} {y1} {x2} {y2} {{}}')


def label(net, x, y, right=False):
    global counter
    counter += 1
    components.append(f'C {{symbols/net_label.sym}} {x} {y} 0 {int(right)} {{name=l{counter} lab={net}}}')


def port(net, x, y, output=False):
    global counter
    counter += 1
    sym = 'opin' if output else 'ipin'
    components.append(f'C {{devices/{sym}.sym}} {x} {y} 0 0 {{name=p{counter} lab={net}}}')


def cell(name, x, y):
    kind, pins = cells[name]
    assert name not in placed
    placed.add(name)
    components.append(f'C {{symbols/sky130_stdcells/{kind}.sym}} {x} {y} 0 0 '
                      f'{{name=x{name} VGND=VGND VNB=VGND VPB=VPWR VPWR=VPWR prefix=sky130_fd_sc_hd__}}')
    return pins


def latch(name, x, data_y, input_label=True, output_label=True):
    p = cell(name, x, data_y + 20)
    if input_label:
        wire(x - 180, data_y, x - 90, data_y)
        label(p['D'], x - 180, data_y)
    for pin, dy in [('GATE', 20), ('RESET_B', 40)]:
        wire(x - 130, data_y + dy, x - 90, data_y + dy)
        label(p[pin], x - 130, data_y + dy)
    if output_label:
        wire(x + 90, data_y, x + 150, data_y)
        label(p['Q'], x + 150, data_y, True)


note('4-BIT TWO-PHASE RECIRCULATION COUNTER', 90, 30, .76)
note('SKY130 HD  |  counter_sky130.v  |  31 standard cells  |  no retiming', 90, 105, .40)
line(90, 165, 3370, 165, 4)
note('CONTROL / ENABLE SAMPLING', 90, 185, .32)
for net, x in [('clk_1', 300), ('clk_2', 620), ('rst_n', 940), ('en', 1230)]:
    port(net, x, 270)
    wire(x, 270, x + 70, 270)

p = cell('en_phi1', 1670, 280)
wire(1540, 270, 1580, 270)
label(p['D'], 1540, 270)
wire(1540, 290, 1580, 290)
label(p['GATE'], 1540, 290)
wire(1760, 270, 1850, 270)
label(p['Q'], 1850, 270, True)
note('dlxtp_1: no reset', 1580, 330, .26)
for net, x in [('VPWR', 2490), ('VGND', 2910)]:
    port(net, x, 270)
    wire(x, 270, x + 70, 270)
note('All cells: VPB=VPWR, VNB=VGND', 2300, 330, .28)
wire(3110, 330, 3190, 330)
port('count[3:0]', 3190, 330, True)
note('Clock sequence: clk_1 then clk_2; active HIGH and non-overlapping.  rst_n=0 asynchronously clears all 16 data latches.', 90, 390, .34)
note('Matching net labels are electrically connected.  count_o[i] = count[i].  Cell instance names use an x prefix for SPICE.', 90, 435, .32)
line(90, 505, 3370, 505, 4)
for text, x in [('CARRY', 160), ('INCREMENT', 640), ('MUX / en', 1090),
                ('MAIN / clk_1', 1580), ('MUX / en_1', 2310), ('MAIN / clk_2', 2800), ('OUTPUT', 3190)]:
    note(text, x, 530, .35)

for bit in range(4):
    y = 660 + 340 * bit
    note(f'BIT {bit}', 90, y - 60, .34)
    # Increment gate.
    kind_name = '_20_' if bit == 0 else f'_{16 + bit}_'
    p = cell(kind_name, 760, y)
    if bit == 0:
        wire(660, y, 720, y)
        label(p['A'], 660, y)
        out_x = 800
    else:
        for pin, dy in [('A', -20), ('B', 20)]:
            wire(660, y + dy, 700, y + dy)
            label(p[pin], 660, y + dy)
        out_x = 820
    wire(out_x, y, 1000, y)
    label(f'increment[{bit}]', 880, y, True)
    wire(1000, y, 1000, y + 20)
    wire(1000, y + 20, 1140, y + 20)
    # Main path: mux1 -> main1 -> mux2 -> main2 -> count.
    p = cell(f'mux_phi1_bit{bit}', 1180, y)
    for pin, dy in [('A0', -20), ('S', 60)]:
        wire(1100, y + dy, 1140, y + dy)
        label(p[pin], 1100, y + dy)
    wire(1220, y, 1580, y)
    label(p['X'], 1250, y, True)
    latch(f'main_phi1_bit{bit}', 1670, y, False, False)
    wire(1760, y, 2220, y)
    label(f'main_q_phi1[{bit}]', 1850, y, True)
    wire(2220, y, 2220, y + 20)
    wire(2220, y + 20, 2360, y + 20)
    p = cell(f'mux_phi2_bit{bit}', 2400, y)
    for pin, dy in [('A0', -20), ('S', 60)]:
        wire(2320, y + dy, 2360, y + dy)
        label(p[pin], 2320, y + dy)
    wire(2440, y, 2800, y)
    label(p['X'], 2470, y, True)
    latch(f'main_phi2_bit{bit}', 2890, y, False, False)
    wire(2980, y, 3220, y)
    label(f'count[{bit}]', 3220, y, True)
    # Explicit recirculation banks: all eight source instances are present.
    latch(f'recirc_phi1_bit{bit}', 1670, y + 170)
    latch(f'recirc_phi2_bit{bit}', 2890, y + 170)
    note('RECIRCULATION / clk_1', 1580, y + 245, .26)
    note('RECIRCULATION / clk_2', 2800, y + 245, .26)
    line(90, y + 290, 3370, y + 290)

for name, y in [('_16_', 1100), ('_15_', 1440)]:
    p = cell(name, 300, y)
    for pin, dy in [('A', -20), ('B', 20)]:
        wire(200, y + dy, 240, y + dy)
        label(p[pin], 200, y + dy)
    wire(360, y, 410, y)
    label(p['X'], 410, y, True)

note('en=1: advance modulo 16 after the two phases.  en=0: hold via recirculation.  Phase-2 selection uses en_1 sampled in phase 1.', 90, 2025, .34)
note('Cells: 16 x dlrtp_1  |  1 x dlxtp_1  |  8 x mux2_1  |  2 x and2_1  |  3 x xor2_1  |  1 x inv_1', 90, 2075, .32)
note('Standard-cell schematic.  Local symbols retain SKY130 pin maps and power attributes; no transistor-level simulation setup is included.', 90, 2120, .29)
assert placed == cells.keys(), cells.keys() - placed
(ROOT / 'counter_sky130.sch').write_text('\n'.join(
    ['v {xschem version=3.4.8RC file_version=1.2}', 'G {}', 'K {}', 'V {}', 'S {}', 'E {}']
    + graphics + wires + components) + '\n')
print(f'Built counter_sky130.sch: {len(placed)} cells, {len(wires)} wire segments')
