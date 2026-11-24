"""Simulate measured activity and run OpenROAD on the existing routed design."""
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
import tempfile
import argparse
from decimal import Decimal

SCRIPT_DIR = Path(__file__).resolve().parent
HERE = SCRIPT_DIR
ROOT = SCRIPT_DIR.parent.parent
IMPLEMENTATION = SCRIPT_DIR.parent
PERIOD_NS = 1.75
MEASUREMENT_FS = 7_168_000_000
SDC_SOURCE = ROOT / 'counter.sdc'
LIBERTY = Path(os.environ.get('COUNTER_POWER_LIBERTY',
               str(ROOT / '../../../sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib'))).resolve()
MODELS = Path(os.environ.get('SKY130_POWER_MODELS', '/home/bailufrost/OpenSTA/examples'))
PLATFORM = Path(os.environ.get('SKY130HD_PLATFORM',
                '/home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd'))
SCENARIOS = {'active': 1, 'mixed': 2, 'hold': 0}
COMPONENTS = ['internal', 'switching', 'leakage', 'total']


def run(command, logfile, env=None):
    with logfile.open('w') as output:
        subprocess.run([str(a) for a in command], cwd=ROOT, stdout=output,
                       stderr=subprocess.STDOUT, env=env, check=True)
    return logfile.read_text()


def digest(path):
    return {'path': str(path.resolve()), 'sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
            'bytes': path.stat().st_size}


