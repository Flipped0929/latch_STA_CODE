# Latch STA — 团队统一仓库

三个人、一个项目、一份目录结构。本仓库把 **Bailu / zqilin / flipped** 三份工作按
**“工具层 → 四个实验阶段 → 理论 → ASIC”** 重新组织到一个树里，所有源文件内容**未做任何修改**，
只调整了位置；`STRUCTURE.md` 是完整的结构说明与索引。

```
00_工具与算法/    C++ 算法与工具（bailu 的 LatchSTA 工具 + zqilin 的算法工程）
01_FF与Latch/     FF vs Latch 对照、时间借用（zqilin 的 PDS 实验 + bailu 的 ASIC 示例 + flipped 的 E1–E4）
02_PDS时钟调度/   PDS 上的时钟调度（Howard 求解 + PDS 约束图）
03_Vivado实验/    Vivado 混合电路实验（zqilin 的 27 组实验；flipped 的借用仲裁在 01 里，见索引）
04_理论/          理论推导与行为级验证（S27 / S298 / T_W_Th 可行域 / 两级锁存器模型）
05_ASIC/          SKY130 / ORFS 大电路（bailu 的 PicoRV32 流程）
docs/             合并记录、筛选脚本
```

**先读 [`STRUCTURE.md`](STRUCTURE.md)**：里面有“按人查”和“按阶段查”两张索引表，
能直接告诉你每一项东西现在在哪、原来在哪、怎么跑。

## 快速定位

| 你是谁 | 从哪里开始 |
|---|---|
| Bailu | `00_工具与算法/bailu_tool/`（工具源码，`CMakeLists.txt` 在根）→ `01_FF与Latch/bailu_examples/counter/`（SKY130 借用验证）→ `05_ASIC/bailu_picorv32/` |
| zqilin | `00_工具与算法/zqilin_algorithms/`（算法）→ `01_FF与Latch/zqilin_phase1/` → `02_PDS时钟调度/zqilin_phase2/` → `03_Vivado实验/zqilin_phase3/`；理论在 `04_理论/`；他自己的目录说明在 `00_工具与算法/zqilin_repo_meta/目录说明.md` |
| flipped | `01_FF与Latch/flipped/`：`REPORT.md`（E1–E4 + 借用仲裁）→ `EVIDENCE_INDEX.md` → `data/` `figures/` → `PRESENTATION_GUIDE.md` |

## 仓库来源与历史

| 阶段 | 内容 |
|---|---|
| 2026-11-24 | 合并 `BailuFrost/LatchSTA_Code@55c8553` 与 `zqilin641-jpg/latch_STA_CODE@bf3f1b2`，保留源码/脚本/文档/摘要，去掉约 1.9 GB 生成产物（见 `docs/merge_notes_2026-11-24.md`） |
| 2026-11-25 | 由“按人分目录”改为“按阶段分目录”；从 zqilin 的旧分支取回 4 个理论目录（这些目录不在他 11-23 工程整理后的树里）；新增 `STRUCTURE.md` 与各阶段 README |

上游仓库仍是历史的权威来源：

- https://github.com/BailuFrost/LatchSTA_Code
- https://github.com/zqilin641-jpg/latch_STA_CODE
