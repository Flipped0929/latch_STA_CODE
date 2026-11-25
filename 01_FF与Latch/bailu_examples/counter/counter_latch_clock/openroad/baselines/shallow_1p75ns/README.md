# counter：浅时钟树布局布线与后布线 STA

当前默认方案将第二相时钟树改为单级 `sky130_fd_sc_hd__clkbuf_2`，四路输出 setup 全部通过，最差 slack **+0.027660 ns**、max TNS **0**。第一相保留两级 TritonCTS。原有 en 输入 hold 和复位 removal 仍有违例，尚未完整时序收敛。

## 时钟树变化与效果

```text
原第二相：clk_2 → and2_1 → clkbuf_2 → clkbuf_2 → 输出锁存器
现第二相：clk_2 → and2_1 → clkbuf_2             → 四个输出锁存器
第一相：  clk_1 → clkbuf_2 → 两支 clkbuf_2     → 七个锁存器
```

第二相只有四个负载，单个缓冲器即可在本次布线下满足库的电气限制。它放在四个输出锁存器的几何中心附近，再做详细布局、实际布线和 OpenRCX 提取。没有将时钟改为 ideal，也没有修改周期、I/O delay、uncertainty 或屏蔽任何时序路径。

| 指标 | 原两级 CTS | 单级 clkbuf_4 | 单级 clkbuf_2（当前） |
| --- | ---: | ---: | ---: |
| 第二相缓冲级数 | 2 | 1 | 1 |
| 第二相最大上升沿插入延时 | 350.562 ps | 260.592 ps | 250.706 ps |
| 第二相上升沿 skew 包络 | 12.709 ps | 0.189 ps | 0.188 ps |
| 第二相最大上升沿 slew | 54.474 ps | 51.318 ps | 72.082 ps |
| 最差输出 setup slack | −65.364 ps | +24.927 ps | +27.660 ps |
| Max TNS | −176.903 ps | 0 | 0 |
| 最差 min slack（含 removal） | −248.033 ps | −179.876 ps | −165.028 ps |

对 count[0] 的实际路径，AND 延时从约 114 ps 变为 **121.621 ps**，原两级缓冲约 118 + 118 ps 变为单级 **128.439 ps**。包括线延时后，到锁存器 GATE 的插入延时约 250.56 ps。单级缓冲的负载更大，因此不能把删除一级直接理解为完整减去原来一级的延时。输出 setup 最差改善 **93.024 ps**。

各输出最差 setup slack：count[0] **+27.660 ps**、count[1] **+32.494 ps**、count[2] **+40.176 ps**、count[3] **+58.574 ps**。这些比较包含 CTS、重新布局和布线变化的共同影响。

详细比较见 [cts_comparison.md](reports/cts_comparison.md) 和 [cts_comparison.csv](reports/cts_comparison.csv)。[clock_endpoints.csv](reports/clock_endpoints.csv) 覆盖全部 11 个锁存器的上升、下降边沿延时、slew 与实际缓冲级数；[clock_metrics.json](reports/clock_metrics.json) 汇总所属时钟的端点包络。

## 保持的输入与输出驱动尺寸

- 输入仍为上级 `counter_sky130.v`、`counter.sdc`，均未修改。
- SKY130 HD，TT / 25°C / 1.80 V；OpenROAD `26Q2-1164-g08f67ee5ec`，2 个线程。
- 周期 1.75 ns，两相高电平各 49%，端口名义非重叠 17.5 ps；uncertainty 50 ps。
- 输出锁存器保留与 `counter_latch_mux_1` 同步的尺寸：bit0/1 为 `dlrtp_4`，bit2/3 为 `dlrtp_2`。上级源网表和原理图继续保留原始 `_1` 尺寸，布局前通过 `replace_cell` 应用 [output_latch_sizes.tsv](inputs/output_latch_sizes.tsv)。
- 所有其他原始单元型号和信号连接保持不变。逐实例结构检查、DEF/电源网表/STA 网表尺寸核对见 [validation.rpt](reports/validation.rpt)。这不是形式等价验证。

原两级方案的物理结果、输入、脚本和报告完整保存在 [baselines/two_level](baselines/two_level/README.md)，单级 clkbuf_4、clkbuf_2 的试验分别在 `experiments/phi2_single4`、`experiments/phi2_single2`。更早的驱动尺寸同步前结果仍在 [before_output_latch_sync.tar.gz](before_output_latch_sync.tar.gz)。

## 当前物理结果与寄生回标

Die 60 × 60 µm，core 48.76 × 48.96 µm。18 个原始逻辑单元、4 个有效时钟缓冲器、1 个 clkinv_2 假负载、30 个 tap、284 个 filler，共 **337** 个物理实例。OpenROAD 报告面积约 **299 µm²**，利用率约 **13%**，含 tap、不含 filler。

