"""Regenerate xschem netlists locally, then verify them against the source."""
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

root = Path(__file__).resolve().parent.parent
xschem = shutil.which('xschem')
if xschem is None:
    raise SystemExit('xschem is not on PATH')
with tempfile.TemporaryDirectory(prefix='counter-sky130-') as temporary:
    for flag, filename in [('-s', 'counter_sky130.spice'),
                           ('-w', 'counter_sky130_extracted.v')]:
        subprocess.run([
            xschem, '-x', '-r', '-q', '-n', flag,
            '--rcfile', str(root / 'xschemrc'),
            '--tcl', (f'set local_netlist_dir 0; set netlist_dir {{{temporary}}}; '
                      f'set USER_CONF_DIR {{{temporary}}}; set bespice_listen_port {{}}'),
            '-o', temporary, '-N', filename,
            str(root / 'counter_sky130.sch'),
        ], cwd=root, check=True)
        data = (Path(temporary) / filename).read_bytes()
        if b'\0' in data:
            raise SystemExit(f'Invalid NUL byte in {filename}')
        destination = root / 'simulation'
        destination.mkdir(exist_ok=True)
        (destination / filename).write_bytes(data)
subprocess.run([sys.executable, str(root / 'verification/verify_connections.py')],
               cwd=root, check=True)
