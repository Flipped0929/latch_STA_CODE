"""Extract with xschem and compare every signal and power pin with the source.

Run with --refresh after editing the schematic; without it, check saved exports.
"""
from collections import Counter
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent.parent
STEM = 'counter_sky130_1'


def cells(path, extracted=False):
    source = re.sub(r'//[^\n]*', '', path.read_text())
    result = {}
    for kind, name, body in re.findall(
            r'(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);', source, re.S):
        if extracted:
            assert name.startswith('x'), name
            name = name[1:]
        pins = dict(re.findall(r'\.(\w+)\s*\(\s*([^()\s]+)\s*\)', body))
        pins = {pin: net.replace('count_o[', 'count[') for pin, net in pins.items()}
        assert name not in result, name
        result[name] = (kind, pins)
    return result


def refresh():
    xschem = shutil.which('xschem')
    assert xschem, 'xschem must be on PATH'
    with tempfile.TemporaryDirectory(prefix=STEM + '-') as temporary:
        for flag, filename in [('-s', STEM + '.spice'),
                               ('-w', STEM + '_extracted.v')]:
            subprocess.run([
                xschem, '-x', '-r', '-q', '-n', flag,
                '--rcfile', str(ROOT / 'xschemrc'),
                '--tcl', (f'set local_netlist_dir 0; set netlist_dir {{{temporary}}}; '
                          f'set USER_CONF_DIR {{{temporary}}}; set bespice_listen_port {{}}'),
                '-o', temporary, '-N', filename, str(ROOT / (STEM + '.sch')),
            ], cwd=ROOT, check=True)
            data = (Path(temporary) / filename).read_bytes()
            assert b'\0' not in data, filename
            (ROOT / 'simulation').mkdir(exist_ok=True)
            (ROOT / 'simulation' / filename).write_bytes(data)


def verify():
    expected = cells(ROOT / (STEM + '.v'))
    actual = cells(ROOT / 'simulation' / (STEM + '_extracted.v'), True)
    assert len(expected) == 19
    assert actual == expected, 'Verilog cell, instance, or signal pin mismatch'
    assert Counter(k for k, _ in actual.values()) == {
        'sky130_fd_sc_hd__dlrtp_1': 9,
        'sky130_fd_sc_hd__mux2_1': 3,
        'sky130_fd_sc_hd__and2_1': 2,
        'sky130_fd_sc_hd__and3_1': 1,
        'sky130_fd_sc_hd__xor2_1': 3,
        'sky130_fd_sc_hd__inv_1': 1,
    }
    # Pin order from each installed SKY130 xschem symbol's format property.
    orders = {
        'dlrtp_1': 'D GATE RESET_B VGND VNB VPB VPWR Q',
        'mux2_1': 'A0 A1 S VGND VNB VPB VPWR X',
        'and2_1': 'A B VGND VNB VPB VPWR X',
        'and3_1': 'A B C VGND VNB VPB VPWR X',
        'xor2_1': 'A B VGND VNB VPB VPWR X',
        'inv_1': 'A VGND VNB VPB VPWR Y',
    }
    spice = (ROOT / 'simulation' / (STEM + '.spice')).read_text()
    assert '\0' not in spice
    seen = set()
    for line in spice.splitlines():
        if not line.startswith('x'):
            continue
        name, *nodes, kind = line.split()
        name = name[1:]
        assert name not in seen, name
        seen.add(name)
        expected_kind, pins = expected[name]
        assert kind == expected_kind, name
        order = orders[kind.removeprefix('sky130_fd_sc_hd__')].split()
        pins = pins | dict(VGND='VGND', VNB='VGND', VPB='VPWR', VPWR='VPWR')
        assert nodes == [pins[pin] for pin in order], name
    assert seen == expected.keys()
    top = re.search(r'^\.subckt\s+' + STEM + r'\s+(.+)$', spice, re.M)
    assert top and top[1].split() == [
        'clk_1', 'clk_2', 'rst_n', 'en', 'VPWR', 'VGND',
        'count[3]', 'count[2]', 'count[1]', 'count[0]',
    ], 'Top-level port mismatch'
    signal_count = sum(len(pins) for _, pins in expected.values())
    report = (
        f'PASS: 19/19 standard-cell types and instance names match {STEM}.v.\n'
        f'PASS: {signal_count}/{signal_count} signal-pin connections match (count_o -> count aliases).\n'
        'PASS: 76/76 SPICE power/body connections match: VGND=VNB, VPWR=VPB.\n'
        'PASS: 9 latches, 3 muxes, 3 XORs, 2 AND2s, 1 AND3, 1 inverter.\n'
        'PASS: all top-level signal and supply ports match.\n'
        'PASS: no missing or additional standard cells.\n'
        'Scope: structural connectivity; no transistor simulation or timing signoff.\n'
    )
    (ROOT / 'verification' / (STEM + '_connections.txt')).write_text(report)
    print(report, end='')


if __name__ == '__main__':
    if '--refresh' in sys.argv[1:]:
        refresh()
    verify()
