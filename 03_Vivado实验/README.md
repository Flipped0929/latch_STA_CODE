# 03_Vivado实验 — 阶段三：Vivado 混合电路

要回答：FF/latch 混合、MMCM 相位、pulse latch、pairl 迭代、retiming 在真实 Vivado 实现下表现如何。

`zqilin_phase3/` 下 27 个实验目录，**每个目录先看它自己的 `REPORT.md`**：

| 组 | 目录 |
|---|---|
| 受控 / 扫频搜索 | `controlled_search/`、`frequency_search/`（含 `_raw`）、`paired_search/`（含 `_raw`）、`selective_bits/` |
| Howard / MMCM / 重定时 | `mmcm_howard/`、`mmcm_retime/`（含 `_raw`）、`retiming_benchmark/` |
| pairl 迭代 | `pairl_iteration/`（含 `_raw`） |
| pulse latch | `pulse_direct/`、`pulse_cycle/` |
| FF / 混合电路对照 | `ff/`、`ff_control/`（含 `_raw`）、`mixed_stage1/`、`mixed_stage2/`、`mixed_stage3/`、`stage3/` |
| 内部对照 | `internal_comp/`（含 `_raw`）、`common_mmcm/`、`carry_reproducer/` |
| 仿真交叉验证 | `modelsim_timing_crosscheck/` |

**相关**：`flipped` 的借用仲裁实验（LUT 延迟链 + 单沿 FF / 两相 FF / 两相 latch 三变体）主题上属于本阶段，
但成果包是一份不可拆的交付物，实际放在 [`../01_FF与Latch/flipped/`](../01_FF与Latch/flipped/)，
先看那份的 `REPORT.md` 第 3 节。
