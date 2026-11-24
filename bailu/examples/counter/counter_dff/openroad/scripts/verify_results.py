#!/usr/bin/env python3
"""Check formal equivalence, SPEF coverage, physical checks, and both STA engines."""
import csv
import html
import json
import os
from pathlib import Path
import re
import subprocess

root = Path(__file__).resolve().parents[1]
reports = root / 'reports'
post = reports / 'postroute'
platform = Path(os.environ.get('SKY130HD_PLATFORM', '/home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd'))
lib = platform / 'lib/sky130_fd_sc_hd__tt_025C_1v80.lib'
read_lib = f'read_liberty -ignore_miss_func -ignore_miss_dir -ignore_miss_data_latch -ignore_buses {lib}'
ys = f'''{read_lib}
read_verilog {root}/inputs/counter_sky130.v
hierarchy -top counter
proc
flatten
opt
clk2fflogic
opt
rename counter gold
design -stash gold
{read_lib}
read_verilog {root}/results/counter_routed.v
hierarchy -top counter
proc
flatten
opt
clk2fflogic
opt
delete counter/VDD counter/VSS
rename counter gate
design -stash gate
design -copy-from gold -as gold gold
design -copy-from gate -as gate gate
equiv_make gold gate equiv
hierarchy -top equiv
equiv_struct
equiv_simple -seq 5
equiv_induct -seq 5
equiv_status -assert
'''
(reports / 'equivalence.ys').write_text(ys)
with (root / 'logs/equivalence.log').open('w') as log:
    subprocess.run(['yosys', '-Q', '-T', '-s', str(reports / 'equivalence.ys')],
                   stdout=log, stderr=subprocess.STDOUT, check=True)
assert 'Equivalence successfully proven!' in (root / 'logs/equivalence.log').read_text()

def rows(path):
    with path.open() as f:
        return list(csv.DictReader(f, delimiter='\t'))

def worst(name):
    slacks = re.findall(r'([-+\d.]+)\s+slack \(', (post / f'{name}.rpt').read_text())
    assert slacks, name
    return min(map(float, slacks))

spef = (root / 'results/counter.spef').read_text()
names = dict(re.findall(r'^\*(\d+) (\S+)$', spef, re.M))
extracted = re.findall(r'^\*D_NET \*(\d+) (\S+)', spef, re.M)
net_rows = rows(reports / 'nets.tsv')
assert {names[n] for n, cap in extracted} == {r['net'] for r in net_rows}
assert len(extracted) == len(net_rows) == 20
assert all(r['routed'] == '1' for r in net_rows)
assert (post / 'parasitic_annotation.rpt').read_text().strip() == 'Found 2 unannotated drivers.\n VDD\n VSS\nFound 0 partially unannotated drivers.'
assert not (post / 'check_setup.rpt').read_text().strip()
assert 'Detailed-route DRC violations: 0' in (reports / 'route_status.rpt').read_text()
assert 'Antenna violations: 0' in (reports / 'audit.rpt').read_text()
assert not any('VIOLATED' in p.read_text() for p in post.glob('*.rpt'))
summary = (post / 'summary.rpt').read_text()
assert 'tns max 0.000000' in summary and 'tns min 0.000000' in summary
independent = reports / 'standalone_sta/summary.rpt'
if independent.exists():
    assert independent.read_text() == summary
    for name in ('setup.rpt', 'hold.rpt', 'recovery.rpt', 'removal.rpt'):
        assert (reports / 'standalone_sta' / name).read_text() == (post / name).read_text()

counts = {r['master']: int(r['count']) for r in rows(reports / 'cell_counts.tsv')}
timing = {name: worst(name) for name in ('setup', 'hold', 'data_setup', 'data_hold',
                                       'output_setup', 'output_hold', 'rst_n_setup', 'rst_n_hold')}
stages = {}
for path in sorted(reports.glob('*_summary.rpt')):
    stages[path.stem.removesuffix('_summary')] = {f'{kind.replace(" ", "_")}_{mode}': float(value) for kind, mode, value in
        re.findall(r'(worst slack|tns) (max|min) ([-\d.]+)', path.read_text())}
data = {'corner': 'TT / 25 C / 1.80 V', 'period_ns': 2.0, 'timing_slack_ns': timing,
        'stages': stages, 'signal_clock_nets': len(net_rows), 'spef_nets': len(extracted),
        'spef_total_net_capacitance_pf': sum(float(cap) for n, cap in extracted),
        'cell_counts': counts, 'route_drc': 0, 'antenna_violations': 0,
        'formal_equivalence': True, 'standalone_sta_matches': independent.exists()}
