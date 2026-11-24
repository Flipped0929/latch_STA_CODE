# Counter 的 xschem 原理图

当前布局布线后的版本为 [counter_routed.sch](counter_routed.sch)，包含实际输出驱动尺寸、CTS 树和门控电路。见 [SVG 预览](counter_routed.svg)、[PNG 预览](counter_routed.png)及[核对说明](openroad/schematic/README.md)。以下 `counter_sky130.*` 继续保留为布局布线前版本。

`counter_sky130.sch` 按修改后的 `counter_sky130.v` 绘制，反映 bit 2、bit 3 的 XOR 重定时结构。

在当前目录运行：

```bash
xschem --rcfile ./xschemrc counter_sky130.sch
```

文件：

- `counter_sky130.sch`：可编辑的 xschem 门级原理图。
- `counter_sky130.svg`：可缩放的矢量预览。
- `counter_sky130.png`：3495 × 2910 像素预览。
- `simulation/counter_sky130.v`：从最终原理图导出的 Verilog 网表。
- `symbols/sky130_stdcells/`：本机 SKY130 PDK 的五种单元符号副本，仅调整实例名文字的位置；保留原版权和许可证说明。
- `xschemrc`：使用本机 `~/eda/pdk/sky130A` 的工程配置。

图的上方是使能锁存器和第二相时钟门控；下方按四个计数位分行，并按组合逻辑、第一相锁存器、重定时 XOR、第二相锁存器分列。

bit 0、bit 1 的加一逻辑仍位于第一相锁存器之前。bit 2、bit 3 的数据位和进位分别由第一相锁存器捕获，再经过 XOR 计算 `next_count[2]`、`next_count[3]`，送入第二相锁存器。新增的两个进位锁存器完整保留了源实例名 `state_phi1_carry_bit2`、`state_phi1_carry_bit3`。

同名网络标签表示电气连接。原 Verilog 的 `assign count = count_o` 在图中合并为同一网络，输出旁的 `count_o[i]` 文字注明对应关系。

`rst_n` 直接连接到全部十个带复位锁存器的 `RESET_B`，包括两个新增的进位锁存器，为低电平有效的异步复位。`clk_1`、`clk_2` 应由外部提供互不重叠的高电平有效相位。

标准单元符号的电源脚通过属性指定：`VPWR`、`VPB` 接 `VPWR`；`VGND`、`VNB` 接 `VGND`。这些是符号的隐含电源属性，原 Verilog 的逻辑端口保持一致。

已通过 xschem 加载、网表导出和图像检查；导出网表的全部 18 个实例和 63 处信号引脚连接均与修改后的源文件逐项核对一致，顶层输入和 4 位输出也一致。xschem 按原理图文件名将导出模块命名为 `counter_sky130`；源模块名为 `counter`。
