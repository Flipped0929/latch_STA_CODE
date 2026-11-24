# counter：SKY130 布局布线、寄生提取与后布线 STA

已完成 OpenROAD 实际运行。详细布线完成，OpenRCX 导出 SPEF，随后由一个全新的 OpenROAD/OpenSTA 进程读取布线后网表、原始 SDC 和 SPEF 做 STA。**当前 1.75 ns 约束下仍有时序违例，尚未时序收敛。**

本次已按 `counter_latch_mux_1/openroad/results/counter_routed.v` 同步第二相输出锁存器驱动尺寸，并重新运行布局布线、寄生提取及 STA。尺寸在布局前通过 `replace_cell` 设置，配置保存于 [output_latch_sizes.tsv](inputs/output_latch_sizes.tsv)。上级源网表和原理图继续保留原始 `_1` 尺寸；物理实现使用下表指定的尺寸。

| 实例 | 输入网表 | 当前物理实现（与参考一致） |
| --- | --- | --- |
| state_phi2_bit0 | dlrtp_1 | dlrtp_4 |
| state_phi2_bit1 | dlrtp_1 | dlrtp_4 |
| state_phi2_bit2 | dlrtp_1 | dlrtp_2 |
| state_phi2_bit3 | dlrtp_1 | dlrtp_2 |

其他原始单元型号、信号连接和 SDC 保持不变。同步前的完整物理结果、脚本和报告已保存在 [before_output_latch_sync.tar.gz](before_output_latch_sync.tar.gz)。参考网表快照见 [mux_reference_counter_routed.v](inputs/mux_reference_counter_routed.v)，逐实例核对结果见 [output_latch_sizes.rpt](reports/output_latch_sizes.rpt)。

## 工具与输入

- OpenROAD：`26Q2-1164-g08f67ee5ec`，2 个线程。
- 输入：上级目录的 `counter_sky130.v` 和 `counter.sdc`，原文件未修改。
- 标准单元：ORFS `sky130hd`，`sky130_fd_sc_hd__tt_025C_1v80.lib`，TT / 25°C / 1.80 V。
- 物理库：`sky130_fd_sc_hd.tlef`、`sky130_fd_sc_hd_merged.lef`。
- 提取模型：ORFS `sky130hd/rcx_patterns.rules`，模型索引 0；平台默认符号链接指向 `sky130hs/rcx_patterns.rules`。
- 输入及工艺文件的 SHA-256 和本机路径记录在 [summary.json](reports/summary.json)。

## 物理实现

直接实现已映射网表，不重新综合 `counter.v`。流程为 floorplan → tapcell → PDN → IO placement → global/detailed placement → CTS → global/detailed routing → filler → OpenRCX。

| 项目 | 结果 |
| --- | ---: |
| Die | 60 × 60 µm |
| Core | 48.76 × 48.96 µm |
| 原始逻辑单元 | 18（包含 11 个锁存器） |
| CTS | 6 个 clkbuf_2，另有 clkbuf_1、clkinv_2 假负载各 1 个 |
| Tap / filler | 30 / 287 |
| 物理实例总数 | 343 |
| OpenROAD 报告面积 | 约 313 µm²，利用率约 13%（含 tap，不含 filler） |
| 信号和时钟网络 | 28 |
| 详细布线线长 / 过孔数 | 约 522 µm / 165 |
| 路由 DRC / 天线违规 | 0 / 0 |
| VDD、VSS 连通检查 | 通过 |

CTS 分别构建 `clk_1` 和 `clk_2_gated` 的树，实际驱动 7 个第一相和 4 个第二相锁存器。`clk_2` 到门控 AND 输入只有一个负载，CTS 未在该段插入树。

## 寄生提取与回标

OpenRCX 使用详细布线后的几何信息提取，`max_res=50 Ω`，`coupling_threshold=0.1 fF`；小于阈值的耦合电容按工具规则接地。日志报告 28 nets、124 rsegs、124 caps、147 ccs。

[counter.spef](results/counter.spef) 的单位为 ns、pF、Ω，`PIN_CAP NONE`，引脚电容由 Liberty 提供。脚本逐一比较 DEF 与 SPEF 网络名，28/28 个信号及时钟网络均覆盖。没有部分回标的驱动端；未回标驱动端仅为 CTS 假负载的悬空输出 `clkload0/Y`、`clkload1/X`，两者均没有连接网络。

用于 STA 的 [counter_routed.v](results/counter_routed.v) 省略 filler、tap 和孤立电源端口，保留所有信号单元与 CTS 负载。[counter_power.v](results/counter_power.v) 保存完整电源连接视图。[validation.rpt](reports/validation.rpt) 验证了：将 CTS 缓冲器视作直通后，原始 18 个单元的全部引脚连接和 4 个输出别名保持一致；型号仅有上述 4 个输出锁存器的预期尺寸调整。DEF、电源网表、STA 网表中的这 4 个型号均与参考快照一致。这是结构连接检查，不是形式等价验证或带延迟仿真。

## 后布线 STA

