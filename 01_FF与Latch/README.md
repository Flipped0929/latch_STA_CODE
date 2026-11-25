# 01_FF与Latch — 阶段一：FF vs Latch 与时间借用

要回答：latch 的透明窗和时间借用，能不能换来频率或延迟收益？PDS、Vivado、ASIC 三个平台各自是什么结果。

| 子目录 | 谁的 | 内容 | 先看 |
|---|---|---|---|
| `zqilin_phase1/` | zqilin | PDS 上的 `ff_and_latch/` 与 `time_borrow/`（baseline / borrow / overflow 三案例）+ 三份 docx 报告 | `time_borrow/README.md` |
| `bailu_examples/` | Bailu | SKY130 4 位主从锁存器计数器（Yosys→OpenSTA→OpenROAD→SPEF→ngspice + 后布线 STA） | `bailu_examples/counter/README.md` |
| `flipped/` | flipped | Vivado/Artix-7 上的 E1 边界替换、E2 相位扫描、E3 Tmin、E4 hold/SDF，以及借用仲裁 | `flipped/REPORT.md` |

三方言的结论对照写在 [`STRUCTURE.md`](../STRUCTURE.md) §3「阶段 1」。
