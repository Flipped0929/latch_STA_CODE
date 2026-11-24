"""Extract both netlist formats from the actual xschem drawing, then check."""
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent.parent
XSCHEM = shutil.which('xschem')
if XSCHEM is None:
    raise SystemExit('xschem is not on PATH')
with tempfile.TemporaryDirectory(prefix='counter-mux2-xschem-') as temporary:
    for flag, filename in [('-s', 'counter_sky130.spice'),
                           ('-w', 'counter_sky130_extracted.v')]:
        result = subprocess.run([
            XSCHEM, '-x', '-r', '-q', '-n', flag,
            '--rcfile', str(ROOT / 'xschemrc'),
            '--tcl', f'proc update_recent_file args {{}}; set local_netlist_dir 0; set netlist_dir {{{temporary}}}',
            '-o', temporary, '-N', filename, str(ROOT / 'counter_sky130.sch'),
        ], cwd=ROOT, text=True, capture_output=True, check=True)
        (ROOT / 'verification' / f'{filename}.log').write_text(result.stdout + result.stderr)
        data = (Path(temporary) / filename).read_bytes()
        if b'\0' in data:
            raise SystemExit(f'Invalid NUL byte in {filename}')
        destination = ROOT / 'simulation'
        destination.mkdir(exist_ok=True)
        (destination / filename).write_bytes(data)
subprocess.run([sys.executable, str(ROOT / 'verification/verify_connections.py')],
               cwd=ROOT, check=True)
