# counter：SKY130 后布线 STA 与最高频率估算

当前布线后电路已绘制为 [xschem 原理图](../counter_routed.sch)，见 [SVG 预览](../counter_routed.svg)和[原理图连接核对说明](schematic/README.md)。

已补充 [当前 1.73 ns 后布线功耗报告](power/README.md)，包含连续计数、50% 使能和保持三种场景、测量 VCD、完整活动覆盖检查、逐单元明细及复现脚本。

当前主 `counter.sdc` 已设为 **1.73 ns（578.035 MHz）**，两相高电平仍各占 49%。在已有单级第二相时钟树、固定布线和 SPEF 下重跑 STA 后，四路输出 setup 均通过，最差 slack **+0.007860 ns**、max TNS **0**。

周期扫描估算的 **setup 限定最高频率约 580.7 MHz**，边界周期约 1.72206 ns。当前仍有 en 输入 hold 和复位 removal 违例，尚不能将这个 setup 上限称为完整时序签核通过的最高工作频率。详细推导、逐点报告和复现方法见 [频率分析报告](frequency_sweep/README.md)。

## 当前分析与固定物理实现

- SKY130 HD，TT / 25°C / 1.80 V；OpenROAD `26Q2-1164-g08f67ee5ec`，2 个线程。
- 本次只调整时钟周期并重新 STA，没有重新布局布线或提取寄生。routed.v、ODB、DEF、SPEF 与 1.75 ns 时的单级树物理实现保持逐字节一致。
- 物理流程使用的源网表仍为 `counter_sky130.v`。主 SDC 由 1.75 ns 改为 1.73 ns；I/O delay、50 ps uncertainty、输入 slew、10 fF 输出负载、门控与复位预算均未改变。
- 1.75 ns 单级树的完整结果、SDC 和脚本保存在 [baselines/shallow_1p75ns](baselines/shallow_1p75ns/README.md)。两级树结果在 [baselines/two_level](baselines/two_level/README.md)。

当前约束：

```tcl
create_clock -name phi1 -period 1.73 -waveform {0.00865 0.85635} [get_ports clk_1]
create_clock -name phi2 -period 1.73 -waveform {0.87365 1.72135} [get_ports clk_2]
```

每相高电平为 0.8477 ns，两个端口的非重叠间隔各为 0.0173 ns。主 STA 从原始精度的 `counter.sdc` 读取约束，使用 propagated clocks 与 SPEF；[reports/effective.sdc](reports/effective.sdc) 是当前精度为 9 位小数的有效约束导出。`results/counter_propagated.sdc` 保留物理实现时的 1.75 ns 约束，不是本次 STA 的输入。

## 频率边界与当前裕量

关键输出路径从 phi2 的 0.505T 上升沿启动，参考下一周期 phi1 的 1.495T 下降沿检查，可用时差为 0.99T。根据 1.75 ns 时的 +27.660 ps slack，局部估计：

```text
T_min ≈ 1.75 − 0.027660 / 0.99 = 1.7220606 ns
F_max_setup ≈ 1000 / T_min = 580.7 MHz
```

实际扫描确认 1.7221 ns 的最差 setup 为 +0.039 ps，1.7220 ns 为 −0.060 ps；该数值边界几乎没有余量。主约束选用 1.73 ns，保留 +7.860 ps setup 裕量；这仍只是在当前 TT 模型和接口预算下的结果。

| 1.73 ns 下检查 | 最差 slack（ns） |
| --- | ---: |
| count[0] / count[1] setup | +0.007860 / +0.012694 |
| count[2] / count[3] setup | +0.020376 / +0.038774 |
| 锁存器间数据 hold | +0.270331 |
| en → enable_phi1/D hold | −0.070319 |
| rst_n removal | −0.165028 |
| Recovery | +0.608052 |
| 门控 setup / hold | +0.244757 / +0.499461 |
| 最小脉宽 | +0.575729 |

Max TNS 为 0，Min TNS 为 −0.699870 ns。`check_setup -verbose` 无约束完整性警告；slew、capacitance、fanout 违规报告为空。四个第二相 RESET_B 的 removal 和 en 输入 hold 均仍有违例；即使 2.0 ns / 500 MHz 重分析，这些同边沿违例也仍存在，不能依靠加长周期修复。

