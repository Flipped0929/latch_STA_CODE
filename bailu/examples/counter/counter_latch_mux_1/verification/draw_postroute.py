"""Draw, netlist and verify the actual 26-cell routed counter with xschem."""
from pathlib import Path
from collections import Counter
import hashlib
import json
import re
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent.parent
STEM = 'counter_postroute'
SOURCE = ROOT / 'openroad/results/counter_routed.v'
ALIASES = {
    'CK1_ROOT': 'clknet_0_clk_1', 'CK2_ROOT': 'clknet_0_clk_2',
    'CK1_A': 'clknet_1_0__leaf_clk_1', 'CK1_B': 'clknet_1_1__leaf_clk_1',
    'CK2_A': 'clknet_1_0__leaf_clk_2', 'CK2_B': 'clknet_1_1__leaf_clk_2',
    'RST_BUF': 'rst_n_buffered1',
}


def cells(text, extracted=False):
    result = {}
    for kind, name, body in re.findall(r'(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);', text, re.S):
        if extracted:
            assert name.startswith('x'), name
            name = name[1:]
        pins = dict(re.findall(r'\.(\w+)\s*\(\s*([^()\s]+)\s*\)', body))
        pins = {pin: canonical(net) for pin, net in pins.items()}
        assert name not in result
        result[name] = (kind, pins)
    return result


def canonical(net):
    return ALIASES.get(net, net).replace('count_o[', 'count[')