详细布线约 **476 µm**、**160** 个过孔；路由 DRC **0**、天线违规 **0**，VDD/VSS 连通检查通过。

OpenRCX 使用 ORFS sky130hd 默认 `rcx_patterns.rules`、模型索引 0，`max_res=50 Ω`、耦合阈值 0.1 fF；提取 **26 nets、113 rsegs、113 caps、133 ccs**。SPEF 使用 ns、pF、Ω，`PIN_CAP NONE`，引脚电容由 Liberty 提供。全部 **26/26** 个路由信号/时钟网络在 SPEF 中覆盖，无部分回标驱动端；唯一未回标端是没有连接网络的假负载输出 `clkload0/Y`。

STA 在全新的 OpenROAD/OpenSTA 进程中读取 [counter_routed.v](results/counter_routed.v)、原始 SDC 和 [counter.spef](results/counter.spef)，使用 propagated clocks。STA 网表省略物理 filler、tap 和孤立电源端口；完整电源视图在 [counter_power.v](results/counter_power.v)。

## 尚存的时序问题

| 检查 | 最差 slack（ns） |
| --- | ---: |
| Max / 输出 setup | +0.027660 |
| Min（含复位 removal） | −0.165028 |
| Min TNS | −0.699869 |
| en → enable_phi1/D hold | −0.070319 |
| 复位 recovery | +0.618053 |
| 门控 setup / hold | +0.254757 / +0.499661 |
| 锁存器间数据 hold | +0.270531 |
| 最小脉宽 | +0.585529 |

仍有四个第二相锁存器的 RESET_B removal 违例，最差 `rst_n → state_phi2_bit2/RESET_B` 为 −0.165028 ns；另有 en 输入 hold 违例。未通过放宽外部复位/使能预算来消除它们。当前 max-slew、max-capacitance、max-fanout 的违规报告为空；`check_setup -verbose` 的约束完整性检查也无警告。

两相端点名义非重叠间隔为 **19.812 ps**（phi1 关断到 phi2 打开）与 **6.084 ps**（phi2 关断到下一次 phi1 打开）。相比原来的第二个边界重叠约 92 ps 已改善，但这里不含 50 ps uncertainty、OCV 或 PVT 变化，不能据此宣称稳健非重叠。

原 SDC 允许 OpenSTA 将 phi1 经 enable 支路追踪到部分 phi2 时钟引脚；[clocks.rpt](reports/clocks.rpt) 保留原始结果。新增端点分析仅选取 phase1 的 phi1 与 phase2 的 phi2 路径，避免把 enable 支路的传播条目解释为第一相树内部 skew；没有新增 clock-sense 或 false-path 约束。

## 文件与复现

- [counter_routed.odb](results/counter_routed.odb)、[counter_routed.def](results/counter_routed.def)：当前完整物理数据库与详细布线。
- [counter_routed.v](results/counter_routed.v)、[counter.spef](results/counter.spef)：当前 STA 信号网表与寄生 RC。
- [timing_summary.rpt](reports/timing_summary.rpt)、[violations.rpt](reports/violations.rpt)、[setup.rpt](reports/setup.rpt)、[hold.rpt](reports/hold.rpt)：完整时序结果。
- [pnr.log](logs/pnr.log)、[sta.log](logs/sta.log)：本次工具日志。
- [summary.json](reports/summary.json)：输入、工艺、尺寸配置和时钟树脚本的 SHA-256，以及物理/时序摘要。

默认重跑当前单级第二相方案：

```bash
bash openroad/run.sh
```

在独立目录复现原两级方案：

```bash
COUNTER_CTS_MODE=two_level OPENROAD_RUN_DIR="$PWD/openroad/experiments/reproduced_two_level" bash openroad/run.sh
```

`COUNTER_CTS_MODE` 支持 `two_level`、`phi2_single2`、`phi2_single4`；`OPENROAD_RUN_DIR` 可指定独立输出目录。平台和程序路径仍可用 `SKY130_PLATFORM`、`OPENROAD_EXE` 覆盖。比较报告可用 `python3 openroad/scripts/compare_cts.py` 重建。

这是 TT 单角的实现与 STA，未进行多角/OCV/SI、完整 foundry DRC 或 LVS 签核。详细布线日志有不带 CUTCLASS 的 LEF58_ENCLOSURE 规则被跳过的提示，DRC=0 表示本次工具已实现规则范围内无违规。命令参考：[OpenROAD CTS 文档](https://openroad.readthedocs.io/en/latest/main/src/cts/README.html)。