## 时钟树、输出尺寸与物理检查

```text
第二相：clk_2 → and2_1 → 单个 clkbuf_2 → 四个输出锁存器
第一相：clk_1 → clkbuf_2 → 两支 clkbuf_2 → 七个锁存器
```

第二相最大上升沿插入延时约 250.706 ps；上升沿 skew 包络约 0.188 ps，最大 slew 约 72.082 ps。原两级树与两个单级候选在 **1.75 ns** 下的历史比较见 [cts_comparison.md](reports/cts_comparison.md)。

输出锁存器继续与 `counter_latch_mux_1` 保持相同驱动尺寸：bit0/1 为 `dlrtp_4`，bit2/3 为 `dlrtp_2`。[output_latch_sizes.tsv](inputs/output_latch_sizes.tsv) 在布局前通过 replace_cell 设置尺寸；上级源网表和原理图继续保留原始 `_1` 尺寸。其他原始单元型号和信号连接保持不变。

Die 60 × 60 µm、core 48.76 × 48.96 µm。18 个原始逻辑单元、4 个时钟缓冲器、1 个 clkinv_2 假负载、30 个 tap、284 个 filler，共 337 个实例。OpenROAD 报告面积约 299 µm²、利用率约 13%（含 tap、不含 filler）。布线约 476 µm、160 个过孔；该物理实现的路由 DRC=0、天线违规=0，VDD/VSS 连通检查通过。

OpenRCX 使用 ORFS sky130hd 默认 RCX 规则、模型索引 0，max_res=50 Ω、耦合阈值 0.1 fF，提取 26 nets、113 rsegs、113 caps、133 ccs。全部 26/26 信号/时钟网络在 SPEF 中覆盖，无部分回标驱动端；唯一未回标端为悬空假负载输出 clkload0/Y。SPEF 的 PIN_CAP NONE，由 Liberty 提供引脚电容。

## 适用范围与文件

两相锁存器端在 1.73 ns 下的名义非重叠间隔为 19.612 ps、5.884 ps，未计入 uncertainty/OCV/PVT 包络，不能据此宣称稳健非重叠。原 SDC 还允许 phi1 经 enable 支路追踪到部分第二相时钟引脚；新增端点时钟表仅选取各锁存器所属时钟的路径，没有通过新增 clock-sense 或 false-path 改变原分析语义。

本次为 TT 单角分析，未执行完整多 PVT/RC 角、OCV、SI、foundry DRC 或 LVS 签核。布线器对部分不带 CUTCLASS 的 LEF58_ENCLOSURE 规则有跳过提示，DRC=0 限于该工具已实现的规则范围。

- [counter.sdc](../counter.sdc)：当前 1.73 ns 主约束。
- [频率扫描报告](frequency_sweep/README.md)、[扫描数据](frequency_sweep/sweep.csv)：上限估算、逐点检查与输入快照。
- [timing_summary.rpt](reports/timing_summary.rpt)、[violations.rpt](reports/violations.rpt)、[setup.rpt](reports/setup.rpt)、[hold.rpt](reports/hold.rpt)：当前 1.73 ns 的报告。
- [clock_endpoints.csv](reports/clock_endpoints.csv)、[clock_metrics.json](reports/clock_metrics.json)：全部 11 个锁存器的时钟边沿与缓冲深度。
- [counter_routed.odb](results/counter_routed.odb)、[counter_routed.def](results/counter_routed.def)、[counter_routed.v](results/counter_routed.v)、[counter.spef](results/counter.spef)：固定物理结果与寄生。
- [validation.rpt](reports/validation.rpt)、[summary.json](reports/summary.json)：结构、尺寸与回标检查，以及输入 SHA-256。

只重跑 STA 或频率扫描的命令见频率分析报告。`bash openroad/run.sh` 则会按当前 1.73 ns 约束重跑完整布局布线、提取和 STA，所得新物理实现需要重新估算频率。`COUNTER_CTS_MODE` 仍支持 two_level、phi2_single2、phi2_single4，默认 phi2_single2；程序与平台路径可通过 OPENROAD_EXE、SKY130_PLATFORM 覆盖。
