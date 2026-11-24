#!/usr/bin/env python3
"""Reproduce ngspice TT postroute transistor simulation using saved SPEF RC."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'scripts'))
from build_netlist import build


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def model_dependencies(path, section=None, seen=None):
    """Hash the selected .lib section and recursively referenced model files."""
    seen = {} if seen is None else seen
    path = path.resolve()
    if str(path) in seen:
        return seen
    seen[str(path)] = sha(path)
    active = section is None
    for line in path.read_text().splitlines():
        f = line.split()
        if not f or f[0].startswith('*'):
            continue
        if f[0].lower() == '.lib' and len(f) == 2:
            active = section is None or f[1].lower() == section.lower()
        elif f[0].lower() == '.endl' and section:
            active = False
        elif active and f[0].lower() in ('.include', '.inc'):
            name = f[1].strip('"\'')
            model_dependencies(path.parent / name, seen=seen)
    return seen


def stimulus(work, probes, pdk, maxstep_ps):
    period = 1.8
    first = 4.0
    cycles = 104
    stop = first + cycles * period + 0.8
    enables = [int(not (32 <= n < 64 and n % 2 == 1) and not (80 <= n < 88))
               for n in range(cycles)]
    enable_events = [(0.0, enables[0])]
    for n in range(1, cycles):
        if enables[n] != enables[n - 1]:
            enable_events.append((first + n * period - 0.8, enables[n]))
    resets = [(0.0, 0), (2.65, 1),
              (first + 68 * period + 0.35, 0), (first + 68 * period + 1.25, 1),
              (first + 74 * period + 1.02, 0), (first + 74 * period + 1.40, 1)]

    def pwl(events):
        points = [f'0 {1.8 * events[0][1]:g}']
        previous = events[0][1]
        for time, level in events[1:]:
            points += [f'{time - 0.05:.6f}n {1.8 * previous:g}',
                       f'{time + 0.05:.6f}n {1.8 * level:g}']
            previous = level
        return 'PWL(\n+ ' + '\n+ '.join(points) + ')'

    vectors = ['v(clk)', 'v(en)', 'v(rst_n)', *[f'v(count{i})' for i in range(4)], 'i(VDD)']
    labels = ['clk', 'en', 'rst_n', 'count0', 'count1', 'count2', 'count3', 'ivdd']
    for i in range(4):
        for pin in ('CLK', 'Q', 'RESET_B'):
            vectors.append(f'v(xdut.{probes[f"count_o_reg[{i}]/{pin}"]})')
            labels.append(f'ff{i}_{pin.lower()}')
    deck = ['Counter postroute transistor transient: TT 25C 1.8V 1.8ns',
            f'.lib "{pdk}/libs.tech/ngspice/sky130.lib.spice" tt']
    deck += [f'.include "models/{p.name}"' for p in sorted((work / 'models').glob('*.spice'))]
    deck += ['.include "inputs/counter_postlayout.spice"', '.temp 25',
             '.option reltol=1e-4 abstol=1e-12 vntol=1e-6 method=trap maxord=2',
             '.option klu', 'VDD vdd 0 1.8',
             '* 100ps full ramps give 60ps 20%-80% input slew; 50% clock duty = 50%.',
             'VCLK clk 0 PULSE(0 1.8 3.95n 0.10n 0.10n 0.80n 1.80n)',
             'VEN en 0 ' + pwl(enable_events), 'VRST rst_n 0 ' + pwl(resets),
             'Xdut clk en rst_n count0 count1 count2 count3 vdd 0 counter_postlayout',
             *[f'Cload{i} count{i} 0 10f' for i in range(4)],
             '.save ' + ' '.join(vectors), '.control', 'set noaskquit',
             'set filetype=binary', 'set wr_singlescale', 'set wr_vecnames', 'set numdgt=12',
             f'tran 2p {stop:.6f}n 0 {maxstep_ps:g}p',
             'write results/transient.raw ' + ' '.join(vectors),
             'wrdata results/transient.tsv ' + ' '.join(vectors), 'quit', '.endc', '.end', '']
    (work / 'inputs/counter_tb.spice').write_text('\n'.join(deck))
    settings = {'period_ns': period, 'first_clock_rise_ns': first, 'cycles': cycles,
                'stop_ns': stop, 'max_timestep_ps': maxstep_ps,
                'supply_v': 1.8, 'temperature_c': 25, 'corner': 'tt',
                'output_load_ff_per_bit': 10, 'full_input_ramp_ps': 100,
                'input_slew_20_80_ps': 60, 'enable_by_cycle': enables,
                'enable_events_ns': enable_events, 'reset_events_ns': resets,
                'waveform_columns': labels}
    (work / 'inputs/stimulus.json').write_text(json.dumps(settings, indent=2) + '\n')
    return settings


def main():
    work = Path(tempfile.mkdtemp(prefix='counter_dff_ngspice_'))
    for name in ('inputs', 'models', 'results', 'logs', 'reports'):
        (work / name).mkdir()
    manifest = {'status': 'running', 'created_utc': datetime.now(timezone.utc).isoformat(),
                'work_directory': str(work), 'sources': []}
    try:
        sources = [ROOT.parent / 'openroad/results/counter_routed.v',
                   ROOT.parent / 'openroad/results/counter.spef', ROOT.parent / 'counter.sdc',
                   Path(__file__).resolve(), *sorted((ROOT / 'scripts').glob('*.py')),
                   *sorted((ROOT / 'models').glob('*.spice')), ROOT / 'models/SOURCES.json', ROOT / 'requirements.txt']
        manifest['sources'] = [{'path': str(p), 'sha256': sha(p)} for p in sources]
        for name in ('counter_routed.v', 'counter.spef'):
            shutil.copy2(ROOT.parent / 'openroad/results' / name, work / 'inputs' / name)
        shutil.copy2(ROOT.parent / 'counter.sdc', work / 'inputs/counter.sdc')
        assert re.search(r'-period\s+1\.80\b', (work / 'inputs/counter.sdc').read_text())
        shutil.copytree(ROOT / 'models', work / 'models', dirs_exist_ok=True)
        audit = build(work)
        pdk = Path(os.environ.get('SKY130_PDK', '/home/bailufrost/eda/pdk/sky130A')).resolve()
        dependencies = model_dependencies(pdk / 'libs.tech/ngspice/sky130.lib.spice', 'tt')
        manifest['device_model_dependencies'] = [{'path': p, 'sha256': h} for p, h in sorted(dependencies.items())]
        settings = stimulus(work, audit['probe_nodes'], pdk, float(os.environ.get('NGSPICE_MAXSTEP_PS', '2')))
        # Local configuration makes SKY130 compatibility independent of ~/.spiceinit.
        (work / '.spiceinit').write_text('set ngbehavior=hsa\nset skywaterpdk\nset ng_nomodcheck\nset num_threads=1\n')
        manifest['ngspice_version'] = subprocess.check_output(['ngspice', '--version'], text=True).strip()
        print(f'Running ngspice: {work}; max timestep {settings["max_timestep_ps"]} ps', flush=True)
        started = time.monotonic()
        with (work / 'logs/launcher.log').open('w') as log:
            subprocess.run(['ngspice', '-b', '-o', 'logs/ngspice.log', 'inputs/counter_tb.spice'],
                           cwd=work, stdout=log, stderr=subprocess.STDOUT, check=True)
        manifest['ngspice_elapsed_seconds'] = time.monotonic() - started
        log = (work / 'logs/ngspice.log').read_text()
        assert 'No. of Data Rows' in log and not re.search(r'\b(error|fatal)\b', log, re.I), log[-4000:]
        from analyze import analyze
        result = analyze(work, settings)
        reference_path = ROOT / 'reports/timestep_2ps_reference.json'
        if reference_path.exists() and settings['max_timestep_ps'] < 2:
            reference = json.loads(reference_path.read_text())
            for relative, digest in reference['input_hashes'].items():
                assert sha(work / relative) == digest, relative
            assert reference['functional_passed'] and result['functional_passed']
            old_delay = reference['transistor_timing_ns']['external_clock_to_output_ns']['max']
            new_delay = result['transistor_timing_ns']['external_clock_to_output_ns']['max']
            old_power = reference['supply_power']['continuous_counting']['average_power_uw']
            new_power = result['supply_power']['continuous_counting']['average_power_uw']
            convergence = {'reference_maxstep_ps': 2.0,
                           'refined_maxstep_ps': settings['max_timestep_ps'],
                           'max_clock_to_output_difference_ps': abs(old_delay - new_delay) * 1000,
                           'counting_power_relative_difference': abs(old_power - new_power) / abs(new_power)}
            assert convergence['max_clock_to_output_difference_ps'] < 1.0
            assert convergence['counting_power_relative_difference'] < 0.01
            result['timestep_convergence'] = convergence
            (work / 'reports/timestep_2ps_reference.json').write_text(reference_path.read_text())
            (work / 'reports/summary.json').write_text(json.dumps(result, indent=2) + '\n')
        manifest['status'] = 'complete'
        manifest['functional_passed'] = result['functional_passed']
        print(json.dumps(result, indent=2), flush=True)
        if not result['functional_passed']:
            raise RuntimeError('Postlayout functional checks failed; inspect reports/summary.json')
    except Exception:
        manifest['status'] = 'failed'
        raise
    finally:
        for name in ('inputs', 'results', 'reports', 'logs'):
            shutil.copytree(work / name, ROOT / name, dirs_exist_ok=True)
        shutil.copy2(work / '.spiceinit', ROOT / 'inputs/ngspice.spiceinit')
        manifest['artifacts'] = [{'path': str(p.relative_to(ROOT)), 'sha256': sha(p)}
                                 for name in ('inputs', 'results', 'reports', 'logs')
                                 for p in sorted((ROOT / name).rglob('*')) if p.is_file()]
        (ROOT / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
