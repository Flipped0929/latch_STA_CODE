# counter_sky130_2：1.75 ns / 49% 后布线 STA

已将项目 `counter.sdc` 周期更新为 **1.75 ns**，两相高电平占比继续为 **49%**。使用 `counter_sky130_2.v` 对应的现有后布线网表与 OpenRCX SPEF 重跑传播时钟 STA。

**原 1.7 ns 下的 3 条输出 setup 违例全部消除。常规 STA 无负 slack，setup/max 与 hold/min TNS 均为 0。输出 setup 最差 +0.020060 ns，数据 hold 最差 +0.027322 ns。** 但严格非重叠仍未满足，phi1 → phi2 锁存器端的名义时钟包络重叠约 **5.691 ps**。

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
| 锁存器数据 Setup | +0.000000 | +0.000000 |
| 锁存器数据 Hold | +0.027322 | +0.027322 |
| 输出 Setup | -0.029440 | +0.020060 |
| 输出 Hold | +0.497189 | +0.497689 |
| phi1 → phi2 Setup | +0.248676 | +0.299176 |
| phi1 → phi2 Hold | +0.267429 | +0.267929 |
| phi2 → phi1 Setup | +0.004750 | +0.029750 |
| phi2 → phi1 Hold | +0.298878 | +0.299379 |
| 复位 Recovery | +0.240338 | +0.265338 |
| 复位 Removal | +0.215387 | +0.215387 |

全局 max 最差为 **0.000000 ns**，min 最差为 **+0.027322 ns**。全局 setup 的 0 ns 条目标记为 `MET`，对应锁存器透明窗口内的合法时间借用；最大报告借用量为 **0.207303 ns**，不能将其当作负裕量违例。

| 输出端 | 1.7 ns setup slack（ns） | 1.75 ns setup slack（ns） |
| --- | ---: | ---: |
| `count[0]` | -0.029440 | +0.020060 |
| `count[1]` | -0.020711 | +0.028789 |
| `count[2]` | -0.004575 | +0.044925 |
| `count[3]` | +0.010054 | +0.059554 |

输出最差仍为 `state_phi2_bit0/Q → count[0]`。新 phi2 上升沿为 0.883750 ns，数据到达时间为 **1.546190 ns**。参考 phi1 下一周期下降沿 **2.616250 ns**，扣除 0.05 ns 不确定度及 1.00 ns output delay，要求时间为 **1.566250 ns**，得到 slack **+0.020060 ns**。

高电平最小脉宽最差裕量为 **+0.639732 ns**，slew 和 capacitance 检查通过。`check_setup -verbose` 无告警，48 项 max/min 结果覆盖 10 个 D、10 个 RESET_B 和 4 个输出端。OpenROAD 与独立 OpenSTA 的逐端点结果完全一致，没有 `VIOLATED` 项。`-violators` 输出会列出 slack 恰为 0 的 `MET` 借用条目，不能按文件是否为空判定违例。

SPEF 注释完整性与原物理实现一致：全部信号和时钟网络已注释，未注释驱动端仅为 VDD/VSS 电源端口，没有部分注释驱动端。

## 两相非重叠

| 方向 | 端口死区 ns | 锁存器端最差名义间隔 ns |
| --- | ---: | ---: |
| phi1 关闭 → phi2 开启 | 0.017500 | -0.005691 |
| phi2 关闭 → 下一周期 phi1 开启 | 0.017500 | +0.002870 |

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
