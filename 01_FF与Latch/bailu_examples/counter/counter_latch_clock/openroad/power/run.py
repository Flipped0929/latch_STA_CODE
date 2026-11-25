"""Measure functional VCD activity and estimate power of the fixed routed counter."""
from pathlib import Path
from collections import defaultdict
from datetime import datetime, timezone
import csv
import hashlib
import json
import math
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = Path(__file__).resolve().parent
FLOW, ROOT = HERE.parent, HERE.parent.parent
PLATFORM = Path(os.environ.get('SKY130_PLATFORM', '/home/bailufrost/eda/OpenROAD-flow-scripts-live/flow/platforms/sky130hd'))
LIBERTY = Path(os.environ.get('COUNTER_POWER_LIBERTY', str(PLATFORM / 'lib/sky130_fd_sc_hd__tt_025C_1v80.lib')))
MODELS = Path(os.environ.get('SKY130_POWER_MODELS', '/home/bailufrost/OpenSTA/examples'))
OPENROAD = os.environ.get('OPENROAD_EXE', '/home/bailufrost/.local/bin/openroad')
SCENARIOS = {'active': 1, 'mixed': 2, 'hold': 0}
COMPONENTS = ['internal', 'switching', 'leakage', 'total']
CYCLES = 4096


def run(command, logfile, env=None):
    with logfile.open('w') as output:
        subprocess.run(list(map(str, command)), cwd=ROOT, stdout=output,
                       stderr=subprocess.STDOUT, env=env, check=True)
    return logfile.read_text()


def digest(path):
    return {'path': str(path.resolve()), 'bytes': path.stat().st_size,
            'sha256': hashlib.sha256(path.read_bytes()).hexdigest()}


def instances(text):
    return {name: (cell, dict(re.findall(r'\.(\w+)\s*\(\s*([^()]+?)\s*\)', pins)))
            for cell, name, pins in re.findall(r'\b(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);', text, re.S)}


def normalize_vcd(source, target, duration_fs):
    text = source.read_text()
    stamps = [int(x) for x in re.findall(r'^#(\d+)$', text, re.M)]
    assert stamps[-1] - stamps[0] == duration_fs, 'Wrong measurement duration'
    text = re.sub(r'\$date\s+.*?\$end', '$date\n measured window\n$end', text, flags=re.S)
    text = re.sub(r'^#(\d+)$', lambda m: '#' + str(int(m[1])-stamps[0]), text, flags=re.M)
    # Expand vectors into scalar bit names before import. This avoids the
    # installed reader's incorrect activity on aliased packed output buses.
    header, body = text.split('$enddefinitions $end', 1)
    vectors, declarations = {}, []
    for line in header.splitlines():
        fields = line.split()
        if fields and fields[0] == '$var' and int(fields[2]) > 1:
            width, code, name = int(fields[2]), fields[3], fields[4]
            ids = vectors.setdefault(code, [f'powerbit{len(vectors)}_{i}' for i in range(width)])
            limits = list(map(int, re.findall(r'-?\d+', fields[5])))
            indexes = list(range(limits[0], limits[-1]-1, -1))
            assert len(indexes) == width
            declarations.extend(f'$var {fields[1]} 1 {ident} {name}[{bit}] $end' for ident, bit in zip(ids, indexes))
        else:
            declarations.append(line)
    values = []
    for line in body.splitlines():
        if line.startswith(('b', 'B')):
            value, code = line[1:].split()
            if code in vectors:
                ids = vectors[code]
                value = value.lower().rjust(len(ids), value[0].lower() if value[0].lower() in 'xz' else '0')
                values.extend(bit + ident for bit, ident in zip(value, ids))
                continue
        values.append(line)
    target.write_text('\n'.join(declarations) + '\n$enddefinitions $end\n' + '\n'.join(values) + '\n')


