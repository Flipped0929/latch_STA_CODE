# 04_理论 — 理论推导与行为级验证

阶段之外、支撑全项目的理论部分（来自 zqilin 的旧分支，原样取回）。

| 目录 | 内容 | 入口 |
|---|---|---|
| `两级锁存器理论模型/` | 周期级 latch vs FF 模型（setup/hold、借用、phase shift、周期边界） | `model.py`、`sweep.py`、`results/` |
| `T_W_Th可行域分析/` | 周期 T × 窗口 W × 保持时间 Th 的可行域扫描与热图 | `feasibility.py`、`results/feasibility_map.svg` |
| `S27行为级验证/` | ISCAS s27 行为级仿真 + skew 网格 + hold 检查 | `sim.py`、`sweep.py`、`hold_check.py`、`results/` |
| `S298行为级验证/` | 同上，s298 | — |

与实测的对照：理论预测“不均衡阶段下 latch 10.30 ns vs FF 16.40 ns”，而
[`../01_FF与Latch/flipped/`](../01_FF与Latch/flipped/) 的实测表明该结论只在 **FF 基线也做成两相**时成立，
对常规单沿 FF，latch 慢约 27% 但延迟少一拍。详见 `flipped/REPORT.md` §3.5。