def write_report(summary):
    scenarios = summary['scenarios']
    labels = {'active': '连续计数（en=1）', 'mixed': '50% 使能（16 周期开 / 16 周期停）',
              'hold': '保持零值（en=0，时钟继续运行）'}
    rows = []
    for name, result in scenarios.items():
        p = result['power_W']['Total']
        rows.append(f"| {labels[name]} | {p['internal']*1e6:.3f} | {p['switching']*1e6:.3f} | "
                    f"{p['leakage']*1e9:.6f} | {p['total']*1e6:.3f} | {result['energy_per_cycle_pJ']:.6f} |")
    active = scenarios['active']
    total = active['power_W']['Total']['total']
    subtotal_rows = []
    for key, label in [('phase1_latches', 'phi1 锁存器（6 个）'),
                       ('phase2_latches', 'phi2 锁存器（4 个）'),
                       ('clock_tree', 'CTS 时钟缓冲器（6 个）'), ('logic', '组合逻辑（9 个）'),
                       ('reset_buffer', '复位缓冲器（1 个）')]:
        p = active['groups_W'][key]
        subtotal_rows.append(f"| {label} | {p['internal']*1e6:.6f} | {p['switching']*1e6:.6f} | "
                             f"{p['leakage']*1e9:.6f} | {p['total']*1e6:.6f} |")
    reduction = 100*(1-scenarios['hold']['power_W']['Total']['total']/total)
    clock_share = 100*active['power_W']['Clock']['total']/total
    period = summary['clock_period_ns']
    clock_description = (f'- 时钟：周期 {period:g} ns，频率 {1000/period:.6f} MHz；'
                         f'phi1 高电平为 {period*.005:.5f}–{period*.495:.5f} ns，'
                         f'phi2 为 {period*.505:.5f}–{period*.995:.5f} ns，各占 49%，'
                         f'端口交接死区 {period*10:g} ps。分析中启用传播时钟。\n')
    reproduce = (f'python3 openroad/power/run.py --sdc {SDC_SOURCE.relative_to(ROOT)} '
                 f'--output-dir {HERE.relative_to(ROOT)}')
    overlap_ps = 23.191 - period*10
    text = f'''# 4 位锁存器计数器：{period:g} ns OpenROAD 后布线功耗报告

连续计数平均功耗 **{total*1e3:.6f} mW**，每周期能量约 **{active['energy_per_cycle_pJ']:.6f} pJ**。
这是现有布局布线及提取寄生参数下、给定功能活动的平均功耗估算。

## 场景结果

| 场景 | 内部功耗 µW | 网络切换功耗 µW | 漏电功耗 nW | 总功耗 µW | 每周期能量 pJ |
| --- | ---: | ---: | ---: | ---: | ---: |
''' + '\n'.join(rows) + f'''

动态功耗 = 内部功耗 + 网络切换功耗。**漏电列使用 nW，其余功耗列使用 µW**；OpenROAD 原始 `power.rpt` / `power.json` 数值均为 W，不能按 Liberty `report_units` 中的 1 nW 直接解读。少量末位差异来自工具浮点累加及显示精度。

连续计数时，CTS 缓冲器占总功耗 **{clock_share:.2f}%**。en=0 仅保持数据，两相时钟和锁存器时钟端仍持续翻转，因此保持状态总功耗仅比连续计数低约 **{reduction:.2f}%**；保持场景不是时钟关闭或电源关闭场景。

## 连续计数的单元组明细

| 单元组 | 内部功耗 µW | 网络切换功耗 µW | 漏电功耗 nW | 总功耗 µW |
| --- | ---: | ---: | ---: | ---: |
''' + '\n'.join(subtotal_rows) + '''

原始报告的 `Sequential` 包含两组锁存器，`Clock` 包含 CTS 缓冲器，`Combinational` 包含组合逻辑及复位缓冲器。逐单元明细及功耗最高的 10 个单元分别见各场景的 `instances.tsv`、`instances.rpt` 和 `top10.tsv`。

## 分析条件

- 工具：''' + summary['openroad'] + '''，2 个线程；功耗计算由 OpenROAD 内置 OpenSTA 执行。
- 工艺：SKY130 HD，TT / 25°C / 1.8 V；复用项目同一 Liberty 功耗表和 nominal OpenRCX SPEF。
- 电路：源网表 19 个单元；物理优化后为 26 个信号单元，包含 10 个锁存器、6 个 CTS 缓冲器、1 个复位缓冲器及尺寸调整。未重新布局布线。
''' + clock_description + '''- 沿用所选 SDC 的输入转换时间、输出负载（每位 0.010 pF）等约束；[SDC 快照](inputs/counter.sdc) 与有效约束保存在本报告目录。
- rst_n 在测量期恒为 1，电源为常量；en 不设 case analysis，按 VCD 中实际活动统计。
''' + f'- Icarus Verilog 使用本机 OpenSTA examples 中的 SkyWater SKY130 功能模型。每个场景先复位 2 周期、计数 16 周期、保持 2 周期，再统计 4096 周期（{summary["measurement_duration_ns"]:g} ns）。复位和预热不计入测量。\n' + '''
- VCD 包含顶层信号及所有单元端口。时间戳重定位至测量窗口起点，以免预热时间稀释翻转率；`*_window.json` 保留原始测量起止时间。

## 验证结果

- Yosys 对当前 `counter_sky130.v` 与后布线网表的 28 个等价点全部证明通过，见 [equivalence.log](logs/equivalence.log)。
- 三种场景均逐周期检查源电路、后布线电路与预期计数序列一致，各通过 4096 个测量周期。
- 三种场景的 VCD 活动注释均为 **94/94 引脚，0 个未注释引脚**；包括 84 个单元信号引脚，测量期没有 X/Z。
- 连续计数的 count[0..3] 翻转次数分别为 4096、2048、1024、512；50% 使能为 2048、1024、512、256；保持状态均为 0。每个时钟均有 8192 次翻转，实测高电平占比 49%。
- SPEF 覆盖全部信号及时钟网络；仅 VDD/VSS 电源端口未注释，无部分注释驱动端。
- 脚本核对逐单元功耗之和与设计总功耗一致，并检查无 NaN、负功耗或工具错误。

## 文件与复现

- [机器可读汇总 JSON](summary.json)、[汇总 CSV](summary.csv)、[输入/工具模型/脚本/输出 SHA-256](manifest.json)。
- 原始功耗报告：[连续计数](reports/active/power.rpt)、[50% 使能](reports/mixed/power.rpt)、[保持](reports/hold/power.rpt)。
- 各场景的 `reports/<场景>/activity_annotation.rpt` 为活动覆盖报告，`parasitic_annotation.rpt` 为寄生注释报告；`activity/*_signals.tsv` 为独立解析的活动统计。
- `activity/*.vcd` 为测量期波形；`logs/` 保存仿真、编译和 OpenROAD 日志，`inputs/` 保存源网表及当前 SDC 快照。

在项目根目录运行：

```sh
''' + reproduce + '''
```

依赖 `openroad`、`yosys`、`iverilog`、`vvp`。可用 `SKY130_POWER_MODELS` 指定包含 `sky130_hd.v` 和 `sky130_hd_primitives.v` 的模型目录，`SKY130HD_PLATFORM` 指定平台，`COUNTER_POWER_LIBERTY` 指定兼容 TT / 25°C / 1.8 V 库。脚本从所选 SDC 提取周期，校验两相各 49% 的边沿，并同步设置测试台时钟、测量窗口和每周期能量计算。

## 适用范围

''' + f'使用零延时门级功能 VCD 和带 SPEF 的 Liberty 平均功耗计算，未做 SDF 延时回标、真实延时毛刺分析或晶体管瞬态功耗仿真。每周期能量为总平均功耗乘 {period:g} ns。漏电值直接来自此 TT 库，在此温度角下计算，不能推广到高温或其他工艺角。\n\n' + f'当前周期下，按全部 latch GATE 的 TT 名义时钟包络计算，phi1→phi2 间隔为 {-overlap_ps:+.3f} ps。' + '''本次功能 VCD 未模拟时钟重叠引起的竞争或额外翻转，相关时序结论见 [最高频率 STA 报告](../fmax_49pct/README.md)。功耗不含片外时钟驱动器、外部负载接收电路、电源网络损耗及封装功耗；未计入 filler/well tap 的额外漏电模型。这些结果不构成多角或硅后功耗签核。

'''
    baseline_path = SCRIPT_DIR / 'summary.json'
    if HERE != SCRIPT_DIR and baseline_path.exists():
        baseline = json.loads(baseline_path.read_text())
        comparison = []
        for name, result in scenarios.items():
            old = baseline['scenarios'][name]['power_W']['Total']['total']
            new = result['power_W']['Total']['total']
            comparison.append(f'| {labels[name]} | {old*1e6:.3f} | {new*1e6:.3f} | {(new/old-1)*100:+.3f}% |')
        text += (f'\n## 与原 {baseline["clock_period_ns"]:g} ns 结果比较\n\n'
                 '| 场景 | 原总功耗 µW | 本次总功耗 µW | 变化 |\n| --- | ---: | ---: | ---: |\n' +
                 '\n'.join(comparison) + '\n\n本次重新生成 VCD 并运行 OpenROAD 功耗分析；表中本次结果为工具计算值。原报告见 [1.75 ns 功耗报告](../power/README.md)。\n')
    (HERE / 'README.md').write_text(text)


