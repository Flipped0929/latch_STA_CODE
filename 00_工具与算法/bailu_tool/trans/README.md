# 两相触发器复制与时钟门控

## 一次运行 PicoRV32 转换流程

在仓库根目录执行：

```bash
INPUT_DIR=../examples/picorv32 TOP=picorv32 CLOCK=clk \
OUTPUT_DIR=../examples/picorv32/picorv32_generated \
bash trans/run_flow.sh
```

脚本以 `trans` 为基准解析相对路径，读取输入目录第一层的全部 `.v` 文件，使用 `../pdk` 中的 SKY130 数据，生成 `_yosys.v`、`_dup.v`、`_gated.v`、`_retimed.v` 和 `_sky130.v` 五份结果。脚本默认保留 fetch 示例参数，因此本仓库运行 PicoRV32 时需要显式设置上面的变量。

可通过 `INPUT_FILE` 指定单个 RTL，`OUTPUT_DIR` 指定输出位置，`PDK_DIR` 指定工艺根目录，`YOSYS`、`CMAKE` 和 `DUPLICATE` 指定工具。再次运行会在全部转换成功后更新五份输出，建议使用独立输出目录保留已有后端输入。

`duplicate` 使用 C++17，实现图 5(a) 的网表变换。输入为已展平、单时钟、使用 Yosys 内部单元的 Verilog 网表。输出加入 `clk_1` 和 `clk_2`，第一相采样，第二相驱动原输出和反馈。下游实例请用命名端口连接。

每个受动态使能控制的触发器复制成两个同类型单元。相同的使能网线共用一只第一相采样 DFF。无使能的 DFF，以及 `E` 恒为 `1` 的高有效 DFFE，直接生成两只无使能 DFF。两相都保留原异步复位极性和复位值。

当前支持上升沿 DFF、高有效 DFFE，以及这些类型的异步清零或置位变体。同步复位、低有效使能、其他时序单元和多时钟输入会报错。

可选的时钟门控步骤将两相数据 DFFE 转为对应的无使能 DFF。第一相数据 DFF 直接接 `clk_1`，第二相数据 DFF 接 `clk_2 & enable_phi1`，其中 `enable_phi1` 来自原有的第一相使能采样 DFF。共用同一采样使能的触发器共用一个与门。恒低使能的第二相时钟接常量 `0`，其异步复位仍然有效。两相必须按 `clk_1`、`clk_2` 的顺序提供不重叠的脉冲，使采样后的使能在 `clk_2` 上升前稳定，并在其高电平期间保持稳定。

## 从 RTL 导出 Yosys 基本单元网表

从仓库根目录运行，示例将四位计数器导出为可供 `duplicate.cmake` 使用的 Verilog 网表。

```sh
yosys -b "verilog -noattr -noexpr" -o counter_yosys.v -p "hierarchy -check -top counter; script trans/export.ys" examples/counter/counter_dff/counter.v
```

工程包含多个 Verilog 源文件时，在命令末尾依次列出源文件，并将 `-top` 改为实际顶层模块名。脚本展平设计，保留 DFFE，并检查输出仅含 Yosys 基本单元。生成的 `counter_yosys.v` 可作为下游 `-DINPUT` 的输入。

## 构建和运行

需要 Yosys、CMake 3.21+、C++17 编译器和已安装的 `nlohmann_json` CMake 包。从仓库根目录运行：

```sh
cmake -S trans -B trans/build
cmake --build trans/build
cmake -DINPUT=examples/counter/counter_dff/counter_yosys.v -DOUTPUT=counter_dup.v -DTOP=counter -DDUPLICATE=trans/build/duplicate -P trans/duplicate.cmake
```

Windows 上将 `DUPLICATE` 指向实际生成的 `duplicate.exe`。如果 Yosys 不在 PATH 中，传入 `-DYOSYS=<可执行文件路径>`。原时钟端口名默认为 `clk`，可用 `-DCLOCK=<端口名>` 指定。输出路径应为新文件。

加上 `-DGATED_OUTPUT` 即可在一次调用中输出复制中间网表和时钟门控网表。以下示例使用 PicoRV32 的 `clk`，两份输出均保留临时触发器：

```sh
cmake -DINPUT=examples/picorv32/picorv32_latch/picorv32_yosys.v -DOUTPUT=picorv32_dup.v -DGATED_OUTPUT=picorv32_gated.v -DTOP=picorv32 -DCLOCK=clk -DDUPLICATE=trans/build/duplicate -P trans/duplicate.cmake
```

直接处理 Yosys JSON 时，`duplicate <top> <clock>` 输出复制中间网表，追加 `--clock-gate` 输出门控网表。两种模式都从标准输入读取原始 JSON，向标准输出写入结果。

结构检查不替代顺序等价验证；转换后的两相时钟、输入变化和输出采样协议需与参考电路统一。

## 重定时后映射到 PDK

`retiming.ys` 是单步计数器示例，输入文件需先准备好。也可映射已有的 PicoRV32 重定时网表：

```sh
cmake -DINPUT=examples/picorv32/picorv32_latch/picorv32_retimed.v -DOUTPUT=picorv32_sky130.v -DTOP=picorv32 -P trans/map_cells.cmake
```

`map_cells.cmake` 默认读取脚本所在目录的 `../pdk/sky130_pdk`，使用 SKY130 HD TT 25°C、1.8 V Liberty。可用 `-DPDK_DIR=...` 指定 PDK 根目录，用 `-DYOSYS=...` 指定 Yosys。输出路径须为新文件。

映射规则将上升沿 `$_DFF_P_` 换为高电平透明的 `dlxtp_1`，将四种高/低有效异步清零或置位的 DFF 换为 `dlrtp_1` 和必要的反相器。直接由 `clk_2` 驱动的门控与门单独映射，其余组合逻辑由 ABC 根据 Liberty 映射。Yosys 在输出前检查单元、端口和驱动连接，并拒绝残留的内部单元。

使用其他 PDK 时，传入 `-DPDK=<名称> -DLIBERTY=<标准单元库.lib> -DCELL_MAP=<映射规则.v>`。映射规则需要覆盖输入网表用到的 DFF 类型和第二相门控与门，目标单元与引脚须在所选 Liberty 中定义。仿真时按 `clk_1`、`clk_2` 的顺序施加不重叠的高电平窗口，在第二相结束后比较输出。
