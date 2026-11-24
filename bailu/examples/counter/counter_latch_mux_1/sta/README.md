# counter_sky130_2.v 布线前 STA

使用 OpenSTA 3.1.0（d1e43c6f9f）读取原始 `../counter_sky130_2.v` 和 `../counter.sdc`，顶层为 `counter`。在以下分析条件下未发现负 slack 或 `VIOLATED` 检查项，max/min TNS 均为 0 ns。网表和 SDC 未修改。

## 分析条件

| 项目 | 设置 |
| --- | --- |
| 标准单元 | 19 个，其中 10 个为高电平有效、异步清零的 dlrtp 锁存器 |
| Liberty | `../../../sky130_pdk/sky130_fd_sc_hd__tt_025C_1v80.lib`，相对电路目录 |
| 工艺角 | TT，25°C，1.8 V |
| 时间、电容单位 | ns、pF |
| phi1 | 周期 1.80 ns，高电平窗口 0.009–0.891 ns |
| phi2 | 周期 1.80 ns，高电平窗口 0.909–1.791 ns |
| 两相占空比、交接死区 | 各 49%，每次交接死区 0.018 ns |
| 时钟模型 | 理想时钟，transition 0.06 ns，uncertainty 0.05 ns |
| en 输入预算 | 相对 phi1 下降沿，min 0.20 ns、max 1.00 ns |
| 输出预算 | 相对 phi1 下降沿，min −0.05 ns、max 1.00 ns |
| 输出负载 | count 每位 0.010 pF |
| rst_n 释放预算 | 上升沿相对 phi2 下降沿，min 0.20 ns、max 0.50 ns |

保留 SDC 的两相相互时序分析，未添加 false path、异步时钟组或 multicycle path。SDC 首行注释仍提及旧网表，但本次脚本实际读取的是 `counter_sky130_2.v`。

未加载 SPEF/SDF，未选择 wire-load model。尽管该 Liberty 包含 wire-load 表，本次所有网络报告中的 wire capacitance 均为零，路径报告中互连延迟为零。负载包含 Liberty 引脚电容及 SDC 输出负载。这是单 TT 角、未计布线 RC 和时钟树延迟/偏斜的基线。

## 结果

| 检查 | 最差 slack（ns） | 路径或说明 |
| --- | ---: | --- |
| 全局 setup/max | 0.000000 | en → phi1 bit0/bit1/toggle2/toggle3，合法时间借用，MET |
| 全局 min | +0.085856 | rst_n → phi2 RESET_B 的 removal |
| 锁存器数据 hold | +0.258639 | phi1 bit0/bit1 → phi2 bit0/bit1，直连路径 |
| phi1 → phi2 setup | +0.126773 | state_phi1_toggle2/Q → _18_/B → _18_/X → state_phi2_bit2/D |
| phi1 → phi2 hold | +0.258639 | state_phi1_bit0/Q → state_phi2_bit0/D，bit1 相同 |
| phi2 → phi1 setup | +0.025519 | state_phi2_bit0/Q → _17_ XOR → _11_ MUX → state_phi1_bit1/D |
| phi2 → phi1 hold | +0.314810 | state_phi2_bit3/Q → state_phi1_bit3/D |
| en 数据 hold | +0.296810 | en → bit3_enable → state_phi1_toggle3/D |
| 输出 setup | +0.277837 | state_phi2_bit0/Q → count[0] |
| 输出 hold | +0.238095 | state_phi2_bit3/Q → count[3] |
| 复位 recovery | +0.399781 | rst_n → phi1 RESET_B |
| 复位 removal | +0.085856 | rst_n → phi2 RESET_B |
| 时钟高电平最小脉宽 | +0.633656 | 实际 0.882000 ns，要求 0.248344 ns |
| 最大转换时间 | +1.281364 | 最差实际 slew 为 0.218636 ns，接收端限制 1.500000 ns |

最大电容检查也通过：最小裕量为 +0.074950 pF，对应 `_17_/X`，实际 0.001964 pF，限制 0.076914 pF。`min_period.rpt` 与 `max_fanout.rpt` 为空，表示本次没有可报告的对应限制。

`check_setup -verbose` 通过，没有未约束端点、缺失时钟或组合环告警。逐端点 max/min 各包含 24 个端点：10 个 D 端、10 个 RESET_B 端、4 个输出，共 48 条记录。数据 hold 与包含复位 removal 的全局 min 数值应分别理解。

## 时间借用与裕量解读

OpenSTA 对透明窗口内发生时间借用的锁存器路径可以报告 0 ns slack，并标记 `MET`。本次 en → phi1 bit0/bit1 的实际借用量为 0.435122 ns，最大可借用量为 0.847884 ns；对应数据到达 2.194122 ns，扣除不确定度后的开启参考时间为 1.759000 ns。借用的影响继续参与后续路径分析。

当前 OpenSTA 的 `-slack_max 0` 和 `-violators` 也会列出 slack 恰为零、状态为 `MET` 的项。因此 `setup_violations.rpt` 或 `violations.rpt` 非空本身不表示发生违例；本次校验未发现负端点裕量或 `VIOLATED`。

phi2 → phi1 的最差 setup 路径裕量为 25.519 ps，本次该路径没有使用端点时间借用。该值及全局 0 ns slack 不应用于直接推算最大工作频率。SDC 只定义了复位上升沿释放预算，未定义复位低电平脉冲持续时间。本次结果不代表多角或布线后签核。

## 报告与复现

- [可复现脚本](run_sta.tcl)、[完整日志](opensta.log)、[有效约束](effective.sdc)。
- [原始汇总](reports/summary.rpt)、[全部检查](reports/checks.rpt)、[约束完整性检查](reports/check_setup.rpt)。
- [逐端点 slack](reports/endpoint_slacks.tsv)、[结构化结果](summary.json)、[输入 SHA-256 及校验记录](manifest.json)。
- [phi1 → phi2 setup](reports/phi1_to_phi2_setup.rpt)、[phi2 → phi1 setup](reports/phi2_to_phi1_setup.rpt)、[数据 hold](reports/data_hold.rpt)。
- [recovery 详细路径](reports/rst_n_setup.rpt)、[removal 详细路径](reports/rst_n_hold.rpt)、[脉宽](reports/pulse_width.rpt)、[网络负载](reports/net_loads.rpt)。

在电路目录执行：

```bash
sta -no_init -exit sta_sky130_2/run_sta.tcl > sta_sky130_2/opensta.log 2>&1
```

可用 `COUNTER_STA_LIBERTY=/绝对路径/library.lib` 指定其他库。脚本重跑更新原始报告；改变输入后需同步更新本文、`summary.json` 与 `manifest.json`。原有 `sta/`、`sta_sky130_1/` 与布线后报告未改动。
