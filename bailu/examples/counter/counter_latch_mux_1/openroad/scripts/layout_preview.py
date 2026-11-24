#!/usr/bin/env python3
"""Validate the saved physical/timing results and produce a reviewable report."""
import csv
import hashlib
import html
import json
import os
import re
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DESIGN = ROOT.parent
PLATFORM = Path(os.environ.get('SKY130HD_PLATFORM', '/home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd'))
REPORT = ROOT / 'reports/postroute'


def read(path):
    return path.read_text()


def table(path):
    with path.open() as f:
        return list(csv.DictReader(f, delimiter='\t'))


def slacks(name):
    return [float(x) for x in re.findall(r'([-+\d.]+)\s+slack \(', read(REPORT / f'{name}.rpt'))]


def digest(path):
    return {'path': str(path.resolve()), 'sha256': hashlib.sha256(path.read_bytes()).hexdigest(), 'bytes': path.stat().st_size}


def cells(path):
    return {n: c for c, n in re.findall(r'(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\(', read(path))}


def make_preview(instances):
    """Draw placed bounding boxes and routed DEF centerlines; not a mask GDS."""
    colors = {'li1': '#7c8593', 'met1': '#346bc0', 'met2': '#d84951', 'met3': '#239779', 'met4': '#b28218', 'met5': '#984dc0'}
    parts = ['<svg xmlns="http://www.w3.org/2000/svg" width="1120" height="800" viewBox="0 0 1120 800">',
             '<rect width="1120" height="800" fill="#f7f9fc"/>',
             '<g font-family="sans-serif" fill="#1c2940">',
             '<text x="40" y="40" font-size="25" font-weight="bold">SKY130 HD / counter_sky130_2 / routed layout</text>',
             '<text x="40" y="66" font-size="15">80 x 80 um die | two-phase latch clock trees | OpenRCX extracted</text></g>',
             '<g transform="translate(40 740) scale(8 -8)">',
             '<rect width="80" height="80" fill="white" stroke="#344055" stroke-width="0.16"/>']
    for cell in instances:
        master, name = cell['master'], cell['instance']
        if '__fill_' in master:
            color = '#edf0f5'
        elif '__tapvpwrvgnd_' in master:
            color = '#c8cdd7'
        elif 'state_phi1' in name:
            color = '#acd8f0'
        elif 'state_phi2' in name:
            color = '#e1c7ef'
        elif '__clkbuf_' in master:
            color = '#ffcd87'
        else:
            color = '#bee3c2'
        x, y, w, h = (float(cell[k]) for k in ['x_um', 'y_um', 'width_um', 'height_um'])
        parts.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{color}" stroke="#7d8798" stroke-width="0.035"><title>{html.escape(name)} / {html.escape(master)}</title></rect>')
    definition = read(ROOT / 'results/counter_routed.def')
    for section, is_power in [('SPECIALNETS', True), ('NETS', False)]:
        match = re.search(rf'(?m)^{section} \d+ ;\n(.*?)^END {section}', definition, re.S)
        assert match
        for path in re.finditer(r'(?:\+ ROUTED|\bNEW)\s+(\w+)\s+(.*?)(?=\bNEW|;)', match[1], re.S):
            layer, body = path.groups()
            points = []
            for px, py in re.findall(r'\(\s*([\d*-]+)\s+([\d*-]+)(?:\s+[-\d]+)?\s*\)', body):
                if (px == '*' or py == '*') and not points:
                    raise ValueError('DEF wildcard without preceding coordinate')
                x = points[-1][0] if px == '*' else int(px) / 1000
                y = points[-1][1] if py == '*' else int(py) / 1000
                points.append((x, y))
            if len(points) < 2:
                continue
            width = {'li1': 0.17, 'met1': 0.14, 'met2': 0.14, 'met3': 0.30, 'met4': 0.30, 'met5': 1.60}.get(layer, 0.14)
            if is_power:
                declared_width = re.match(r'(\d+)', body)
                if declared_width:
                    width = int(declared_width[1]) / 1000
            xy = ' '.join(f'{x},{y}' for x, y in points)
            parts.append(f'<polyline points="{xy}" fill="none" stroke="{colors.get(layer, "#666")}" stroke-width="{width}" opacity="{0.20 if is_power else 0.9}" stroke-linecap="square"/>')
    parts.append('</g><g font-family="sans-serif" fill="#1c2940" font-size="16">')
    parts.append('<text x="735" y="130" font-size="21" font-weight="bold">Signal metal layers</text>')
    for i, (name, color) in enumerate(colors.items()):
        y = 170 + 34 * i
        parts.append(f'<path d="M735 {y}h45" stroke="{color}" stroke-width="4"/><text x="795" y="{y+5}">{name}</text>')
    for i, (name, color) in enumerate([('phi1 latches', '#acd8f0'), ('phi2 latches', '#e1c7ef'), ('clock buffers', '#ffcd87'), ('logic / reset buffer', '#bee3c2')]):
        y = 420 + 34 * i
        parts.append(f'<rect x="735" y="{y-14}" width="26" height="18" fill="{color}" stroke="#7d8798"/><text x="780" y="{y}">{name}</text>')
    parts += ['<text x="735" y="610">Power stripes shown at 20% opacity.</text>', '<text x="735" y="640">Cell boxes and wire centerlines only.</text>', '<text x="735" y="670">Use the DEF / ODB for layout inspection.</text>', '</g></svg>']
    (ROOT / 'results/layout_preview.svg').write_text('\n'.join(parts))


if __name__ == "__main__":
    make_preview(table(ROOT / "reports/physical_inventory.tsv"))