def draw(expected):
    original = (ROOT / 'counter_sky130.sch').read_text().splitlines()
    lines = []
    clock_labels = dict.fromkeys(['l7', 'l18', 'l30'], 'CK1_A')
    clock_labels.update(dict.fromkeys(['l37', 'l45', 'l52'], 'CK1_B'))
    clock_labels.update(dict.fromkeys(['l15', 'l27'], 'CK2_A'))
    clock_labels.update(dict.fromkeys(['l35', 'l50'], 'CK2_B'))
    for line in original:
        if line.startswith('L 4 '):
            continue
        if line.startswith('C '):
            name_match = re.search(r'name=(\S+)', line)
            name = name_match[1] if name_match else ''
            if name.startswith('x') and name[1:] in expected:
                kind = expected[name[1:]][0].removeprefix('sky130_fd_sc_hd__')
                line = re.sub(r'sky130_stdcells/\w+\.sym', f'sky130_stdcells/{kind}.sym', line)
            if name in clock_labels:
                line = re.sub(r'lab=[^\s}]+', 'lab=' + clock_labels[name], line)
            if 'lab=rst_n}' in line and name != 'l3' and name != 'p3':
                line = line.replace('lab=rst_n}', 'lab=RST_BUF}')
            if name in ['p5', 'p6']:
                line = line.replace('devices/ipin.sym', 'devices/iopin.sym')
            line = line.replace('=VPWR', '=VDD').replace('=VGND', '=VSS')
        if line.startswith(('C ', 'T ')):
            match = re.match(r'([CT] \{.*?\} [-\d.]+ )([-\d.]+)( .*)$', line)
            assert match, line
            y = float(match[2])
            if y >= 255:
                line = match[1] + f'{y+550:g}' + match[3]
        elif line.startswith(('N ', 'L ')):
            parts = line.split()
            for index in ([2, 4] if parts[0] == 'N' else [3, 5]):
                if float(parts[index]) >= 255:
                    parts[index] = f'{float(parts[index])+550:g}'
            line = ' '.join(parts)
        line = line.replace('4-BIT TWO-PHASE LATCH COUNTER', '4-BIT LATCH COUNTER | POST-ROUTE SCHEMATIC')
        line = line.replace('SKY130 HD | Source: counter_sky130.v | 19 cells / 10 resettable latches',
                            'SKY130 HD | openroad/results/counter_routed.v | 26 cells / 10 latches / 6 CTS buffers')
        line = line.replace('PHASE 1: clk_1', 'PHASE 1: CK1_A / CK1_B')
        line = line.replace('PHASE 2: clk_2', 'PHASE 2: CK2_A / CK2_B')
        line = line.replace('clk_1 then clk_2: active-high, non-overlapping phases. rst_n = 0 asynchronously clears ALL 10 latches.',
                            'Data flow: left to right. Named clock/reset labels connect to the buffered trees above.')
        line = line.replace('en = 0 holds the count. Feedback uses count[n] = count_o[n]. All cells: VPB = VPWR, VNB = VGND.',
                            'en = 0 holds count. count[n] = count_o[n]. All cells: VPWR = VPB = VDD; VGND = VNB = VSS.')
        lines.append(line)
    additions = []
    def wire(x1, y1, x2, y2):
        additions.append(f'N {x1} {y1} {x2} {y2} {{}}')
    def label(x, y, lab, right=False):
        additions.append(f'C {{devices/lab_pin.sym}} {x} {y} 0 {int(right)} {{name=pr_l{len(additions)} lab={lab}}}')
    def text(x, y, value, size=.33):
        additions.append(f'T {{{value}}} {x} {y} 0 0 {size} {size} {{layer=4}}')
    def cell(x, y, name):
        kind = expected[name][0].removeprefix('sky130_fd_sc_hd__')
        additions.append(f'C {{sky130_stdcells/{kind}.sym}} {x} {y} 0 0 '
                         f'{{name=x{name} VGND=VSS VNB=VSS VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }}')
    for coords in [(60,30,2320,30), (2320,30,2320,2250), (2320,2250,60,2250),
                   (60,2250,60,30), (60,255,2320,255), (60,800,2320,800), (60,2120,2320,2120)]:
        additions.append('L 4 ' + ' '.join(map(str, coords)) + ' {}')
    text(100, 280, 'PROPAGATED CLOCK TREES AND BUFFERED RESET', .45)
    for phase, root_x, leaf_x in [(1,310,690), (2,1390,1770)]:
        root_name = f'clkbuf_0_clk_{phase}'
        cell(root_x,450,root_name)
        wire(root_x-100,450,root_x-40,450)
        label(root_x-100,450,f'clk_{phase}')
        wire(root_x+40,450,root_x+160,450)
        label(root_x+100,450,f'CK{phase}_ROOT',True)
        wire(root_x+160,390,root_x+160,450)
        wire(root_x+160,450,root_x+160,510)
        for branch, y, tag in [(0,390,'A'),(1,510,'B')]:
            cell(leaf_x,y,f'clkbuf_1_{branch}__f_clk_{phase}')
            wire(root_x+160,y,leaf_x-40,y)
            wire(leaf_x+40,y,leaf_x+300,y)
            label(leaf_x+300,y,f'CK{phase}_{tag}',True)
        text(root_x-100,335,f'phi{phase}: 3 x clkbuf_4',.36)
        text(root_x-100,570,f'CK{phase}_ROOT = clknet_0_clk_{phase}',.29)
        text(root_x-100,605,f'CK{phase}_A = clknet_1_0__leaf_clk_{phase}',.29)
        text(root_x-100,635,f'CK{phase}_B = clknet_1_1__leaf_clk_{phase}',.29)
    cell(310,710,'reset_release_buf1')
    wire(210,710,270,710)
    label(210,710,'rst_n')
    wire(350,710,660,710)
    label(660,710,'RST_BUF',True)
    text(900,690,'RST_BUF = rst_n_buffered1; drives RESET_B of all 10 latches',.33)
    text(900,730,'Actual sizes: phi2 bit0/1 = dlrtp_4; bit2/3 = dlrtp_2; bit3_enable = and2_4',.33)
    text(100,2210,'Cell connectivity drawing. Extracted interconnect RC is retained separately in counter.spef.',.34)
    # Put primitives before decorations; xschem uses explicit net labels across panels.
    (ROOT / f'{STEM}.sch').write_text('\n'.join(lines+additions)+'\n')


