# counter_yosys.v 的 xschem 原理图

打开原理图：

```sh
xschem --rcfile ./xschem_yosysrc ./counter_yosys.sch
```

原理图文件为 `counter_yosys.sch`，预览为 `counter_yosys.svg` 和 `counter_yosys.png`。
请保留同目录下的 `yosys_cells/` 和 `xschem_yosysrc`；仅需要 xschem 自带的 devices 符号库，无需 SKY130 PDK。

## 电路对应关系

四行分别表示 bit 0～3。数据从左向右经过递增逻辑、保持/递增选择器、clk_1 触发器和 clk_2 触发器，最后输出 count。

| 单元 | 数量 | 作用 |
| --- | ---: | --- |
| `$_DFF_PN0_` | 8 | 上升沿触发、异步低有效复位，复位值为 0 |
| `$_MUX_` | 4 | en=0 选 A 保持当前值；en=1 选 B 递增 |
| `$_AND_` | 2 | 生成高位翻转条件 |
| `$_XOR_` | 3 | bit 1～3 的递增逻辑 |
| `$_NOT_` | 1 | bit 0 的翻转逻辑 |

`clk_1` 上升沿捕获下一计数值，随后 `clk_2` 上升沿更新输出及反馈；依照源网表说明，两相应按此顺序、使用不重叠的高电平脉冲。`rst_n=0` 异步清零全部 8 个触发器。

图上相同名称的网络标签表示电气连接。源网表的 `assign count = count_o` 已合并为 `count[n]` 网络；其余未参与单元连接的纯别名不增加器件。实例名保持原样。

此网表中的存储单元为 D 触发器。原目录中的 `counter_sky130.sch` 对应另一份使用锁存器的网表；本图独立保存为 `counter_yosys.sch`。

## 验证与导出

```sh
python3 verification/verify_counter_yosys.py
```

该命令通过 xschem 重新生成 `simulation/counter_yosys_extracted.v`，核对全部 18 个实例、65 个引脚连接和顶层端口，结果保存至 `verification/counter_yosys_connections.txt`。导出模块名为 `counter_yosys`，源模块名为 `counter`。

本图为 Yosys 通用逻辑单元原理图，适用于逻辑连接检查和 Verilog 导出。Verilog 仿真需同时加载 Yosys 的 `simcells.v`。

重新导出 SVG（命令行无图形模式）：

```sh
xschem -x -r -q --rcfile ./xschem_yosysrc \
  --command 'xschem line_width 2; xschem print svg counter_yosys.svg 2400 1600' \
  ./counter_yosys.sch
```

`yosys_cells/and2.sym`、`xor2.sym` 和 `not.sym` 的图形改编自已安装的 xschem SKY130 标准单元符号，保留原 Apache-2.0 许可头；逻辑和网表格式已改为对应的 Yosys 通用单元。MUX 和 DFF 为本项目的本地符号。
