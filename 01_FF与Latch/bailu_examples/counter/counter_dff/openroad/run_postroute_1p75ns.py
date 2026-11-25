#!/usr/bin/env python3
"""Analyze existing routing at 1.75 ns; preserve the original 2 ns results."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile

root = Path(__file__).resolve().parent
out = root / 'postroute_1p75ns'
work = Path(tempfile.mkdtemp(prefix='counter_dff_sta_1p75ns_'))
for name in ('inputs', 'scripts', 'results', 'logs'):
    (work / name).mkdir()
sources = [root.parent / 'counter.sdc', root / 'results/counter_routed.v',
           root / 'results/counter.spef', root / 'scripts/common.tcl', root / 'scripts/sta.tcl', Path(__file__).resolve()]
for name in ('common.tcl', 'sta.tcl'):
    shutil.copy2(root / 'scripts' / name, work / 'scripts' / name)
shutil.copy2(root.parent / 'counter.sdc', work / 'inputs/counter.sdc')
for name in ('counter_routed.v', 'counter.spef'):
    shutil.copy2(root / 'results' / name, work / 'results' / name)
platform = Path(os.environ.get('SKY130HD_PLATFORM', '/home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd'))
sources.append(platform / 'lib/sky130_fd_sc_hd__tt_025C_1v80.lib')
manifest = {'status': 'running', 'created_utc': datetime.now(timezone.utc).isoformat(),
            'work_directory': str(work), 'period_ns': 1.75, 'waveform_ns': [0.0, 0.875],
            'physical_implementation': 'Existing 2 ns routing reused without modification',
            'sources': [{'path': str(p), 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in sources]}
try:
    sdc = (work / 'inputs/counter.sdc').read_text()
    assert '-period 1.75 -waveform {0.00 0.875}' in sdc, 'Expected 1.75 ns clock and 50% duty cycle'
    for exe, subdir in [('openroad', 'postroute'), ('sta', 'standalone_sta')]:
        print(f'Running {exe} at 1.75 ns', flush=True)
        manifest[exe + '_version'] = subprocess.check_output([exe, '-version'], text=True).strip()
        with (work / 'logs' / (exe + '.log')).open('w') as log:
            subprocess.run([exe, '-no_init', '-exit', str(work / 'scripts/sta.tcl')], check=True,
                           stdout=log, stderr=subprocess.STDOUT, cwd=work,
                           env={**os.environ, 'STA_REPORT_SUBDIR': subdir})
    reports = work / 'reports/postroute'
    other = work / 'reports/standalone_sta'
    for name in ('summary.rpt', 'setup.rpt', 'hold.rpt', 'recovery.rpt', 'removal.rpt'):
        assert (reports / name).read_bytes() == (other / name).read_bytes(), name
    assert not (reports / 'check_setup.rpt').read_text().strip(), 'Constraint coverage failed'
    assert (reports / 'parasitic_annotation.rpt').read_text().strip() == 'Found 2 unannotated drivers.\n VDD\n VSS\nFound 0 partially unannotated drivers.'
    summary = (reports / 'summary.rpt').read_text()
    metrics = {kind.replace(' ', '_') + '_' + mode: float(value) for kind, mode, value in
               re.findall(r'(worst slack|tns) (max|min) ([-\d.]+)', summary)}
    slacks = {}
    for name in ('data_setup', 'data_hold', 'output_setup', 'output_hold', 'rst_n_setup', 'rst_n_hold'):
        values = re.findall(r'([-+\d.]+)\s+slack \(', (reports / (name + '.rpt')).read_text())
        slacks[name] = min(map(float, values))
    violation_counts = {name: (reports / (name + '_violations.rpt')).read_text().count('slack (VIOLATED)')
                        for name in ('setup', 'hold')}
    result = {'period_ns': 1.75, 'waveform_ns': [0.0, 0.875], 'corner': 'SKY130 HD TT / 25 C / 1.80 V',
              'metrics_ns': metrics, 'path_slacks_ns': slacks, 'violation_counts': violation_counts,
              'standalone_sta_matches': True, 'constraint_coverage_passed': True,
              'timing_passed': metrics['worst_slack_max'] >= 0 and metrics['worst_slack_min'] >= 0}
    (work / 'reports/summary.json').write_text(json.dumps(result, indent=2) + '\n')
    manifest['status'] = 'complete'
    manifest['timing_passed'] = result['timing_passed']
    print(json.dumps(result, indent=2), flush=True)
except Exception:
    manifest['status'] = 'failed'
    raise
finally:
    out.mkdir(exist_ok=True)
    for name in ('inputs', 'scripts', 'results', 'reports', 'logs'):
        if (work / name).exists():
            shutil.copytree(work / name, out / name, dirs_exist_ok=True)
    manifest['artifacts'] = [{'path': str(p.relative_to(work)), 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()}
                             for p in sorted(work.rglob('*')) if p.is_file()]
    (out / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
