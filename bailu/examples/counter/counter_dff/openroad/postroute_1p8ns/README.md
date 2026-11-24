# 1.8 ns 后布线 STA 与功耗报告

源 `counter.sdc` 的时钟周期为 **1.80 ns**，波形为 `{0.00 0.90}`，频率为 **555.556 MHz**。分析使用现有最终布线网表和 OpenRCX SPEF、传播时钟，以及 **SKY130 HD / TT / 25°C / 1.80 V** Liberty。输入输出延迟、0.05 ns uncertainty 和每位输出 0.010 pF 负载沿用现有约束。

## STA 结果

**时序通过。** OpenROAD 的后布线分析与独立 OpenSTA 复核一致。

| 检查 | 最差 slack（ns） |
| --- | ---: |
| 全局 setup/max | +0.034991 |
| 全局 hold/min | +0.055961 |
| 触发器数据输入 setup | +0.362305 |
| 触发器数据输入 hold | +0.055961 |
| 输出 setup | +0.034991 |
| 输出 hold | +0.566126 |
| 异步复位 recovery | +0.821372 |
| 异步复位 removal | +0.473234 |

Setup/hold TNS 均为 0，违例端点数均为 0。约束覆盖检查通过；最小脉宽、最大转换时间、最大电容检查未发现违例。额外 min-period/max-fanout 限值沿用 Liberty/SDC，不添加库中未定义的限值。所有有时序意义的驱动端获得 SPEF 注释，仅供电端 VDD/VSS 除外。

最差 setup 路径为 `count_o_reg[0]/Q → count[0]`：数据到达时间 **0.715009 ns**，要求时间 `1.80 − 1.00 − 0.05 = 0.750000 ns`，余量 **0.034991 ns**。

## 功耗结果与活动假设

功耗场景为 `en=1`、`rst_n=1`，时钟持续运行，计数器每周期递增。使用最终网表（包含 3 个 CTS 缓冲器）和 SkyWater 官方功能模型进行零延迟门级仿真；先复位并预热 16 周期，再记录 **256 周期 / 460.8 ns**，覆盖 16 次完整计数循环。全部 **272 次计数检查通过**。复位和预热阶段不在 VCD 记录窗口内。

OpenROAD 读取 VCD 后，**64 个端口及单元引脚获得注释，未注释为 0**。使用 Liberty 功耗模型、实际布线 SPEF、STA 计算的 slew 和现有输出负载执行 `report_power`，独立 OpenSTA 对各功耗分量复核一致。功耗场景的 `en/rst_n` 常量设置位于 STA 报告生成之后，不影响原有使能时序与异步复位 recovery/removal 检查。

| 分量 | 功耗（µW） |
| --- | ---: |
| 内部功耗 Internal | 207.5221 |
| 开关功耗 Switching | 90.1560 |
| 动态功耗（Internal + Switching） | 297.6782 |
| 漏电功耗 Leakage | 0.00009758 |
| **总功耗 Total** | **297.6783** |

时钟树功耗约 **108.8267 µW**，已经包含在总功耗中。原始 `power.rpt` 和 `power_instances.rpt` 的表头明确使用 **W（瓦）**；`units.rpt` 显示的 Liberty 功耗单位为 nW，不能据此将 `report_power` 的瓦数再次按 nW 换算。总量由工具浮点数累计，末位可能有微小舍入差异。

这是指定连续计数场景下的估算：使用零延迟活动，未进行 SDF 时序仿真，因此不完整反映实际延迟引起的毛刺功耗；也不代表停钟、使能间歇开启或复位场景的平均功耗。功能网表不包含 tap/endcap 和 filler，因此这些物理单元的漏电不在总功耗内。分析仅覆盖 TT 单角。

流程依据：[OpenROAD 官方文档中的 VCD 功耗分析示例](https://openroad.readthedocs.io/en/latest/main/src/sta/doc/Examples.html#power-analysis)。

## 文件与复现

| 文件 | 内容 |
| --- | --- |
| [reports/postroute/summary.rpt](reports/postroute/summary.rpt) | OpenROAD STA 汇总 |
| [reports/postroute/setup.rpt](reports/postroute/setup.rpt) / [hold.rpt](reports/postroute/hold.rpt) | 完整时钟路径 |
| [reports/postroute/violations.rpt](reports/postroute/violations.rpt) | 各类违例检查 |
| [reports/postroute/power.rpt](reports/postroute/power.rpt) | 功耗分组与总量，单位 W |
| [reports/postroute/power_instances.rpt](reports/postroute/power_instances.rpt) | 逐单元功耗，包含 CTS |
| [reports/postroute/power_activity.rpt](reports/postroute/power_activity.rpt) | VCD 注释覆盖 |
| [reports/summary.json](reports/summary.json) | 时序及功耗机器可读汇总 |
| `reports/standalone_sta/` | 独立 OpenSTA 复核 |
| `inputs/counter.sdc` / `inputs/counter_counting.vcd` | 实际输入约束与活动 |
| `scripts/counter_power_tb.v` / `logs/simulation.log` | 功耗测试平台与计数验证 |
| `scripts/power.tcl` / `logs/openroad.log` | 实际分析脚本与日志 |
| `manifest.json` | 工具版本、输入及产物 SHA-256 |

在设计根目录执行：

```sh
python3 openroad/run_postroute_1p8ns.py
```

依赖 OpenROAD、OpenSTA（`sta`）、Icarus Verilog（`iverilog`、`vvp`）、Python 3。`SKY130HD_PLATFORM` 可覆盖工艺平台目录，`SKY130_SIM_MODELS` 可覆盖包含 `sky130_hd.v` 和 `sky130_hd_primitives.v` 的仿真模型目录；默认模型来自本机 OpenROAD 源码的 `src/sta/examples/`，实际路径与哈希记录在 manifest 中。

使用 `/tmp` 工作目录运行后复制结果回项目。原有物理网表和 SPEF 逐字节复用，历史 2 ns、1.7 ns 和 1.75 ns 报告保留。本次未重新布局布线。
