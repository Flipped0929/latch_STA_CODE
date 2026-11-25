# 01_FF与Latch — 阶段一：FF vs Latch 与时间借用

要回答：latch 的透明窗和时间借用，能不能换来频率或延迟收益？PDS、Vivado、ASIC 三个平台各自是什么结果。

| 子目录 | 谁的 | 内容 | 先看 |
|---|---|---|---|
| `zqilin_phase1/` | zqilin | PDS 上的 `ff_and_latch/` 与 `time_borrow/`（baseline / borrow / overflow 三案例）+ 实验报告 docx（润色版 + 增补版） | `time_borrow/README.md` |
| `bailu_examples/counter/` | Bailu | SKY130 4 位主从锁存器计数器（Yosys→OpenSTA→OpenROAD→SPEF→ngspice + 后布线 STA） | `bailu_examples/counter/README.md` |
| `bailu_examples/picorv32/` | Bailu | PicoRV32 的 DFF 版与锁存器版：ORFS 流程 + 两阶段 EQY 等价性证明（大电路） | 目录内各 `README.md` |
| `flipped/` | flipped | Vivado/Artix-7 上的 E1 边界替换、E2 相位扫描、E3 Tmin、E4 hold/SDF，以及借用仲裁 | `flipped/REPORT.md` |

`counter` 与 `picorv32` 是同一类工作：在真实 ASIC 流程上验证“锁存器化”的收益与等价性，只是规模不同
（小电路先验证、大电路再确认）。两者用到的 SKY130 数据在
[`../00_工具与算法/bailu_tool/pdk/`](../00_工具与算法/bailu_tool/pdk/)。

三方言的结论对照写在 [`STRUCTURE.md`](../STRUCTURE.md) §3「阶段 1」。
