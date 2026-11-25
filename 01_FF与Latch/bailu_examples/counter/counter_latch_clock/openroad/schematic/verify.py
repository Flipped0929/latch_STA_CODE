"""Check xschem's exported instance masters and nets against routed Verilog."""
from collections import Counter
from pathlib import Path
import hashlib
import json
import re

root = Path(__file__).resolve().parents[2]
source = root / 'openroad/results/counter_routed.v'
exported = root / 'simulation/counter_routed.v'


def parse(path):
    return {name: (master, dict(re.findall(r'\.(\w+)\s*\(\s*([^()]+?)\s*\)', body)))
            for master, name, body in re.findall(r'\b(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);', path.read_text(), re.S)}


def canonical(net):
    return re.sub(r'^count_o\[(\d)\]$', r'count[\1]', net)


reference, actual = parse(source), parse(exported)
power_view = parse(root / 'openroad/results/counter_power.v')
sch_properties = {
    name: dict(re.findall(r'(\w+)=([^\s}]+)', properties))
    for name, properties in re.findall(
        r'C \{symbols/sky130_stdcells/[^}]+\}[^\n]+\{name=(\S+) ([^}\n]+)\}',
        (root / 'counter_routed.sch').read_text())
}
assert len(reference) == 23 and set(actual) == set(reference)
connections = 0
for name, (master, pins) in reference.items():
    assert actual[name][0] == master, (name, master, actual[name][0])
    observed = dict(actual[name][1])
    if name == 'clkload0':
        floating = observed.pop('Y')
        assert sum(net == floating for _, ports in actual.values() for net in ports.values()) == 1
        assert '// noconn #' + floating in exported.read_text()
    expected = {pin: canonical(net) for pin, net in pins.items()}
    assert observed == expected, (name, expected, observed)
    for power_pin, supply in {'VPWR': 'VDD', 'VPB': 'VDD', 'VGND': 'VSS', 'VNB': 'VSS'}.items():
        assert power_view[name][1][power_pin] == sch_properties[name][power_pin] == supply, (name, power_pin)
    connections += len(pins)
text = exported.read_text()
for port in ['clk_1', 'clk_2', 'en', 'rst_n']:
    assert re.search(r'input\s+wire\s+' + port + r'\b', text)
assert re.search(r'output\s+wire\s+\[3:0\]\s+count\b', text)
assert 'input wire' not in text.split(');', 1)[1]
masters = dict(sorted(Counter(master for master, _ in actual.values()).items()))
report = {
    'instance_count': len(actual), 'matched_routed_signal_connections': connections,
    'ports': {'inputs': ['clk_1', 'clk_2', 'en', 'rst_n'], 'output': 'count[3:0]'},
    'masters': masters, 'dummy_output': 'clkload0/Y remains unconnected (xschem NC marker)',
    'aliases': 'count_o[i] is merged into count[i] as in the routed assign statements',
    'power_connections': 'VPWR/VPB=VDD; VGND/VNB=VSS, matching counter_power.v',
    'sha256': {str(path.relative_to(root)): hashlib.sha256(path.read_bytes()).hexdigest()
               for path in [source, root / 'openroad/results/counter_power.v', exported, root / 'counter_routed.sch']},
}
here = Path(__file__).resolve().parent
(here / 'verification.json').write_text(json.dumps(report, indent=2) + '\n')
message = (f'PASS: All {len(actual)} routed instance names and master cells match.\n'
           f'PASS: All {connections} connected signal pins match, allowing only count_o/count aliases.\n'
           'PASS: CTS dummy clkload0/Y has an NC marker and no other load.\n'
           'PASS: Four top-level inputs and the 4-bit output match.\n')
message += 'PASS: All 23 cells use the VDD/VSS power assignments of the routed power view.\n'
(here / 'verification.rpt').write_text(message)
print(message, end='')
