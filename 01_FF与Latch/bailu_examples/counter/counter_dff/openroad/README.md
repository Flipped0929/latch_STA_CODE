# Counter：Sky130 布局布线、寄生提取和后布线 STA

**最新约束为 1.80 ns，下降沿为 0.90 ns（555.556 MHz）。** 使用现有布线和 SPEF 在 OpenROAD 中重新分析后，setup/hold 均通过，最差 slack 分别为 **+0.034991 ns / +0.055961 ns**。已补充基于门级仿真 VCD 的连续计数功耗报告，总功耗约 **297.678 µW**（TT / 25°C / 1.80 V，`en=1`、`rst_n=1`）。完整结果和功耗假设见 [1.8 ns STA 与功耗报告](postroute_1p8ns/README.md)，复现命令为 `python3 openroad/run_postroute_1p8ns.py`。

此前的 [1.75 ns 分析](postroute_1p75ns/README.md) 和 [1.7 ns 分析](postroute_1p7ns/README.md) 继续保留；其专用脚本要求源 SDC 与对应历史周期一致。

另已补充 [ngspice 后布线晶体管级仿真](../ngspice/README.md)：使用最终网表、SPEF 分布 RC 与官方 MOS 单元模型，在相同的 1.8 ns / TT 条件下检查计数、保持、溢出和异步复位，并提供模拟波形、实际延迟及 VDD 电源功耗。该方法的单元内部寄生覆盖范围见对应说明。

以下保留原 **2.00 ns** 实现和分析记录。其输入快照保存在 `inputs/`，当时的文件 SHA-256 与工艺路径记录在 `manifest.json`；这些历史快照不随当前源 SDC 更新。此处原有全流程与核验命令针对 2 ns 基线，当前约束重分析请使用上面的专用命令。

工具为 OpenROAD **26Q2-1164-g08f67ee5ec**，标准单元库为 **sky130_fd_sc_hd / TT / 25°C / 1.80 V**。时钟周期 **2.00 ns（500 MHz）**，setup/hold uncertainty 均为 0.05 ns。输入延迟、输出延迟、输入转换时间、输出负载和复位释放约束均取自原 SDC。

## 后布线时序结果

从详细布线 DEF 在新的 OpenROAD 进程中使用 OpenRCX 提取 SPEF，再在独立进程中读取最终网表、原 SDC 和 SPEF，设置传播时钟后分析。以下时间单位均为 ns。

| 检查 | 最差 slack | 结果 |
| --- | ---: | --- |
| 全局 setup/max | +0.234991 | 通过 |
| 全局 hold/min | +0.055961 | 通过 |
| 触发器数据输入 setup | +0.562305 | 通过 |
| 触发器数据输入 hold | +0.055961 | 通过 |
| 输出 setup | +0.234991 | 通过 |
| 输出 hold | +0.566126 | 通过 |
| 异步复位 recovery | +0.921372 | 通过 |
| 异步复位 removal | +0.573234 | 通过 |

Setup 和 hold TNS 均为 **0**。最差 setup 路径为 `count_o_reg[0]/Q → count[0]`，数据到达时间 0.715009 ns，要求时间 0.950000 ns。最差 hold 路径为 `en → _12_/S → _12_/X → count_o_reg[0]/D`，数据到达时间 0.325606 ns，要求时间 0.269645 ns。

`rst_n` 的释放时刻按 SDC 相对时钟下降沿的 0.20–0.50 ns 建模，全部四个触发器的 recovery/removal 均已检查。最小脉宽、最大转换时间和最大电容检查通过；Liberty/SDC 未定义的额外 min-period 和 max-fanout 限值不会凭空添加，相关报告可能为空。`check_setup.rpt` 为空，表示该工具的约束覆盖检查没有发现问题。

时钟上升沿插入延迟为 **0.248515–0.253952 ns**，极差为 **0.005437 ns**；下降沿为 0.267431–0.272316 ns。详细时钟路径与 uncertainty 均包含在报告中。独立的 OpenSTA 对 setup、hold、recovery、removal 路径报告及汇总逐文件复核，结果一致。

| 阶段 | 最差 max slack | 最差 min slack |
| --- | ---: | ---: |
| 原网表、理想时钟 | +0.514928 | +0.302481 |
| 布局后、估算 RC、理想时钟 | +0.475432 | +0.309498 |
| CTS 后、布局 RC、传播时钟 | +0.219773 | +0.049248 |
| 全局布线后、估算 RC、传播时钟 | +0.196192 | +0.041743 |
| 详细布线后、提取 SPEF、传播时钟 | **+0.234991** | **+0.055961** |

## 物理实现和提取核验

