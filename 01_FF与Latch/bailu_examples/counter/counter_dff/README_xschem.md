# counter 的 xschem 门级原理图

在本目录运行 `xschem counter.sch` 即可打开。项目自带 `xschemrc` 和
`symbols/` 下的五类逻辑符号，无需加载 PDK。

`counter.sch` 按 bit 0～3 排列，逐单元重建 `counter_mapped.v`：

| 原网表单元 | 数量 | 原理图实例 |
| --- | ---: | --- |
| `$_DFF_PN0_` | 4 | U7～U10，分别对应 `count_o_reg[0]`～`[3]` |
| `$_MUX_` | 4 | U11～U14 |
| `$_AND_` | 2 | U15、U16 |
| `$_XOR_` | 3 | U17～U19 |
| `$_NOT_` | 1 | U20 |

所有触发器均为时钟上升沿触发、低有效异步清零；时钟端带三角标记，
复位端带反相圆圈。`en=0` 时 MUX 选择 Q 的反馈，保持计数值；
`en=1` 时选择加一逻辑。计数从 15 回绕到 0。

原理图使用 `count[n]` 作为 `count_o[n]` 的同名等价网络，依据网表中的
`assign count = count_o`。原网表中其他仅用于别名的 assign 也列在图纸底部。
相同标签的网络电气相连；顶部 `count[3:0]` 是总线输出端口，四个位片使用其位标签。

这是原网表中 Yosys 通用逻辑单元的原理图，没有指定工艺库或晶体管尺寸。
`verification/cells.v` 为图中单元提供 Verilog 行为定义，可用于数字仿真。

运行 `bash verify.sh` 会从当前原理图重新导出 Verilog 并完成以下检查：

1. 与 `counter_mapped.v` 逐项比较 14 个单元、49 个引脚连接及全部端口。
2. 将原理图导出网表与 `counter.v` 做 Yosys 等价性证明。
   证明使用 `async2sync`；异步复位在时钟间的行为另外通过事件仿真检查。
3. 运行 Icarus Verilog 仿真，覆盖全部计数值的保持、加一、回绕，
   以及时钟高/低电平期间的异步清零，共 316 次检查。

验证结果保存在 `verification/`。`counter.svg` 和 `counter.png` 是 xschem 原理图预览。
`generate_schematic.py` 可重新生成原理图及符号；如已手动编辑图纸，请勿直接覆盖。
