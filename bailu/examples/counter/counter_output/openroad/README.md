# counter 布局布线与后布线 STA

使用 OpenROAD `26Q2-1164-g08f67ee5ec`、ORFS SKY130 HD 平台和 **TT / 25 °C / 1.80 V** 标准单元库。输入为上级目录的 [counter_sky130.v](../counter_sky130.v) 和 [counter.sdc](../counter.sdc)。

原 SDC 的门控检查引用了旧实例名。运行时将 `gate_phi2/B` 映射到网表中的 `gate_phi2_11/B`，实际加载的文件为 [applied.sdc](reports/applied.sdc)。时钟周期、波形、50 ps 时钟不确定度、I/O 延时和负载均沿用原始约束。原 SDC 注释中的 1.72206 ns 估计对应另一版物理实现。

## 物理实现与寄生

- Die 为 60 × 60 µm，core 为 48.76 × 48.96 µm。原网表的 19 个逻辑单元均保留原驱动尺寸。第一相 CTS 插入 3 个时钟缓冲器及 1 个平衡负载，第二相门控输出通过 1 个时钟缓冲器驱动 4 个锁存器。另插入了 30 个 tap 和 290 个 filler。
- 详细布线约 481 µm、153 个过孔。全部 27 条信号和时钟网已布通，OpenROAD 路由 DRC 和天线违规均为 0，VDD/VSS 连通检查通过。路由器跳过了部分无 CUTCLASS 的 LEF58_ENCLOSURE 规则。检查范围为 OpenROAD 路由规则。 [布局布线日志](logs/pnr.log)
- OpenRCX 从详细布线几何提取 27 条网络、121 个电阻段、128 个耦合电容项。使用 ORFS sky130hd 默认 RCX 规则（当前安装链接到 sky130hs 同名规则）、模型索引 0、最大电阻合并值 50 Ω、耦合阈值 0.1 fF。逐网核对 DEF 与 SPEF，27 条网络完全匹配。STA 无部分回标驱动端，唯一未回标端 `clkload0/X` 为 CTS 平衡负载的悬空输出。 [SPEF 回标报告](reports/parasitic_annotation.rpt)

## 后布线 STA

在独立 OpenROAD 进程中读入布线后网表、实际 SDC 和 SPEF，使用传播时钟。**1.73 ns 下存在时序违例。**

| 检查 | WNS（ns） | TNS（ns） | 违例端点 |
| --- | ---: | ---: | --- |
| Max / setup | −0.118631 | −0.295085 | 4 个 `count[*]` 输出 |
| Min / hold、removal | −0.189561 | −0.820303 | 4 个第二相锁存器复位端、1 个使能锁存器数据端 |

- 最差输出 setup 位于 `count[0]`，余量 −0.118631 ns。其他三个输出的 setup 余量分别为 −0.094615、−0.063568 和 −0.018272 ns。 [Setup 路径](reports/setup.rpt)
- `rst_n` 到 `count_o_reg[2]/RESET_B` 的 removal 余量为 −0.189561 ns，`en` 到 `dup_enable_2/D` 的 hold 余量为 −0.063293 ns。 [Hold 路径](reports/hold.rpt) · [违例清单](reports/violations.rpt)
- Recovery、门控 setup/hold 和最小脉宽的最差余量分别为 +0.600979、+0.259558 / +0.485857 和 +0.578609 ns。报告未发现最大 slew、电容或扇出违例。 [专项检查](reports/special_checks.rpt)
- 从脉宽报告中各锁存器所属时钟的边沿可见，`count_o_reg[3]` 的第二相下降沿约在 1.998283 ns，`_14_` 的下一周期第一相上升沿约在 1.983429 ns，这对锁存器的名义高电平窗口重叠约 14.9 ps。`report_clock_latency` 的 phi1 汇总还纳入经门控使能支路到达第二相锁存器的路径。 [专项检查](reports/special_checks.rpt) · [时钟报告](reports/clocks.rpt)

## 交付与复现

| 文件 | 用途 |
| --- | --- |
| [counter_routed.odb](results/counter_routed.odb) · [counter_routed.def](results/counter_routed.def) | 布线版图 |
| [counter.spef](results/counter.spef) | 后布线寄生 |
| [counter_routed.v](results/counter_routed.v) · [counter_power.v](results/counter_power.v) | STA 网表及带电源连接的物理网表 |
| [timing_summary.rpt](reports/timing_summary.rpt) · [violations.rpt](reports/violations.rpt) | STA 摘要及违例端点 |
| [run.sh](run.sh) | 重跑布局布线、提取及 STA |

在项目目录执行 `bash openroad/run.sh`。可通过 `OPENROAD_EXE` 指定 OpenROAD 可执行文件，通过 `SKY130_PLATFORM` 指定 ORFS sky130hd 平台目录。输出位于 `openroad/results`、`openroad/reports` 和 `openroad/logs`。
