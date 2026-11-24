#!/usr/bin/env python3
"""Sweep fixed-layout post-route STA at 49% duty with unchanged external budgets."""
import csv
import hashlib
import json
import os
import re
import subprocess
from datetime import datetime, timezone
from decimal import Decimal
from pathlib import Path

ROOT = Path(__file__).resolve().parent
PNR = ROOT.parent
DESIGN = PNR.parent
BASE = PNR / 'sta_1p75ns_49pct'
LIB = (DESIGN / '../../../sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib').resolve()
PERIODS = ['1.75', '1.73', '1.7298', '1.7297', '2.319', '2.32']


def digest(path):
    return dict(path=str(path.resolve()), sha256=hashlib.sha256(path.read_bytes()).hexdigest())


def rows(path):
    with path.open() as stream:
        return list(csv.DictReader(stream, delimiter='\t'))


def path_slack(report, name):
    values = re.findall(r'([-+\d.]+)\s+slack \(', (report / f'{name}.rpt').read_text())
    if not values:
        raise RuntimeError(f'Missing paths in {name}')
    return min(map(float, values))


def main():
    baseline = (BASE / 'counter.sdc').read_text()
    physical = sorted((PNR / 'results').glob('*'))
    before = [digest(p) for p in physical if p.is_file()]
    # Old manifests contain paths from the source directory before this project was copied.
    # Check current local artifacts against those hashes by filename, never follow old paths.
    original = json.loads((PNR / 'manifest.json').read_text())
    for entry in original['outputs']:
        path = PNR / 'results' / Path(entry['path']).name
        assert digest(path)['sha256'] == entry['sha256'], path
    assert digest(LIB)['sha256'] == next(x['sha256'] for x in original['inputs'] if Path(x['path']).name == LIB.name)
    assert (DESIGN / 'counter_sky130.v').read_bytes() == (PNR / 'inputs/counter_sky130_2.v').read_bytes()
    (ROOT / 'counter_before.sdc').write_text(baseline)
    output_slack = path_slack(BASE / 'reports/openroad', 'output_setup')
    # launch phi2 rise = .505T; next phi1 fall = 1.495T; available interval = .99T.
    estimate = 1.75 - output_slack / .99
    records = []
    for value in PERIODS:
        period = Decimal(value)
        scenario = ROOT / ('T' + value.replace('.', 'p') + 'ns')
        scenario.mkdir(exist_ok=True)
        clocks = {'phi1': (period * Decimal('.005'), period * Decimal('.495')),
                  'phi2': (period * Decimal('.505'), period * Decimal('.995'))}
        sdc = re.sub(r'# Period .*?\n# The phases .*?\n',
                     f'# Period {value} ns; each phase high for {period * Decimal(".49")} ns (49%).\n'
                     f'# The phases have {period * Decimal(".01")} ns port dead time per handoff.\n', baseline)
        for name, (rise, fall) in clocks.items():
            sdc = re.sub(rf'create_clock -name {name} -period [\d.]+ -waveform \{{[\d.]+ [\d.]+\}}',
                         f'create_clock -name {name} -period {value} -waveform {{{rise:f} {fall:f}}}', sdc)
        # Every actual constraint other than the two create_clock commands stays identical.
        budgets = lambda text: [line.strip() for line in text.splitlines()
                               if line.strip() and not line.lstrip().startswith(('#', 'create_clock'))]
        assert budgets(sdc) == budgets(baseline)
        (scenario / 'counter.sdc').write_text(sdc)
        for engine, executable in [('openroad', 'openroad'), ('standalone', 'sta')]:
            report = scenario / 'reports' / engine
            (scenario / 'logs').mkdir(exist_ok=True)
            env = dict(os.environ, COUNTER_STA_SDC=str(scenario / 'counter.sdc'),
                       POSTROUTE_REPORT_DIR=str(report))
            with (scenario / 'logs' / f'{engine}.log').open('w') as stream:
                subprocess.run([executable, '-no_init', '-exit', str(ROOT / 'run_sta.tcl')],
                               env=env, stdout=stream, stderr=subprocess.STDOUT, check=True)
            log = (scenario / 'logs' / f'{engine}.log').read_text()
            assert 'POSTROUTE_STA_COMPLETE:' in log, log
            assert not re.search(r'(?im)^\s*(?:\[(?:WARNING|ERROR)|Error|Warning|STA_FAILED)', log), log
            assert not (report / 'check_setup.rpt').read_text().strip()
            assert (report / 'parasitic_annotation.rpt').read_text().strip() == (
                'Found 2 unannotated drivers.\n VDD\n VSS\nFound 0 partially unannotated drivers.')
        report = scenario / 'reports/openroad'
        endpoints = rows(report / 'endpoint_slacks.tsv')
        assert endpoints == rows(scenario / 'reports/standalone/endpoint_slacks.tsv')
        assert len(endpoints) == 48 and len({r['endpoint'] for r in endpoints}) == 24
        if value == '1.75':
            assert endpoints == rows(BASE / 'reports/openroad/endpoint_slacks.tsv')
        negatives = [r for r in endpoints if float(r['slack_ns']) < 0]
        violated_files = [p.name for p in report.glob('*.rpt') if 'VIOLATED' in p.read_text()]
        latency = {}
        for name, block in re.findall(r'Clock (\S+)\n(.*?)(?=Clock |\Z)',
                                      (report / 'clock_latency.rpt').read_text(), re.S):
            pairs = re.findall(r'^([\d.]+) ([\d.]+) latency$', block, re.M)
            assert len(pairs) == 2
            latency[name] = dict(zip(['rise_min', 'rise_max', 'fall_min', 'fall_max'],
                                    [float(x) for pair in pairs for x in pair]))
        gaps = {'phi1_to_phi2': float(period) * .01 + latency['phi2']['rise_min'] - latency['phi1']['fall_max'],
                'phi2_to_next_phi1': float(period) * .01 + latency['phi1']['rise_min'] - latency['phi2']['fall_max']}
        (scenario / 'clock_nonoverlap.rpt').write_text(
            'Nominal TT conservative envelope over all latch GATE pins; latency rounded to 0.000001 ns.\n'
            'Uncertainty/jitter not subtracted; independent of conventional STA pass/fail.\n' +
            ''.join(f'{name}: {gap:+.6f} ns\n' for name, gap in gaps.items()) +
            f'Strict nominal sink nonoverlap: {"PASS" if min(gaps.values()) > 0 else "FAIL"}\n')
        categories = ['data_setup', 'data_hold', 'output_setup', 'output_hold',
                      'phi1_to_phi2_setup', 'phi1_to_phi2_hold',
                      'phi2_to_phi1_setup', 'phi2_to_phi1_hold', 'rst_n_setup', 'rst_n_hold']
        summary = (report / 'summary.rpt').read_text()
        record = dict(period_ns=float(period), frequency_mhz=1000 / float(period),
                      scenario=scenario.name, conventional_sta_passed=not negatives and not violated_files,
                      negative_endpoints=negatives, violated_reports=violated_files,
                      slacks_ns={name: path_slack(report, name) for name in categories},
                      worst_slacks_ns={mode: float(v) for mode, v in re.findall(r'^worst slack (max|min) ([-\d.]+)$', summary, re.M)},
                      tns_ns={mode: float(v) for mode, v in re.findall(r'^tns (max|min) ([-\d.]+)$', summary, re.M)},
                      pulse_width_slack_ns=min(map(float, re.findall(r'([-+\d.]+) \((?:MET|VIOLATED)\)', (report / 'pulse_width.rpt').read_text()))),
                      nominal_sink_nonoverlap_gaps_ns=gaps, strict_nominal_nonoverlap_passed=min(gaps.values()) > 0,
                      independent_sta_match=True)
        records.append(record)
        print(f'T={value} ns, f={record["frequency_mhz"]:.6f} MHz, '
              f'output setup={record["slacks_ns"]["output_setup"]:+.6f} ns, '
              f'STA={record["conventional_sta_passed"]}, nonoverlap={record["strict_nominal_nonoverlap_passed"]}', flush=True)
    assert before == [digest(p) for p in physical if p.is_file()]
    assert [r['conventional_sta_passed'] for r in records] == [True, True, True, False, True, True]
    assert [r['strict_nominal_nonoverlap_passed'] for r in records] == [False, False, False, False, False, True]
    result = dict(generated_at=datetime.now(timezone.utc).isoformat(),
                  corner='SKY130 HD TT / 25 C / 1.8 V / existing nominal OpenRCX SPEF',
                  duty_fraction=.49, output_slack_at_1p75_ns=output_slack,
                  setup_estimated_min_period_ns=estimate, setup_estimated_fmax_mhz=1000 / estimate,
                  strict_nonoverlap_estimated_min_period_ns=(.279602 - .256411) / .01,
                  physical_artifacts_unchanged=True, physical_artifacts=before,
                  inputs=[digest(LIB), digest(BASE / 'counter.sdc'), digest(ROOT / 'run_sta.tcl'),
                          digest(PNR / 'scripts/postroute_sta.tcl'), digest(PNR / 'scripts/config.tcl'), digest(Path(__file__))],
                  scenarios=records)
    (ROOT / 'summary.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    columns = ['period_ns', 'frequency_mhz', 'output_setup_slack_ns', 'data_hold_slack_ns',
               'setup_tns_ns', 'hold_tns_ns', 'conventional_sta_passed',
               'phi1_to_phi2_gap_ns', 'phi2_to_phi1_gap_ns', 'strict_nominal_nonoverlap_passed']
    with (ROOT / 'sweep.tsv').open('w') as stream:
        writer = csv.writer(stream, delimiter='\t')
        writer.writerow(columns)
        for r in records:
            writer.writerow([r['period_ns'], r['frequency_mhz'], r['slacks_ns']['output_setup'],
                             r['slacks_ns']['data_hold'], r['tns_ns']['max'], r['tns_ns']['min'],
                             r['conventional_sta_passed'], *r['nominal_sink_nonoverlap_gaps_ns'].values(),
                             r['strict_nominal_nonoverlap_passed']])


if __name__ == '__main__':
    main()