def vcd_statistics(path, routed, duration_fs, period):
    # Independent transition/duty audit; aliases share one VCD identifier.
    text = path.read_text()
    assert re.search(r'\$timescale\s+1fs\s+\$end', text)
    header, body = text.split('$enddefinitions $end', 1)
    scopes, signals, states = [], [], {}
    for line in header.splitlines():
        fields = line.split()
        if not fields:
            continue
        if fields[0] == '$scope':
            scopes.append(fields[2])
        elif fields[0] == '$upscope':
            scopes.pop()
        elif fields[0] == '$var':
            width, code, name = int(fields[2]), fields[3], fields[4]
            indexes = list(range(width-1, -1, -1))
            if len(fields) > 6 and fields[5].startswith('['):
                limits = list(map(int, re.findall(r'-?\d+', fields[5])))
                indexes = list(range(limits[0], limits[-1]-1, -1))
            prefix = '/'.join(scopes) + '/' + name
            names = [prefix] if width == 1 else [f'{prefix}[{index}]' for index in indexes]
            signals.append((code, names))
            states.setdefault(code, [dict(value='x', last=0, high=0, unknown=0, transitions=0) for _ in range(width)])
    now = 0
    for line in body.splitlines():
        line = line.strip()
        if not line or line.startswith('$'):
            continue
        if line.startswith('#'):
            now = int(line[1:])
            continue
        if line[0] in 'bB':
            value, code = line[1:].split()
        elif line[0] in '01xXzZ':
            value, code = line[0], line[1:]
        else:
            continue
        if code not in states:
            continue
        bits = states[code]
        value = value.lower().rjust(len(bits), value[0].lower() if value[0].lower() in 'xz' else '0')
        for bit, new in zip(bits, value):
            elapsed = now-bit['last']
            bit['high'] += elapsed if bit['value'] == '1' else 0
            bit['unknown'] += elapsed if bit['value'] in 'xz' else 0
            if new in '01' and bit['value'] in '01' and new != bit['value']:
                bit['transitions'] += 1
            bit['value'], bit['last'] = new, now
    assert now == duration_fs
    rows = {}
    for code, names in signals:
        for name, bit in zip(names, states[code]):
            elapsed = now-bit['last']
            high = bit['high'] + (elapsed if bit['value'] == '1' else 0)
            unknown = bit['unknown'] + (elapsed if bit['value'] in 'xz' else 0)
            rows[name] = dict(signal=name, transitions=bit['transitions'],
                              density_per_second=bit['transitions']/(now*1e-15),
                              duty=high/now, unknown_fraction=unknown/now)
    cell_pins = []
    for name, (_, pins) in routed.items():
        pin_names = set(pins)
        if name.startswith('clkload'):
            pin_names.add('Y')
        cell_pins.extend(f'tb_power/dut/{name}/{pin}' for pin in pin_names)
    assert len(cell_pins) == 73
    assert all(rows[pin]['unknown_fraction'] == 0 for pin in cell_pins)
    for clock in ['clk_1', 'clk_2']:
        row = rows[f'tb_power/dut/{clock}']
        assert row['transitions'] == 2*CYCLES and abs(row['duty']-.49) < 1e-12
    enabled = {'active': CYCLES, 'mixed': CYCLES//2, 'hold': 0}[path.stem]
    gated = rows['tb_power/dut/clk_2_gated']
    assert gated['transitions'] == 2*enabled
    assert abs(gated['duty']-.49*enabled/CYCLES) < 1e-12
    for bit in range(4):
        assert rows[f'tb_power/dut/count[{bit}]']['transitions'] == enabled >> bit
    with path.with_name(path.stem + '_signals.tsv').open('w') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(next(iter(rows.values()))), delimiter='\t')
        writer.writeheader()
        writer.writerows(rows[key] for key in sorted(rows))
    return rows, {'cell_signal_pins': len(cell_pins), 'unknown_cell_pins': 0,
                  'clock_transitions_each': 2*CYCLES, 'clock_high_fraction': .49,
                  'gated_clock_transitions': gated['transitions'], 'gated_clock_high_fraction': gated['duty'],
                  'count_transitions': [rows[f'tb_power/dut/count[{bit}]']['transitions'] for bit in range(4)]}


def group_of(name):
    if name.startswith('state_phi1_'): return 'phase1_latches'
    if name.startswith('state_phi2_'): return 'phase2_latches'
    if name == 'enable_phi1': return 'enable_latch'
    if name.startswith('clkload'): return 'clock_dummy'
    if name.startswith('clkbuf_phi2_'): return 'clock_phi2'
    if name.startswith('clkbuf_'): return 'clock_phi1'
    if name == 'gate_phi2': return 'clock_gate'
    return 'logic'


