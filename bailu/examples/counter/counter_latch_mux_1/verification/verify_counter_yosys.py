"""Re-export the Xschem drawing and compare every connected cell pin."""
from collections import Counter
from pathlib import Path
import re
import shutil
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent.parent


def cells(path):
    source = re.sub(r'//[^\n]*', '', path.read_text())
    matches = re.findall(r'\\(\$_\w+_)\s+(\w+)\s*\((.*?)\);', source, re.S)
    result = {}
    for kind, name, body in matches:
        pins = dict(re.findall(r'\.(\w+)\s*\(\s*([^()\s]+)\s*\)', body))
        pins = {pin: net.replace('count_o[', 'count[') for pin, net in pins.items()}
        assert name not in result, f'Duplicate instance: {name}'
        result[name] = (kind, pins)
    return result


def main():
    with tempfile.TemporaryDirectory(prefix='counter-yosys-') as directory:
        subprocess.run([
            shutil.which('xschem') or 'xschem', '-x', '-r', '-q', '-n', '-w',
            '--rcfile', str(ROOT / 'xschem_yosysrc'),
            '--tcl', f'set USER_CONF_DIR {{{directory}}}; set bespice_listen_port {{}}; '
                     f'set local_netlist_dir 0; set netlist_dir {{{directory}}}',
            '-o', directory, '-N', 'counter_yosys_extracted.v',
            str(ROOT / 'counter_yosys.sch'),
        ], cwd=ROOT, check=True)
        exported = Path(directory) / 'counter_yosys_extracted.v'
        expected = cells(ROOT / 'counter_yosys.v')
        actual = cells(exported)
        assert len(expected) == 18, 'Unexpected source cell count'
        assert expected == actual, 'Instance, cell type, or signal pin mismatch'
        assert Counter(kind for kind, _ in actual.values()) == {
            '$_DFF_PN0_': 8, '$_MUX_': 4, '$_AND_': 2, '$_XOR_': 3, '$_NOT_': 1,
        }
        assert sum(len(pins) for _, pins in actual.values()) == 65
        verilog = exported.read_text()
        assert re.search(r'output\s+wire\s+\[3:0\]\s+count\b', verilog)
        assert set(re.findall(r'input\s+wire\s+(\w+)', verilog)) == {
            'clk_1', 'clk_2', 'rst_n', 'en',
        }
        assert '\0' not in verilog
        (ROOT / 'simulation/counter_yosys_extracted.v').write_text(verilog)

    report = (
        'PASS: all 18 instance names and Yosys cell types match counter_yosys.v.\n'
        'PASS: all 65 signal-pin connections match (count_o[n] = count[n]).\n'
        'PASS: 8 DFF_PN0, 4 MUX, 2 AND, 3 XOR, 1 NOT.\n'
        'PASS: clk_1, clk_2, rst_n, en, count[3:0] match the top-level ports.\n'
        'PASS: no missing or additional cells; no unconnected cell pins.\n'
        'Scope: structural connectivity; no physical timing verification.\n'
    )
    (ROOT / 'verification/counter_yosys_connections.txt').write_text(report)
    print(report, end='')


if __name__ == '__main__':
    main()
