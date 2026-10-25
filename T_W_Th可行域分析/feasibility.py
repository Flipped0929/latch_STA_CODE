#!/usr/bin/env python3
"""Scan the two-latch model over period T, L1 window W, and hold time Th."""
import argparse
import csv
import math
import sys
from dataclasses import replace
from pathlib import Path
from typing import Any

HERE = Path(__file__).resolve().parent
MODEL_DIR = HERE.parent / "两级锁存器理论模型"
sys.path.insert(0, str(MODEL_DIR))

from model import Circuit, evaluate


def number_grid(start: float, stop: float, step: float) -> list[float]:
    if step <= 0 or stop < start:
        raise ValueError("require step > 0 and stop >= start")
    count = int(math.floor((stop - start) / step + 1e-9))
    return [round(start + i * step, 9) for i in range(count + 1)]


def evaluate_feasibility(
    period: float,
    window: float,
    common_hold: float,
    circuit: Circuit = Circuit(),
) -> dict[str, Any]:
    """Evaluate setup feasibility and the largest common hold requirement.

    ``common_hold`` replaces both latch hold requirements. The returned
    maximum is meaningful only when both setup checks pass.
    """
    if common_hold < 0:
        raise ValueError("common_hold must be non-negative")

    no_hold = replace(circuit, hold1=0.0, hold2=0.0)
    result = evaluate(period, no_hold, window=window)
    setup1 = result["latch1_setup_slack"]
    setup2 = result["latch2_setup_slack"]
    setup_pass = min(setup1, setup2) >= 0

    if setup_pass:
        hold1_capacity = result["latch1_hold_slack"]
        hold2_capacity = result["latch2_hold_slack"]
        max_common_hold = min(hold1_capacity, hold2_capacity)
        passes = max_common_hold >= common_hold
    else:
        hold1_capacity = None
        hold2_capacity = None
        max_common_hold = None
        passes = False

    return {
        "period_ns": period,
        "window_ns": window,
        "l2_window_ns": period - window,
        "common_hold_ns": common_hold,
        "latch1_setup_slack_ns": setup1,
        "latch2_setup_slack_ns": setup2,
        "latch1_hold_capacity_ns": hold1_capacity,
        "latch2_hold_capacity_ns": hold2_capacity,
        "max_common_hold_ns": max_common_hold,
        "setup_pass": setup_pass,
        "pass_at_common_hold": passes,
    }


def scan(
    periods: list[float],
    windows: list[float],
    common_hold: float,
    circuit: Circuit = Circuit(),
) -> list[dict[str, Any]]:
    rows = []
    for period in periods:
        for window in windows:
            if 0 < window < period:
                rows.append(evaluate_feasibility(period, window, common_hold, circuit))
    return rows


def write_csv(path: Path, rows: list[dict[str, Any]]) -> None:
    if not rows:
        raise ValueError("the requested T/W grid contains no valid points")
    with path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)


def summarize(rows: list[dict[str, Any]], common_hold: float) -> dict[str, Any]:
    passing_by_period: dict[float, list[float]] = {}
    for row in rows:
        if row["pass_at_common_hold"]:
            passing_by_period.setdefault(row["period_ns"], []).append(row["window_ns"])

    if not passing_by_period:
        return {
            "common_hold_ns": common_hold,
            "first_passing_period_ns": None,
            "min_passing_window_ns": None,
            "max_passing_window_ns": None,
            "passing_window_count": 0,
        }

    first_period = min(passing_by_period)
    passing_windows = passing_by_period[first_period]
    return {
        "common_hold_ns": common_hold,
        "first_passing_period_ns": first_period,
        "min_passing_window_ns": min(passing_windows),
        "max_passing_window_ns": max(passing_windows),
        "passing_window_count": len(passing_windows),
    }


def _hex(rgb: tuple[int, int, int]) -> str:
    return "#%02x%02x%02x" % rgb


def _mix(a: tuple[int, int, int], b: tuple[int, int, int], ratio: float) -> tuple[int, int, int]:
    return tuple(round(x + (y - x) * ratio) for x, y in zip(a, b))


def _capacity_color(value: float, maximum: float) -> str:
    stops = [(44, 123, 182), (171, 217, 160), (253, 174, 97)]
    ratio = min(1.0, max(0.0, value / maximum)) if maximum > 0 else 0.0
    if ratio <= 0.5:
        color = _mix(stops[0], stops[1], ratio * 2)
    else:
        color = _mix(stops[1], stops[2], (ratio - 0.5) * 2)
    return _hex(color)


