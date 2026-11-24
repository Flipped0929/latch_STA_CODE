# counter_sky130 原理图

`counter_sky130.sch` 使用已安装的 SKY130A `sky130_stdcells` 符号，逐单元对应当前 `counter_sky130.v`。`counter_sky130.svg` 和 `counter_sky130.png` 为原理图预览。

在本目录启动：

```sh
xschem --rcfile ./xschemrc ./counter_sky130.sch
```

工艺库默认位于 `$HOME/eda/pdk/sky130A`，也可通过 `PDK_ROOT` 指定根目录。

## 电路结构

- 第 0、1 位：递增逻辑和保持选择器 → clk_1 锁存器 → clk_2 锁存器。
- 第 2、3 位：clk_1 分别锁存当前位和使能翻转条件 → XOR → clk_2 锁存器。两个翻转条件各有一个独立锁存器。
- 共 19 个单元：10 个 `dlrtp_1`、2 个 `mux2_1`、3 个 `xor2_1`、2 个 `and3_1`、1 个 `and2_1` 和 1 个 `inv_1`。
- clk_1、clk_2 为按此顺序工作的不重叠高电平有效时钟；rst_n 为全部 10 个锁存器的异步低有效复位。
- 反馈网络 `count[n]` 对应 Verilog 中 `count_o[n]`，两者通过原文件中的 assign 等价。未使用的中间线和纯别名不增加器件。
- 电源端口为 `VPWR`、`VGND`。标准单元的电源/衬底端口通过实例属性连接：`VPB=VPWR`、`VNB=VGND`；双击单元可查看。

## 连接验证

```sh
python3 verification/refresh_netlists.py
```

此命令调用 xschem 重新导出 `simulation/counter_sky130.spice` 和 `simulation/counter_sky130_extracted.v`，再逐单元核对类型、实例名、70 个信号引脚、76 个电源/衬底连接及顶层端口。结果保存在 `verification/connections.txt`。

仅检查已保存的网表：

```sh
python3 verification/verify_connections.py
```

导出的 Verilog 顶层名称为 `counter_sky130`，原文件顶层名称为 `counter`；xschem 实例名在原实例名前增加 `x`。检查时已处理这些命名差异和 `count_o` 别名。此次验证为结构连接核对，未进行晶体管仿真或时序签核。

后续分析见 [OpenROAD 后布线功耗报告](openroad/power/README.md) 和 [ngspice 后布线晶体管级仿真](simulation/postlayout/README.md)，其中 ngspice 使用物理优化后的网表及提取互连 RC。