- Die 为 **60 × 60 µm**，核心约为 **39.56 × 38.08 µm**，共 14 行标准单元。
- 保留原有 4 个 `dfrtp_1`、4 个 `mux2_1`、2 个 `and2_1`、3 个 `xor2_1` 和 1 个 `inv_1`，新增 3 个 `clkbuf_4` 构成时钟树。时序修复检查没有要求改动原逻辑单元。
- 插入 44 个 tap/endcap 和 166 个 filler，完成 VDD/VSS 电源环、met1 电源轨及 met4/met5 电源网格。
- 信号允许 met1–met5，时钟允许 met3–met5；最终 **20/20** 条信号及时钟网完成布线，并全部出现在 SPEF 中。
- OpenROAD 详细路由器报告 **0 个 DRC**，天线检查 **0 个 net/pin 违例**；最终 ODB 重新打开后，布局合法性和 VDD/VSS 连通性检查通过。
- OpenRCX 使用平台 `rcx_patterns.rules`，提取模型索引为 0，耦合阈值为 0.1 fF；小于阈值的耦合电容接地。SPEF 单位为 Ω、pF；不含单元引脚电容，STA 从 Liberty 加载引脚电容。
- SPEF 注释覆盖全部有时序意义的驱动端。仅 VDD/VSS 被列为未注释驱动端，它们为供电网络，已在 STA 中设置 case analysis。
- Yosys 对输入网表和最终网表完成时序逻辑等价证明：**20 个等价点全部通过**。该证明使用单元布尔/时序逻辑模型；实际延迟由 STA 分析。

本次结果为 TT 单角实现和后布线分析。OpenROAD 路由器提示部分不带 CUTCLASS 的 `LEF58_ENCLOSURE` 规则不受支持；其零路由 DRC 不代表完整工艺签核。本次未运行 SS/FF 多角、foundry signoff DRC/LVS 或 GDS stream-out。

## 结果文件

| 文件 | 内容 |
| --- | --- |
| [results/counter_routed.odb](results/counter_routed.odb) | 最终布局布线数据库 |
| [results/counter_routed.def](results/counter_routed.def) | 最终布局和实际走线 DEF |
| [results/counter_routed.v](results/counter_routed.v) | 最终功能网表，保留 CTS、去除 tap/filler |
| `results/counter_routed_power.v` | 包含供电连接与物理单元的网表 |
| [results/counter.spef](results/counter.spef) | 从实际详细布线提取的寄生参数 |
| `results/counter_extracted.odb` | 含提取寄生数据的 ODB |
| `results/counter.sdf` | 后布线延迟注释 |
| `results/counter_propagated.sdc` | 实现后的传播时钟约束 |
| [reports/postroute/summary.rpt](reports/postroute/summary.rpt) | 后布线 STA 汇总 |
| [reports/postroute/setup.rpt](reports/postroute/setup.rpt) | max/setup 与 recovery 完整时钟路径 |
| [reports/postroute/hold.rpt](reports/postroute/hold.rpt) | min/hold 与 removal 完整时钟路径 |
| `reports/postroute/rst_n_setup.rpt` / `rst_n_hold.rpt` | 复位 recovery/removal 路径 |
| `reports/postroute/checks.rpt` / `violations.rpt` | 各类检查和违例 |
| `reports/postroute/effective.sdc` | 最终分析实际使用的约束 |
| `reports/standalone_sta/` | 独立 OpenSTA 复核报告 |
| [reports/verification.rpt](reports/verification.rpt) | 等价性、注释覆盖和 STA 核验 |
| [reports/summary.json](reports/summary.json) | 机器可读汇总 |
| `reports/audit.rpt`、`instances.tsv`、`nets.tsv` | 最终物理检查和单元/线网清单 |
| [results/layout_preview.svg](results/layout_preview.svg) | 根据实际 DEF 路由与 ODB 单元边界生成的预览 |
| `results/layout_preview.png` | 预览位图 |
| `logs/` | 各阶段日志，包括 Yosys 等价证明 |

## 复现和查看

从本设计目录执行：

```sh
python3 openroad/run_flow.py
```

需要本机已安装的 OpenROAD、OpenSTA（`sta`）、Yosys、Python 3，以及用于预览转换的系统 librsvg/cairo。流程在 `/tmp/counter_dff_openroad_*` 中运行，再将结果复制到 `openroad/`，避免 VMware HGFS 中间文件问题。重新运行会更新此结果目录。

默认平台为 `/home/bailufrost/eda/OpenROAD-flow-scripts/flow/platforms/sky130hd`；可用 `SKY130HD_PLATFORM` 环境变量覆盖。工艺文件不重复打包，准确路径及哈希见 `manifest.json`。

独立重新提取、分析或核验已保存结果：

```sh
openroad -no_init -exit openroad/scripts/extract.tcl
openroad -no_init -exit openroad/scripts/sta.tcl
STA_REPORT_SUBDIR=standalone_sta sta -no_init -exit openroad/scripts/sta.tcl
openroad -no_init -exit openroad/scripts/audit.tcl
python3 openroad/scripts/verify_results.py
python3 openroad/scripts/render_preview.py
```

用 OpenROAD GUI 打开最终版图：

```sh
openroad -gui -no_init openroad/scripts/view.tcl
```
