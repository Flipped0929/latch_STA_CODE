"""Compare actual xschem SPICE/Verilog exports to the source cell connections."""
from pathlib import Path
from collections import Counter
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
assert len(expected) == 19
assert expected == actual, 'Verilog instance, cell type, or signal pin mismatch'
assert Counter(kind for kind, _ in actual.values()) == {
    'sky130_fd_sc_hd__dlrtp_1': 10,
    'sky130_fd_sc_hd__mux2_1': 2,
    'sky130_fd_sc_hd__xor2_1': 3,
    'sky130_fd_sc_hd__and3_1': 2,
    'sky130_fd_sc_hd__and2_1': 1,
    'sky130_fd_sc_hd__inv_1': 1,
}, 'Cell inventory mismatch'

# SPICE node order comes from the installed library symbol format strings.
orders = {
    'dlrtp_1': 'D GATE RESET_B VGND VNB VPB VPWR Q',
    'mux2_1': 'A0 A1 S VGND VNB VPB VPWR X',
    'and2_1': 'A B VGND VNB VPB VPWR X',
    'and3_1': 'A B C VGND VNB VPB VPWR X',
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
top = re.search(r'^\.subckt\s+counter_sky130\s+(.+)$', spice, re.M)
assert top and top[1].split() == [
    'clk_1', 'clk_2', 'rst_n', 'en', 'VPWR', 'VGND',
    'count[3]', 'count[2]', 'count[1]', 'count[0]',
], 'Top-level SPICE port mismatch'
verilog = (ROOT / 'simulation/counter_sky130_extracted.v').read_text()
assert re.search(r'output\s+wire\s+\[3:0\]\s+count\b', verilog)
assert set(re.findall(r'input\s+wire\s+(\w+)', verilog)) == {
    'clk_1', 'clk_2', 'rst_n', 'en', 'VPWR', 'VGND',
}, 'Top-level Verilog port mismatch'

report = (
    'PASS: 19/19 standard-cell instances match counter_sky130.v.\n'
    'PASS: all 70 signal-pin connections match after count_o -> count aliasing.\n'
    'PASS: all 76 SPICE power/body connections match: VGND=VNB, VPWR=VPB.\n'
    'PASS: 10 latches, 2 muxes, 3 XORs, 2 AND3s, 1 AND2, 1 inverter.\n'
    'PASS: all top-level signal and supply ports match.\n'
    'PASS: no missing or additional standard cells.\n'
    'Scope: structural connectivity; no transistor simulation or timing signoff.\n'
)
assert sum(len(pins) for _, pins in expected.values()) == 70
(ROOT / 'verification/connections.txt').write_text(report)
print(report, end='')
