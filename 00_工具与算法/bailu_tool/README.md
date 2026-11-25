# LatchSTA：RTL 到锁存器电路转换与时序分析

本项目包含触发器电路到双相锁存器电路的转换脚本、锁存器时序分析代码，以及 counter 和 PicoRV32 的电路实例。转换流程先导出 Yosys 基本单元网表，复制两相存储单元并处理使能门控，再对第一相数据单元重定时，最后映射为 SKY130 标准单元。

## 获取项目

```bash
git clone --recurse-submodules https://github.com/BailuFrost/LatchSTA_Code.git
cd LatchSTA_Code
```

已有克隆可执行 `git submodule update --init --recursive`。`examples/picorv32/repository` 固定上游 PicoRV32 版本，`pdk/icsprout55-pdk` 固定可选的 ICsprout55 PDK 版本；SKY130 示例使用的库和映射文件位于 `pdk/sky130_pdk`。

## RTL 到双相 latch 转换

转换工具位于 [trans](trans/README.md)，需要 Linux 环境中的 Yosys（包含 ABC）、CMake 3.21+、C++17 编译器和 `nlohmann_json`。Yosys 0.68 是当前归档实例使用的版本。

在仓库根目录转换 PicoRV32，并将新结果写入独立目录：

```bash
INPUT_DIR=../examples/picorv32 \
TOP=picorv32 CLOCK=clk \
OUTPUT_DIR=../examples/picorv32/picorv32_generated \
bash trans/run_flow.sh
```

脚本以 `trans` 为基准解析这些相对路径，自动构建转换程序，再生成五份网表：

| 文件后缀 | 内容 |
|---|---|
| `_yosys.v` | Yosys 基本单元网表 |
| `_dup.v` | 两相复制中间网表 |
| `_gated.v` | 将使能转换为共享时钟门控后的网表 |
| `_retimed.v` | 第一相数据单元重定时结果 |
| `_sky130.v` | SKY130 latch 电路网表 |

可通过 `INPUT_FILE` 指定单个 RTL，或通过 `INPUT_DIR` 读取目录第一层的全部 `.v` 文件；设置实际的 `TOP`、`CLOCK` 和 `OUTPUT_DIR`。默认脚本示例名为 fetch，本仓库使用上面的显式参数运行 PicoRV32。完整参数、单步命令和支持的时序单元见 [转换说明](trans/README.md)。

两相必须按 `clk_1`、`clk_2` 顺序提供不重叠的透明窗口。当前 PicoRV32 配置已通过 RTL→Yosys 网表、Yosys 网表→latch 相位边界模型两阶段 EQY 验证，配置、通过日志、网表版本及适用条件见 [PicoRV32 等价验证](examples/picorv32/equivalence/README.md)。该结论限定于记录的输入版本和两相协议，不包含 SKY130 单元映射或后端时序签核。

## 实例与后端结果

| 目录 | 内容 |
|---|---|
| [counter_dff](examples/counter/counter_dff/openroad/README.md) | Counter DFF 基线、布局布线、提取和仿真 |
| [counter_latch_clock](examples/counter/counter_latch_clock/openroad/README.md) | 双相时钟 latch 方案与频率、功耗实验 |
| [counter_latch_mux_1](examples/counter/counter_latch_mux_1/openroad/README.md) | MUX 使能 latch 方案及后布局仿真 |
| [counter_latch_mux_2](examples/counter/counter_latch_mux_2/README_xschem.md) | 第二组 MUX latch 电路和原理图 |
| [counter_output](examples/counter/counter_output/openroad/README.md) | 转换输出与后端实验 |
| [PicoRV32 DFF](examples/picorv32/picorv32_dff/设计报告.md) | DFF 基线的六阶段 ORFS 结果 |
| [PicoRV32 latch](examples/picorv32/picorv32_latch/设计报告.md) | 双相 latch 的六阶段 ORFS 结果 |

PicoRV32 两组目录均保存配置、SDC、日志、报告和最终 GDS/DEF/网表/SPEF。Latch 的 `holdfix30ps` 实验恢复显式门控检查，并增加 hold 修复目标；独立读取最终 SDC 时还须加载同目录的 `gating_checks.tcl`。频率、功耗和验证范围以各自设计报告为准。

## 时序分析程序

`src/`、`include/` 保留基于约束图的 Howard、YTO、LP 等锁存器时序分析与 SDC 导出代码。主程序需要 LEDA、GLPK、Boost、OpenBLAS、xtensor 等原有依赖；CMake 从 `LEDAROOT` 或 `-DLEDA_ROOT=...` 寻找 LEDA。

```bash
cmake -S . -B build
cmake --build build -j8
./build/main <input_file> <iterations> <ellipsoid_radius> [latch_timing.json] [--read-only] [--no-skew] [--duty-cycle fraction] [--export-sdc new_file.sdc]
```

`--read-only` 只读取输入；`--no-skew` 固定时钟偏移为零。不同输入 schema 的适用条件不同，模型求得的周期不等同于后端签核或硅片工作频率。

## SKY130 表征数据检查

```bash
python3 -m unittest discover -s pdk/sky130_pdk -p 'test_extract_latch_timing.py'
```

库的来源、许可证及固定条件表征说明见 [SKY130 数据说明](pdk/sky130_pdk/README.md)。

## 目录

- `trans/`：两相复制、使能门控、ABC 重定时和工艺映射脚本。
- `examples/counter/`、`examples/picorv32/`：源电路、中间网表、配置及归档结果。
- `pdk/`：SKY130 数据和映射文件，以及可选 PDK 子模块。
- `src/`、`include/`：时序分析实现。
- `benchmark/`、`benchmark_rslt/`、`CSTIC/`：原有基准数据和解析代码。

构建目录与缓存不纳入版本控制。已移除的旧实验和回归文件仍可从 Git 历史中查阅。
