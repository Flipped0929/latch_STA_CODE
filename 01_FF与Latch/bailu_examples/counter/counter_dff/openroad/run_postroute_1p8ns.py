#!/usr/bin/env python3
"""Analyze timing and VCD-based counting power on existing routing at 1.8 ns."""
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
out = root / 'postroute_1p8ns'
work = Path(tempfile.mkdtemp(prefix='counter_dff_sta_1p8ns_'))
for name in ('inputs', 'scripts', 'results', 'logs'):
    (work / name).mkdir()
sources = [root.parent / 'counter.sdc', root / 'results/counter_routed.v',
           root / 'results/counter.spef', *[root / 'scripts' / name for name in ('common.tcl', 'sta.tcl', 'power.tcl', 'counter_power_tb.v')], Path(__file__).resolve()]
for name in ('common.tcl', 'sta.tcl', 'power.tcl', 'counter_power_tb.v'):
    shutil.copy2(root / 'scripts' / name, work / 'scripts' / name)
shutil.copy2(root.parent / 'counter.sdc', work / 'inputs/counter.sdc')
for name in ('counter_routed.v', 'counter.spef'):
    shutil.copy2(root / 'results' / name, work / 'results' / name)
platform = Path(os.environ.get('SKY130HD_PLATFORM', '/home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd'))
sources.append(platform / 'lib/sky130_fd_sc_hd__tt_025C_1v80.lib')
models = Path(os.environ.get('SKY130_SIM_MODELS',
    '/home/bailufrost/eda/OpenROAD-flow-scripts/tools/OpenROAD/src/sta/examples'))
sources.extend(models / name for name in ('sky130_hd_primitives.v', 'sky130_hd.v'))
manifest = {'status': 'running', 'created_utc': datetime.now(timezone.utc).isoformat(),
            'work_directory': str(work), 'period_ns': 1.8, 'waveform_ns': [0.0, 0.9],
            'physical_implementation': 'Existing 2 ns routing reused without modification',
            'sources': [{'path': str(p), 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in sources]}
try:
    sdc = (work / 'inputs/counter.sdc').read_text()
    assert '-period 1.80 -waveform {0.00 0.90}' in sdc, 'Expected 1.8 ns clock and 50% duty cycle'
    manifest['iverilog_version'] = subprocess.check_output(['iverilog', '-V'], text=True, stderr=subprocess.STDOUT).splitlines()[0]
    with (work / 'logs/simulation.log').open('w') as log:
        subprocess.run(['iverilog', '-g2012', '-DFUNCTIONAL', '-DUNIT_DELAY=', '-s', 'counter_power_tb',
                        '-o', str(work / 'counter_sim'),
                        str(models / 'sky130_hd_primitives.v'), str(models / 'sky130_hd.v'),
                        str(work / 'results/counter_routed.v'),
                        str(work / 'scripts/counter_power_tb.v')], check=True,
                       stdout=log, stderr=subprocess.STDOUT, cwd=work)
        subprocess.run(['vvp', str(work / 'counter_sim')], check=True,
                       stdout=log, stderr=subprocess.STDOUT, cwd=work)
    assert 'PASS: 272 counting checks' in (work / 'logs/simulation.log').read_text()
    for exe, subdir in [('openroad', 'postroute'), ('sta', 'standalone_sta')]:
        print(f'Running {exe} at 1.8 ns', flush=True)
        manifest[exe + '_version'] = subprocess.check_output([exe, '-version'], text=True).strip()
        with (work / 'logs' / (exe + '.log')).open('w') as log:
            subprocess.run([exe, '-no_init', '-exit', str(work / 'scripts/power.tcl')], check=True,
                           stdout=log, stderr=subprocess.STDOUT, cwd=work,
                           env={**os.environ, 'STA_REPORT_SUBDIR': subdir})
    reports = work / 'reports/postroute'
    other = work / 'reports/standalone_sta'
    for name in ('summary.rpt', 'setup.rpt', 'hold.rpt', 'recovery.rpt', 'removal.rpt'):
        assert (reports / name).read_bytes() == (other / name).read_bytes(), name
    # Both engines must consume the VCD and agree on each power component.
    def power_values(directory):
        report = (directory / 'power.rpt').read_text()
        match = re.search(r'^Total\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)', report, re.M)
        assert match, 'Missing power totals'
        values = dict(zip(('internal', 'switching', 'leakage', 'total'), map(float, match.groups())))
        assert all(value >= 0 for value in values.values()) and values['total'] > 0
        assert abs(sum(values[k] for k in ('internal', 'switching', 'leakage')) - values['total']) < max(1e-12, values['total'] * 1e-6)
        return values
    power = power_values(reports)
    reference_power = power_values(other)
    for component in power:
        assert abs(power[component] - reference_power[component]) <= max(1e-15, power[component] * 1e-6), component
    activity = (reports / 'power_activity.rpt').read_text()
    assert not re.search(r'unannotated\s+[1-9]', activity), activity
    assert re.search(r'vcd\s+64\b', activity), activity
    for name in ('counter_routed.v', 'counter.spef'):
        assert (work / 'results' / name).read_bytes() == (root / 'results' / name).read_bytes(), name
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
    result = {'period_ns': 1.8, 'waveform_ns': [0.0, 0.9], 'corner': 'SKY130 HD TT / 25 C / 1.80 V',
              'metrics_ns': metrics, 'path_slacks_ns': slacks, 'violation_counts': violation_counts,
              'standalone_sta_matches': True, 'constraint_coverage_passed': True,
              'timing_passed': metrics['worst_slack_max'] >= 0 and metrics['worst_slack_min'] >= 0}
    result['power'] = {
        'method': 'VCD from zero-delay gate-level simulation of routed netlist',
        'workload': 'Continuous counting; en=1; rst_n=1; reset and warm-up excluded',
        'recorded_cycles': 256, 'recorded_duration_ns': 460.8,
        'frequency_mhz': 1000 / 1.8,
        'output_load_pf_per_bit': 0.010,
        'units': 'W', 'components': power,
        'dynamic_w': power['internal'] + power['switching'],
        'vcd_annotated_pins': 64, 'unannotated_pins': 0,
        'simulation_counting_checks_passed': 272,
        'standalone_sta_matches': True,
        'limitations': 'TT single corner; no SDF glitch timing; tap/filler excluded from functional netlist'
    }
    (work / 'reports/summary.json').write_text(json.dumps(result, indent=2) + '\n')
    manifest['status'] = 'complete'
    manifest['timing_passed'] = result['timing_passed']
    manifest['power_workload'] = result['power']['workload']
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
                             for name in ('inputs', 'scripts', 'results', 'reports', 'logs')
                             for p in sorted((work / name).rglob('*')) if p.is_file()]
    (out / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