def normalize_vcd(path, target):
    """Exclude warmup time by rebasing the first dumped timestamp to zero."""
    data = path.read_text()
    times = [int(t) for t in re.findall(r'^#(\d+)$', data, re.M)]
    assert times and times[-1] - times[0] == MEASUREMENT_FS, 'Wrong VCD measurement window'
    # Suppress wall-clock-only metadata for repeatable activity files.
    data = re.sub(r'\$date\s+.*?\$end', '$date\n measurement window\n$end', data, flags=re.S)
    target.write_text(re.sub(r'^#(\d+)$', lambda m: '#' + str(int(m[1]) - times[0]), data, flags=re.M))
    return times[0], times[-1]


def vcd_statistics(path, output):
    """Independent transition/duty check, including every routed cell pin."""
    data = path.read_text()
    assert re.search(r'\$timescale\s+1fs\s+\$end', data)
    header, body = data.split('$enddefinitions $end', 1)
    scopes, signals, id_bits = [], [], {}
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
            indexes = list(range(width - 1, -1, -1))
            if len(fields) > 6 and fields[5].startswith('['):
                limits = [int(n) for n in re.findall(r'-?\d+', fields[5])]
                indexes = list(range(limits[0], limits[-1] - 1, -1))
            prefix = '/'.join(scopes) + '/' + name
            names = [prefix] if width == 1 else [f'{prefix}[{i}]' for i in indexes]
            signals.append((code, names))
            id_bits.setdefault(code, [dict(value='x', last=0, high=0, unknown=0, transitions=0)
                                      for _ in range(width)])
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
        if code not in id_bits:
            continue
        bits = id_bits[code]
        value = value.lower()
        value = value.rjust(len(bits), value[0] if value[0] in 'xz' else '0')
        for bit, new in zip(bits, value):
            elapsed = now - bit['last']
            bit['high'] += elapsed if bit['value'] == '1' else 0
            bit['unknown'] += elapsed if bit['value'] in 'xz' else 0
            if new in '01' and bit['value'] in '01' and new != bit['value']:
                bit['transitions'] += 1
            bit['value'], bit['last'] = new, now
    assert now == MEASUREMENT_FS
    rows = {}
    for code, names in signals:
        for name, bit in zip(names, id_bits[code]):
            elapsed = now - bit['last']
            high = bit['high'] + (elapsed if bit['value'] == '1' else 0)
            unknown = bit['unknown'] + (elapsed if bit['value'] in 'xz' else 0)
            rows[name] = dict(signal=name, transitions=bit['transitions'],
                              transitions_per_cycle=bit['transitions']/4096,
                              density_per_ns=bit['transitions']/(now*1e-6),
                              duty=high/now, unknown_fraction=unknown/now)
    connected_pins = []
    routed = (IMPLEMENTATION / 'results/counter_routed.v').read_text()
    for _, inst, body in re.findall(r'(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);', routed, re.S):
        connected_pins.extend(f'tb_power/dut/{inst}/{pin}' for pin in re.findall(r'\.(\w+)\s*\(', body))
    cell_pins = [rows[name] for name in connected_pins]
    assert len(cell_pins) == 84, f'Expected 84 cell signal pins, got {len(cell_pins)}'
    assert all(r['unknown_fraction'] == 0 for r in cell_pins), 'Unknown measured cell pin value'
    for clock in ['clk_1', 'clk_2']:
        row = rows[f'tb_power/dut/{clock}']
        assert row['transitions'] == 8192 and abs(row['duty'] - .49) < 1e-12
    for bit in range(4):
        row = rows[f'tb_power/dut/count[{bit}]']
        expected = {'active': 4096 >> bit, 'mixed': 2048 >> bit, 'hold': 0}[path.stem]
        assert row['transitions'] == expected, (path.stem, bit, row)
    with output.open('w') as f:
        writer = csv.DictWriter(f, fieldnames=list(next(iter(rows.values()))), delimiter='\t')
        writer.writeheader()
        writer.writerows(rows[n] for n in sorted(rows))
    return {'cell_signal_pins': len(cell_pins), 'unknown_cell_pins': 0,
            'clock_transitions_each': 8192, 'clock_high_fraction': .49,
            'count_transitions': [rows[f'tb_power/dut/count[{i}]']['transitions'] for i in range(4)]}


