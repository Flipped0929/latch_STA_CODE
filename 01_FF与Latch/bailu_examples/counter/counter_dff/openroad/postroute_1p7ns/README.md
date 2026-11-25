# 1.7 ns 后布线 STA

当前源 `counter.sdc` 已调整为 `-period 1.70 -waveform {0.00 0.85}`，保持 50% 占空比。输入/输出延迟、uncertainty、转换时间、负载和相对下降沿的复位释放预算保持原值。

使用原 2 ns 实现的最终布线网表及 OpenRCX SPEF，未重新布局布线或优化单元。分析角为 **SKY130 HD / TT / 25°C / 1.80 V**，时钟为传播时钟。输入快照见 `inputs/counter.sdc`、`results/counter_routed.v` 和 `results/counter.spef`；工艺路径、工具版本与 SHA-256 见 `manifest.json`。

## 结果

**1.7 ns 时序未通过：4 个输出端点存在 setup 违例。**

| 检查 | 最差 slack（ns） | 结果 |
| --- | ---: | --- |
| 全局 setup/max | −0.065009 | 4 个端点违例 |
| 全局 hold/min | +0.055961 | 通过 |
| 触发器数据输入 setup | +0.262305 | 通过 |
| 触发器数据输入 hold | +0.055961 | 通过 |
| 输出 setup | −0.065009 | 未通过 |
| 输出 hold | +0.566126 | 通过 |
| 复位 recovery | +0.771372 | 通过 |
| 复位 removal | +0.423234 | 通过 |

Setup TNS 为 **−0.161519 ns**，hold TNS 为 **0 ns**。最小脉宽、最大转换时间和最大电容检查未报告违例。

| 输出端点 | Setup slack（ns） |
| --- | ---: |
| `count[0]` | −0.065009 |
| `count[1]` | −0.042524 |
| `count[2]` | −0.030422 |
| `count[3]` | −0.023564 |

最差路径为 `count_o_reg[0]/Q → count[0]`。按原输出延迟 1.00 ns、setup uncertainty 0.05 ns，输出要求时间为 `1.70 − 1.00 − 0.05 = 0.650000 ns`；数据到达时间为 **0.715009 ns**，因此 slack 为 **−0.065009 ns**。相对 2 ns 基线，输出 setup 余量减少 0.30 ns。复位释放跟随下降沿移到 0.85 ns，其 recovery/removal 仍通过。

OpenROAD 与独立 OpenSTA 的汇总、setup、hold、recovery 和 removal 路径报告逐文件一致。约束覆盖检查通过；SPEF 注释覆盖所有信号和时钟驱动端，仅 VDD/VSS 供电端列为未注释。

## 文件与复现

- [STA 汇总](reports/postroute/summary.rpt)
- [违例汇总](reports/postroute/violations.rpt)
- [Setup 违例完整路径](reports/postroute/setup_violations.rpt)
- [Hold 完整路径](reports/postroute/hold.rpt)
- [实际生效约束](reports/postroute/effective.sdc)
- [机器可读汇总](reports/summary.json)
- 独立 OpenSTA 复核报告：`reports/standalone_sta/`
- 延迟注释：`results/counter.sdf`
- 工具日志：`logs/openroad.log`、`logs/sta.log`

在设计根目录运行：

```sh
python3 openroad/run_postroute_1p7ns.py
```

脚本将当前 1.7 ns SDC 与现有布线网表、SPEF 快照到 `/tmp` 中执行，再保存到本目录。`manifest.json` 的 `status: complete` 表示分析成功执行，`timing_passed: false` 表示存在时序违例。原 2 ns 物理实现及分析文件继续保留在 `openroad/results/` 与 `openroad/reports/`。
