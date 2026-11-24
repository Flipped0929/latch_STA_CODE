#!/usr/bin/env python3
"""Run in /tmp and copy results back to the HGFS project directory."""
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
from datetime import datetime, timezone

root = Path(__file__).resolve().parent
project = root.parent
platform = Path(os.environ.get('SKY130HD_PLATFORM', '/home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd'))
work = Path(tempfile.mkdtemp(prefix='counter_dff_openroad_'))
(work / 'inputs').mkdir()
(work / 'logs').mkdir()
shutil.copytree(root / 'scripts', work / 'scripts')
sources = [project / 'counter_sky130.v', project / 'counter.sdc',
           platform / 'lef/sky130_fd_sc_hd.tlef', platform / 'lef/sky130_fd_sc_hd_merged.lef',
           platform / 'lib/sky130_fd_sc_hd__tt_025C_1v80.lib', platform / 'rcx_patterns.rules',
           platform / 'setRC.tcl', platform / 'make_tracks.tcl', Path(__file__).resolve(),
           *sorted((root / 'scripts').glob('*'))]
for name in ('counter_sky130.v', 'counter.sdc'):
    shutil.copy2(project / name, work / 'inputs' / name)
manifest = {'work_directory': str(work), 'platform': str(platform), 'status': 'running',
            'created_utc': datetime.now(timezone.utc).isoformat(),
            'openroad_version': subprocess.check_output(['openroad', '-version'], text=True).strip(),
            'sources': [{'path': str(p), 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in sources]}
try:
    for stage in ('pnr', 'extract', 'sta', 'audit'):
        print(f'Running {stage}: {work}', flush=True)
        with (work / 'logs' / f'{stage}.log').open('w') as log:
            subprocess.run(['openroad', '-no_init', '-exit', str(work / 'scripts' / f'{stage}.tcl')],
                           stdout=log, stderr=subprocess.STDOUT, check=True, cwd=work)
    sta = shutil.which('sta')
    if not sta:
        raise RuntimeError('OpenSTA executable sta is required for independent timing verification')
    if sta:
        with (work / 'logs/standalone_sta.log').open('w') as log:
            subprocess.run([sta, '-no_init', '-exit', str(work / 'scripts/sta.tcl')],
                           stdout=log, stderr=subprocess.STDOUT, check=True, cwd=work,
                           env={**os.environ, 'STA_REPORT_SUBDIR': 'standalone_sta'})
    subprocess.run(['python3', str(work / 'scripts/verify_results.py')], cwd=work, check=True)
    subprocess.run(['python3', str(work / 'scripts/render_preview.py')], cwd=work, check=True)
    manifest['status'] = 'complete'
except Exception:
    manifest['status'] = 'failed'
    raise
finally:
    for name in ('inputs', 'results', 'reports', 'logs'):
        if (work / name).exists():
            shutil.copytree(work / name, root / name, dirs_exist_ok=True)
    manifest['artifacts'] = [{'path': str(p.relative_to(work)), 'sha256': hashlib.sha256(p.read_bytes()).hexdigest(),
                              'bytes': p.stat().st_size}
                             for name in ('inputs', 'results', 'reports', 'logs')
                             for p in sorted((work / name).rglob('*')) if p.is_file()]
    (root / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(f"Status: {manifest['status']}; results: {root}; work: {work}", flush=True)
