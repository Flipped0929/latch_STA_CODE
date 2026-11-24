"""Render the measured power summary as a standalone Markdown report."""
from pathlib import Path
import csv
import json

here = Path(__file__).resolve().parent
summary = json.loads((here / 'summary.json').read_text())
scenarios = summary['scenarios']
labels = {'active': '连续计数（en=1）', 'mixed': '50% 使能（16 周期开 / 16 周期停）',
          'hold': '保持零值（en=0）'}
groups = {'phase1_latches': '第一相数据/进位锁存器（6 个）',
          'phase2_latches': '第二相输出锁存器（4 个）', 'enable_latch': '使能锁存器（1 个）',
          'clock_phi1': '第一相 CTS 缓冲器（3 个）', 'clock_phi2': '第二相单级缓冲器（1 个）',
          'clock_gate': '门控 AND（1 个）', 'clock_dummy': 'CTS 反相假负载（1 个）',
          'logic': '其余组合逻辑（6 个）'}
active = scenarios['active']['power_W']['Total']['total']
hold = scenarios['hold']['power_W']['Total']['total']
period = summary['clock_period_ns']
lines = [
    '# 门控两相锁存器计数器：后布线功耗报告', '',
    f"当前 **{period:.2f} ns / {summary['clock_frequency_MHz']:.3f} MHz**、SKY130 HD **TT / 25°C / 1.80 V** 下，连续计数平均功耗约 **{active*1e6:.3f} µW（{active*1e3:.6f} mW）**。",
    '基于已布线网表、提取 SPEF、实际功能仿真活动和 Liberty 功耗表计算；未改变现有电路、布线或时序约束。', '',
    '## 场景汇总', '',
    '| 场景 | 内部功耗 µW | 网络切换功耗 µW | 漏电功耗 nW | 总功耗 µW | 每周期能量 pJ |',
    '| --- | ---: | ---: | ---: | ---: | ---: |',
]
for name, result in scenarios.items():
    power = result['power_W']['Total']
    lines.append(f"| {labels[name]} | {power['internal']*1e6:.3f} | {power['switching']*1e6:.3f} | "
                 f"{power['leakage']*1e9:.6f} | {power['total']*1e6:.3f} | {result['energy_per_cycle_pJ']:.6f} |")
lines += ['',
    '动态功耗 = 内部功耗 + 网络切换功耗。内部功耗来自单元内部充放电及短路电流的 Liberty 表；网络切换功耗包含提取寄生与输出负载的充放电。每周期能量 = 平均功耗 × 时钟周期，不是某个瞬时峰值。',
    '**原始 OpenROAD power.rpt / power.json 均使用 W。上表漏电列为 nW，其余功耗列为 µW。** 不能按 report_units 中 Liberty 的 1 nW 单位直接解读 report_power 的数值。', '',
    f"保持零值时平均功耗比连续计数低 **{100*(1-hold/active):.2f}%**。此时第二相门控时钟、其单级缓冲器和四个输出锁存器均不再翻转；第一相树、六个第一相数据锁存器与使能锁存器仍被时钟驱动，所以保持功耗不是漏电功耗。", '',
    '## 单元分组', '',
    '| 单元组 | 连续计数总功耗 µW | 50% 使能总功耗 µW | 保持总功耗 µW |',
    '| --- | ---: | ---: | ---: |',
]
for group, label in groups.items():
    powers = [scenarios[name]['groups_W'][group]['total']*1e6 for name in scenarios]
    lines.append('| ' + label + ' | ' + ' | '.join(f'{value:.6f}' for value in powers) + ' |')
