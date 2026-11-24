# 1.75 ns 后布线 STA

源 `counter.sdc` 已改为 `-period 1.75 -waveform {0.00 0.875}`，保持 50% 占空比。其余输入/输出预算、uncertainty 和负载保持不变。使用原有最终布线网表及 OpenRCX SPEF，以 **SKY130 HD / TT / 25°C / 1.80 V** 和传播时钟重新分析。

**时序未通过：仅输出 `count[0]` 存在 setup 违例，缺少 0.015009 ns（约 15.009 ps）余量。**

| 检查 | 最差 slack（ns） | 结果 |
| --- | ---: | --- |
| 全局 setup/max | −0.015009 | 1 个端点违例 |
| 全局 hold/min | +0.055961 | 通过 |
| 触发器数据输入 setup | +0.312305 | 通过 |
| 触发器数据输入 hold | +0.055961 | 通过 |
| 输出 hold | +0.566126 | 通过 |
| 复位 recovery | +0.796372 | 通过 |
| 复位 removal | +0.448234 | 通过 |

Setup TNS 为 **−0.015009 ns**，hold TNS 为 **0 ns**。最小脉宽、最大转换时间和最大电容检查未报告违例。

| 输出端点 | Setup slack（ns） |
| --- | ---: |
| `count[0]` | −0.015009 |
| `count[1]` | +0.007476 |
| `count[2]` | +0.019578 |
| `count[3]` | +0.026436 |

最差路径为 `count_o_reg[0]/Q → count[0]`。输出要求时间为 `1.75 − 1.00 − 0.05 = 0.700000 ns`，数据到达时间为 **0.715009 ns**。相对 1.7 ns 分析，setup 余量增加 0.05 ns，违例端点由 4 个减少到 1 个。

OpenROAD 与独立 OpenSTA 的汇总、setup、hold、recovery、removal 路径报告逐文件一致。约束覆盖检查通过；全部信号和时钟驱动端获得 SPEF 注释，供电端 VDD/VSS 除外。物理网表和 SPEF 与原实现保持逐字节一致；本次未重新布局布线。

结果文件：

- [STA 汇总](reports/postroute/summary.rpt)
- [违例汇总](reports/postroute/violations.rpt)
- [Setup 违例完整路径](reports/postroute/setup_violations.rpt)
- [全部 Setup 路径](reports/postroute/setup.rpt)
- [全部 Hold 路径](reports/postroute/hold.rpt)
- [生效约束](reports/postroute/effective.sdc)
- [机器可读汇总](reports/summary.json)
- 独立 OpenSTA 复核：`reports/standalone_sta/`
- 输入约束快照：`inputs/counter.sdc`
- 网表、SPEF、SDF：`results/`
- 工具版本、输入及产物哈希：`manifest.json`

在设计根目录复现：

```sh
python3 openroad/run_postroute_1p75ns.py
```

`manifest.json` 中 `status: complete` 表示分析完成，`timing_passed: false` 表示存在时序违例。原 2 ns 实现和 1.7 ns 报告均保留。
