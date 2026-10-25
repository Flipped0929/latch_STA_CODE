#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Create a small dependency-free SVG summary for ver.4."""

from __future__ import annotations

import csv
import html
from pathlib import Path


HERE = Path(__file__).resolve().parent
RESULTS = HERE / "results"
FIGURES = HERE / "figures"


def esc(value: object) -> str:
    return html.escape(str(value), quote=True)


def text(lines: list[str], x: float, y: float, value: object, size: int = 13,
         color: str = "#202124", anchor: str = "start") -> None:
    lines.append(
        f'<text x="{x:g}" y="{y:g}" font-family="Arial, sans-serif" '
        f'font-size="{size}px" fill="{color}" text-anchor="{anchor}">{esc(value)}</text>'
    )


def main() -> None:
    with (RESULTS / "retuned_sensitivity.csv").open(encoding="utf-8", newline="") as stream:
        rows = list(csv.DictReader(stream))
    factors = sorted({float(row["max_delay_factor"]) for row in rows})
    groups = sorted({float(row["min_delay_factor"]) for row in rows})
    colors = ["#2f6db0", "#d17a22", "#4e9f50", "#a3479a", "#777777"]
    width, height = 1100, 620
    lines = [f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">',
             '<title>S27 ver.4 retuned sensitivity</title>',
             '<rect width="100%" height="100%" fill="#ffffff"/>']
    text(lines, 35, 35, "S27 ver.4：延迟扰动后的重新优化", 24)
    text(lines, 35, 58, "每条曲线固定 Dmin 缩放，横轴为 Dmax 缩放；显示离线 retuned 结果", 13, "#555555")
    x0, y0, w, h = 90, 110, 460, 390
    x1, y1 = 620, 110
    all_t = [float(row["retuned_T_ns"]) for row in rows]
    all_dw = [float(row["delta_W_ns"]) for row in rows]
    factor_index = {factor: index for index, factor in enumerate(factors)}
    def panel(px, py, title, key, values):
        text(lines, px, py - 18, title, 17)
        lo, hi = min(values), max(values)
        pad = max((hi - lo) * .1, .01); lo -= pad; hi += pad
        lines.append(f'<rect x="{px}" y="{py}" width="{w}" height="{h}" fill="#fafafa" stroke="#cccccc"/>')
        def point(row):
            factor = float(row["max_delay_factor"])
            xx = px + factor_index[factor] * w / max(1, len(factors) - 1)
            yy = py + h - (float(row[key]) - lo) / (hi - lo) * h
            return xx, yy
        for gi, min_factor in enumerate(groups):
            subset = sorted((r for r in rows if float(r["min_delay_factor"]) == min_factor),
                            key=lambda r: float(r["max_delay_factor"]))
            pts = " ".join(f"{x:g},{y:g}" for x, y in (point(r) for r in subset))
            lines.append(f'<polyline points="{pts}" fill="none" stroke="{colors[gi]}" stroke-width="2"/>')
            for row in subset:
                x, y = point(row)
                lines.append(f'<circle cx="{x:g}" cy="{y:g}" r="3" fill="{colors[gi]}"/>')
            text(lines, px + w - 8, py + 20 + gi * 18, f"Dmin {min_factor:+.0%}", 11, colors[gi], "end")
        text(lines, px + w / 2, py + h + 30, "Dmax 缩放", 12, anchor="middle")
        text(lines, px - 8, py + 4, f"{hi:.3f}", 10, anchor="end")
        text(lines, px - 8, py + h, f"{lo:.3f}", 10, anchor="end")
    panel(x0, y0, "重新优化周期 T（ns）", "retuned_T_ns", all_t)
    panel(x1, y1, "透明窗变化 ΔW（ns）", "delta_W_ns", all_dw)
    text(lines, 35, 570, "固定方案与 retuned 的差异见 results/retuned_sensitivity.csv；非法 Dmin>Dmax 组合未进入图。", 12, "#555555")
    lines.append("</svg>")
    FIGURES.mkdir(parents=True, exist_ok=True)
    (FIGURES / "retuned_sensitivity.svg").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(FIGURES / "retuned_sensitivity.svg")


if __name__ == "__main__":
    main()
