"""Check actual xschem exports against every source instance and pin."""
from collections import Counter
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent.parent
PATTERN = r'(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);'


def cells(path, extracted=False):
    source = re.sub(r'//[^\n]*', '', path.read_text())
    result = {}
    for kind, name, body in re.findall(PATTERN, source, re.S):
        if extracted:
            assert name.startswith('x'), name
            name = name[1:]
        pins = dict(re.findall(r'\.(\w+)\s*\(\s*([^()\s]+)\s*\)', body))
        pins = {pin: net.replace('count_o[', 'count[') for pin, net in pins.items()}
        assert name not in result, name
        result[name] = (kind, pins)
    return result


expected = cells(ROOT / 'counter_sky130.v')
actual = cells(ROOT / 'simulation/counter_sky130_extracted.v', True)
assert len(expected) == 31
assert expected == actual, '\n'.join(
    f'{name}: expected {expected.get(name)}, got {actual.get(name)}'
    for name in expected.keys() | actual.keys() if expected.get(name) != actual.get(name))

# Confirm every external signal has the right direction and count width.
export = (ROOT / 'simulation/counter_sky130_extracted.v').read_text()
for name in ['clk_1', 'clk_2', 'rst_n', 'en', 'VPWR', 'VGND']:
    assert re.search(r'\binput\s+wire\s+' + name + r'\s*[,)]', export), name
assert re.search(r'\boutput\s+wire\s+\[3:0\]\s+count\s*[,)]', export)

orders = {
    'dlrtp_1': 'D GATE RESET_B VGND VNB VPB VPWR Q',
    'dlxtp_1': 'D GATE VGND VNB VPB VPWR Q',
    'mux2_1': 'A0 A1 S VGND VNB VPB VPWR X',
    'and2_1': 'A B VGND VNB VPB VPWR X',
    'xor2_1': 'A B VGND VNB VPB VPWR X',
    'inv_1': 'A VGND VNB VPB VPWR Y',
}
seen = set()
spice = (ROOT / 'simulation/counter_sky130.spice').read_text()
assert '\0' not in spice
for line in spice.splitlines():
    if not line.startswith('x'):
        continue
    name, *nodes, kind = line.split()
    name = name[1:]
    assert name not in seen
    seen.add(name)
    expected_kind, pins = expected[name]
    assert kind == expected_kind
    order = orders[kind.removeprefix('sky130_fd_sc_hd__')].split()
    assert len(nodes) == len(order)
    pins = pins | dict(VGND='VGND', VNB='VGND', VPB='VPWR', VPWR='VPWR')
    assert nodes == [pins[pin] for pin in order], name
assert seen == expected.keys()

pin_count = sum(len(pins) for _, pins in expected.values())
report = (
    f'PASS: {len(expected)}/31 standard-cell instances match counter_sky130.v.\n'
    f'PASS: all {pin_count} signal pins match after count_o -> count aliasing.\n'
    f'PASS: all {4 * len(expected)} SPICE power/body connections match: VGND=VNB, VPWR=VPB.\n'
    'PASS: 4 signal inputs, the count[3:0] output bus, and 2 power inputs.\n'
    'PASS: no missing or additional standard cells.\n'
    + ''.join(f'  {kind}: {number}\n' for kind, number in sorted(Counter(k for k, _ in expected.values()).items()))
)
(ROOT / 'verification/connections.txt').write_text(report)
print(report, end='')