def write_svg(path: Path, rows: list[dict[str, Any]], hold_limit: float) -> None:
    periods = sorted({row["period_ns"] for row in rows})
    windows = sorted({row["window_ns"] for row in rows})
    by_point = {(row["period_ns"], row["window_ns"]): row for row in rows}
    capacities = [
        row["max_common_hold_ns"]
        for row in rows
        if row["max_common_hold_ns"] is not None
    ]
    color_max = max(capacities, default=1.0)

    width, height = 1050, 700
    left, top, plot_width, plot_height = 90, 90, 850, 500
    cell_width = plot_width / len(periods)
    cell_height = plot_height / len(windows)
    elements = [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">',
        '<rect width="100%" height="100%" fill="#ffffff"/>',
        '<style>text{font-family:Arial,sans-serif;fill:#222} .small{font-size:12px} .axis{font-size:14px}</style>',
        '<text x="90" y="35" font-size="21" font-weight="bold">Two-latch feasibility over T and W</text>',
        f'<text x="90" y="60" class="small">Grey: setup fails; color: maximum common hold requirement (ns). Requested Th={hold_limit:g} ns.</text>',
    ]

    for y_index, window in enumerate(windows):
        y = top + (len(windows) - 1 - y_index) * cell_height
        for x_index, period in enumerate(periods):
            row = by_point.get((period, window))
            if row is None or not row["setup_pass"]:
                fill = "#e1e4e6"
            else:
                fill = _capacity_color(row["max_common_hold_ns"], color_max)
            x = left + x_index * cell_width
            elements.append(
                f'<rect x="{x:.2f}" y="{y:.2f}" width="{cell_width + 0.15:.2f}" '
                f'height="{cell_height + 0.15:.2f}" fill="{fill}" stroke="#ffffff" stroke-width="0.25"/>'
            )

    elements.extend([
        f'<rect x="{left}" y="{top}" width="{plot_width}" height="{plot_height}" fill="none" stroke="#333" stroke-width="1"/>',
        f'<text x="{left + plot_width / 2}" y="{top + plot_height + 48}" text-anchor="middle" class="axis">Clock period T (ns)</text>',
        f'<text x="25" y="{top + plot_height / 2}" transform="rotate(-90 25 {top + plot_height / 2})" text-anchor="middle" class="axis">L1 transparent window W (ns)</text>',
    ])

    for value in (periods[0], periods[len(periods) // 2], periods[-1]):
        index = periods.index(value)
        x = left + (index + 0.5) * cell_width
        elements.append(f'<text x="{x:.1f}" y="{top + plot_height + 20}" text-anchor="middle" class="small">{value:g}</text>')
    for value in (windows[0], windows[len(windows) // 2], windows[-1]):
        index = windows.index(value)
        y = top + (len(windows) - index - 0.5) * cell_height + 4
        elements.append(f'<text x="{left - 12}" y="{y:.1f}" text-anchor="end" class="small">{value:g}</text>')

    legend_x, legend_y, legend_width = left + 100, top + plot_height + 85, 400
    for i in range(100):
        x = legend_x + legend_width * i / 100
        color = _capacity_color(color_max * i / 99, color_max)
        elements.append(f'<rect x="{x:.2f}" y="{legend_y}" width="{legend_width / 100 + 0.1:.2f}" height="14" fill="{color}"/>')
    elements.extend([
        f'<text x="{legend_x}" y="{legend_y + 32}" class="small">0</text>',
        f'<text x="{legend_x + legend_width}" y="{legend_y + 32}" text-anchor="end" class="small">{color_max:.2f} ns</text>',
        f'<text x="{legend_x + legend_width + 35}" y="{legend_y + 12}" class="small">hold capacity</text>',
        '</svg>',
    ])
    path.write_text("\n".join(elements), encoding="utf-8")


def main() -> None:
    defaults = Circuit()
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--t-start", type=float, default=8.0)
    parser.add_argument("--t-stop", type=float, default=18.0)
    parser.add_argument("--t-step", type=float, default=0.1)
    parser.add_argument("--w-start", type=float, default=1.0)
    parser.add_argument("--w-stop", type=float, default=17.0)
    parser.add_argument("--w-step", type=float, default=0.1)
    parser.add_argument("--hold-time", type=float, default=0.1, help="common hold requirement Th in ns")
    parser.add_argument("--out-dir", type=Path, default=HERE / "results")
    for name in (
        "d1_max", "d1_min", "d2_max", "d2_min", "tcq_src_max", "tcq_src_min",
        "tdq_l1_max", "tdq_l1_min", "tcq_l1_max", "tcq_l1_min", "setup1", "setup2",
    ):
        parser.add_argument("--" + name.replace("_", "-"), type=float, default=getattr(defaults, name))
    args = parser.parse_args()

    values = {name: getattr(defaults, name) for name in defaults.__dataclass_fields__}
    for name in (
        "d1_max", "d1_min", "d2_max", "d2_min", "tcq_src_max", "tcq_src_min",
        "tdq_l1_max", "tdq_l1_min", "tcq_l1_max", "tcq_l1_min", "setup1", "setup2",
    ):
        values[name] = getattr(args, name)
    circuit = Circuit(**values)

    periods = number_grid(args.t_start, args.t_stop, args.t_step)
    windows = number_grid(args.w_start, args.w_stop, args.w_step)
    rows = scan(periods, windows, args.hold_time, circuit)
    args.out_dir.mkdir(parents=True, exist_ok=True)
    write_csv(args.out_dir / "feasibility_surface.csv", rows)
    summary = summarize(rows, args.hold_time)
    write_csv(args.out_dir / "feasibility_summary.csv", [summary])
    write_svg(args.out_dir / "feasibility_map.svg", rows, args.hold_time)

    period = summary["first_passing_period_ns"]
    if period is None:
        print(f"No point passed for Th={args.hold_time:g} ns on the selected grid.")
    else:
        print(
            f"First passing grid period at Th={args.hold_time:g} ns: {period:g} ns; "
            f"passing W={summary['min_passing_window_ns']:g}..{summary['max_passing_window_ns']:g} ns "
            f"({summary['passing_window_count']} sampled windows)."
        )
    print(f"Wrote T/W surface, summary, and SVG map to {args.out_dir}")


if __name__ == "__main__":
    main()