def main():
    for directory in ['inputs', 'activity', 'logs', 'reports']:
        (HERE / directory).mkdir(exist_ok=True)
    for executable in ['iverilog', 'vvp', OPENROAD]:
        assert shutil.which(executable), executable
    snapshots = {'counter_sky130.v': ROOT / 'counter_sky130.v', 'counter.sdc': ROOT / 'counter.sdc',
                 'counter_routed.v': FLOW / 'results/counter_routed.v', 'counter.spef': FLOW / 'results/counter.spef'}
    for target, source in snapshots.items():
        shutil.copy2(source, HERE / 'inputs' / target)
    routed = instances((HERE / 'inputs/counter_routed.v').read_text())
    assert len(routed) == 23
    clocks = {name: tuple(map(float, (period, rise, fall))) for name, period, rise, fall in re.findall(
        r'create_clock\s+-name\s+(\w+)\s+-period\s+([\d.]+)\s+-waveform\s+\{([\d.]+)\s+([\d.]+)\}',
        (HERE / 'inputs/counter.sdc').read_text())}
    assert set(clocks) == {'phi1', 'phi2'} and clocks['phi1'][0] == clocks['phi2'][0]
    period, rise1, fall1 = clocks['phi1']
    _, rise2, fall2 = clocks['phi2']
    assert 0 < rise1 < fall1 < rise2 < fall2 < period
    assert abs((fall1-rise1)/period-.49) < 1e-12 and abs((fall2-rise2)/period-.49) < 1e-12
    duration_fs = round(CYCLES*period*1e6)
    parameters = {'PERIOD': period, 'PHI1_RISE': rise1, 'PHI1_FALL': fall1,
                  'PHI2_RISE': rise2, 'PHI2_FALL': fall2}
    (HERE / 'inputs/timing.vh').write_text(''.join(f'localparam realtime {key} = {value:.9f};\n'
        for key, value in parameters.items()) + f'localparam integer MEASURED_CYCLES = {CYCLES};\n')
    reference = HERE / 'inputs/counter_reference.v'
    reference.write_text(re.sub(r'\bmodule\s+counter\b', 'module counter_reference',
                               (HERE / 'inputs/counter_sky130.v').read_text(), count=1))
    lib_text = LIBERTY.read_text()
    assert re.search(r'nom_voltage\s*:\s*1\.8', lib_text)
    assert re.search(r'nom_temperature\s*:\s*25\.', lib_text)
    results = {}
    with tempfile.TemporaryDirectory(prefix='counter-clock-power-') as temp:
        compiled = Path(temp) / 'counter.vvp'
        run(['iverilog', '-g2012', '-DFUNCTIONAL', '-DUNIT_DELAY=', '-I', HERE / 'inputs',
             '-s', 'tb_power', '-o', compiled, MODELS / 'sky130_hd_primitives.v', MODELS / 'sky130_hd.v',
             reference, HERE / 'inputs/counter_routed.v', HERE / 'tb_power.sv'], HERE / 'logs/compile.log')
        for scenario, number in SCENARIOS.items():
            raw = Path(temp) / (scenario + '.vcd')
            window = HERE / 'activity' / (scenario + '_window.json')
            log = run(['vvp', compiled, f'+SCENARIO={number}', f'+VCD={raw}', f'+WINDOW={window}'],
                      HERE / 'logs' / (scenario + '_simulation.log'))
            assert 'PASS:' in log
            vcd = HERE / 'activity' / (scenario + '.vcd')
            normalize_vcd(raw, vcd, duration_fs)
            measured, validation = vcd_statistics(vcd, routed, duration_fs, period)
            env = dict(os.environ, COUNTER_POWER_SCENARIO=scenario, SKY130_PLATFORM=str(PLATFORM),
                       COUNTER_POWER_LIBERTY=str(LIBERTY))
            log = run([OPENROAD, '-no_init', '-exit', HERE / 'run_power.tcl'],
                      HERE / 'logs' / (scenario + '_openroad.log'), env)
            assert f'POWER_COMPLETE: {scenario}' in log and '[ERROR' not in log
            reports = HERE / 'reports' / scenario
            annotation = (reports / 'activity_annotation.rpt').read_text()
            assert re.search(r'^vcd\s+81$', annotation, re.M), annotation
            assert re.search(r'^unannotated\s+0$', annotation, re.M), annotation
            parasitics = (reports / 'parasitic_annotation.rpt').read_text()
            assert 'Found 1 unannotated drivers.\n clkload0/Y' in parasitics
            assert 'Found 0 partially unannotated drivers.' in parasitics
            with (reports / 'activities.tsv').open() as stream:
                activities = list(csv.DictReader(stream, delimiter='\t'))
            assert len(activities) == 81
            for activity in activities:
                actual = measured['tb_power/dut/' + activity['pin']]
                assert activity['origin'] in {'vcd', 'clock'}, activity
                # get_property formats density with six significant digits,
                # and duty with three decimal places in this OpenROAD build.
                assert math.isclose(float(activity['density_per_second']), actual['density_per_second'], rel_tol=5e-6, abs_tol=1), activity
                expected_duty = actual['duty']
                if activity['pin'] == 'clkload0/Y' and activity['origin'] == 'clock':
                    # This build returns the source clock duty for an inverted
                    # clock output. This unused output has no wire/load; its
                    # toggle rate is correct. The cell's leakage conditions and
                    # related-power pin depend only on A, which is verified.
                    expected_duty = 1-expected_duty
                assert math.isclose(float(activity['duty']), expected_duty, abs_tol=0.000501), activity
            power = json.loads((reports / 'power.json').read_text())
            for group in power.values():
                assert all(math.isfinite(value) and value >= 0 for value in group.values())
                assert math.isclose(sum(group[key] for key in COMPONENTS[:3]), group['total'], rel_tol=2e-6)
            with (reports / 'instances.tsv').open() as stream:
                cells = list(csv.DictReader(stream, delimiter='\t'))
            assert len(cells) == 23
            grouped = defaultdict(lambda: {key: 0.0 for key in COMPONENTS})
            for cell in cells:
                for key in COMPONENTS:
                    grouped[group_of(cell['instance'])][key] += float(cell[key + '_W'])
            for key in COMPONENTS:
                assert math.isclose(sum(float(cell[key + '_W']) for cell in cells), power['Total'][key], rel_tol=2e-6)
            top = sorted(cells, key=lambda cell: float(cell['total_W']), reverse=True)[:10]
            with (reports / 'top10.tsv').open('w') as stream:
                writer = csv.DictWriter(stream, fieldnames=list(top[0]), delimiter='\t')
                writer.writeheader()
                writer.writerows(top)
            total = power['Total']
            results[scenario] = dict(power_W=power, groups_W=dict(grouped),
                                     dynamic_W=total['internal']+total['switching'],
                                     energy_per_cycle_pJ=total['total']*period*1e3,
                                     validation=validation, window=json.loads(window.read_text()))
            print(f"{scenario}: {total['total']*1e6:.6f} uW; 81/81 pin activities verified", flush=True)
    summary = dict(generated_utc=datetime.now(timezone.utc).isoformat(),
                   openroad=subprocess.check_output([OPENROAD, '-version'], text=True).strip(),
                   corner='SKY130 HD TT / 25 C / 1.80 V, fixed routed SPEF',
                   clock_period_ns=period, clock_frequency_MHz=1000/period,
                   waveforms_ns=clocks, measured_cycles=CYCLES, measurement_duration_ns=duration_fs/1e6,
                   routed_cells=23, latches=11, clock_buffers=4, clock_dummy_loads=1,
                   scenarios=results)
    (HERE / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    with (HERE / 'summary.csv').open('w') as stream:
        writer = csv.writer(stream)
        writer.writerow(['scenario', 'internal_uW', 'switching_uW', 'leakage_nW', 'total_uW', 'energy_pJ_per_cycle'])
        for name, scenario in results.items():
            power = scenario['power_W']['Total']
            writer.writerow([name, power['internal']*1e6, power['switching']*1e6,
                             power['leakage']*1e9, power['total']*1e6, scenario['energy_per_cycle_pJ']])
    for group in ['clock_phi2', 'phase2_latches']:
        assert results['hold']['groups_W'][group]['switching'] == 0
        assert results['hold']['groups_W'][group]['internal'] == 0
    subprocess.run([sys.executable, HERE / 'report.py'], check=True)
    for filename, source in snapshots.items():
        assert source.read_bytes() == (HERE / 'inputs' / filename).read_bytes(), 'Inputs changed during analysis'
    inputs = list(snapshots.values()) + [LIBERTY, MODELS / 'sky130_hd.v', MODELS / 'sky130_hd_primitives.v',
             PLATFORM / 'lef/sky130_fd_sc_hd.tlef', PLATFORM / 'lef/sky130_fd_sc_hd_merged.lef']
    manifest = dict(generated_utc=summary['generated_utc'], inputs=[digest(path) for path in inputs],
                    scripts=[digest(HERE / name) for name in ['run.py', 'run_power.tcl', 'tb_power.sv', 'report.py']],
                    outputs=[digest(HERE / name) for name in ['summary.json', 'summary.csv', 'groups.csv', 'README.md']
                             + [f'activity/{name}.vcd' for name in SCENARIOS]
                             + [f'reports/{name}/power.json' for name in SCENARIOS]
                             + [f'reports/{name}/instances.tsv' for name in SCENARIOS]])
    (HERE / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
