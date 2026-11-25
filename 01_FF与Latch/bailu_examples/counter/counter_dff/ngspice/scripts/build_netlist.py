"""Convert this routed counter's named-pin Verilog and OpenRCX SPEF to SPICE.

Fail closed on missing pins, mismatched logical nets, disconnected RC trees,
unsupported units, or inconsistent duplicate coupling-capacitor records.
"""
from collections import Counter, defaultdict
import json
from pathlib import Path
import re


def clean(value):
    return value.replace('\\', '')


class UnionFind:
    def __init__(self):
        self.parent = {}

    def find(self, node):
        self.parent.setdefault(node, node)
        if self.parent[node] != node:
            self.parent[node] = self.find(self.parent[node])
        return self.parent[node]

    def join(self, a, b):
        self.parent[self.find(a)] = self.find(b)


def build(work):
    verilog = (work / 'inputs/counter_routed.v').read_text()
    spef = (work / 'inputs/counter.spef').read_text()
    assert '*C_UNIT 1 PF' in spef and '*R_UNIT 1 OHM' in spef
    assert '"PIN_CAP NONE"' in spef, 'Cell input capacitance must not be counted twice'
    aliases = UnionFind()
    for a, b in re.findall(r'assign\s+(\S+)\s*=\s*(\S+)\s*;', verilog):
        aliases.join(clean(a), clean(b))

    cells = {}
    for master, inst, body in re.findall(
            r'(sky130_fd_sc_hd__\w+)\s+(\\\S+|\w+)\s*\((.*?)\);', verilog, re.S):
        pins = dict(re.findall(r'\.(\w+)\(([^)]+)\)', body))
        cells[clean(inst)] = (master, {p: aliases.find(clean(n.strip())) for p, n in pins.items()})
    assert len(cells) == 17
    expected = {'mux2_1': 4, 'and2_1': 2, 'xor2_1': 3, 'inv_1': 1,
                'clkbuf_4': 3, 'dfrtp_1': 4}
    assert Counter(m.split('__')[1] for m, _ in cells.values()) == expected

    name_map = {}
    mapped = spef.split('*NAME_MAP\n', 1)[1].split('*PORTS\n', 1)[0]
    for key, name in re.findall(r'^\*(\d+)\s+(.+)$', mapped, re.M):
        name_map[key] = clean(name)

    def expand(token):
        return clean(re.sub(r'\*(\d+)', lambda m: name_map[m[1]], token))

    nets, net, section = [], None, None
    for line in spef.splitlines():
        fields = line.split()
        if not fields:
            continue
        if fields[0] == '*D_NET':
            net = {'name': expand(fields[1]), 'declared_cap_pf': float(fields[2]),
                   'connections': [], 'caps': [], 'resistors': []}
            nets.append(net)
        elif fields[0] in ('*CONN', '*CAP', '*RES', '*END'):
            section = fields[0]
        elif net is not None and section == '*CONN' and fields[0] in ('*I', '*P'):
            net['connections'].append((fields[0], expand(fields[1])))
        elif fields[0].isdigit() and section in ('*CAP', '*RES'):
            nodes = [expand(f) for f in fields[1:-1]]
            value = float(fields[-1])
            assert value >= 0
            net['caps' if section == '*CAP' else 'resistors'].append((nodes, value))
    assert len(nets) == 20

    pin_nodes, node_net = {}, {}
    grounds = defaultdict(float)
    # A physical coupling capacitor is printed once in each adjacent D_NET.
    coupling_records = defaultdict(dict)
    resistors = []
    for net in nets:
        logical = aliases.find(net['name'])
        tree = UnionFind()
        for nodes, value in net['resistors']:
            a, b = nodes
            assert value > 0, 'A zero-ohm wire needs exact node merging'
            tree.join(a, b)
            resistors.append((a, b, value))
            for node in nodes:
                assert node not in node_net or node_net[node] == logical
                node_net[node] = logical
        for kind, node in net['connections']:
            assert node in node_net and node_net[node] == logical, node
            if kind == '*I':
                inst, pin = node.rsplit(':', 1)
                assert inst in cells and pin in cells[inst][1], node
                assert cells[inst][1][pin] == logical, (node, logical)
                pin_nodes[(inst, pin)] = node
            else:
                assert aliases.find(node) == logical, node
        assert len({tree.find(node) for node in tree.parent}) == 1, net['name']
        assert abs(sum(v for _, v in net['caps']) - net['declared_cap_pf']) < 5e-8
        local_couplings = defaultdict(float)
        for nodes, value in net['caps']:
            if len(nodes) == 1:
                grounds[nodes[0]] += value
            else:
                assert len(nodes) == 2
                local_couplings[tuple(sorted(nodes))] += value
        for pair, value in local_couplings.items():
            coupling_records[pair][logical] = value

    couplings = []
    for pair, records in coupling_records.items():
        a, b = pair
        assert a in node_net and b in node_net, pair
        values = list(records.values())
        assert len(values) == 2 and node_net[a] != node_net[b], (pair, records)
        assert abs(values[0] - values[1]) < 1e-12, pair
        if values[0] > 0:
            couplings.append((a, b, values[0]))
    assert set(grounds) <= set(node_net)

    ports = {'clk': 'clk', 'en': 'en', 'rst_n': 'rst_n',
             **{f'count[{i}]': f'count{i}' for i in range(4)}}
    nodes = dict(ports)
    for original in sorted(node_net):
        if original not in nodes:
            nodes[original] = f'n{len(nodes):04d}'
    body = ['* Final routed counter: transistor cell models plus distributed SPEF RC.',
            '* SPEF C_UNIT pF; R_UNIT ohm; cell pin capacitance is provided by MOS models.',
            '.subckt counter_postlayout clk en rst_n count0 count1 count2 count3 vdd vss']
    signal_pins = 0
    mos_count = 0
    cell_info = []
    for index, (inst, (master, pins)) in enumerate(cells.items()):
        text = (work / 'models' / (master + '.spice')).read_text()
        match = re.search(r'^\.subckt\s+(\S+)\s+(.+)$', text, re.M | re.I)
        assert match and match[1] == master
        order = match[2].split()
        assert set(pins) == set(order) - {'VGND', 'VNB', 'VPB', 'VPWR'}
        signal_pins += len(pins)
        connections = []
        for pin in order:
            if pin in ('VGND', 'VNB'):
                connections.append('vss')
            elif pin in ('VPWR', 'VPB'):
                connections.append('vdd')
            else:
                connections.append(nodes[pin_nodes[(inst, pin)]])
        count = len(re.findall(r'^X\S+\s', text, re.M))
        mos_count += count
        body.extend([f'* {inst}', f'Xcell{index:02d} ' + ' '.join(connections) + ' ' + master])
        cell_info.append({'instance': inst, 'master': master, 'spice_instance': f'Xcell{index:02d}',
                          'mosfets': count})
    assert len(pin_nodes) == signal_pins == 55
    for index, (a, b, value) in enumerate(resistors):
        body.append(f'Rwire{index} {nodes[a]} {nodes[b]} {value:.12g}')
    caps = [(node, None, value) for node, value in grounds.items() if value > 0] + couplings
    for index, (a, b, value) in enumerate(caps):
        # Use vss as ground, preserving the top-level supply connection.
        body.append(f'Cwire{index} {nodes[a]} {nodes[b] if b else "vss"} {value:.12g}p')
    body.extend(['.ends counter_postlayout', ''])
    (work / 'inputs/counter_postlayout.spice').write_text('\n'.join(body))
    node_rows = ['spice_node\tspef_node\tlogical_net']
    node_rows.extend(f'{mapped}\t{original}\t{node_net[original]}' for original, mapped in nodes.items())
    (work / 'reports/node_map.tsv').write_text('\n'.join(node_rows) + '\n')
    info = {'signal_clock_nets': len(nets), 'functional_cells_including_cts': len(cells),
            'cell_signal_pins_connected': signal_pins, 'mosfets': mos_count,
            'wire_resistors': len(resistors),
            'wire_ground_capacitors': sum(v > 0 for v in grounds.values()),
            'wire_coupling_capacitors': len(couplings),
            'wire_ground_capacitance_pf': sum(grounds.values()),
            'wire_coupling_capacitance_pf': sum(c for _, _, c in couplings),
            'duplicated_spef_couplings_deduplicated': True,
            'pin_connectivity_and_rc_tree_checks_passed': True,
            'cells': cell_info,
            'probe_nodes': {f'{inst}/{pin}': nodes[node] for (inst, pin), node in pin_nodes.items()}}
    (work / 'reports/netlist_audit.json').write_text(json.dumps(info, indent=2) + '\n')
    return info