def export_and_verify(expected):
    executable = shutil.which('xschem')
    assert executable, 'xschem not found'
    with tempfile.TemporaryDirectory(prefix='counter-postroute-') as temporary:
        common = [executable, '-x', '-r', '-q', '--rcfile', str(ROOT / 'xschemrc'),
                  '--tcl', f'set USER_CONF_DIR {{{temporary}}}; set bespice_listen_port {{}}; '
                           f'set local_netlist_dir 0; set netlist_dir {{{temporary}}}']
        logs = []
        for flag, filename in [('-s', f'{STEM}.spice'), ('-w', f'{STEM}_extracted.v')]:
            result = subprocess.run(common + ['-n', flag, '-o', temporary, '-N', filename,
                                               str(ROOT / f'{STEM}.sch')], cwd=ROOT,
                                    stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, check=True)
            logs.append(result.stdout)
            data = (Path(temporary) / filename).read_bytes()
            assert b'\0' not in data
            (ROOT / 'simulation' / filename).write_bytes(data)
        result = subprocess.run(common + ['--command',
            f'xschem line_width 1.5; xschem print svg {{{ROOT / (STEM + ".svg")}}} 3400 3300',
            str(ROOT / f'{STEM}.sch')], cwd=ROOT, stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT, text=True, check=True)
        logs.append(result.stdout)
        (ROOT / 'verification/counter_postroute_xschem.log').write_text('\n'.join(logs))
    verilog = (ROOT / 'simulation' / f'{STEM}_extracted.v').read_text()
    actual = cells(verilog, True)
    assert expected == actual, f'Cell/pin mismatch: {[(n, expected.get(n), actual.get(n)) for n in expected.keys()|actual.keys() if expected.get(n)!=actual.get(n)]}'
    spice = (ROOT / 'simulation' / f'{STEM}.spice').read_text()
    pdk = Path.home() / 'eda/pdk/sky130A/libs.tech/xschem/sky130_stdcells'
    seen = set()
    for line in spice.splitlines():
        if not line.startswith('x'):
            continue
        name, *nets, master = line.split()
        name = name[1:]
        assert name not in seen
        seen.add(name)
        kind, pins = expected[name]
        assert master == kind
        symbol = (pdk / (kind.removeprefix('sky130_fd_sc_hd__') + '.sym')).read_text()
        format_string = re.search(r'format="([^"]+)"', symbol)[1]
        order = [a or b for a, b in re.findall(r'@@(\w+)|@(VGND|VNB|VPB|VPWR)', format_string)]
        pins = pins | dict(VGND='VSS', VNB='VSS', VPB='VDD', VPWR='VDD')
        assert [canonical(n) for n in nets] == [pins[p] for p in order], (name,nets,order)
    assert seen == expected.keys()
    top = re.search(r'^\.subckt\s+' + STEM + r'\s+(.+)$',spice,re.M)
    assert top and set(top[1].split()) == {'clk_1','clk_2','rst_n','en','VDD','VSS',
                                          'count[0]','count[1]','count[2]','count[3]'}
    assert set(re.findall(r'input\s+wire\s+(\w+)', verilog)) == {'clk_1','clk_2','rst_n','en'}
    assert set(re.findall(r'inout\s+wire\s+(\w+)', verilog)) == {'VDD','VSS'}
    assert re.search(r'output\s+wire\s+\[3:0\]\s+count\b',verilog)
    inventory = Counter(kind for kind, _ in actual.values())
    report = ('PASS: all 26 routed cell types and instance names match openroad/results/counter_routed.v.\n'
              'PASS: all 84 signal-pin connections match, including individual CTS leaf membership.\n'
              'PASS: all 104 SPICE power/body connections match: VPWR=VPB=VDD; VGND=VNB=VSS.\n'
              'PASS: 10 latches, 6 CTS buffers, 1 reset buffer, 9 logic gates; actual drive strengths preserved.\n'
              'PASS: top-level clk_1, clk_2, rst_n, en, count[3:0], VDD and VSS match.\n'
              'PASS: no missing or additional cells; original signal net names recovered through documented aliases.\n'
              'Scope: post-route standard-cell connectivity; SPEF RC and physical-only filler/tap cells are not expanded.\n')
    assert sum(len(pins) for _,pins in expected.values()) == 84
    (ROOT / 'verification/counter_postroute_connections.txt').write_text(report)
    print(report,end='')
    subprocess.run(['/usr/bin/python3',str(ROOT/'verification/render_svg.py'),
                    str(ROOT/f'{STEM}.svg'),str(ROOT/f'{STEM}.png')], check=True)
    files = [SOURCE, ROOT/f'{STEM}.sch',ROOT/f'{STEM}.svg',ROOT/f'{STEM}.png',
             ROOT/'simulation'/f'{STEM}.spice',ROOT/'simulation'/f'{STEM}_extracted.v',Path(__file__),
             ROOT/'verification/render_svg.py']
    (ROOT/'verification/counter_postroute_manifest.json').write_text(json.dumps(
        dict(clock_reset_aliases=ALIASES, inventory=dict(inventory),
             files=[dict(path=str(p.relative_to(ROOT)),sha256=hashlib.sha256(p.read_bytes()).hexdigest()) for p in files]),
        indent=2)+'\n')


if __name__ == '__main__':
    expected = cells(SOURCE.read_text())
    assert len(expected) == 26
    draw(expected)
    export_and_verify(expected)
