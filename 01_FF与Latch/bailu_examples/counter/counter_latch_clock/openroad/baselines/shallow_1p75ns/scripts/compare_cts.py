"""Compare preserved two-level CTS with the two completed shallow-tree runs."""
from pathlib import Path
import csv
import json
import re

flow = Path(__file__).resolve().parents[1]
cases = [("原两级 CTS", flow / "baselines/two_level"),
         ("第二相单级 clkbuf_4", flow / "experiments/phi2_single4"),
         ("第二相单级 clkbuf_2（当前）", flow)]
rows = []
for label, root in cases:
    reports = root / "reports"
    summary = json.loads((reports / "summary.json").read_text())
    clocks = json.loads((reports / "clock_metrics.json").read_text())
    phi2 = clocks["phases"]["phi2"]
    row = {
        "方案": label,
        "第二相缓冲级数": "/".join(map(str, phi2["rise"]["buffer_stages"])),
        "phi2上升延时最大_ps": phi2["rise"]["latency_max_ns"] * 1000,
        "phi2上升skew包络_ps": phi2["rise"]["skew_envelope_ns"] * 1000,
        "phi2上升slew最大_ps": phi2["rise"]["slew_max_ns"] * 1000,
        "输出setup最差slack_ps": summary["timing_ns"]["worst slack max"] * 1000,
        "max_TNS_ps": summary["timing_ns"]["tns max"] * 1000,
        "min最差slack_ps": summary["timing_ns"]["worst slack min"] * 1000,
        "phi1关断至phi2打开名义间隔_ps": clocks["nominal_phase_gaps"]["phi1_close_to_phi2_open_ns"] * 1000,
        "phi2关断至下次phi1打开名义间隔_ps": clocks["nominal_phase_gaps"]["phi2_close_to_next_phi1_open_ns"] * 1000,
    }
    rows.append(row)
    for filename in ("check_setup.rpt", "electrical_violations.rpt", "route_drc.rpt"):
        assert not (reports / filename).read_text().strip(), (label, filename)
    assert summary["output_latch_sizes_match_mux_reference"]
    # Input netlist, SDC and process sources must match the preserved baseline.
    if rows[:-1]:
        for path, digest in baseline_hashes.items():
            assert summary["sha256"][path] == digest, (label, path)
    else:
        baseline_hashes = summary["sha256"]

output = flow / "reports"
with (output / "cts_comparison.csv").open("w", newline="") as stream:
    writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
    writer.writeheader()
    writer.writerows(rows)
lines = ["# 浅时钟树后布线比较", "",
         "三种方案均完成详细布线、OpenRCX 与 SPEF 回标 STA；周期仍为 1.75 ns。原网表、SDC、工艺库与输出锁存器尺寸保持一致。", "",
         "| 指标 | " + " | ".join(row["方案"] for row in rows) + " |",
         "| --- | ---: | ---: | ---: |"]
for key in list(rows[0])[1:]:
    values = [f"{row[key]:.3f}" if isinstance(row[key], float) else str(row[key]) for row in rows]
    lines.append("| " + key + " | " + " | ".join(values) + " |")
lines.extend(["", "第二相单级 clkbuf_2 的输出 setup 最差裕量为 +27.660 ps，max TNS 为 0，当前采用此方案。",
              "门控 AND 和缓冲器的物理延时仍然存在。原路径约为 114 + 118 + 118 ps，新路径约为 122 + 128 ps（另含导线延时）；不能理解为消除了所有时钟延时。",
              "", "本次优化消除了输出 setup 违例。原有 en 输入 hold 与 rst_n removal 仍有违例，见 violations.rpt。",
              "两相名义间隔不含 50 ps uncertainty、OCV 或多 PVT 变化；6.084 ps 的最小名义间隔不足以证明稳健非重叠。",
              "", "## 当前输出 setup", "", "| 输出 | 最差 slack（ps） |", "| --- | ---: |"])
text = (output / "setup.rpt").read_text()
for bit in range(4):
    values = []
    for block in text.split("Startpoint: ")[1:]:
        if f"Endpoint: count[{bit}] " in block:
            values.append(float(re.search(r"([-\d.]+)\s+slack", block)[1]) * 1000)
    lines.append(f"| count[{bit}] | {min(values):.3f} |")
lines.extend(["", "## 当前 count[0] 路径", "", "```text"])
block = next(block for block in text.split("Startpoint: ")[1:] if "Endpoint: count[0] " in block)
for line in block.splitlines():
    if any(pin in line for pin in ("gate_phi2/X", "clkbuf_phi2_single1/X", "state_phi2_bit0/GATE", "state_phi2_bit0/Q", "count[0] (out)")):
        lines.append(line)
lines.extend(["```", "", "全部 11 个锁存器端的上升/下降边沿延时、slew 和实际缓冲深度见 clock_endpoints.csv；该表仅统计各锁存器所属的真实时钟，排除 phi1 经使能支路追踪到 phi2 的标签。", ""])
(output / "cts_comparison.md").write_text("\n".join(lines))
print("CTS comparison validated and written.")
