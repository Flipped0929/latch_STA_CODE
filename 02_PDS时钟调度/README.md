# 02_PDS时钟调度 — 阶段二

要回答：给定 latch 网表的借用约束，如何解出全局最优的时钟到达时间（clock skew scheduling）。

| 文件 / 目录 | 内容 |
|---|---|
| `zqilin_phase2/FINAL_CLOCKS.csv` | 求解得到的最终时钟配置 |
| `zqilin_phase2/FINAL_RESULTS.json` | 汇总结果 |
| `zqilin_phase2/build_howard_app/` | 扫频时调用的可执行程序 |
| `zqilin_phase2/tools/pds_howard.cpp` | PDS 约束图接口（把 PDS 报告转成求解器输入） |
| `zqilin_phase2/实验阶段二.docx` | 实验报告 |

算法实现本身在 [`00_工具与算法/zqilin_algorithms/`](../00_工具与算法/zqilin_algorithms/)。
