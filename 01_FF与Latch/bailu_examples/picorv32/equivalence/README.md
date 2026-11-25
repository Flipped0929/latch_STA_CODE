# PicoRV32 两阶段 EQY 等价验证

当前归档的 PicoRV32 默认配置已完成以下两阶段形式验证，两个运行日志均以 `Successfully proved designs equivalent` 和 `DONE (PASS, rc=0)` 结束。

| 阶段 | Gold | Gate | 归档结果 | 原运行耗时 |
|---|---|---|---|---|
| RTL → Yosys | `../picorv32.v` | `../picorv32_latch/picorv32_yosys.v` | [PASS 日志](evidence/rtl_yosys/logfile.txt) | 1396 s |
| Yosys → latch 采样模型 | Yosys 网表 | 从 `picorv32_latch.v` 提取的相位边界模型 | [PASS 日志](evidence/yosys_latch/logfile.txt) | 383 s |

两阶段通过结果与 latch 拓扑检查共同支持：在下述两相协议下，归档通用 latch 网表与原 RTL 在宏周期采样边界上功能一致。第二阶段不是对任意时钟关系下的原始 latch 波形作无条件证明。存在 X/don't-care 时，沿用 EQY 的 gold 三值和安全替换语义，不要求实现侧保留 RTL 未定义值。

## 证明条件与相位模型

- 第一相 `clk_1` 后接第二相 `clk_2`，两相不重叠。
- 所有外部数据及控制输入（包括同步低有效 `resetn`）在一个宏周期内保持稳定。
- 透明阶段逻辑充分稳定后比较采样边界行为；一个宏周期对应参考模型的一次状态更新。
- 保留 CPU 原有未初始化状态，不额外把 CPU 寄存器清零。不启用会增加 CPU 内置性质及环境限制的 `FORMAL` 宏。

第二阶段配置先将实际通用 latch 网表导出为 JSON，再由 [build_phase_model.py](build_phase_model.py) 检查结构并生成同步采样模型。结构不满足要求时脚本返回非零，EQY 停止，不继续使用旧模型。

[归档结构报告](evidence/structure.json)记录了 842 个第一相 latch、1597 个第二相 latch，其中 1280 个第二相 latch 使用 49 个共享门控。检查确认：

1. 第一相透明网络无反馈环，数据路径不依赖时钟值。
2. 第二相数据均由第一相 latch 隔离；门控使能来自第一相 latch，在第二相期间冻结。
3. 外部输出不直接暴露第一相 latch 状态或时钟。
4. 没有为 CPU 添加初始化值。

通过这些前提，第一相透明逻辑可在边界模型中表示为组合关系，第二相状态按宏周期并行提交；门控仍表示为状态更新使能。脚本保留真实第二相状态别名以支持 EQY 分区，调试别名按配置排除。模型只用于形式验证，不可作为电路实现替换输入。

## 复现

需要 Linux/WSL 环境中的 Yosys（含 `+/simcells.v` 和 ABC）、EQY、SBY、Z3、Python 3 及 make。归档证明日志记录 Yosys 0.68，提交 `38e001a6f`；EQY/SBY/Z3 的具体版本未在现有证据中单独记录。依赖应预先安装。

从仓库根目录执行：

```bash
cd examples/picorv32
eqy -d equivalence/rtl_yosys equivalence/rtl_yosys.eqy
eqy -d equivalence/yosys_latch equivalence/yosys_latch.eqy
```

上述运行目录由本目录 `.gitignore` 排除。若目录已存在，请改用新的 `-d` 路径保存复跑结果。第二阶段会在 `equivalence/checks/phase/` 重新导出 JSON、生成采样模型及结构报告；配置以 EQY 的执行步骤自动调用 Python，无需手工改写网表。

两次运行都必须最终返回 `DONE (PASS, rc=0)`。单独有限深度展开、`UNKNOWN`、超时或只完成结构检查均不代表完整 EQY 证明成功。归档文件保留原运行目录名 `rtl_yosys_10`、`yosys_latch_2` 及原始工具路径，未改写为本次归档路径。

## 证据与版本

`evidence/rtl_yosys/` 和 `evidence/yosys_latch/` 分别保存原始主日志、gold/gate 处理日志、实际预处理脚本、匹配点和分区列表。[structure.json](evidence/structure.json)记录模型生成器和输入网表 SHA-256；同样的记录也嵌入已通过运行的 [gate.log](evidence/yosys_latch/gate.log)。原始 RTL 和 Yosys 网表与归档基线一致，本次补充通用 latch 输入及验证成果。

| 文件（相对 `examples/picorv32/`） | SHA-256 |
|---|---|
| `picorv32.v` | `fd142889e8178ef67f1cff17cb2d18b3adae56fcae2badf7cbcc4c4f5ac7960e` |
| `picorv32_latch/picorv32_yosys.v` | `d306819468d3672738e39cfaaca93a97493491b83cca1425fce3d6639fcc10c0` |
| `picorv32_latch/picorv32_latch.v` | `4d3bab25770adcf0845d74f9b37b10c5ced39c1b90fe2a8aea9e4b98e5768f83` |

SHA-256 按文件原始字节计算；跨平台检出转换换行时，应以 Git 中归档的原始内容校验。重新生成网表、修改模型生成器或改变参数后，应重新检查结构并运行两阶段证明。

本次同步归档既有成功结果并核对输入版本，不声称重新执行了完整 EQY 求解。生成的庞大分区中间文件、可执行仿真文件和未完成的历史尝试未纳入归档。该结果不包含通用 latch→SKY130 单元映射的等价证明，不包含布局布线、传播延迟、setup/hold、毛刺或亚稳态，也不证明转换工具对全部 RTL 和参数组合都正确。
