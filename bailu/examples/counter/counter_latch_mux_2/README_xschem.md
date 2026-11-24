# SKY130 两相回流计数器原理图

`counter_sky130.sch` 是根据本目录 `counter_sky130.v` 绘制的可编辑 xschem 标准单元级原理图。
两份源 Verilog 文件均未修改。

在本目录运行：

```bash
xschem --rcfile xschemrc counter_sky130.sch
```

`counter_sky130.svg` 是可放大的矢量图，`counter_sky130.png` 是 3400 × 2160 像素预览。
所需的六种 Sky130 单元符号随项目保存在 `symbols/sky130_stdcells/`，打开图纸不需要额外配置 PDK 路径。
这些符号复制自本机 SKY130A PDK，保留原引脚坐标、网表格式及 Apache 2.0 版权说明；仅移动实例名文字，避免长名字与符号重叠。
`symbols/net_label.sym` 是用于长信号名的紧凑标签。

## 图纸结构

四个位从上到下排列。每一行的主数据路径从左到右为：

`递增逻辑 → mux_phi1 → main_phi1 → mux_phi2 → main_phi2 → count`

每行下方另有两个回流锁存器，未将它们合并或省略：

- `recirc_phi1_bitN`：由 `clk_1` 控制，采样 `count[N]`，反馈到第二相 MUX 的 A0。
- `recirc_phi2_bitN`：由 `clk_2` 控制，采样 `main_q_phi1[N]`，反馈到第一相 MUX 的 A0。

顶部的 `en_phi1` 采样 `en`，其输出 `en_1` 控制第二相 MUX；第一相 MUX 直接使用 `en`。

| 标准单元 | 数量 | 用途 |
| --- | ---: | --- |
| `sky130_fd_sc_hd__dlrtp_1` | 16 | 四组各 4 位的数据锁存器，低电平异步清零 |
| `sky130_fd_sc_hd__dlxtp_1` | 1 | 第一相使能采样，无复位引脚 |
| `sky130_fd_sc_hd__mux2_1` | 8 | 两相的数据／回流选择 |
| `sky130_fd_sc_hd__and2_1` | 2 | 进位生成 |
| `sky130_fd_sc_hd__xor2_1` | 3 | 位 1～3 的递增逻辑 |
| `sky130_fd_sc_hd__inv_1` | 1 | 位 0 翻转 |

`clk_1`、`clk_2` 均为高电平透明，按第一相、第二相的顺序施加不重叠的时钟窗口。
`rst_n=0` 异步清零全部 16 个数据锁存器；`en_phi1` 不受复位控制。

同名标签表示电气连接。源网表中的 `assign count = count_o` 在图纸中统一为 `count[3:0]`；其他内部网络名保留。
每个实例名前增加 `x`，以满足 SPICE 子电路实例命名要求，例如 `main_phi1_bit0` 对应 `xmain_phi1_bit0`。

图纸另提供 `VPWR`、`VGND` 电源接口。所有单元属性均设置为 `VPB=VPWR`、`VNB=VGND`，这些连接包含在导出的 SPICE 网表中。

## 连接检查

已从实际 `.sch` 文件用 xschem 重新导出两种网表，并与源网表逐实例、逐引脚比较：

- `simulation/counter_sky130_extracted.v`：Verilog 结构网表，模块名为 `counter_sky130`。
- `simulation/counter_sky130.spice`：含电源及衬底连接的 SPICE 子电路。
- `verification/connections.txt`：检查结果。

检查通过：31 个单元类型和实例对应一致，116 个信号引脚连接一致，124 个电源／衬底连接正确，输入方向及四位输出总线正确，无遗漏或额外单元。
检查范围为结构连接；未进行晶体管级仿真或时序签核。SPICE 文件为子电路定义，运行仿真需要标准单元模型与测试激励。

重新从图纸提取并检查：

```bash
python3 verification/refresh_netlists.py
```

仅核对已有导出文件：

```bash
python3 verification/verify_connections.py
```

`verification/build_schematic.py` 为图纸生成脚本，需要本机 `~/eda/pdk/sky130A` 中的原始符号库。
它会重建图纸并覆盖手工编辑；日常编辑直接使用 xschem 即可。