def main():
    global HERE, PERIOD_NS, MEASUREMENT_FS, SDC_SOURCE
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--sdc', type=Path, default=ROOT / 'counter.sdc')
    parser.add_argument('--output-dir', type=Path, default=SCRIPT_DIR)
    args = parser.parse_args()
    HERE = args.output_dir.resolve()
    SDC_SOURCE = args.sdc.resolve()
    sdc = SDC_SOURCE.read_text()
    clock_matches = dict((name, tuple(map(Decimal, (period, rise, fall))))
                         for name, period, rise, fall in re.findall(
                             r'create_clock -name (\w+) -period ([\d.]+) -waveform \{([\d.]+) ([\d.]+)\}', sdc))
    period = clock_matches['phi1'][0]
    assert period > 0
    assert clock_matches == {'phi1': (period, period*Decimal('.005'), period*Decimal('.495')),
                             'phi2': (period, period*Decimal('.505'), period*Decimal('.995'))}, \
        'Expected two phases with 49% high time and symmetric 1% dead time'
    PERIOD_NS = float(period)
    window_fs = period * 4096 * 1_000_000
    assert window_fs == int(window_fs), 'Measurement window must be representable in fs'
    assert period * 5000 == int(period * 5000), 'Clock edges must be representable in fs'
    MEASUREMENT_FS = int(window_fs)
    HERE.mkdir(parents=True, exist_ok=True)
    physical_before = [digest(p) for p in sorted((IMPLEMENTATION / 'results').iterdir()) if p.is_file()]
    for directory in ['inputs', 'activity', 'logs', 'reports']:
        (HERE / directory).mkdir(exist_ok=True)
    for tool in ['iverilog', 'vvp', 'openroad', 'yosys']:
        assert shutil.which(tool), f'Missing {tool}'
    source = ROOT / 'counter_sky130.v'
    assert source.read_bytes() == (IMPLEMENTATION / 'inputs/counter_sky130_2.v').read_bytes(), \
        'Current source differs from routed input snapshot; reroute before estimating power'
    (HERE / 'inputs/counter_sky130.v').write_bytes(source.read_bytes())
    (HERE / 'inputs/counter.sdc').write_bytes(SDC_SOURCE.read_bytes())
    sdc = (HERE / 'inputs/counter.sdc').read_text()
    expected_clocks = {name: tuple(map(float, values)) for name, values in clock_matches.items()}
    for name, expected in expected_clocks.items():
        match = re.search(r'create_clock\s+-name\s+' + name +
                          r'\s+-period\s+([\d.]+)\s+-waveform\s+\{([\d.]+)\s+([\d.]+)\}', sdc)
        assert match and tuple(map(float, match.groups())) == expected, \
            'SDC clocks changed: update tb_power.sv and report assumptions together'
    assert re.search(r'set_load\s+0\.010\s+\[get_ports\s+\{count\*\}\]', sdc), \
        'Output load changed: update report assumptions'
    lib_text = LIBERTY.read_text()
    assert re.search(r'nom_voltage\s*:\s*1\.8000', lib_text)
    assert re.search(r'nom_temperature\s*:\s*25\.0000', lib_text)
    reference = HERE / 'inputs/counter_reference.v'
    reference.write_text(source.read_text().replace('module counter(', 'module counter_reference(', 1))

    # Re-prove the current source against the existing, sized and buffered netlist.
    equivalence = (IMPLEMENTATION / 'scripts/check_equivalence.ys').read_text()
    equivalence = equivalence.replace('../../../sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib', str(LIBERTY))
    equivalence = equivalence.replace('openroad_sky130_2/inputs/counter_sky130_2.v', str(source))
    equivalence = equivalence.replace('openroad_sky130_2/results/counter_routed.v',
                                      str(IMPLEMENTATION / 'results/counter_routed.v'))
    eq_script = HERE / 'inputs/check_equivalence.ys'
    eq_script.write_text(equivalence)
    eq_log = run(['yosys', '-Q', '-T', '-s', eq_script], HERE / 'logs/equivalence.log')
    assert 'Equivalence successfully proven!' in eq_log

    results = {}
    with tempfile.TemporaryDirectory(prefix='counter-power-') as temp:
        compiled = Path(temp) / 'counter.vvp'
        run(['iverilog', '-g2012', '-DFUNCTIONAL', '-DUNIT_DELAY=', '-s', 'tb_power',
             f'-Ptb_power.PERIOD_NS={PERIOD_NS}',
             '-o', compiled, MODELS / 'sky130_hd_primitives.v', MODELS / 'sky130_hd.v',
             reference, IMPLEMENTATION / 'results/counter_routed.v', SCRIPT_DIR / 'tb_power.sv'],
            HERE / 'logs/compile.log')
        for scenario, number in SCENARIOS.items():
            raw = Path(temp) / (scenario + '_raw.vcd')
            window = HERE / 'activity' / (scenario + '_window.json')
            log = run(['vvp', compiled, f'+SCENARIO={number}', f'+VCD={raw}', f'+WINDOW={window}'],
                      HERE / 'logs' / (scenario + '_simulation.log'))
            assert 'PASS:' in log
            vcd = HERE / 'activity' / (scenario + '.vcd')
            normalize_vcd(raw, vcd)
            validation = vcd_statistics(vcd, HERE / 'activity' / (scenario + '_signals.tsv'))
            window_data = json.loads(window.read_text())
            assert window_data['period_ns'] == PERIOD_NS and window_data['cycles'] == 4096
            assert math.isclose(window_data['end_ns']-window_data['begin_ns'], MEASUREMENT_FS/1e6, abs_tol=1e-9)
            env = dict(os.environ, COUNTER_POWER_SCENARIO=scenario, COUNTER_POWER_DIR=str(HERE))
            log = run(['openroad', '-no_init', '-exit', SCRIPT_DIR / 'run_power.tcl'],
                      HERE / 'logs' / (scenario + '_openroad.log'), env)
            assert f'POWER_COMPLETE: {scenario}' in log and '[ERROR' not in log and 'POWER_FAILED' not in log
            reports = HERE / 'reports' / scenario
            annotation = (reports / 'activity_annotation.rpt').read_text()
            assert re.search(r'^vcd\s+94$', annotation, re.M)
            assert re.search(r'^unannotated\s+0$', annotation, re.M)
            parasitics = (reports / 'parasitic_annotation.rpt').read_text()
            assert 'Found 2 unannotated drivers.\n VDD\n VSS\n' in parasitics
            assert 'Found 0 partially unannotated drivers.' in parasitics
            power = json.loads((reports / 'power.json').read_text())
            for group in power.values():
                assert all(math.isfinite(v) and v >= 0 for v in group.values())
                assert math.isclose(sum(group[k] for k in COMPONENTS[:3]), group['total'], rel_tol=1e-6)
            with (reports / 'instances.tsv').open() as f:
                instances = list(csv.DictReader(f, delimiter='\t'))
            assert len(instances) == 26
            for key in COMPONENTS:
                assert math.isclose(sum(float(r[key + '_W']) for r in instances),
                                    power['Total'][key], rel_tol=1e-6)
            grouped = defaultdict(lambda: {key: 0.0 for key in COMPONENTS})
            for row in instances:
                name = row['instance']
                group = ('clock_tree' if name.startswith('clkbuf_') else
                         'phase1_latches' if name.startswith('state_phi1_') else
                         'phase2_latches' if name.startswith('state_phi2_') else
                         'reset_buffer' if name.startswith('reset_release_buf') else 'logic')
                for key in COMPONENTS:
                    grouped[group][key] += float(row[key + '_W'])
            top = sorted(instances, key=lambda r: float(r['total_W']), reverse=True)[:10]
            with (reports / 'top10.tsv').open('w') as f:
                writer = csv.DictWriter(f, fieldnames=list(top[0]), delimiter='\t')
                writer.writeheader()
                writer.writerows(top)
            total = power['Total']
            results[scenario] = dict(power_W=power, groups_W=dict(grouped),
                                     dynamic_W=total['internal']+total['switching'],
                                     energy_per_cycle_pJ=total['total']*PERIOD_NS*1e3,
                                     validation=validation, window=json.loads(window.read_text()))
            print(f"{scenario}: {total['total'] * 1e6:.6f} uW; 94/94 activities annotated")

    summary = {'generated_utc': datetime.now(timezone.utc).isoformat(),
               'openroad': subprocess.check_output(['openroad', '-version'], text=True).strip(),
               'corner': 'SKY130 HD TT / 25 C / 1.8 V; extracted nominal RC',
               'clock_period_ns': PERIOD_NS, 'clock_frequency_MHz': 1000/PERIOD_NS,
               'clock_high_fraction': .49, 'output_load_pF_each': .010,
               'measured_cycles': 4096, 'measurement_duration_ns': MEASUREMENT_FS/1e6,
               'routed_cells': 26, 'latches': 10, 'clock_buffers': 6,
               'functional_equivalence_passed': True, 'scenarios': results}
    (HERE / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    write_report(summary)
    with (HERE / 'summary.csv').open('w') as f:
        writer = csv.writer(f)
        writer.writerow(['scenario', 'internal_uW', 'switching_uW', 'leakage_nW',
                         'dynamic_uW', 'total_uW', 'energy_pJ_per_cycle'])
        for name, result in results.items():
            p = result['power_W']['Total']
            writer.writerow([name, p['internal']*1e6, p['switching']*1e6, p['leakage']*1e9,
                             result['dynamic_W']*1e6, p['total']*1e6, result['energy_per_cycle_pJ']])
    inputs = [source, SDC_SOURCE, LIBERTY,
              IMPLEMENTATION / 'results/counter_routed.v', IMPLEMENTATION / 'results/counter.spef',
              MODELS / 'sky130_hd.v', MODELS / 'sky130_hd_primitives.v',
              PLATFORM / 'lef/sky130_fd_sc_hd.tlef', PLATFORM / 'lef/sky130_fd_sc_hd_merged.lef']
    outputs = [HERE / 'summary.json', HERE / 'summary.csv', HERE / 'README.md']
    for scenario in SCENARIOS:
        outputs.extend([HERE / 'activity' / (scenario + '.vcd'),
                        HERE / 'reports' / scenario / 'power.json'])
    assert physical_before == [digest(p) for p in sorted((IMPLEMENTATION / 'results').iterdir()) if p.is_file()]
    manifest = dict(generated_utc=summary['generated_utc'], inputs=[digest(p) for p in inputs],
                    physical_artifacts_unchanged=True, physical_artifacts=physical_before,
                    scripts=[digest(SCRIPT_DIR / n) for n in ['run.py', 'run_power.tcl', 'tb_power.sv']],
                    outputs=[digest(p) for p in outputs])
    (HERE / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