lines += ['',
    '此分组按实际电路作用统计，覆盖全部 23 个信号单元；OpenROAD 内置 Clock 分组还包含门控 AND 和 CTS 假负载，不能直接等同于“四个 CTS 缓冲器”。保持场景下，第二相缓冲器和四个输出锁存器的内部及网络切换功耗均为 0，仅剩库中漏电值。第一相 CTS 缓冲器约 108.743 µW，六个第一相数据锁存器约 93.456 µW，是保持功耗的主要来源。', '',
    '各场景逐单元 internal/switching/leakage/total 明细见 reports/<场景>/instances.tsv，最高功耗的十个单元见 top10.tsv；完整分组组件数据在 summary.json 和 groups.csv。', '',
    '## 测量条件', '',
    f"- 工具：OpenROAD **{summary['openroad']}** 内置 OpenSTA 功耗分析器，2 个线程；活动由 Icarus Verilog 的 SKY130 功能模型产生。",
    '- 使用当前输出尺寸：bit0/1 为 dlrtp_4，bit2/3 为 dlrtp_2；第二相为单级 clkbuf_2，第一相为两级 CTS。23 个建模单元中包含 11 个锁存器、4 个有效时钟缓冲器、1 个 CTS 假负载和 7 个逻辑门。',
    '- 两个外部时钟始终运行，各为 49% 高电平。phi1 高电平 0.00865–0.85635 ns，phi2 为 0.87365–1.72135 ns；报告保留当前输入 slew、每位 0.010 pF 输出负载等约束，并使用传播时钟和 SPEF。',
    '- 测量期间 rst_n 恒为 1；复位释放、复位瞬态和预热不计入平均功耗。en 不设 case analysis，保持完整门控逻辑，由实测 VCD 给出活动。',
    f"- 每个场景测量 **{summary['measured_cycles']} 周期 / {summary['measurement_duration_ns']:.2f} ns**。开始前复位 2 周期、完整计数 16 周期回到零；保持场景再运行 2 个停用周期使第一相流水状态稳定。",
    '- 连续/混合场景在门控已经开启的稳态下开始测量。混合场景在每 32 周期中计数 16 周期、保持 16 周期；保持场景固定 count=0。该使能模式是本次假设，不代表未知的实际工作负载。', '',
    '## 活动与结果核查', '',
    '- 三个场景均逐周期对比源网表、后布线网表与预期计数值，各通过 4096 次检查。测量期全部 73 个单元信号引脚均无 X/Z；加上 8 个顶层信号引脚，VCD 注释覆盖 **81/81，未注释引脚 0**。',
    '- 外部 clk_1、clk_2 在每个场景均翻转 8192 次；第二相门控输出在连续计数、混合、保持场景分别翻转 **8192、4096、0** 次。工具实际用于功耗的门控信号活动也逐项核对，不仅检查“成功载入 VCD”。',
    '- count[0..3] 的翻转次数：连续计数为 4096 / 2048 / 1024 / 512，混合为 2048 / 1024 / 512 / 256，保持均为 0。',
    '- 测量 VCD 的时间戳从测量窗口起点重定位为 0，以免预热时间稀释翻转率；*_window.json 保存真实仿真起止时间。packed vector 被展开为标量位后导入，避免本机读取器对别名输出总线统计错误。',
    '- 工具对纯时钟节点使用 SDC 派生的活动，与 VCD 的频率和占空比一致。一个已记录的例外是未连接反相假负载 clkload0/Y：工具查询返回源时钟的 49%，而 VCD 为 51%；该端无网络/外载、翻转率一致，单元漏电条件及内部功耗表仅关联输入 A，输入活动已核对。',
    '- 全部实际信号/时钟网络均由 SPEF 回标，无部分回标驱动端。唯一无寄生注释的是无连接输出 clkload0/Y。',
    '- 脚本核对 23 个实例功耗之和与设计总功耗一致，并检查各功耗项无 NaN、无负值，以及动态组件与总和相符。工具活动查询的数值比较考虑了其六位有效数字密度和三位小数 duty 的显示精度。', '',
    '## 文件与复现', '',
    '- [汇总 CSV](summary.csv)、[汇总及分组 JSON](summary.json)、[组件分组 CSV](groups.csv)、[SHA-256 清单](manifest.json)。',
    '- 原始功耗报告：[连续计数](reports/active/power.rpt)、[50% 使能](reports/mixed/power.rpt)、[保持](reports/hold/power.rpt)。',
    '- reports/<场景>/activity_annotation.rpt：活动覆盖；activities.tsv：工具采用的活动；parasitic_annotation.rpt：寄生覆盖；effective.sdc：当前场景有效约束。',
    '- activity/*.vcd：规范化测量波形；*_signals.tsv：独立解析的活动；logs/：编译、仿真和功耗分析日志；inputs/：网表、SDC、SPEF、时钟参数的快照。', '',
    '在电路目录运行：', '', '```bash', 'python3 openroad/power/run.py', '```', '',
    '可用 SKY130_PLATFORM、COUNTER_POWER_LIBERTY、SKY130_POWER_MODELS、OPENROAD_EXE 覆盖本机路径。脚本从当前 SDC 自动生成时钟参数，不会沿用上一个 1.75 ns 周期。仅重建本文和分组表可运行 python3 openroad/power/report.py。', '',
    '## 适用范围', '',
    '这是零延时功能 VCD + Liberty 表 + SPEF 电容/时序的平均功耗估算。没有做 SDF 延时回标、真实延时毛刺、模拟短脉冲、竞争或晶体管瞬态仿真，也没有给出峰值电流、IR drop 或多角功耗签核。',
    '当前 1.73 ns STA 的 en hold 与复位 removal 仍有违例，两相最小名义非重叠间隔约 5.884 ps；这些物理时序风险未通过本次功能仿真消除，详见 [当前 STA](../README.md)。',
    '结果包含单元驱动 10 fF 输出负载所需的充放电功耗，不含片外时钟源、外部接收电路、电源网络损耗、封装功耗及 filler/tap 的额外漏电模型。漏电值仅适用于所用 TT / 25°C 库；保持不同数据值或换用其他 PVT 角可能改变结果。',
    '原 ../reports/power.rpt 为未载入 VCD 的默认活动报告，不能代替本报告的场景功耗。', '',
]
(here / 'README.md').write_text('\n'.join(lines))
with (here / 'groups.csv').open('w') as stream:
    writer = csv.writer(stream)
    writer.writerow(['scenario', 'group', 'internal_uW', 'switching_uW', 'leakage_nW', 'total_uW'])
    for name, result in scenarios.items():
        for group in groups:
            power = result['groups_W'][group]
            writer.writerow([name, group, power['internal']*1e6, power['switching']*1e6,
                             power['leakage']*1e9, power['total']*1e6])
print('Power report and component table written.')
