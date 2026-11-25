"""Check counter behavior and measure analog waveforms independently of SPICE."""
import csv
import json
from pathlib import Path
import numpy as np


def analyze(work, settings):
    data = np.loadtxt(work / 'results/transient.tsv', skiprows=1)
    assert np.isfinite(data).all()
    times = data[:, 0] * 1e9
    signals = dict(zip(settings['waveform_columns'], data[:, 1:].T))
    assert np.all(np.diff(times) >= 0) and times[-1] >= settings['stop_ns'] - 0.001
    period, first = settings['period_ns'], settings['first_clock_rise_ns']
    cycles = settings['cycles']

    def at(name, time):
        return float(np.interp(time, times, signals[name]))

    events = [(first + n * period, 'clock', n) for n in range(cycles)]
    events += [(t, 'reset', level) for t, level in settings['reset_events_ns']]
    events.sort()

    def expected(time):
        count, reset = 0, 0
        for t, kind, value in events:
            if t > time:
                break
            if kind == 'reset':
                reset = value
                if not reset:
                    count = 0
            elif not reset:
                count = 0
            elif settings['enable_by_cycle'][value]:
                count = (count + 1) & 15
        return count

    samples = [(1.5, 'initial_reset')]
    samples += [(first + n * period + offset, f'cycle_{n}_{label}')
                for n in range(cycles) for offset, label in ((0.75, 'output_deadline'), (1.60, 'settled'))]
    for time, level in settings['reset_events_ns'][2:]:
        samples.append((time + (0.25 if level == 0 else 0.10), 'async_reset' if level == 0 else 'reset_release'))
    checks = []
    for time, label in sorted(samples):
        value = expected(time)
        volts = [at(f'count{i}', time) for i in range(4)]
        valid = all(v >= 1.44 if (value >> i) & 1 else v <= 0.36 for i, v in enumerate(volts))
        checks.append({'time_ns': time, 'check': label, 'expected': value,
                       **{f'count{i}_v': v for i, v in enumerate(volts)}, 'passed': valid})
    with (work / 'reports/functional_checks.csv').open('w') as f:
        writer = csv.DictWriter(f, fieldnames=list(checks[0]))
        writer.writeheader()
        writer.writerows(checks)
    result = {'corner': 'SKY130 TT / 25 C / 1.80 V', 'period_ns': period,
              'frequency_mhz': 1000 / period, 'simulated_cycles': cycles,
              'max_timestep_ps': settings['max_timestep_ps'], 'data_points': len(times),
              'functional_passed': all(c['passed'] for c in checks),
              'functional_checks': len(checks), 'functional_failures': [c for c in checks if not c['passed']],
              'logic_thresholds_v': {'low_max': 0.36, 'high_min': 1.44},
              'coverage': 'Continuous count, repeated overflow, hold at every state, asynchronous reset with clock high/low, reset release'}
    def crossings(name, level, rising):
        y = signals[name]
        mask = ((y[:-1] < level) & (y[1:] >= level) if rising
                else (y[:-1] > level) & (y[1:] <= level))
        idx = np.flatnonzero(mask & (np.diff(times) > 0))
        return times[idx] + (level - y[idx]) * (times[idx + 1] - times[idx]) / (y[idx + 1] - y[idx])

    cache = {}

    def crossing(name, level, rising, start, end):
        key = (name, level, rising)
        if key not in cache:
            cache[key] = crossings(name, level, rising)
        found = cache[key][(cache[key] >= start) & (cache[key] <= end)]
        assert len(found) == 1, (key, start, end, found.tolist())
        return float(found[0])

    clock_delays = []
    transitions = []
    for n in range(cycles):
        edge = first + n * period
        before, after = expected(edge - 0.001), expected(edge + 0.001)
        reset_in_cycle = any(edge < t < edge + period and level == 0
                             for t, level in settings['reset_events_ns'])
        for bit in range(4):
            clk = crossing(f'ff{bit}_clk', 0.9, True, edge, edge + 0.7)
            clock_delays.append({'cycle': n, 'bit': bit, 'latency_ns': clk - edge})
            if reset_in_cycle or ((before >> bit) & 1) == ((after >> bit) & 1):
                continue
            rise = bool((after >> bit) & 1)
            out = crossing(f'count{bit}', 0.9, rise, edge, edge + 0.9)
            q = crossing(f'ff{bit}_q', 0.9, rise, edge, edge + 0.9)
            lo = crossing(f'count{bit}', 0.36, rise, edge, edge + 1.0)
            hi = crossing(f'count{bit}', 1.44, rise, edge, edge + 1.0)
            transitions.append({'cycle': n, 'bit': bit, 'direction': 'rise' if rise else 'fall',
                                'external_clock_to_output_ns': out - edge,
                                'local_clock_to_q_ns': q - clk,
                                'q_to_output_wire_ns': out - q,
                                'output_slew_20_80_ns': abs(hi - lo)})

    def stats(values):
        return {'min': float(min(values)), 'max': float(max(values)), 'mean': float(np.mean(values))}

    with (work / 'reports/timing_measurements.csv').open('w') as f:
        writer = csv.DictWriter(f, fieldnames=list(transitions[0]))
        writer.writeheader()
        writer.writerows(transitions)
    result['transistor_timing_ns'] = {
        'measurement_threshold_v': 0.9, 'transitions_measured': len(transitions),
        'clock_insertion': stats([x['latency_ns'] for x in clock_delays]),
        **{key: stats([x[key] for x in transitions]) for key in
           ('external_clock_to_output_ns', 'local_clock_to_q_ns', 'output_slew_20_80_ns')}}

    power = -1.8 * signals['ivdd']

    def power_window(start, end):
        inside = (times > start) & (times < end)
        t = np.r_[start, times[inside], end]
        p = np.interp(t, times, power)
        return {'start_ns': start, 'end_ns': end,
                'average_power_uw': float(np.trapezoid(p, t) / (end - start) * 1e6),
                'energy_pj': float(np.trapezoid(p, t) * 1e3)}

    result['supply_power'] = {
        'continuous_counting': power_window(first + 16 * period, first + 32 * period),
        'enable_low_clock_running': power_window(first + 81 * period, first + 88 * period),
        'scope': 'Energy from ideal 1.8 V VDD source; excludes energy delivered by input drivers'}
    reset_delays = []
    for time, level in settings['reset_events_ns'][2:]:
        if level == 0:
            for bit in range(4):
                if at(f'count{bit}', time - 0.1) > 0.9:
                    fall = crossing(f'count{bit}', 0.9, False, time - 0.03, time + 0.4)
                    reset_delays.append({'assertion_ns': time, 'bit': bit, 'reset_to_output_ns': fall - time})
    result['asynchronous_reset_delays'] = reset_delays
    result['limitations'] = [
        'Existing OpenRCX signal/clock interconnect RC, including coupling, is used.',
        'Official transistor cell netlists include no full extracted cell-internal interconnect RC or explicit diffusion areas.',
        'Ideal supply and input drivers; power-grid RC, package, tap/filler and multi-corner analysis are excluded.',
        'Transient scenario validation supplements STA; it does not prove all timing paths or corner cases.']
    plot(work, times, signals, power, settings)
    (work / 'reports/summary.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


def plot(work, times, signals, power, settings):
    import os
    os.environ.setdefault('MPLCONFIGDIR', '/tmp/counter_ngspice_matplotlib')
    os.environ.setdefault('XDG_CACHE_HOME', '/tmp/counter_ngspice_cache')
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    plt.rcParams.update({'font.size': 10, 'svg.fonttype': 'none'})
    channels = ['clk', 'en', 'rst_n', 'count0', 'count1', 'count2', 'count3']
    colors = ['#6b7280', '#9333ea', '#dc2626', '#0072b2', '#009e73', '#d55e00', '#cc79a7']
    for name, xlim in [('waveforms', (0, settings['stop_ns'])), ('counting_zoom', (3, 34))]:
        fig, axes = plt.subplots(7, 1, figsize=(15, 9), sharex=True, layout='constrained')
        keep = (times >= xlim[0]) & (times <= xlim[1])
        for ax, channel, color in zip(axes, channels, colors):
            ax.plot(times[keep], signals[channel][keep], color=color, linewidth=1.0)
            ax.set_ylabel(channel + '\n(V)', rotation=0, labelpad=30, va='center')
            ax.set_ylim(-0.15, 1.95)
            ax.set_yticks([0, 1.8])
            ax.grid(alpha=0.22)
            ax.spines[['top', 'right']].set_visible(False)
        axes[-1].set_xlabel('Time (ns)')
        axes[-1].set_xlim(*xlim)
        fig.suptitle('Counter postroute transistor simulation | SKY130 TT, 25 C, 1.80 V | T = 1.80 ns\n'
                     'Official cell MOS netlists + distributed OpenRCX wire RC and coupling | 10 fF / output', fontsize=13)
        fig.savefig(work / 'results' / (name + '.png'), dpi=160)
        fig.savefig(work / 'results' / (name + '.svg'))
        plt.close(fig)
    fig, axes = plt.subplots(3, 1, figsize=(13, 7), sharex=True, layout='constrained')
    keep = (times >= 30) & (times <= 34)
    for channel, label in [('clk', 'External CLK'), ('ff0_clk', 'FF0 CLK pin')]:
        axes[0].plot(times[keep], signals[channel][keep], label=label)
    for channel, label in [('count0', 'count[0] port'), ('ff0_q', 'FF0 Q pin')]:
        axes[1].plot(times[keep], signals[channel][keep], label=label)
    axes[2].plot(times[keep], power[keep] * 1e6, color='#0072b2')
    for ax in axes:
        ax.grid(alpha=0.22)
        ax.spines[['top', 'right']].set_visible(False)
    for ax in axes[:2]:
        ax.set_ylabel('Voltage (V)')
        ax.legend(loc='upper right')
        ax.set_ylim(-0.15, 1.95)
    axes[2].set_ylabel('VDD power (uW)')
    axes[2].set_xlabel('Time (ns)')
    axes[2].set_xlim(30, 34)
    fig.suptitle('Clock insertion, clock-to-Q, output routing delay and supply power')
    fig.savefig(work / 'results/timing_zoom.png', dpi=160)
    fig.savefig(work / 'results/timing_zoom.svg')
    plt.close(fig)