(reports / 'summary.json').write_text(json.dumps(data, indent=2) + '\n')
(reports / 'verification.rpt').write_text(
    'PASS: Yosys sequential equivalence against input counter_sky130.v.\n'
    'PASS: 20/20 routed signal/clock nets present in extracted SPEF.\n'
    'PASS: all timed signal/clock drivers annotated; only VDD/VSS excluded.\n'
    'PASS: constraints cover all timing endpoints.\n'
    'PASS: setup, hold, recovery, removal, pulse width, slew and capacitance checks.\n'
    f'PASS: independent OpenSTA comparison: {independent.exists()}.\n')

# A compact preview from actual DEF route centerlines and ODB instance bounds.
colors = {'li1': '#8795a7', 'met1': '#4375cc', 'met2': '#dc6270', 'met3': '#22a387', 'met4': '#d49a31', 'met5': '#a976cd'}
parts = ['<svg xmlns="http://www.w3.org/2000/svg" width="920" height="760" viewBox="0 0 920 760">',
         '<rect width="920" height="760" fill="#f5f7fc"/>',
         '<g font-family="sans-serif" fill="#1d2e46"><text x="35" y="36" font-size="23" font-weight="bold">Counter / SKY130 HD / routed layout</text>',
         '<text x="35" y="62" font-size="14">60 x 60 um | 4 D flip-flops | 2 ns clock | TT / 25 C / 1.80 V</text></g>',
         '<g transform="translate(35 710) scale(10 -10)"><rect width="60" height="60" fill="white" stroke="#40516a" stroke-width="0.12"/>']
for r in rows(reports / 'instances.tsv'):
    m = r['master']
    color = '#eef1f6' if '__fill_' in m else '#cbd2dc' if '__tapvpwrvgnd_' in m else '#a8cef0' if '__dfrtp_' in m else '#ffd18a' if '__clkbuf_' in m else '#bce2bf'
    x, y, w, h = (float(r[k]) for k in ('x_um', 'y_um', 'width_um', 'height_um'))
    parts.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{color}" stroke="#8291a6" stroke-width="0.03"><title>{html.escape(r["instance"])} / {m}</title></rect>')
definition = (root / 'results/counter_routed.def').read_text()
for section, power in [('SPECIALNETS', True), ('NETS', False)]:
    match = re.search(rf'(?m)^{section} \d+ ;\n(.*?)^END {section}', definition, re.S)
    assert match
    for layer, body in re.findall(r'(?:\+ ROUTED|\bNEW)\s+(\w+)\s+(.*?)(?=\bNEW|;)', match[1], re.S):
        points = []
        for px, py in re.findall(r'\(\s*([\d*-]+)\s+([\d*-]+)(?:\s+[-\d]+)?\s*\)', body):
            x = points[-1][0] if px == '*' else int(px) / 1000
            y = points[-1][1] if py == '*' else int(py) / 1000
            points.append((x, y))
        if len(points) < 2:
            continue
        width = {'met1': .14, 'met2': .14, 'met3': .3, 'met4': .3, 'met5': 1.6}.get(layer, .17)
        if power and (declared := re.match(r'(\d+)', body)):
            width = int(declared[1]) / 1000
        coords = ' '.join(f'{x},{y}' for x, y in points)
        parts.append(f'<polyline points="{coords}" fill="none" stroke="{colors[layer]}" stroke-width="{width}" opacity="{.16 if power else .9}"/>')
parts.append('</g><g font-family="sans-serif" fill="#1d2e46" font-size="15">')
for i, (name, color) in enumerate(colors.items()):
    y = 145 + i * 31
    parts.append(f'<path d="M675 {y}h32" stroke="{color}" stroke-width="4"/><text x="720" y="{y+5}">{name}</text>')
for i, (name, color) in enumerate([('D flip-flops', '#a8cef0'), ('Clock buffers', '#ffd18a'), ('Logic', '#bce2bf')]):
    y = 395 + i * 32
    parts.append(f'<rect x="675" y="{y-14}" width="25" height="18" fill="{color}"/><text x="715" y="{y}">{name}</text>')
parts += ['<text x="675" y="565">Cell boxes and route</text><text x="675" y="589">centerlines from DEF.</text>',
          '<text x="675" y="635">Power grid shown faintly.</text></g></svg>']
(root / 'results/layout_preview.svg').write_text('\n'.join(parts))
print('VERIFICATION_COMPLETE', json.dumps(timing))
