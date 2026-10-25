#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Create dependency-free SVG figures for the S27 ver.3 experiments.

The validator deliberately writes CSV rather than depending on a plotting
package.  This companion turns those CSV files into reviewable SVGs using
only the Python standard library.  The boundary plots use the *fixed* ver.2
period/window/skew while the delay-perturbation plots also use that same
schedule; no point is re-optimized (the distinction is printed in each
figure).  Optional behavior and dynamic-hold columns are accepted when a
newer validator provides them.
"""

from __future__ import annotations

import argparse
import csv
import html
import math
from pathlib import Path
from typing import Iterable, Mapping, Sequence


HERE = Path(__file__).resolve().parent
DEFAULT_RESULTS = HERE / "results"
DEFAULT_FIGURES = HERE / "figures"


def read_csv(path: Path) -> list[dict[str, str]]:
    if not path.exists():
        raise FileNotFoundError(f"missing validator output: {path}")
    with path.open("r", encoding="utf-8-sig", newline="") as fh:
        return list(csv.DictReader(fh))


def number(row: Mapping[str, str], key: str, default: float = float("nan")) -> float:
    try:
        value = float(row.get(key, ""))
        return value if math.isfinite(value) else default
    except (TypeError, ValueError):
        return default


def boolean(row: Mapping[str, str], key: str) -> bool:
    return str(row.get(key, "")).strip().lower() in {"1", "true", "yes", "pass", "passed"}


def esc(value: object) -> str:
    return html.escape(str(value), quote=True)


def fmt(value: float, digits: int = 3) -> str:
    if not math.isfinite(value):
        return "n/a"
    return f"{value:.{digits}f}"


def svg_open(width: int, height: int, title: str) -> list[str]:
    return [
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" '
        f'viewBox="0 0 {width} {height}">',
        f"<title>{esc(title)}</title>",
        '<rect width="100%" height="100%" fill="#ffffff"/>',
    ]


def text(lines: list[str], x: float, y: float, value: object, *, size: int = 13,
         fill: str = "#202124", anchor: str = "start", weight: str = "normal",
         rotate: float | None = None) -> None:
    transform = f' transform="rotate({rotate:g} {x:g} {y:g})"' if rotate is not None else ""
    lines.append(
        f'<text x="{x:g}" y="{y:g}" font-family="Arial, sans-serif" font-size="{size}px" '
        f'fill="{fill}" text-anchor="{anchor}" font-weight="{weight}"{transform}>{esc(value)}</text>'
    )


def color_scale(value: float, low: float, high: float, *, diverging: bool = False) -> str:
    """Return a readable red-to-green color without external color libraries."""
    if not math.isfinite(value):
        return "#eeeeee"
    if diverging:
        if value >= 0:
            ratio = min(1.0, value / max(high, 1e-12))
            # pale green -> saturated green
            r, g, b = int(236 - 126 * ratio), int(248 - 26 * ratio), int(238 - 108 * ratio)
        else:
            ratio = min(1.0, -value / max(-low, 1e-12))
            # pale red -> saturated red
            r, g, b = int(252), int(238 - 122 * ratio), int(238 - 122 * ratio)
    else:
        ratio = (value - low) / (high - low) if high > low else 0.5
        ratio = min(1.0, max(0.0, ratio))
        r, g, b = int(244 - 144 * ratio), int(120 + 112 * ratio), int(112 - 30 * ratio)
    return f"#{r:02x}{g:02x}{b:02x}"


def heatmap_panel(lines: list[str], x0: float, y0: float, width: float, height: float,
                  title: str, subtitle: str, x_values: Sequence[float],
                  y_values: Sequence[float], values: Mapping[tuple[float, float], float],
                  *, mode: str, x_label: str = "T (ns)", y_label: str = "W (ns)") -> None:
    """Draw a rectangular heatmap panel; x/y are sorted unique numeric values."""
    text(lines, x0, y0 - 35, title, size=17, weight="bold")
    text(lines, x0, y0 - 17, subtitle, size=11, fill="#5f6368")
    left, top = x0 + 58, y0 + 8
    right, bottom = x0 + width - 12, y0 + height - 46
    ncol, nrow = max(1, len(x_values)), max(1, len(y_values))
    cw, ch = (right - left) / ncol, (bottom - top) / nrow
    finite = [v for v in values.values() if math.isfinite(v)]
    if mode == "rate":
        lo, hi = 0.0, 1.0
    elif mode == "slack":
        lo, hi = min(finite + [0.0]), max(finite + [0.0])
        m = max(abs(lo), abs(hi), 1e-9)
        lo, hi = -m, m
    else:
        lo, hi = 0.0, 1.0
    for iy, yv in enumerate(y_values):
        # Draw larger W at the top, as in a normal Cartesian plot.
        row = len(y_values) - 1 - iy
        for ix, xv in enumerate(x_values):
            value = values.get((xv, yv), float("nan"))
            if not math.isfinite(value):
                fill = "#eeeeee"
            elif mode == "binary":
                fill = "#55a868" if value >= 0.5 else "#d9534f"
            else:
                fill = color_scale(value, lo, hi, diverging=(mode == "slack"))
            x, y = left + ix * cw, top + row * ch
            lines.append(f'<rect x="{x:g}" y="{y:g}" width="{cw:g}" height="{ch:g}" '
                         f'fill="{fill}" stroke="#ffffff" stroke-width="1"/>')
            if math.isfinite(value):
                label = ("PASS" if value >= 0.5 else "FAIL") if mode == "binary" else (
                    f"{value:.2f}" if mode == "rate" else f"{value:.3f}")
                text(lines, x + cw / 2, y + ch / 2 + 4, label, size=9,
                     anchor="middle", fill="#111111")
            else:
                text(lines, x + cw / 2, y + ch / 2 + 4, "N/A", size=9,
                     anchor="middle", fill="#555555")
    # Axis labels and ticks.  Ticks are intentionally sparse for readability.
    tick_digits = 5 if x_label in {"T (ns)", "W (ns)"} else 3
    for ix, xv in enumerate(x_values):
        if len(x_values) <= 10 or ix in {0, len(x_values) - 1, len(x_values) // 2}:
            text(lines, left + (ix + .5) * cw, bottom + 17, fmt(xv, tick_digits), size=10, anchor="middle")
    for iy, yv in enumerate(y_values):
        row = len(y_values) - 1 - iy
        if len(y_values) <= 10 or iy in {0, len(y_values) - 1, len(y_values) // 2}:
            text(lines, left - 8, top + (row + .5) * ch + 4, fmt(yv, tick_digits), size=10, anchor="end")
    text(lines, (left + right) / 2, bottom + 36, x_label, size=11, anchor="middle")
    text(lines, left - 46, (top + bottom) / 2, y_label, size=11, anchor="middle", rotate=-90)
    # Compact legend.
    if mode == "binary":
        legend = [("#55a868", "PASS"), ("#d9534f", "FAIL"), ("#eeeeee", "N/A")]
    elif mode == "rate":
        legend = [("#d87870", "0"), ("#8bc68b", "1")]
    else:
        legend = [("#f25252", "negative"), ("#eeeeee", "0"), ("#55bd62", "positive")]
    lx, ly = right - 135, y0 - 31
    for color, label in legend:
        lines.append(f'<rect x="{lx:g}" y="{ly - 9:g}" width="12" height="12" fill="{color}"/>')
        text(lines, lx + 16, ly + 1, label, size=10)
        lx += 16 + max(30, len(label) * 6)


def boundary_figure(rows: Sequence[Mapping[str, str]], hold_rows: Sequence[Mapping[str, str]], out: Path) -> None:
    ts = sorted({number(r, "T") for r in rows if math.isfinite(number(r, "T"))})
    ws = sorted({number(r, "W") for r in rows if math.isfinite(number(r, "W"))})
    if not ts or not ws:
        raise ValueError("boundary_grid.csv contains no T/W values")
    static = {(number(r, "T"), number(r, "W")): 1.0 if boolean(r, "static_pass") else 0.0 for r in rows}
    behavior = {(number(r, "T"), number(r, "W")): number(r, "behavior_pass_rate") for r in rows}
    hold = {(number(r, "T"), number(r, "W")): number(r, "min_hold_slack_ns") for r in rows}
    lines = svg_open(1460, 1040, "S27 ver.3 static, functional and hold boundary")
    text(lines, 42, 34, "S27 ver.3：边界交叉验证", size=24, weight="bold")
    text(lines, 42, 57, "改变 T/W，固定使用 ver.2 的 skew，未重新优化 skew（fixed skew）", size=13, fill="#444444")
    text(lines, 42, 78, "行为模型为 XOR 时序图；动态 hold 仅统计 seed=2701 下实际发生的转换，不构成全路径证明。", size=11, fill="#5f6368")
    heatmap_panel(lines, 35, 160, 690, 390, "静态可行性", "setup / extended setup / hold / W≤T/2", ts, ws, static, mode="binary")
    heatmap_panel(lines, 755, 160, 690, 390, "功能行为", "代表性确定性输入通过率（fast vs 30 ns gold）", ts, ws, behavior, mode="rate")
    heatmap_panel(lines, 35, 610, 690, 390, "静态 hold 裕量", "每条边最小 hold slack（ns）；正值为绿色", ts, ws, hold, mode="slack")
    dyn_hold = {(number(r, "T"), number(r, "W")): number(r, "dynamic_min_slack_ns")
                for r in hold_rows}
    dyn_ts = sorted({number(r, "T") for r in hold_rows if math.isfinite(number(r, "T"))})
    dyn_ws = sorted({number(r, "W") for r in hold_rows if math.isfinite(number(r, "W"))})
    if dyn_ts and dyn_ws:
        heatmap_panel(lines, 755, 610, 690, 390, "动态 hold 裕量（稀疏测试点）",
                      "仅 hold_sensitivity.csv 中 5 个点；未扫描完整 T/W 网格", dyn_ts, dyn_ws,
                      dyn_hold, mode="slack")
    else:
        text(lines, 755, 650, "hold_sensitivity.csv 无有效 T/W 点。", size=14, fill="#d9534f")
    text(lines, 42, 1021, "Fixed vs retuned：本图为 fixed schedule；如对每个 T/W 点重新优化 skew，需另标 retuned 并单独汇报。", size=12, fill="#333333")
    lines.append("</svg>")
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")


def perturbation_figure(rows: Sequence[Mapping[str, str]], out: Path) -> None:
    factors = sorted({number(r, "max_delay_factor") for r in rows})
    mins = sorted({number(r, "min_delay_factor") for r in rows})
    if not factors or not mins:
        raise ValueError("perturbation.csv contains no factor grid")
    static = {}
    for r in rows:
        key = (number(r, "max_delay_factor"), number(r, "min_delay_factor"))
        # A scale pair with Dmin>Dmax is outside the delay interval model.
        # Draw it as N/A (grey) rather than as an algorithmic failure.
        valid = boolean(r, "delay_range_valid") if "delay_range_valid" in r else True
        static[key] = (1.0 if boolean(r, "static_pass") else 0.0) if valid else float("nan")
    min_slack = {}
    behavior = {}
    dynamic = {}
    for r in rows:
        key = (number(r, "max_delay_factor"), number(r, "min_delay_factor"))
        valid = boolean(r, "delay_range_valid") if "delay_range_valid" in r else True
        values = [number(r, k) for k in ("min_setup_slack_ns", "min_extended_setup_slack_ns", "min_hold_slack_ns")]
        min_slack[key] = (min(v for v in values if math.isfinite(v))
                          if valid and any(math.isfinite(v) for v in values) else float("nan"))
        for col in ("behavior_pass_rate", "dmax_behavior_pass_rate"):
            if col in r:
                behavior[key] = number(r, col) if valid else float("nan")
                break
        for col in ("dynamic_hold_min_slack_ns", "dmin_dynamic_hold_min_slack_ns"):
            if col in r:
                dynamic[key] = number(r, col) if valid else float("nan")
                break
    lines = svg_open(1460, 1040, "S27 ver.3 delay perturbation sensitivity")
    text(lines, 42, 34, "S27 ver.3：延迟扰动敏感性", size=24, weight="bold")
    text(lines, 42, 57, "横轴 Dmax 缩放，纵轴 Dmin 缩放；所有点固定 ver.2 T/W/skew，未重新优化（fixed schedule）", size=13, fill="#444444")
    text(lines, 42, 78, "若未来重新优化每个扰动点，应单独标记 retuned，并和 fixed 结果分开汇报。", size=11, fill="#5f6368")
    heatmap_panel(lines, 35, 160, 690, 390, "静态可行性", "static_pass", factors, mins, static, mode="binary", x_label="Dmax factor", y_label="Dmin factor")
    heatmap_panel(lines, 755, 160, 690, 390, "最小静态裕量", "min(setup, extended setup, hold) slack（ns）", factors, mins, min_slack, mode="slack", x_label="Dmax factor", y_label="Dmin factor")
    if behavior:
        heatmap_panel(lines, 35, 610, 690, 390, "功能行为（Dmax 扰动）", "14 个代表性模式；行为模型只用 Dmax，故沿 Dmin 方向重复", factors, mins, behavior, mode="rate", x_label="Dmax factor", y_label="Dmin factor")
    else:
        text(lines, 35, 650, "当前 CSV 没有扰动后的行为通过率列。", size=13, fill="#5f6368")
    if dynamic:
        heatmap_panel(lines, 755, 610, 690, 390, "动态 hold 裕量（Dmin 扰动）", "固定 seed=2701 的已观察跳变；非全路径证明", factors, mins, dynamic, mode="slack", x_label="Dmax factor", y_label="Dmin factor")
    else:
        text(lines, 755, 650, "当前 CSV 没有扰动后的动态 hold 裕量列。", size=13, fill="#5f6368")
    text(lines, 42, 1021, "Fixed vs retuned：本图 fixed；改变延迟但固定 T/W/skew。retuned 必须每个扰动点重跑优化并另行标注。", size=12, fill="#333333")
    lines.append("</svg>")
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")


def hold_figure(rows: Sequence[Mapping[str, str]], out: Path) -> None:
    """Plot the small dynamic-hold sensitivity table as a readable SVG."""
    lines = svg_open(980, 430, "S27 ver.3 dynamic hold sensitivity")
    text(lines, 32, 32, "S27 ver.3：动态 hold 敏感性（补充诊断）", size=22, weight="bold")
    text(lines, 32, 53, "固定 seed=2701；只记录实际发生的 min-delay 转换，因此不替代静态逐边约束。", size=12, fill="#5f6368")
    if not rows:
        text(lines, 32, 100, "hold_sensitivity.csv 为空。", size=14, fill="#d9534f")
        lines.append("</svg>")
        out.write_text("\n".join(lines) + "\n", encoding="utf-8")
        return
    x0, y0, w, h = 80, 100, 830, 230
    vals = [number(r, "dynamic_min_slack_ns") for r in rows if math.isfinite(number(r, "dynamic_min_slack_ns"))]
    lo, hi = min(vals + [0.0]), max(vals + [0.0])
    span = max(hi - lo, 1e-9)
    n = len(rows)
    zero_y = y0 + h * (hi / span)
    lines.append(f'<line x1="{x0}" y1="{zero_y:g}" x2="{x0+w}" y2="{zero_y:g}" stroke="#777" stroke-dasharray="4 3"/>')
    text(lines, x0 - 8, zero_y + 4, "0", size=10, anchor="end")
    bw = w / max(n, 1) * .66
    for i, row in enumerate(rows):
        value = number(row, "dynamic_min_slack_ns")
        x = x0 + (i + .5) * w / n
        if math.isfinite(value):
            y = y0 + h * ((hi - value) / span)
            top, bottom = min(zero_y, y), max(zero_y, y)
            fill = "#55a868" if value >= 0 else "#d9534f"
            lines.append(f'<rect x="{x-bw/2:g}" y="{top:g}" width="{bw:g}" height="{max(1,bottom-top):g}" fill="{fill}"/>')
            text(lines, x, top - 6, fmt(value, 3), size=10, anchor="middle")
        label = row.get("point", f"p{i}")
        text(lines, x, y0 + h + 20, label, size=10, anchor="middle", rotate=-35)
        text(lines, x, y0 + h + 42, "PASS" if boolean(row, "dynamic_pass") else "FAIL", size=10, anchor="middle", fill="#2f7f43" if boolean(row, "dynamic_pass") else "#a33")
    text(lines, x0 + w / 2, 405, "固定 T/W/skew 下的测试点", size=11, anchor="middle")
    lines.append("</svg>")
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")


def hold_margin_figure(rows: Sequence[Mapping[str, str]], out: Path) -> None:
    """Compare static and observed dynamic hold slack as the requirement changes."""
    lines = svg_open(1040, 500, "S27 ver.3 hold margin sensitivity")
    text(lines, 34, 32, "S27 ver.3：hold 裕量要求敏感性", size=22, weight="bold")
    text(lines, 34, 54, "T/W/skew 固定为 ver.2 名义值；只改变理论 hold 要求，未重新优化。", size=12, fill="#5f6368")
    if not rows:
        text(lines, 34, 100, "hold_margin_sensitivity.csv 为空。", size=14, fill="#d9534f")
        lines.append("</svg>")
        out.write_text("\n".join(lines) + "\n", encoding="utf-8")
        return
    x0, y0, w, h = 95, 100, 860, 270
    static_vals = [number(r, "static_min_hold_slack_ns") for r in rows]
    dynamic_vals = [number(r, "dynamic_min_slack_ns") for r in rows]
    vals = [v for v in static_vals + dynamic_vals if math.isfinite(v)]
    lo, hi = min(vals + [0.0]), max(vals + [0.0])
    pad = max((hi - lo) * .12, .01)
    lo, hi = lo - pad, hi + pad
    span = hi - lo
    def yy(v: float) -> float:
        return y0 + h * (hi - v) / span
    zero_y = yy(0.0)
    lines.append(f'<line x1="{x0}" y1="{zero_y:g}" x2="{x0+w}" y2="{zero_y:g}" stroke="#777" stroke-dasharray="4 3"/>')
    text(lines, x0 - 8, zero_y + 4, "0", size=10, anchor="end")
    # A small y-axis scale with three values is enough for this diagnostic plot.
    for value in (lo, 0.0, hi):
        y = yy(value)
        lines.append(f'<line x1="{x0-4}" y1="{y:g}" x2="{x0+w}" y2="{y:g}" stroke="#eeeeee"/>')
        text(lines, x0 - 8, y + 4, fmt(value, 3), size=10, anchor="end")
    n = len(rows)
    xs = [x0 + (i + .5) * w / max(n, 1) for i in range(n)]
    def poly(values: Sequence[float], color: str) -> None:
        points = " ".join(f"{x:g},{yy(v):g}" for x, v in zip(xs, values) if math.isfinite(v))
        lines.append(f'<polyline points="{points}" fill="none" stroke="{color}" stroke-width="2.5"/>')
        for x, v in zip(xs, values):
            if math.isfinite(v):
                lines.append(f'<circle cx="{x:g}" cy="{yy(v):g}" r="4" fill="{color}"/>')
                text(lines, x, yy(v) - 8, fmt(v, 3), size=10, anchor="middle")
    poly(static_vals, "#3b6fb6")
    poly(dynamic_vals, "#d17a22")
    for i, row in enumerate(rows):
        x = xs[i]
        text(lines, x, y0 + h + 22, fmt(number(row, "hold_margin_ns"), 2), size=10, anchor="middle")
        text(lines, x, y0 + h + 40, "S:" + ("P" if boolean(row, "static_pass") else "F") +
             " D:" + ("P" if boolean(row, "dynamic_pass") else "F"), size=10, anchor="middle",
             fill="#2f7f43" if boolean(row, "static_pass") and boolean(row, "dynamic_pass") else "#a33")
    # Legend is in the open top-right area and does not cover the plotted lines.
    text(lines, 720, 82, "静态逐边 slack", size=11, fill="#3b6fb6")
    lines.append('<line x1="700" y1="78" x2="714" y2="78" stroke="#3b6fb6" stroke-width="3"/>')
    text(lines, 880, 82, "动态观察 slack", size=11, fill="#d17a22")
    lines.append('<line x1="860" y1="78" x2="874" y2="78" stroke="#d17a22" stroke-width="3"/>')
    text(lines, x0 + w / 2, 480, "统一 hold 要求（ns）", size=11, anchor="middle")
    lines.append("</svg>")
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--results-dir", type=Path, default=DEFAULT_RESULTS)
    parser.add_argument("--output-dir", type=Path, default=DEFAULT_FIGURES)
    args = parser.parse_args(argv)
    args.output_dir.mkdir(parents=True, exist_ok=True)
    boundary_figure(read_csv(args.results_dir / "boundary_grid.csv"),
                    read_csv(args.results_dir / "hold_sensitivity.csv"),
                    args.output_dir / "boundary_heatmaps.svg")
    perturbation_figure(read_csv(args.results_dir / "perturbation.csv"), args.output_dir / "perturbation_sensitivity.svg")
    hold_figure(read_csv(args.results_dir / "hold_sensitivity.csv"), args.output_dir / "dynamic_hold_sensitivity.svg")
    margin_path = args.results_dir / "hold_margin_sensitivity.csv"
    if margin_path.exists():
        hold_margin_figure(read_csv(margin_path), args.output_dir / "hold_margin_sensitivity.svg")
    print(f"wrote SVG figures to {args.output_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
