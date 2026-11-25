# 05_ASIC — 大规模 ASIC 流程

阶段之外的 ASIC 侧验证，与 [`../01_FF与Latch/bailu_examples/counter/`](../01_FF与Latch/bailu_examples/counter/)
配套（小电路先验证、大电路再确认）。

| 目录 | 内容 | 入口 |
|---|---|---|
| `bailu_picorv32/` | PicoRV32 的 DFF 版与锁存器版 ORFS 流程、两阶段 EQY 等价性证明 | 目录内各 `README.md` / 流程脚本 |

> 这些流程用到的 SKY130 数据在 [`../00_工具与算法/bailu_tool/pdk/`](../00_工具与算法/bailu_tool/pdk/)；
> 流程脚本里出现的绝对路径（`/home/bailufrost/eda/...`）是原作者本机路径，换机器需自行调整——这是原有状态，未做修改。
