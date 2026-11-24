# 布局布线后的 xschem 原理图

已按当前 [counter_routed.v](../results/counter_routed.v) 绘制可编辑的 xschem 门级原理图，保留全部 **23 个信号单元**及其实际型号和实例名。

- [counter_routed.sch](../../counter_routed.sch)：原生可编辑原理图。
- [SVG 预览](../../counter_routed.svg)：可放大查看网络和型号。
- [PNG 预览](../../counter_routed.png)：4200 × 3300 像素。
- [xschem 导出网表](../../simulation/counter_routed.v)：用于逐项核对。
- [连接验证](verification.rpt)、[型号及 SHA-256](verification.json)。

在电路目录打开：

```bash
xschem --rcfile ./xschemrc counter_routed.sch
```

## 图中内容

上方左侧是第一相两级时钟树：`clkbuf_0_clk_1` 连接两个叶缓冲器。实际 `clknet_1_0__leaf_clk_1`、`clknet_1_1__leaf_clk_1` 分别连接到原网表指定的锁存器，并显示 `clkload0` 反相假负载及其 NC 输出。

上方右侧是使能锁存器和第二相门控：`enable_phi1` 的 GATE 使用实际第一相叶时钟；`gate_phi2` 的输出经 `clkbuf_phi2_single1` 单级缓冲后连接四个输出锁存器。保留缓冲插入后的上游网络名 `clknet_phi2_leaf1` 和下游 `clk_2_gated`。

下方按 bit0–bit3 分行显示加一/进位、第一相锁存器、重定时 XOR 和第二相输出锁存器。输出型号与布线结果一致：

| 实例 | 实际单元 |
| --- | --- |
| state_phi2_bit0 | sky130_fd_sc_hd__dlrtp_4 |
| state_phi2_bit1 | sky130_fd_sc_hd__dlrtp_4 |
| state_phi2_bit2 | sky130_fd_sc_hd__dlrtp_2 |
| state_phi2_bit3 | sky130_fd_sc_hd__dlrtp_2 |

同名网络标签表示电气连接；`count_o[i]` 按原布线网表的 assign 合并为 `count[i]`。带复位锁存器的 RESET_B 均连接 rst_n。隐含电源属性与完整布线电源网表 [counter_power.v](../results/counter_power.v) 一致：VPWR/VPB 接 VDD，VGND/VNB 接 VSS。

## 核对与预览

由 xschem 实际加载 `.sch` 并导出 Verilog，核对全部 23 个实例的型号与 **72 处已连接信号引脚**均一致。唯一额外导出的引脚为 `clkload0/Y`，xschem 分配浮动 net1，并用 NC 标记；已检查该网络没有其他负载。顶层四个输入和 4 位输出一致。xschem 按文件名把导出模块命名为 `counter_routed`，源网表模块名为 `counter`。

SVG 由 xschem 原生导出；PNG 由该 SVG 经系统 librsvg/Cairo 渲染。已检查整页、时钟树和 bit2 数据通路细节，避免长网络标签遮挡门符号。局部图：[第一相](phi1_detail.png)、[第二相](phi2_detail.png)、[bit2 数据通路](data_detail.png)。

本图表示布局布线后的门级连接，不表示单元的实际几何位置。filler、tap、PDN 等物理对象保留在 DEF/ODB 中；提取的分布 RC 保留在 SPEF 中，未展开成大量 R/C 元件。原先的 `counter_sky130.sch/.svg/.png` 保持为布局布线前版本。

## 重建当前版本

```bash
bash openroad/schematic/run.sh
```

流程依次生成 `.sch`、调用 xschem 导出网表和 SVG、渲染 PNG、逐项验证连接。新尺寸及 CTS 符号位于 `symbols/sky130_stdcells/`，从本机 SKY130 单元符号派生，保留版权说明；仅调整实例名文字位置及相应尺寸型号。PNG 渲染使用系统 `/usr/bin/python3` 的 gi/Rsvg、Cairo 和 Pillow。
