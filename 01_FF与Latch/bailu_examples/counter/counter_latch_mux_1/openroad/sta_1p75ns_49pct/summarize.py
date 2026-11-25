#!/usr/bin/env python3
"""Validate the fixed-layout counter_sky130_2 STA rerun at 1.75 ns / 49%."""
import csv
import hashlib
import json
import re
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parent
PNR = ROOT.parent
DESIGN = PNR.parent
REPORT = ROOT / 'reports/openroad'


def read(path):
    return path.read_text()


def table(path):
    with path.open() as stream:
        return list(csv.DictReader(stream, delimiter='\t'))


def digest(path):
    return dict(path=str(path.resolve()), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), bytes=path.stat().st_size)


def slack(name):
    return min(map(float, re.findall(r'([-+\d.]+)\s+slack \(', read(REPORT / f'{name}.rpt'))))


def main():
    budget_lines = lambda p: [s.strip() for s in read(p).splitlines() if s.strip() and not s.lstrip().startswith(('#', 'create_clock'))]
    assert budget_lines(ROOT / 'counter_before.sdc') == budget_lines(ROOT / 'counter.sdc')
    clocks = {}
    for name, period, rise, fall in re.findall(r'create_clock -name (\w+) -period ([\d.]+) -waveform \{([\d.]+) ([\d.]+)\}', read(ROOT / 'counter.sdc')):
        period, rise, fall = map(float, (period, rise, fall))
        assert abs(period - 1.75) < 1e-10 and abs((fall - rise) / period - 0.49) < 1e-10
        clocks[name] = dict(period_ns=period, rise_ns=rise, fall_ns=fall, high_ns=fall-rise, high_fraction=(fall-rise)/period)
    assert set(clocks) == {'phi1', 'phi2'}
    primary = table(REPORT / 'endpoint_slacks.tsv')
    assert primary == table(ROOT / 'reports/standalone/endpoint_slacks.tsv')
    assert len(primary) == 48 and len({r['endpoint'] for r in primary}) == 24
    assert not read(REPORT / 'check_setup.rpt').strip()
    for engine in ['openroad', 'standalone']:
        log = read(ROOT / f'logs/{engine}.log')
        assert 'POSTROUTE_STA_COMPLETE:' in log
        assert not re.search(r'(?im)^\s*(?:\[(?:WARNING|ERROR)|Error|Warning|STA_FAILED)', log)
    baseline = json.loads(read(PNR / 'manifest.json'))
    unchanged = []
    for entry in baseline['outputs']:
        path = Path(entry['path'])
        assert digest(path)['sha256'] == entry['sha256'], path
        unchanged.append(path.name)
    summary = read(REPORT / 'summary.rpt')
    worst = {mode: float(v) for mode, v in re.findall(r'^worst slack (max|min) ([-\d.]+)$', summary, re.M)}
    tns = {mode: float(v) for mode, v in re.findall(r'^tns (max|min) ([-\d.]+)$', summary, re.M)}
    negative = [r for r in primary if float(r['slack_ns']) < 0]
    assert not negative and not any('VIOLATED' in read(p) for p in REPORT.glob('*.rpt'))
    assert tns == {'max': 0.0, 'min': 0.0}
    assert read(REPORT / 'parasitic_annotation.rpt').strip() == 'Found 2 unannotated drivers.\n VDD\n VSS\nFound 0 partially unannotated drivers.'
    latency = {}
    for name, block in re.findall(r'Clock (\S+)\n(.*?)(?=Clock |\Z)', read(REPORT / 'clock_latency.rpt'), re.S):
        pairs = re.findall(r'^([\d.]+) ([\d.]+) latency$', block, re.M)
        assert len(pairs) == 2
        latency[name] = dict(zip(['rise_min', 'rise_max', 'fall_min', 'fall_max'], [float(x) for pair in pairs for x in pair]))
    port_gaps = dict(phi1_to_phi2=clocks['phi2']['rise_ns']-clocks['phi1']['fall_ns'], phi2_to_next_phi1=1.75+clocks['phi1']['rise_ns']-clocks['phi2']['fall_ns'])
    sink_gaps = dict(phi1_to_phi2=round(port_gaps['phi1_to_phi2']+latency['phi2']['rise_min']-latency['phi1']['fall_max'], 6), phi2_to_next_phi1=round(port_gaps['phi2_to_next_phi1']+latency['phi1']['rise_min']-latency['phi2']['fall_max'], 6))
    checks = [('data_setup', '锁存器数据 Setup'), ('data_hold', '锁存器数据 Hold'), ('output_setup', '输出 Setup'), ('output_hold', '输出 Hold'), ('phi1_to_phi2_setup', 'phi1 → phi2 Setup'), ('phi1_to_phi2_hold', 'phi1 → phi2 Hold'), ('phi2_to_phi1_setup', 'phi2 → phi1 Setup'), ('phi2_to_phi1_hold', 'phi2 → phi1 Hold'), ('rst_n_setup', '复位 Recovery'), ('rst_n_hold', '复位 Removal')]
    values = {name: slack(name) for name, _ in checks}
    timing_rows = '\n'.join(f'| {label} | {baseline["slacks_ns"][name]:+.6f} | {values[name]:+.6f} |' for name, label in checks)
    old_outputs = {r['endpoint']: float(r['slack_ns']) for r in table(PNR / 'reports/postroute/endpoint_slacks.tsv') if r['analysis'] == 'max' and r['endpoint'].startswith('count[')}
    outputs = {r['endpoint']: float(r['slack_ns']) for r in primary if r['analysis'] == 'max' and r['endpoint'].startswith('count[')}
    output_rows = '\n'.join(f'| `{name}` | {old_outputs[name]:+.6f} | {value:+.6f} |' for name, value in sorted(outputs.items()))
    borrow = max(map(float, re.findall(r'actual time borrow\s+([-+\d.]+)', read(REPORT / 'data_setup.rpt'))))
    pulse_slack = min(map(float, re.findall(r'([-+\d.]+) \(MET\)', read(REPORT / 'pulse_width.rpt'))))
    inputs = [ROOT / 'counter.sdc', ROOT / 'counter_before.sdc', PNR / 'results/counter_routed.v', PNR / 'results/counter.spef', DESIGN / '../../../sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib', PNR / 'scripts/config.tcl', PNR / 'scripts/postroute_sta.tcl', ROOT / 'run_sta.tcl', ROOT / 'run.sh', ROOT / 'summarize.py']
    manifest = dict(generated_at=datetime.now(timezone.utc).isoformat(), openroad=read(ROOT / 'logs/openroad.log').splitlines()[0], opensta=read(ROOT / 'logs/standalone.log').splitlines()[0], netlist_source='counter_sky130_2.v routed implementation', corner='SKY130 HD TT / 25 C / 1.8 V / existing nominal OpenRCX SPEF', inputs=[digest(p) for p in inputs], project_sdc_matches_snapshot=read(DESIGN / 'counter.sdc') == read(ROOT / 'counter.sdc'), physical_artifacts_unchanged=unchanged, waveforms=clocks, propagated_clocks=True, independent_sta_match=True, constraint_sanity_passed=True, endpoint_results=len(primary), negative_endpoint_slacks=len(negative), conventional_sta_passed=not negative, worst_slacks_ns=worst, tns_ns=tns, slacks_ns=values, output_setup_slacks_ns=outputs, maximum_reported_time_borrow_ns=borrow, pulse_width_slack_ns=pulse_slack, clock_latency_ns=latency, nominal_sink_nonoverlap_gaps_ns=sink_gaps, strict_nominal_nonoverlap_passed=all(v > 0 for v in sink_gaps.values()))
    (ROOT / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
    (ROOT / 'clock_waveforms.tsv').write_text('clock\tperiod_ns\trise_ns\tfall_ns\thigh_ns\thigh_percent\n' + ''.join(f'{name}\t{v["period_ns"]:.6f}\t{v["rise_ns"]:.6f}\t{v["fall_ns"]:.6f}\t{v["high_ns"]:.6f}\t{100*v["high_fraction"]:.2f}\n' for name, v in clocks.items()))
    (ROOT / 'clock_nonoverlap.rpt').write_text(
        'Nominal TT, conservative envelope over all latch GATE pins; uncertainty/jitter not subtracted.\n'
        f'phi1 -> phi2: 0.017500 + {latency["phi2"]["rise_min"]:.6f} - {latency["phi1"]["fall_max"]:.6f} = {sink_gaps["phi1_to_phi2"]:+.6f} ns\n'
        f'phi2 -> next phi1: 0.017500 + {latency["phi1"]["rise_min"]:.6f} - {latency["phi2"]["fall_max"]:.6f} = {sink_gaps["phi2_to_next_phi1"]:+.6f} ns\n'
        f'Strict nominal sink nonoverlap: {"PASS" if manifest["strict_nominal_nonoverlap_passed"] else "FAIL"}\n')
    (ROOT / 'README.md').write_text(f'''# counter_sky130_2：1.75 ns / 49% 后布线 STA

已将项目 `counter.sdc` 周期更新为 **1.75 ns**，两相高电平占比继续为 **49%**。使用 `counter_sky130_2.v` 对应的现有后布线网表与 OpenRCX SPEF 重跑传播时钟 STA。

**原 1.7 ns 下的 3 条输出 setup 违例全部消除。常规 STA 无负 slack，setup/max 与 hold/min TNS 均为 0。输出 setup 最差 +{values['output_setup']:.6f} ns，数据 hold 最差 +{values['data_hold']:.6f} ns。** 但严格非重叠仍未满足，phi1 → phi2 锁存器端的名义时钟包络重叠约 **{-sink_gaps['phi1_to_phi2']*1000:.3f} ps**。

## 约束与输入

| 时钟 | 周期 ns | 上升沿 ns | 下降沿 ns | 高电平宽度 ns | 占比 |
| --- | ---: | ---: | ---: | ---: | ---: |
| phi1 | 1.750 | 0.00875 | 0.86625 | 0.8575 | 49% |
| phi2 | 1.750 | 0.88375 | 1.74125 | 0.8575 | 49% |

两个端口交接死区均为 **0.0175 ns**。只按比例调整时钟周期和边沿位置，原 I/O delay、复位释放预算、输出负载及 0.05 ns 时钟不确定度不变。[本次 SDC 快照](counter.sdc) 与项目当前约束一致；[修改前快照](counter_before.sdc) 为 1.7 ns / 49%。

继续使用 SKY130 HD TT、25°C、1.8 V 库，26 个时序网表单元、10 个锁存器。未重做布局布线、CTS 或提取；后布线网表、DEF、ODB 和 SPEF 的哈希与原 `openroad_sky130_2/manifest.json` 一致。原 1.7 ns 报告保留。

## 与 1.7 ns 的对比

| 检查 | 1.7 ns slack（ns） | 1.75 ns slack（ns） |
| --- | ---: | ---: |
{timing_rows}

全局 max 最差为 **{worst['max']:.6f} ns**，min 最差为 **{worst['min']:+.6f} ns**。全局 setup 的 0 ns 条目标记为 `MET`，对应锁存器透明窗口内的合法时间借用；最大报告借用量为 **{borrow:.6f} ns**，不能将其当作负裕量违例。

| 输出端 | 1.7 ns setup slack（ns） | 1.75 ns setup slack（ns） |
| --- | ---: | ---: |
{output_rows}

输出最差仍为 `state_phi2_bit0/Q → count[0]`。新 phi2 上升沿为 0.883750 ns，数据到达时间为 **1.546190 ns**。参考 phi1 下一周期下降沿 **2.616250 ns**，扣除 0.05 ns 不确定度及 1.00 ns output delay，要求时间为 **1.566250 ns**，得到 slack **+0.020060 ns**。

高电平最小脉宽最差裕量为 **+{pulse_slack:.6f} ns**，slew 和 capacitance 检查通过。`check_setup -verbose` 无告警，48 项 max/min 结果覆盖 10 个 D、10 个 RESET_B 和 4 个输出端。OpenROAD 与独立 OpenSTA 的逐端点结果完全一致，没有 `VIOLATED` 项。`-violators` 输出会列出 slack 恰为 0 的 `MET` 借用条目，不能按文件是否为空判定违例。

SPEF 注释完整性与原物理实现一致：全部信号和时钟网络已注释，未注释驱动端仅为 VDD/VSS 电源端口，没有部分注释驱动端。

## 两相非重叠

| 方向 | 端口死区 ns | 锁存器端最差名义间隔 ns |
| --- | ---: | ---: |
| phi1 关闭 → phi2 开启 | 0.017500 | {sink_gaps['phi1_to_phi2']:+.6f} |
| phi2 关闭 → 下一周期 phi1 开启 | 0.017500 | {sink_gaps['phi2_to_next_phi1']:+.6f} |

phi1 最晚下降沿为 0.866250 + 0.279602 = 1.145852 ns；phi2 最早上升沿为 0.883750 + 0.256411 = 1.140161 ns，相差 −0.005691 ns，即重叠 5.691 ps。反向有 2.870 ps 正间隔。

这是 TT 角全部锁存器 GATE 端时钟包络的保守组合，未扣除抖动或不确定度。**常规数据 STA 通过与严格时钟非重叠是两个独立结论**；本次未调整时钟树来消除重叠。

## 文件与复现

- [原始 STA 汇总](reports/openroad/summary.rpt)、[全部检查](reports/openroad/checks.rpt)、[逐端点裕量](reports/openroad/endpoint_slacks.tsv)。
- [输出 Setup 路径](reports/openroad/output_setup.rpt)、[数据 Setup](reports/openroad/data_setup.rpt)、[数据 Hold](reports/openroad/data_hold.rpt)。
- [有效约束](reports/openroad/effective.sdc)、[精确波形](clock_waveforms.tsv)、[传播时钟延迟](reports/openroad/clock_latency.rpt)、[非重叠计算](clock_nonoverlap.rpt)。
- [独立 OpenSTA 汇总](reports/standalone/summary.rpt)、[输入哈希与校验记录](manifest.json)、[OpenROAD 日志](logs/openroad.log)、[OpenSTA 日志](logs/standalone.log)。

在项目目录运行，不执行布局布线：

```bash
bash openroad_sky130_2/sta_1p75ns_49pct/run.sh
```

脚本使用本目录 SDC 快照。本次是 TT/nominal RC 单角分析，不替代多工艺角、OCV 或 SI 签核。时钟属性简表的边沿只显示两位小数，精确值以 SDC 快照和有效约束为准。
''')
    print(f'1.75 ns / 49% STA: {len(primary)} matching OpenROAD/OpenSTA results; no negative slack; setup and hold TNS = 0.')
    print(f'Output setup slack {values["output_setup"]:+.6f} ns; data hold slack {values["data_hold"]:+.6f} ns.')
    print(f'Nominal sink nonoverlap gaps: {sink_gaps}; strict nonoverlap passed: {manifest["strict_nominal_nonoverlap_passed"]}.')


if __name__ == '__main__':
    main()
