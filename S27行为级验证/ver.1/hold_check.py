#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Run min-delay hold-window checks at the existing s27 period boundaries."""
import csv
import html
import os

from sim import (SAFE_W, SKEW_HOWARD, SKEW_LP, analyze_hold, run_point)

HERE = os.path.dirname(os.path.abspath(__file__))
RES = os.path.join(HERE, 'results')
FIG = os.path.join(HERE, 'figures')
SEEDS = (2701, 2702, 2703)
ZERO_SKEW = [0.0, 0.0, 0.0, 0.0]

CASES = [
    ('ff', 6.584, 0.0, ZERO_SKEW),
    ('ff_lp_skew', 6.259, 0.0, SKEW_LP),
    ('lat_Wsafe_s0', 5.059, min(5.059 / 2, SAFE_W), ZERO_SKEW),
    ('lat_Wsafe_lp', 5.057, min(5.057 / 2, SAFE_W), SKEW_LP),
    ('lat_Wsafe_howard', 8.644, min(8.644 / 2, SAFE_W), SKEW_HOWARD),
]


def main():
    os.makedirs(RES, exist_ok=True)
    os.makedirs(FIG, exist_ok=True)
    summary = []
    details = []

    for name, period, window, skew in CASES:
        functional = run_point(period, window, skew)
        seed_margins = []
        for seed in SEEDS:
            result = analyze_hold(period, window, skew, hold_time=0.0,
                                  seed=seed)
            margin = result['min_clearance']
            if margin is not None:
                seed_margins.append(margin)
            for check in result['checks']:
                details.append((
                    name, period, window, ','.join('%.5f' % s for s in skew),
                    functional['pass'], seed, check['src'], check['dst'],
                    check['cycle'], check['close_time'],
                    check['next_data_transition'], check['available_hold'],
                ))
            print('%-18s seed=%d functional=%s min_observed_hold=%.6f ns'
                  % (name, seed, functional['pass'], margin or 0.0), flush=True)

        summary.append((
            name, period, window, ','.join('%.5f' % s for s in skew),
            functional['pass'], min(seed_margins) if seed_margins else '',
            max(seed_margins) if seed_margins else '',
            len(seed_margins),
        ))

    with open(os.path.join(RES, 'hold_summary.csv'), 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow([
            'variant', 'period_ns', 'window_ns', 'skew_ns', 'functional_pass',
            'min_observed_hold_ns', 'max_observed_hold_ns', 'seed_count',
        ])
        writer.writerows(summary)

    with open(os.path.join(RES, 'hold_checks.csv'), 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow([
            'variant', 'period_ns', 'window_ns', 'skew_ns', 'functional_pass',
            'seed', 'source', 'target', 'capture_cycle', 'close_ns',
            'next_input_transition_ns', 'available_hold_ns',
        ])
        writer.writerows(details)

    write_margin_svg(os.path.join(FIG, 'hold_margin.svg'), summary)
    print('wrote hold_summary.csv, hold_checks.csv, and hold_margin.svg')


def write_margin_svg(path, summary):
    width, height = 960, 480
    left, right, top, bottom = 84, 28, 62, 112
    plot_w, plot_h = width - left - right, height - top - bottom
    highs = [float(row[6]) for row in summary]
    y_max = max(highs) * 1.15 if highs else 1.0
    y_max = max(y_max, 0.1)
    pieces = [
        '<svg xmlns="http://www.w3.org/2000/svg" width="960" height="480" viewBox="0 0 960 480">',
        '<rect width="960" height="480" fill="#ffffff"/>',
        '<text x="480" y="30" text-anchor="middle" font-family="Arial" font-size="18" fill="#222">s27 min-delay hold-window check across three input seeds</text>',
    ]
    for tick in range(6):
        value = y_max * tick / 5
        y = top + plot_h * (1 - tick / 5)
        pieces.append('<line x1="%d" y1="%.1f" x2="%d" y2="%.1f" stroke="#d9e0e3"/>'
                      % (left, y, width - right, y))
        pieces.append('<text x="%d" y="%.1f" text-anchor="end" font-family="Arial" font-size="12" fill="#444">%.3f</text>'
                      % (left - 10, y + 4, value))
    pieces.append('<line x1="%d" y1="%d" x2="%d" y2="%d" stroke="#333"/>'
                  % (left, top, left, top + plot_h))
    pieces.append('<line x1="%d" y1="%d" x2="%d" y2="%d" stroke="#333"/>'
                  % (left, top + plot_h, width - right, top + plot_h))
    slot = plot_w / max(1, len(summary))
    bar_w = min(72, slot * 0.48)
    for index, row in enumerate(summary):
        low, high = float(row[5]), float(row[6])
        mid = (low + high) / 2
        x = left + slot * (index + 0.5)
        y_mid = top + plot_h * (1 - mid / y_max)
        y_high = top + plot_h * (1 - high / y_max)
        y_low = top + plot_h * (1 - low / y_max)
        pieces.append('<rect x="%.1f" y="%.1f" width="%.1f" height="%.1f" fill="#2a9d8f" opacity="0.85"/>'
                      % (x - bar_w / 2, y_mid, bar_w, top + plot_h - y_mid))
        pieces.append('<line x1="%.1f" y1="%.1f" x2="%.1f" y2="%.1f" stroke="#264653" stroke-width="2"/>'
                      % (x, y_high, x, y_low))
        pieces.append('<line x1="%.1f" y1="%.1f" x2="%.1f" y2="%.1f" stroke="#264653" stroke-width="2"/>'
                      % (x - 6, y_high, x + 6, y_high))
        pieces.append('<line x1="%.1f" y1="%.1f" x2="%.1f" y2="%.1f" stroke="#264653" stroke-width="2"/>'
                      % (x - 6, y_low, x + 6, y_low))
        label = html.escape(row[0])
        pieces.append('<text x="%.1f" y="%d" text-anchor="end" transform="rotate(-20 %.1f %d)" font-family="Arial" font-size="12" fill="#222">%s</text>'
                      % (x + 12, top + plot_h + 34, x + 12, top + plot_h + 34, label))
    pieces.append('<text x="%d" y="%d" text-anchor="middle" font-family="Arial" font-size="13" fill="#222">minimum observed hold clearance (ns)</text>'
                  % (left + plot_w / 2, height - 18))
    pieces.append('</svg>')
    with open(path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(pieces) + '\n')


if __name__ == '__main__':
    main()