读取原始 `counter.sdc` 后执行 `set_propagated_clock [all_clocks]`，再读取 SPEF。保留周期、两相波形、50 ps uncertainty、I/O delay、10 fF 输出负载、复位 recovery/removal 和门控时钟检查；未增加 false path、multicycle 或 reset 屏蔽。

| 检查 | 最差 slack（ns） | 结论 |
| --- | ---: | --- |
| Max（setup/recovery 等） | -0.065364 | 违例，最差为 count[0] 输出 setup |
| Min（hold/removal 等） | -0.248033 | 违例，最差为复位 removal |
| Max TNS | -0.176903 | 4 个输出端点违例 |
| Min TNS | -1.060578 | 4 个复位端点和 1 个 en 端点违例 |
| en → enable_phi1/D hold | -0.072079 | 违例 |
| Recovery | +0.619949 | 通过 |
| Clock gating setup / hold | +0.238170 / +0.510843 | 通过 |
| 最小脉宽 | +0.584449 | 通过 |
| 最大 slew / capacitance / fanout 违规 | 0 | 在所读 Liberty/SDC 规则下 |

具体违例见 [violations.rpt](reports/violations.rpt)，展开的时钟、单元与寄生延迟见 [setup.rpt](reports/setup.rpt)、[hold.rpt](reports/hold.rpt)。

- 最差 setup：`state_phi2_bit0 → count[0]`，到达时间 1.631614 ns，要求时间 1.566250 ns，slack −0.065364 ns。其余输出最差 slack 分别为 −0.060669、−0.033401、−0.017470 ns。最差 setup 相比同步前改善 0.052835 ns；该比较包含重新布局布线和 CTS 变化的影响。
- 最差 removal：`rst_n → state_phi2_bit2/RESET_B`，复位到达 1.942522 ns，要求不早于 2.190555 ns，slack −0.248033 ns。第二相其余 3 个复位端点同样违例。
- `en → enable_phi1/D` 的 hold 要求时间 1.138394 ns，最早到达 1.066314 ns，slack −0.072079 ns。
- 锁存器 STA 保留 time borrowing 分析，当前展开报告中实际借用量均为 0 ns；不能按普通触发器路径直接估算 Fmax。
- 信号视图的 [check_setup.rpt](reports/check_setup.rpt) 为空：没有缺少时钟、I/O delay、未约束端点或组合环的检查警告。

## 结果的适用范围

这是 TT 单角的 OpenROAD 实现与 STA 结果，未执行多 PVT/多 RC 角、SI、完整 foundry DRC、LVS 或 GDS 签核。详细布线器日志提示部分不带 CUTCLASS 的 `LEF58_ENCLOSURE` 规则被跳过，因此路由 DRC=0 只表示本次工具支持并执行的规则没有违规。

输入端 17.5 ps 的两相非重叠间隔不会自动保证锁存器端也非重叠。报告中的第一相直接树上升延时约 0.255 ns，第二相下降延时约 0.354–0.365 ns；据此，第二相关断与下一次第一相打开可能出现约 0.09 ns 的重叠。后续若要求严格非重叠，需要一起处理跨相树延时、门控路径和接口 hold/removal，而不能仅放宽周期。

原 SDC 还允许 OpenSTA 将 phi1 经 enable 锁存器和 AND 的使能支路追踪到部分第二相时钟引脚；[clocks.rpt](reports/clocks.rpt) 保留工具原始结果。这些跨使能支路的 phi1 延时不应解释为第一相树内部的 skew。后续可单独复核 `gate_phi2/B` 的 clock-sense 建模；本次没有追加该约束来改变输入 SDC 的分析语义。

## 文件与复现

- [counter_routed.odb](results/counter_routed.odb)：最终完整物理数据库。
- [counter_routed.def](results/counter_routed.def)：详细布线后的布局与连线。
- [counter_power.v](results/counter_power.v)、[counter_routed.v](results/counter_routed.v)：物理电源视图与 STA 信号视图。
- [counter.spef](results/counter.spef)：提取的寄生 RC。
- [counter_propagated.sdc](results/counter_propagated.sdc)：OpenROAD 导出的传播时钟约束。
- [timing_summary.rpt](reports/timing_summary.rpt)、[special_checks.rpt](reports/special_checks.rpt)：总时序指标与异步、门控、脉宽检查。
- [pnr.log](logs/pnr.log)、[sta.log](logs/sta.log)：完整工具日志。

从本例目录重新运行：

```bash
bash openroad/run.sh
```

可以通过环境变量 `SKY130_PLATFORM` 和 `OPENROAD_EXE` 更换平台目录与可执行程序；默认使用本机已有安装。脚本在 `openroad/` 中覆盖本次流程输出。仅重跑 STA：

```bash
cd openroad
export SKY130_PLATFORM=/home/bailufrost/eda/OpenROAD-flow-scripts-live/flow/platforms/sky130hd
/home/bailufrost/.local/bin/openroad -no_init -exit -log logs/sta.log scripts/sta.tcl
python3 scripts/summarize.py
```
