# 最高时钟频率估算与周期扫描

在当前 SKY130 HD **TT / 25°C / 1.80 V**、固定布线网表和 SPEF、10 fF 输出负载、1 ns 最大输出延时预算和 50 ps clock uncertainty 下，**setup 限定的最高频率约为 580.7 MHz**，对应周期约 **1.72206 ns**。

这不是完整时序签核通过的工作频率。当前仍有 en 输入 hold 和四个第二相锁存器的复位 removal 违例；扫描到 2.0 ns / 500 MHz 时它们仍存在，单纯降低频率不能修复这些同边沿检查。

主约束 [counter.sdc](../../counter.sdc) 已调整为 **1.73 ns / 578.035 MHz**，并重新运行 SPEF 后布线 STA。该点最差 setup slack **+7.860 ps**，max TNS **0**。采用这一数值是为了避免直接取接近零裕量的边界点，并不代表已经满足所有工作条件。

## 估算依据

原 1.75 ns 下，最差路径为 `state_phi2_bit0 → count[0]`，slack +0.027660 ns。两相波形按周期 T 等比例变化：

- phi1：上升沿 0.005T、下降沿 0.495T；
- phi2：上升沿 0.505T、下降沿 0.995T；
- 两相高电平各 49%，两个端口非重叠间隔各 0.01T。

此输出路径从 phi2 的 0.505T 上升沿启动，在下一周期 phi1 的 1.495T 下降沿参考下检查。可用时间为 **0.99T**，不能简单按半周期或直接用 `T − slack` 计算。

根据原路径展开报告，单位均为 ns：

```text
clock insertion 到 bit0/GATE = 0.250560
latch GATE→Q               = 0.403678
Q→输出导线延时             = 0.000602
output_delay_max           = 1.000000
clock_uncertainty          = 0.050000

arrival(T)  = 0.505T + 0.250560 + 0.403678 + 0.000602
required(T) = 1.495T - 1.000000 - 0.050000
slack(T)    = 0.99T - 1.704840

T_min ≈ 1.704840 / 0.99 = 1.7220606 ns
F_max_setup ≈ 1000 / T_min = 580.6997 MHz
```

该公式仅在关键路径不变的局部范围适用。因此实际重新运行了 8 个周期点，检查关键路径切换、锁存器 time borrowing、recovery/removal、门控、脉宽、slew/capacitance、数据 hold 及约束完整性。边界附近限制路径均仍为 count[0] 输出路径；2 ns 点的最差 max 路径转为 en 输入路径。

## 实际 SPEF STA 扫描结果

| 周期 ns | 频率 MHz | 最差 max/setup slack ps | Max TNS ps | 最差 min/removal slack ps |
| --- | ---: | ---: | ---: | ---: |
| 2.0000 | 500.000 | +223.793 | 0 | −165.028 |
| 1.7500 | 571.429 | +27.660 | 0 | −165.028 |
| **1.7300** | **578.035** | **+7.860** | **0** | **−165.028** |
| 1.7250 | 579.710 | +2.910 | 0 | −165.028 |
| 1.7221 | 580.686 | +0.039 | 0 | −165.028 |
| 1.7220 | 580.720 | −0.060 | −0.060 | −165.028 |
| 1.7200 | 581.395 | −2.040 | −2.040 | −165.028 |
| 1.7000 | 588.235 | −21.840 | −48.170 | −165.028 |

边界被实际结果夹在 **1.7220–1.7221 ns**（约 580.686–580.720 MHz）。这个数值精度用于定位 STA 数值边界，不代表工艺与模型具有相同精度；1.7221 ns 的 0.039 ps 裕量不能作为实际设计余量。

原始逐点结果见 [sweep.csv](sweep.csv)、[summary.json](summary.json)。每个 `T_*ns` 子目录均保存该点 SDC、完整 STA 日志、setup/hold 展开报告、有效 SDC 及端点时钟指标，例如 [1.73 ns](T_1p7300ns/reports/timing_summary.rpt)、[边界通过点](T_1p7221ns/reports/setup.rpt)、[边界违例点](T_1p7220ns/reports/setup.rpt)。

## 主约束调整后的结果

```tcl
create_clock -name phi1 -period 1.73 -waveform {0.00865 0.85635} [get_ports clk_1]
create_clock -name phi2 -period 1.73 -waveform {0.87365 1.72135} [get_ports clk_2]
```

仅改变两条 create_clock 的周期和按比例缩放的边沿；每相高电平为 0.8477 ns，两个端口间隔各 0.0173 ns。其他 I/O 延时、输入 slew、输出负载、uncertainty、门控和复位假设均保持不变。

| 1.73 ns 下检查 | 结果 ns |
| --- | ---: |
| count[0] setup | +0.007860 |
| count[1] setup | +0.012694 |
| count[2] setup | +0.020376 |
| count[3] setup | +0.038774 |
| 锁存器间数据 hold | +0.270331 |
| en → enable_phi1/D hold | −0.070319 |
| rst_n → state_phi2_bit2/RESET_B removal | −0.165028 |
| Recovery | +0.608052 |
| 门控 setup / hold | +0.244757 / +0.499461 |
| 最小脉宽 | +0.575729 |

约束完整性、slew/capacitance/fanout 检查无违规；SPEF 无部分回标驱动端，唯一未回标端是悬空假负载 `clkload0/Y`。两相锁存器端的名义间隔为 19.612 ps、5.884 ps，未计入 uncertainty/OCV/PVT 包络，仍需验证稳健非重叠。

主 STA 报告已更新到 [../reports](../reports/timing_summary.rpt)，可直接使用 [有效 SDC](../reports/effective.sdc)。该 SDC 使用 9 位小数导出，避免边界点波形被默认输出精度舍入。`results/counter_propagated.sdc` 是物理流程原先按 1.75 ns 导出的历史文件；当前 STA 实际读的是主 `counter.sdc`。

## 实现范围、快照与复现

本轮**没有重新布局布线或提取寄生**。使用已有单级第二相树以及 bit0/1=dlrtp_4、bit2/3=dlrtp_2 的输出尺寸。已逐字节核对当前 routed.v、ODB、DEF、SPEF 与 [1.75 ns 基线](../baselines/shallow_1p75ns/README.md) 一致。该基线还保存当时的 SDC、脚本和全部报告。

扫描输入网表、SPEF、模板 SDC 快照保存在 [inputs](inputs/template.sdc)，SHA-256 记录于 summary.json。每个周期点启动独立 OpenROAD/OpenSTA 进程，从相同 SPEF 重新读入，避免约束累积。

重建完整扫描：

```bash
python3 openroad/scripts/frequency_sweep.py
```

仅重跑当前 1.73 ns STA，不改变物理结果：

```bash
SKY130_PLATFORM=/home/bailufrost/eda/OpenROAD-flow-scripts-live/flow/platforms/sky130hd \
  /home/bailufrost/.local/bin/openroad -no_init -exit -log openroad/logs/sta.log openroad/scripts/sta.tcl
SKY130_PLATFORM=/home/bailufrost/eda/OpenROAD-flow-scripts-live/flow/platforms/sky130hd \
  python3 openroad/scripts/summarize.py
```

这是当前接口预算和 TT 单角条件下的 setup 上限，不是电路脱离接口约束的固有速度。只有在 hold、removal 和时钟非重叠问题修复并完成多 PVT/RC 角验证后，才能给出完整可签核的工作频率。
