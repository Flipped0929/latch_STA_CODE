#!/usr/bin/env python3
"""Sweep a two-stage FF/latch timing model and generate CSV/PNG results."""
import argparse
import csv
import math
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt

from model import Circuit, evaluate


HERE = Path(__file__).resolve().parent


def number_grid(start: float, stop: float, step: float):
    if step <= 0 or stop < start:
        raise ValueError("require step > 0 and stop >= start")
    count = int(math.floor((stop - start) / step + 1e-9))
    return [round(start + i * step, 9) for i in range(count + 1)]


def main():
    defaults = Circuit()
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--start", type=float, default=4.0, help="first period in ns")
    parser.add_argument("--stop", type=float, default=22.0, help="last period in ns")
    parser.add_argument("--step", type=float, default=0.02, help="period increment in ns")
    parser.add_argument(
        "--phase-shifts",
        type=float,
        nargs="+",
        default=[-1.0, 0.0, 1.0],
        help="shared L1-close/L2-open phase shifts in ns",
    )
    parser.add_argument("--out-dir", type=Path, default=HERE / "results")
    for name in (
        "d1_max", "d1_min", "d2_max", "d2_min", "tcq_src_max", "tcq_src_min",
        "tcq_ff_max", "tcq_ff_min", "tdq_l1_max", "tdq_l1_min", "tcq_l1_max",
        "tcq_l1_min", "tdq_l2_max", "tcq_l2_max", "setup1", "hold1", "setup2", "hold2",
    ):
        parser.add_argument("--" + name.replace("_", "-"), type=float, default=getattr(defaults, name))
    args = parser.parse_args()

    circuit_values = {
        name: getattr(args, name)
        for name in defaults.__dataclass_fields__
    }
    circuit = Circuit(**circuit_values)
    periods = number_grid(args.start, args.stop, args.step)
    args.out_dir.mkdir(parents=True, exist_ok=True)

    rows = []
    summary = []
    for phase_shift in args.phase_shifts:
        profile = [evaluate(period, circuit, phase_shift) for period in periods]
        for result in profile:
            rows.append(result)
        for mode, key in (("ff", "ff_pass"), ("latch", "latch_pass")):
            minimum = next((r["period"] for r in profile if r[key]), None)
            summary.append({"phase_shift": phase_shift, "mode": mode, "min_pass_period": minimum})

    fields = list(rows[0])
    with (args.out_dir / "sweep.csv").open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)
    with (args.out_dir / "summary.csv").open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(summary[0]))
        writer.writeheader()
        writer.writerows(summary)

    fig, ax = plt.subplots(figsize=(7.2, 4.4), constrained_layout=True)
    shifts = sorted(set(args.phase_shifts))
    width = 0.34
    x = list(range(len(shifts)))
    for offset, mode, color in ((-width / 2, "ff", "#c54e52"), (width / 2, "latch", "#168b86")):
        values = []
        for shift in shifts:
            value = next(
                r["min_pass_period"]
                for r in summary
                if r["phase_shift"] == shift and r["mode"] == mode
            )
            values.append(float("nan") if value is None else value)
        ax.bar([i + offset for i in x], values, width=width, label=mode.upper(), color=color)
    ax.set_xticks(x, [f"{v:+g} ns" for v in shifts])
    ax.set_xlabel("Shared phase shift from T/2")
    ax.set_ylabel("First passing period on sweep grid (ns)")
    ax.set_title("Two-stage FF vs latch timing boundary")
    ax.grid(axis="y", alpha=0.25)
    ax.legend(frameon=False)
    fig.savefig(args.out_dir / "period_boundary.png", dpi=160)
    plt.close(fig)

    zero_profile = [evaluate(period, circuit, 0.0) for period in periods]
    fig, axes = plt.subplots(2, 1, figsize=(7.2, 6.0), sharex=True, constrained_layout=True)
    axes[0].plot(periods, [r["ff_setup_slack"] for r in zero_profile], label="FF", color="#c54e52")
    axes[0].plot(periods, [r["latch_setup_slack"] for r in zero_profile], label="Latch", color="#168b86")
    axes[0].set_ylabel("Worst setup slack (ns)")
    axes[0].set_title("Setup and hold margins at zero phase shift")
    axes[0].legend(frameon=False)
    axes[1].plot(periods, [r["ff_hold_slack"] for r in zero_profile], label="FF", color="#c54e52")
    axes[1].plot(periods, [r["latch_hold_slack"] for r in zero_profile], label="Latch", color="#168b86")
    axes[1].set_ylabel("Worst hold slack (ns)")
    axes[1].set_xlabel("Clock period T (ns)")
    for ax in axes:
        ax.axhline(0, color="#333333", linewidth=0.8, linestyle="--")
        ax.grid(alpha=0.25)
    fig.savefig(args.out_dir / "slack_sweep.png", dpi=160)
    plt.close(fig)

    trace = next((r for r in zero_profile if r["latch_pass"] and not r["ff_pass"]), None)
    if trace is None:
        trace = next((r for r in zero_profile if r["latch_pass"]), zero_profile[-1])
    fig, ax = plt.subplots(figsize=(8.0, 4.6), constrained_layout=True)
    phase, period = trace["phase"], trace["period"]
    rows_y = {"L1 transparent": 5, "L1 D/Q": 4, "L2 transparent": 3, "L2 D/Q": 2, "FF comparison": 1}
    ax.broken_barh([(0, phase)], (4.75, 0.5), facecolors="#63a69f", alpha=0.8)
    ax.broken_barh([(phase, period - phase)], (2.75, 0.5), facecolors="#80b7d5", alpha=0.8)
    events = [
        (trace["l1_d_arrival"], 4.12, "L1 D arrives", "#333333", (-45, 20)),
        (trace["l1_q_time"], 3.88, "L1 Q updates", "#168b86", (8, -24)),
        (trace["l2_d_arrival"], 2, "L2 D arrives", "#168b86", (-76, 18)),
        (trace["ff2_d_arrival"], 1, "FF2 D arrives", "#c54e52", (8, -24)),
    ]
    for time, y, label, color, offset in events:
        ax.scatter([time], [y], color=color, zorder=3)
        ax.annotate(
            label,
            (time, y),
            xytext=offset,
            textcoords="offset points",
            fontsize=8,
            arrowprops={"arrowstyle": "-", "color": color, "linewidth": 0.7},
        )
    for time, label in ((0, "launch"), (phase, "phase boundary"), (period, "capture boundary")):
        ax.axvline(time, color="#777777", linewidth=0.8, linestyle="--")
        ax.text(time, 0.40, label, va="bottom", ha="left", fontsize=8)
    ax.set_yticks(list(rows_y.values()), list(rows_y.keys()))
    ax.set_xlim(0, max(period, trace["ff2_d_arrival"]) * 1.12)
    ax.set_ylim(0.25, 5.6)
    ax.set_xlabel("Time from source launch (ns)")
    ax.set_title(
        f"Example timeline at T={period:.2f} ns: borrow={trace['borrow']:.2f} ns; "
        f"FF pass={trace['ff_pass']}, latch pass={trace['latch_pass']}"
    )
    ax.grid(axis="x", alpha=0.2)
    fig.savefig(args.out_dir / "timing_trace.png", dpi=160)
    plt.close(fig)

    for row in summary:
        print(
            f"phase_shift={row['phase_shift']:+.3f} ns mode={row['mode']:5s} "
            f"min_pass_period={row['min_pass_period']} ns"
        )
    print(f"Wrote CSV and figures to {args.out_dir}")


if __name__ == "__main__":
    main()
