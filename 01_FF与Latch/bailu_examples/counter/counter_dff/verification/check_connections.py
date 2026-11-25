#!/usr/bin/env python3
"""Compare every cell and pin of the Xschem export against counter_mapped.v."""
from pathlib import Path
import re

root = Path(__file__).resolve().parent.parent
source = (root / 'counter_mapped.v').read_text()
export = (root / 'verification/counter_from_schematic.v').read_text()
types = {'yosys_and': '$_AND_', 'yosys_xor': '$_XOR_',
         'yosys_not': '$_NOT_', 'yosys_mux': '$_MUX_',
         'yosys_dff_pn0': '$_DFF_PN0_'}

def pins(body):
    return {p: re.sub(r'\s+', '', n).replace('count_o[', 'count[')
            for p, n in re.findall(r'\.(\w+)\s*\(\s*([^()]*)\)', body)}

expected = {}
for typ, name, body in re.findall(
        r'\\(\$_[A-Z0-9_]+)\s+(\S+)\s*(?:/\*.*?\*/)?\s*\((.*?)\);',
        source, re.S):
    if name.startswith('\\count_o_reg['):
        number = 7 + int(re.search(r'\[(\d+)\]', name).group(1))
    else:
        number = int(name.strip('_'))
    expected[f'U{number}'] = (typ, pins(body))
actual = {name: (types[typ], pins(body)) for typ, name, body in re.findall(
    r'(yosys_\w+)\s+(U\d+)\s*\((.*?)\);', export, re.S)}
assert len(expected) == 14, f'Expected 14 source cells, found {len(expected)}'
assert expected == actual, '\n'.join(
    f'{k}: expected {expected.get(k)}, got {actual.get(k)}'
    for k in expected.keys() | actual.keys() if expected.get(k) != actual.get(k))
assert re.search(r'output\s+wire\s+\[3:0\]\s+count', export)
for port in ['clk', 'rst_n', 'en']:
    assert re.search(r'input\s+wire\s+' + port + r'\b', export)
print(f'PASS: all {len(actual)} cell types, {sum(len(p) for _, p in actual.values())} pin connections, and 4 ports match counter_mapped.v.')
