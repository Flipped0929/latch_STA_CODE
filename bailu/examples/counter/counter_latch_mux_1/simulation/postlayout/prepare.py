"""Convert routed SKY130 cells plus SPEF distributed RC to transistor SPICE."""
from pathlib import Path
from collections import Counter, defaultdict
import csv
import hashlib
import json
import math
import os
import re
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
CELL_ROOT = Path(os.environ.get('SKY130_HD_SOURCE', '/mnt/hgfs/LatchSTA_Code/pdk_work/sources/sky130_fd_sc_hd'))
PDK = Path(os.environ.get('PDK_ROOT', str(Path.home() / 'eda/pdk'))) / 'sky130A'


def sha(path):
    return dict(path=str(path.resolve()), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), bytes=path.stat().st_size)


def prepare():
    for name in ['netlists', 'logs', 'results', 'plots']:
        (HERE / name).mkdir(exist_ok=True)
    routed = ROOT / 'openroad/results/counter_routed.v'
    spef_path = ROOT / 'openroad/results/counter.spef'
    assert (ROOT/'counter_sky130.v').read_bytes() == (ROOT/'openroad/inputs/counter_sky130_2.v').read_bytes()
    source = routed.read_text()
    cells = {}
    for kind, inst, body in re.findall(r'(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);', source, re.S):
        cells[inst] = kind, dict(re.findall(r'\.(\w+)\s*\(\s*([^\s()]+)\s*\)', body))
    assert len(cells) == 26
    aliases = dict(re.findall(r'assign\s+(\S+)\s*=\s*(\S+)\s*;', source))
    def canonical(net):
        return aliases.get(net, net)

    spef = spef_path.read_text()
    assert '*C_UNIT 1 PF' in spef and '*R_UNIT 1 OHM' in spef
    names = dict(re.findall(r'^\*(\d+)\s+(\S+)\s*$', spef.split('*D_NET', 1)[0], re.M))
    def expand(token):
        return re.sub(r'^\*(\d+)', lambda m: names[m[1]], token)
    sections = re.findall(r'^\*D_NET\s+(\S+)\s+(\S+)\n(.*?)^\*END\s*$', spef, re.M | re.S)
    assert len(sections) == 30
    caps, resistors, pin_nodes, port_nodes, node_net = [], [], {}, {}, {}
    totals = []
    for net, total, body in sections:
        net = expand(net)
        section = None
        cap_sum = 0
        for line in body.splitlines():
            fields = line.split()
            if not fields:
                continue
            if fields[0] in ['*CONN', '*CAP', '*RES']:
                section = fields[0]
                continue
            if section == '*CONN':
                node = expand(fields[1])
                node_net[node] = net
                if fields[0] == '*I':
                    inst, pin = node.rsplit(':', 1)
                    assert inst in cells and pin in cells[inst][1], (inst, pin)
                    assert canonical(cells[inst][1][pin]) == canonical(net)
                    assert (inst, pin) not in pin_nodes
                    pin_nodes[inst, pin] = node
                elif fields[0] == '*P':
                    assert canonical(node) == canonical(net)
                    port_nodes[node] = node
                else:
                    raise AssertionError(fields)
            elif section == '*CAP':
                a = expand(fields[1])
                b = '0' if len(fields) == 3 else expand(fields[2])
                value = float(fields[-1]) * 1e-12
                assert value >= 0
                cap_sum += value
                caps.append((a, b, value))
            elif section == '*RES':
                a, b, value = expand(fields[1]), expand(fields[2]), float(fields[3])
                assert value > 0
                resistors.append((a, b, value))
        assert math.isclose(cap_sum, float(total)*1e-12, rel_tol=1e-5, abs_tol=1e-22), net
        totals.append(dict(net=net, declared_cap_f=float(total)*1e-12, listed_cap_f=cap_sum))
    assert len(pin_nodes) == sum(len(p) for _, p in cells.values()) == 84
    assert set(port_nodes) == {'clk_1', 'clk_2', 'en', 'rst_n', *(f'count[{b}]' for b in range(4))}

    # A coupling capacitor appears in BOTH participating D_NET sections.
    # Retain a single physical capacitor, checking the symmetric values agree.
    coupling, grounded = {}, []
    for a, b, value in caps:
        if not value:
            continue
        if b == '0':
            grounded.append((a, b, value))
        else:
            key = tuple(sorted((a, b)))
            if key in coupling:
                assert math.isclose(coupling[key], value, rel_tol=1e-7), (key, coupling[key], value)
            else:
                coupling[key] = value
    physical_caps = grounded + [(a, b, v) for (a, b), v in sorted(coupling.items())]
    all_nodes = set(n for a, b, _ in physical_caps + resistors for n in [a, b]) | set(pin_nodes.values()) | set(port_nodes)
    mapping = {'0': '0'}
    mapping.update({name: name for name in ['clk_1', 'clk_2', 'en', 'rst_n']})
    mapping.update({f'count[{b}]': f'count{b}' for b in range(4)})
    for i, name in enumerate(sorted(all_nodes - mapping.keys())):
        mapping[name] = f'n{i:04d}'
    assert len(set(mapping.values())) == len(mapping)
    # All endpoints and all positive-capacitance nodes must have a resistor
    # path to a net endpoint. No dangling coupling-only nodes are accepted.
    graph = defaultdict(set)
    for a, b, _ in resistors:
        graph[a].add(b)
        graph[b].add(a)
    seen = set(pin_nodes.values()) | set(port_nodes)
    todo = list(seen)
    while todo:
        for neighbor in graph[todo.pop()] - seen:
            seen.add(neighbor)
            todo.append(neighbor)
    assert all_nodes - {'0'} <= seen, sorted(all_nodes-seen-{'0'})

    cell_files, definitions, orders = [], [], {}
    for kind in sorted({k for k, _ in cells.values()}):
        base = kind.removeprefix('sky130_fd_sc_hd__').rsplit('_', 1)[0]
        path = CELL_ROOT/'cells'/base/(kind+'.spice')
        data = path.read_text()
        match = re.search(r'(?im)^\.subckt\s+' + kind + r'\s+(.+)$', data)
        assert match, kind
        orders[kind] = match[1].split()
        # Original SkyWater dimensions e.g. 1e6u evaluate to 1 micron under
        # the PDK's .option scale=1u. Preserve the upstream text exactly.
        definitions.append(data)
        cell_files.append(path)
    (HERE/'netlists/sky130_cells.spice').write_text('\n'.join(definitions))
    # Load exactly the same TT MOS definitions used by the PDK .lib tt.
    # This circuit needs only nfet_01v8 and pfet_01v8_hvt (their wrappers also
    # define the special 0.36um variants). Avoid parsing unused RF/HV models.
    ngdir=PDK/'libs.tech/ngspice'
    common=(ngdir/'all.spice').read_text().split('* include all individual diode models',1)[0]
    common=common.replace('.include "parameters/lod.spice"',
                           f'.include "{ngdir}/parameters/lod.spice"')
    used_models=[PDK/'libs.ref/sky130_fd_pr/spice'/f'sky130_fd_pr__{device}__{suffix}.spice'
                 for device in ['nfet_01v8','pfet_01v8_hvt']
                 for suffix in ['tt.pm3','mismatch.corner']]
    model_lines=['* Unmodified MOS files selected from SKY130 .lib tt; unused device families omitted.',
                 '.param mc_mm_switch=0 mc_pr_switch=0',common,
                 *[f'.include "{path}"' for path in used_models]]
    (HERE/'netlists/tt_used_models.spice').write_text('\n'.join(model_lines)+'\n')
    shutil.copyfile(CELL_ROOT/'LICENSE', HERE/'netlists/LICENSE.sky130')
    lines = ['* Routed transistor circuit with distributed OpenRCX RC and explicit coupling.',
             '* Ports: four inputs, supply/ground, count[3:0].',
             '.subckt counter_postlayout clk_1 clk_2 rst_n en VPWR VGND count3 count2 count1 count0']
    transistors = 0
    for inst, (kind, pins) in cells.items():
        nodes = []
        for pin in orders[kind]:
            if pin in ['VGND', 'VNB']:
                nodes.append('VGND')
            elif pin in ['VPWR', 'VPB']:
                nodes.append('VPWR')
            else:
                nodes.append(mapping[pin_nodes[inst, pin]])
        lines.append('x'+inst+' '+' '.join(nodes)+' '+kind)
        definition = definitions[sorted(orders).index(kind)]
        transistors += len(re.findall(r'^X\d+\s', definition, re.M))
    lines.append('* Interconnect resistances in ohms.')
    for i, (a, b, value) in enumerate(resistors):
        lines.append(f'Rwire{i} {mapping[a]} {mapping[b]} {value:.12g}')
    lines.append('* Interconnect capacitances in farads; coupling is NOT grounded.')
    for i, (a, b, value) in enumerate(physical_caps):
        lines.append(f'Cwire{i} {mapping[a]} {mapping[b]} {value:.12g}')
    lines.append('.ends counter_postlayout')
    (HERE/'netlists/counter_postlayout.spice').write_text('\n'.join(lines)+'\n')
    with (HERE/'netlists/nodes.tsv').open('w') as f:
        w = csv.writer(f, delimiter='\t')
        w.writerow(['spef_node', 'spice_node'])
        w.writerows(sorted(mapping.items()))
    pins = {f'{inst}/{pin}': mapping[node] for (inst, pin), node in pin_nodes.items()}
    (HERE/'netlists/pin_nodes.json').write_text(json.dumps(pins, indent=2)+'\n')
    summary = dict(signal_cells=len(cells), transistors=transistors, signal_pins=len(pin_nodes),
                   signal_ports=len(port_nodes), spef_nets=len(sections), resistors=len(resistors),
                   ground_capacitors=len(grounded), coupling_capacitors=len(coupling),
                   listed_positive_couplings=sum(v>0 and b!='0' for a,b,v in caps),
                   ground_cap_f=sum(v for _,_,v in grounded), coupling_cap_f=sum(coupling.values()),
                   cell_types=dict(Counter(k for k,_ in cells.values())), nets=totals,
                   source_inputs=[sha(p) for p in [routed,spef_path,*cell_files,*used_models,
                                                   ngdir/'all.spice',ngdir/'parameters/lod.spice']],
                   model_library=str(PDK/'libs.tech/ngspice/sky130.lib.spice'))
    (HERE/'netlists/conversion.json').write_text(json.dumps(summary,indent=2)+'\n')
    print('RC_CONVERSION_PASS:', {k:summary[k] for k in ['signal_cells','transistors','signal_pins','spef_nets','resistors','ground_capacitors','coupling_capacitors']})
    return summary


if __name__ == '__main__':
    prepare()
