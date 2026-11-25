#!/usr/bin/env python3
"""Validate physical results and summarize the retimed counter at 1.7 ns."""
import csv
import hashlib
import json
import os
import re
from datetime import datetime, timezone
from pathlib import Path

from layout_preview import make_preview

ROOT = Path(__file__).resolve().parents[1]
DESIGN = ROOT.parent
REPORT = ROOT / 'reports/postroute'
PLATFORM = Path(os.environ.get('SKY130HD_PLATFORM', '/home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd'))


def read(path):
    return path.read_text()


def table(path):
    with path.open() as stream:
        return list(csv.DictReader(stream, delimiter='\t'))


def digest(path):
    return dict(path=str(path.resolve()), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), bytes=path.stat().st_size)


def cells(path):
    return {name: master for master, name in re.findall(r'(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\(', read(path))}


def slack(name):
    return min(map(float, re.findall(r'([-+\d.]+)\s+slack \(', read(REPORT / f'{name}.rpt'))))


def main():
    pnr_log = read(ROOT / 'logs/pnr.log')
    assert 'PNR_RCX_COMPLETE:' in pnr_log
    assert 'Detailed-route DRC violations: 0' in read(ROOT / 'reports/route_status.rpt')
    assert all(f'All shapes on net {net} are connected.' in pnr_log for net in ['VDD', 'VSS'])
    layout_log = read(ROOT / 'logs/layout_check.log')
    assert 'LAYOUT_CHECK_COMPLETE' in layout_log
    assert 'Found 0 net violations.' in layout_log and 'Found 0 pin violations.' in layout_log
    eq_log = read(ROOT / 'logs/equivalence.log')
    assert 'Equivalence successfully proven!' in eq_log
    assert 'POSTROUTE_STA_COMPLETE:' in read(ROOT / 'logs/postroute_sta.log')
    assert not read(REPORT / 'check_setup.rpt').strip()
    endpoints = table(REPORT / 'endpoint_slacks.tsv')
    assert len(endpoints) == 48 and len({r['endpoint'] for r in endpoints}) == 24
    assert endpoints == table(ROOT / 'reports/standalone_sta/endpoint_slacks.tsv')
    summary = read(REPORT / 'summary.rpt')
    worst = {key: float(value) for key, value in re.findall(r'^worst slack (max|min) ([-\d.]+)$', summary, re.M)}
    tns = {key: float(value) for key, value in re.findall(r'^tns (max|min) ([-\d.]+)$', summary, re.M)}
    negative = [r for r in endpoints if float(r['slack_ns']) < 0]
    for mode in ['max', 'min']:
        assert abs(sum(min(0.0, float(r['slack_ns'])) for r in endpoints if r['analysis'] == mode) - tns[mode]) < 2e-6
    violated = set(re.findall(r'^(\S+).*\(VIOLATED\)', read(REPORT / 'violations.rpt'), re.M))
    assert violated == {r['endpoint'] for r in negative}
    for name in ['recovery', 'removal', 'pulse_width', 'max_slew', 'max_capacitance']:
        assert 'VIOLATED' not in read(REPORT / f'{name}.rpt')
    annotation = read(REPORT / 'parasitic_annotation.rpt').strip()
    assert annotation == 'Found 2 unannotated drivers.\n VDD\n VSS\nFound 0 partially unannotated drivers.'
    net_rows = table(ROOT / 'reports/net_inventory.tsv')
    timed_nets = [r for r in net_rows if r['type'] not in {'POWER', 'GROUND'}]
    assert all(r['has_routing'] == '1' for r in timed_nets)
    spef = read(ROOT / 'results/counter.spef')
    names = dict(re.findall(r'^\*(\d+) (\S+)$', spef, re.M))
    dnets = re.findall(r'^\*D_NET \*(\d+) (\S+)', spef, re.M)
    assert {names[key] for key, _ in dnets} == {r['net'] for r in timed_nets}
    source_cells = cells(ROOT / 'inputs/counter_sky130_2.v')
    routed_cells = cells(ROOT / 'results/counter_routed.v')
    assert len(source_cells) == 19
    assert sum('__dlrtp_' in value for value in routed_cells.values()) == 10
    resized = {n: {'before': source_cells[n], 'after': value} for n, value in routed_cells.items() if n in source_cells and source_cells[n] != value}
    added = {n: value for n, value in routed_cells.items() if n not in source_cells}
    clock_cells = sum('__clkbuf_' in value for value in added.values())
    inventory = table(ROOT / 'reports/physical_inventory.tsv')
    waveforms = {}
    for name, period, rise, fall in re.findall(r'create_clock -name (\w+) -period ([\d.]+) -waveform \{([\d.]+) ([\d.]+)\}', read(ROOT / 'inputs/counter.sdc')):
        period, rise, fall = map(float, (period, rise, fall))
        assert abs(period - 1.7) < 1e-10 and abs((fall - rise) / period - 0.49) < 1e-10
        waveforms[name] = dict(period_ns=period, rise_ns=rise, fall_ns=fall, high_ns=fall-rise, high_fraction=(fall-rise)/period)
    assert len(waveforms) == 2
    latency = {}
    for name, block in re.findall(r'Clock (\S+)\n(.*?)(?=Clock |\Z)', read(REPORT / 'clock_latency.rpt'), re.S):
        pairs = re.findall(r'^([\d.]+) ([\d.]+) latency$', block, re.M)
        assert len(pairs) == 2
        latency[name] = dict(zip(['rise_min', 'rise_max', 'fall_min', 'fall_max'], [float(x) for pair in pairs for x in pair]))
    port_gaps = dict(phi1_to_phi2=waveforms['phi2']['rise_ns'] - waveforms['phi1']['fall_ns'], phi2_to_next_phi1=1.7 + waveforms['phi1']['rise_ns'] - waveforms['phi2']['fall_ns'])
    sink_gaps = dict(phi1_to_phi2=round(port_gaps['phi1_to_phi2'] + latency['phi2']['rise_min'] - latency['phi1']['fall_max'], 6), phi2_to_next_phi1=round(port_gaps['phi2_to_next_phi1'] + latency['phi1']['rise_min'] - latency['phi2']['fall_max'], 6))
    keys = [('data_setup', '锁存器数据 Setup'), ('data_hold', '锁存器数据 Hold'), ('output_setup', '输出 Setup'), ('output_hold', '输出 Hold'), ('phi1_to_phi2_setup', 'phi1 → phi2 Setup'), ('phi1_to_phi2_hold', 'phi1 → phi2 Hold'), ('phi2_to_phi1_setup', 'phi2 → phi1 Setup'), ('phi2_to_phi1_hold', 'phi2 → phi1 Hold'), ('rst_n_setup', '复位 Recovery'), ('rst_n_hold', '复位 Removal')]
    values = {key: slack(key) for key, _ in keys}
    previous_dir = DESIGN / 'openroad_sky130_1/sta_1p7ns_49pct'
    previous = json.loads(read(previous_dir / 'manifest.json'))
    old_outputs = {r['endpoint']: float(r['slack_ns']) for r in table(previous_dir / 'reports/openroad/endpoint_slacks.tsv') if r['analysis'] == 'max' and r['endpoint'].startswith('count[')}
    outputs = {r['endpoint']: float(r['slack_ns']) for r in endpoints if r['analysis'] == 'max' and r['endpoint'].startswith('count[')}
    comparison = '\n'.join(f'| `{endpoint}` | {old_outputs[endpoint]:+.6f} | {value:+.6f} | {value-old_outputs[endpoint]:+.6f} |' for endpoint, value in sorted(outputs.items()))
    timing_table = '\n'.join(f'| {label} | {values[key]:+.6f} |' for key, label in keys)
    resize_table = '\n'.join(f'- `{name}`：`{value["before"]}` → `{value["after"]}`。' for name, value in resized.items())
    negative_table = '\n'.join(f'| `{r["startpoint"]}` → `{r["endpoint"]}` | {float(r["slack_ns"]):+.6f} |' for r in negative)
    inputs = [ROOT / 'inputs/counter_sky130_2.v', ROOT / 'inputs/counter.sdc', DESIGN / '../../../sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib', PLATFORM / 'lef/sky130_fd_sc_hd.tlef', PLATFORM / 'lef/sky130_fd_sc_hd_merged.lef', PLATFORM / 'rcx_patterns.rules', PLATFORM / 'setRC.tcl', PLATFORM / 'make_tracks.tcl', PLATFORM / 'pdn.tcl']
    manifest = dict(generated_at=datetime.now(timezone.utc).isoformat(), openroad=pnr_log.splitlines()[0], opensta=read(ROOT / 'logs/standalone_sta.log').splitlines()[0], corner='TT / 25 C / 1.8 V / nominal ORFS SKY130 RC', source_project_netlist_matches_snapshot=read(DESIGN / 'counter_sky130_2.v') == read(ROOT / 'inputs/counter_sky130_2.v'), source_project_sdc_matches_snapshot=read(DESIGN / 'counter.sdc') == read(ROOT / 'inputs/counter.sdc'), inputs=[digest(p) for p in inputs], scripts=[digest(p) for p in sorted((ROOT / 'scripts').glob('*')) if p.is_file()] + [digest(ROOT / 'run_all.sh')], outputs=[digest(ROOT / 'results' / name) for name in ['counter_routed.v', 'counter_routed.def', 'counter_routed.odb', 'counter.spef']], physical_instances=len(inventory), timed_cells=len(routed_cells), source_cells=len(source_cells), latches=10, cts_buffers=clock_cells, fillers=sum('__fill_' in r['master'] for r in inventory), taps=sum('__tapvpwrvgnd_' in r['master'] for r in inventory), extracted_nets=len(dnets), signal_wire_length_um_rounded=int(re.findall(r'Total wire length = (\d+) um', pnr_log)[-1]), signal_vias=int(re.findall(r'Total number of vias = (\d+)', pnr_log)[-1]), detailed_router_drc_violations=0, antenna_net_violations=0, antenna_pin_violations=0, power_connectivity_passed=True, constraint_sanity_passed=True, functional_equivalence_with_source_passed=True, independent_opensta_results_match=True, endpoint_results=len(endpoints), worst_slacks_ns=worst, tns_ns=tns, negative_endpoint_slacks=len(negative), negative_endpoints=negative, conventional_sta_passed=not negative, slacks_ns=values, waveforms=waveforms, clock_latency_ns=latency, nominal_sink_nonoverlap_gaps_ns=sink_gaps, strict_nominal_nonoverlap_passed=all(v > 0 for v in sink_gaps.values()), resized_cells=resized, added_cells=added, output_setup_comparison={name: dict(previous_ns=old_outputs[name], current_ns=value, improvement_ns=value-old_outputs[name]) for name, value in outputs.items()})
    (ROOT / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
    (ROOT / 'reports/clock_nonoverlap.rpt').write_text(
        'Nominal TT, conservative envelope over all latch GATE pins; uncertainty/jitter not subtracted.\n'
        f'phi1 -> phi2: 0.017000 + {latency["phi2"]["rise_min"]:.6f} - {latency["phi1"]["fall_max"]:.6f} = {sink_gaps["phi1_to_phi2"]:+.6f} ns\n'
        f'phi2 -> next phi1: 0.017000 + {latency["phi1"]["rise_min"]:.6f} - {latency["phi2"]["fall_max"]:.6f} = {sink_gaps["phi2_to_next_phi1"]:+.6f} ns\n'
        f'Strict nominal sink nonoverlap: {"PASS" if manifest["strict_nominal_nonoverlap_passed"] else "FAIL"}\n')
    make_preview(inventory)
    improvement = worst['max'] - previous['worst_slacks_ns']['max']
    (ROOT / 'README.md').write_text(f'''# counter_sky130_2：1.7 ns 布局布线、提取及后布线 STA

已使用 OpenROAD 对项目 `counter_sky130_2.v` 完成重新布局布线、两相 CTS、OpenRCX 寄生提取及传播时钟 STA。保持 **1.7 ns 周期、两相高电平占比 49%**，原 I/O、复位预算和不确定度不变。原始网表和 `counter.sdc` 未修改，分析输入快照及 SHA-256 已保存。

**最终仍有 {len(negative)} 条输出 setup 违例，最差 slack 为 {worst['max']:.6f} ns，max TNS 为 {tns['max']:.6f} ns；最差路径已转移到 `state_phi2_bit0/Q → count[0]`。数据 hold、复位 recovery/removal、脉宽与 slew/capacitance 检查通过。**

原 `count[2]` 路径由 −0.075181 ns 改善到 {outputs['count[2]']:+.6f} ns；全局最差裕量改善约 **{improvement*1000:.3f} ps**。严格非重叠仍未满足：phi1 → phi2 的名义时钟包络重叠约 **{-sink_gaps['phi1_to_phi2']*1000:.3f} ps**。

## 交付文件

- [详细布线 DEF](results/counter_routed.def)、[布线数据库 ODB](results/counter_routed.odb)、[提取数据库 ODB](results/counter_extracted.odb)。
- [后布线网表](results/counter_routed.v)、[OpenRCX SPEF](results/counter.spef)、[有效 STA 约束](reports/postroute/effective.sdc)。
- [完整 STA 汇总](reports/postroute/summary.rpt)、[违例清单](reports/postroute/violations.rpt)、[逐端点裕量](reports/postroute/endpoint_slacks.tsv)。
- [输入网表快照](inputs/counter_sky130_2.v)、[SDC 快照](inputs/counter.sdc)、[输入/输出及工具校验记录](manifest.json)、[复现入口](run_all.sh)。

![新网表的布局布线预览](results/layout_preview.png)

预览为 DEF 导线中心线和实际单元边界，含淡色电源网格。物理版图交付为 DEF/ODB，未生成 GDS。

## 结构和实现条件

`counter_sky130_2.v` 将 bit2 的 XOR 也放到 phi1 与 phi2 之间，新增 `state_phi1_toggle2`，bit2/bit3 均由 phi1 锁存操作数后经 XOR 送到 phi2。输入网表共有 19 个单元，其中 **10 个锁存器**（phi1 六个、phi2 四个）。

| 项目 | 设置或结果 |
| --- | --- |
| OpenROAD | 26Q2-1164-g08f67ee5ec，2 个线程 |
| 独立交叉验证 | OpenSTA 3.1.0 d1e43c6f9f |
| 工艺 / Liberty | SKY130 HD，TT / 25°C / 1.8 V，沿用项目原 TT 库 |
| 物理平台 | 本地 ORFS sky130hd 技术 LEF、单元 LEF、轨道及 PDN |
| 提取 RC | ORFS sky130hd 指定的 rcx_patterns.rules，nominal 单角 |
| Die / Core 设置 | 80 × 80 µm / (10.12, 10.88)–(70, 70) µm |
| Site / 全局布局目标密度 | unithd / 0.35 |
| 信号 / 时钟布线层 | met1–met5 / met3–met5；末端引脚访问可用低层 |
| 最终时序网表单元数 | {len(routed_cells)}，含 10 个锁存器、{clock_cells} 个时钟缓冲器和 1 个复位缓冲器 |
| 物理实例数 | {len(inventory)}，含 {manifest['fillers']} 个 filler、{manifest['taps']} 个 well tap |
| 信号及两相时钟导线 | 约 {manifest['signal_wire_length_um_rounded']} µm，{manifest['signal_vias']} 个过孔，不含 PDN |
| 提取网络数 | {len(dnets)}，覆盖全部信号及两相时钟网络 |
| 详细布线器最终 DRC | 0 |
| 天线检查 | 0 个网络 / 0 个引脚违例 |
| VDD / VSS 连通性 | 均通过 |

时钟波形：phi1 为 **0.0085–0.8415 ns**，phi2 为 **0.8585–1.6915 ns**；每相高电平 0.833 ns，两个端口死区均为 0.017 ns。所有 I/O/复位 delay、输出负载和时钟不确定度直接沿用 SDC。

## 后布线时序

| 检查 | 最差 slack ns |
| --- | ---: |
{timing_table}

max/setup WNS 为 **{worst['max']:.6f} ns**，max TNS 为 **{tns['max']:.6f} ns**；min 最差为 **{worst['min']:+.6f} ns**，min TNS 为 **{tns['min']:.6f} ns**。

| 违例路径 | slack ns |
| --- | ---: |
{negative_table}

最差路径从 phi2 上升沿 **0.858500 ns** 出发，经过实际时钟树、`state_phi2_bit0` 的 GATE→Q 和输出导线，到达 `count[0]` 的时间为 **1.520940 ns**。输出以 phi1 下一周期下降沿 2.541500 ns 为参考，扣除 0.05 ns 不确定度和 1.00 ns output delay，要求时间为 **1.491500 ns**，因此 slack 为 **−0.029440 ns**。

`count[3]` 的 setup 已为 {outputs['count[3]']:+.6f} ns。锁存器 D 端的 0 ns 条目标记为 `MET`，对应合法时间借用，应与负 slack 输出违例区分。`-violators` 输出包含 0 ns 的 `MET` 条目，文件非空不能直接作为违例判据。

`check_setup -verbose` 无告警，仅表示约束完整性检查通过。48 项 max/min 结果覆盖 10 个 D、10 个 RESET_B 和 4 个 count 输出；OpenROAD 与独立 OpenSTA 的逐端点结果完全一致。SPEF 逐项匹配全部实际信号/时钟网络，无部分注释驱动端；注释报告列出的未注释端仅为电源端口 VDD/VSS。

高电平最小脉宽最差裕量为 +0.615232 ns；最大转换时间最差裕量 +1.090001 ns，最大电容最差裕量 +0.073524 pF。`min_period.rpt`、`max_fanout.rpt` 为空，表示本次无可报告的对应限制。

## 与上一版在 1.7 ns 下比较

| 输出端 | counter_sky130_1 slack ns | counter_sky130_2 slack ns | 改善 ns |
| --- | ---: | ---: | ---: |
{comparison}

上一版的 max TNS 为 −0.175890 ns、4 条输出 setup 违例；新版本为 {tns['max']:.6f} ns、{len(negative)} 条。原最差 `count[2]` 路径改善，但最差输出转移到 count[0]，未达到全部时序收敛。

这是两份物理实现的最终结果对比。新版本按 1.7 ns 重跑了布局布线与尺寸优化，旧版本最初按 2 ns 建成后在 1.7 ns 重分析，因此上述差异不能全部归因于重定时。原记录见 [上一版 1.7 ns 报告](../openroad_sky130_1/sta_1p7ns_49pct/README.md)。

## 两相时钟端的非重叠

| 方向 | 端口死区 ns | 锁存器端最差名义间隔 ns |
| --- | ---: | ---: |
| phi1 关闭 → phi2 开启 | 0.017000 | {sink_gaps['phi1_to_phi2']:+.6f} |
| phi2 关闭 → 下一周期 phi1 开启 | 0.017000 | {sink_gaps['phi2_to_next_phi1']:+.6f} |

phi1 最晚下降沿为 0.841500 + 0.279602 = 1.121102 ns，phi2 最早上升沿为 0.858500 + 0.256411 = 1.114911 ns，相差 −0.006191 ns，即名义重叠 6.191 ps。反向仍有 2.370 ps 正间隔。这是全部锁存器 GATE 端的 TT 名义时钟包络，未扣除抖动或不确定度，严格非重叠要求未满足；该检查独立于数据 hold。

## 优化和验证

流程包括 floorplan、I/O 放置、tap/PDN、全局/详细布局、CTS、复位缓冲、placement RC 下的 setup 优化、全局布线寄生下的 setup 优化、重新详布、filler、PDN 连通检查和 OpenRCX 提取。添加的复位缓冲器计入真实延迟，不放宽外部复位预算。

原始单元的最终尺寸变化：

{resize_table}

首次完整详布/提取结果保留在 [first_pass](first_pass/reports/postroute/summary.rpt)。增加全局布线寄生优化后，优化器未接受进一步修改，最终负裕量仍存在；日志中的 `RSZ-0062` 与这一结果一致。

Yosys 使用同一 Liberty 功能模型，将输入 `counter_sky130_2.v` 与本次后布线网表展开，并以 `clk2fflogic` 处理锁存器后检查功能等价：**28 个等价点全部证明通过**。这验证本次物理缓冲和尺寸优化相对 `_2.v` 的零延迟功能保持，不是 `_1.v` 与 `_2.v` 的重定时等价证明。真实电气延迟由后布线 STA 检查。

详细布线器日志含 `DRT-0349`：该版本忽略没有 CUTCLASS 的 LEF58_ENCLOSURE 条目。0 DRC 为布线器已实现规则范围内的结果，未进行完整晶圆厂 DRC/LVS、金属密度填充或多角/OCV/SI 签核。

## 报告和复现

- [布线日志](logs/pnr.log)、[CTS 统计](reports/cts.rpt)、[DRC 状态](reports/route_status.rpt)、[天线/布局检查](logs/layout_check.log)、[功能等价](logs/equivalence.log)。
- [全部时序/电气检查](reports/postroute/checks.rpt)、[Setup 违例详细路径](reports/postroute/setup_violations.rpt)、[数据 Hold](reports/postroute/data_hold.rpt)。
- [时钟传播延迟](reports/postroute/clock_latency.rpt)、[非重叠计算](reports/clock_nonoverlap.rpt)、[SPEF 注释](reports/postroute/parasitic_annotation.rpt)、[独立 STA 汇总](reports/standalone_sta/summary.rpt)。

在项目目录运行：

```bash
bash openroad_sky130_2/run_all.sh
```

入口读取 `inputs/` 中的快照，重新生成最终实现、SPEF、STA、物理与等价检查、manifest 及版图预览，不覆盖 first_pass 或上一版目录。工具正常完成但时序未收敛时仍保存报告，manifest 的 `conventional_sta_passed` 为 false。可用 `SKY130HD_PLATFORM` 指定兼容平台路径。
''')
    print(f'Completed: {len(routed_cells)} timing cells / 10 latches; {len(dnets)} extracted nets; {len(endpoints)} matching endpoint results.')
    print(f'DRC=0; antenna=0; PDN connected; functional equivalence PASS; setup/max slack={worst["max"]:.6f} ns; TNS={tns["max"]:.6f} ns; {len(negative)} negative endpoints.')
    print(f'Nominal nonoverlap gaps: {sink_gaps}.')


if __name__ == '__main__':
    main()
