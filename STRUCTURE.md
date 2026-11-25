# 仓库结构说明（STRUCTURE）

> 这份文档解决一个问题：**三个人打开仓库，三十秒内能找到自己 / 队友的东西。**
> 先看“§1 顶层结构”，再用“§2 按人查”或“§3 按阶段查”。
> 最后更新：2026-11-25（按阶段重排后）

---

## 1. 顶层结构

```
latch_STA_CODE/
├─ README.md                项目简介与快速定位
├─ STRUCTURE.md             本文档
├─ 00_工具与算法/            C++ 算法与工具（整个项目的“底座”）
│  ├─ bailu_tool/           bailu 的 LatchSTA 工具（src/include/CMake/pdk/CSTIC/benchmark/tests）
│  ├─ zqilin_algorithms/    zqilin 的算法工程（src/include/benchmark/tests/CSTIC/历史构建）
│  └─ zqilin_repo_meta/     zqilin 原仓库的目录说明与元文件（原样保留）
├─ 01_FF与Latch/            阶段一：FF vs Latch 对照与时间借用
│  ├─ zqilin_phase1/        PDS 上的 ff_and_latch + time_borrow + 三份实验报告
│  ├─ bailu_examples/       ASIC 侧锁存器示例（SKY130 counter：后布线 STA + ngspice）
│  └─ flipped/              flipped 的 E1–E4 与借用仲裁成果包（报告/数据/图/脚本）
├─ 02_PDS时钟调度/           阶段二：PDS 时钟调度
│  └─ zqilin_phase2/        FINAL_CLOCKS.csv、FINAL_RESULTS.json、build_howard_app、tools/pds_howard.cpp
├─ 03_Vivado实验/            阶段三：Vivado 混合电路实验
│  └─ zqilin_phase3/        27 组实验（controlled_search / frequency_search / pairl_iteration / mmcm_howard / pulse_* / mixed_stage1-3 / retiming_benchmark …）
├─ 04_理论/                  理论（阶段之外，支撑全项目）
│  ├─ 两级锁存器理论模型/      cycle-level latch vs FF 模型（model.py、sweep、可行性边界）
│  ├─ T_W_Th可行域分析/        (周期, 窗口, 保持时间) 可行域扫描与热图
│  ├─ S27行为级验证/          ISCAS s27 行为级 + skew 网格验证
│  └─ S298行为级验证/         ISCAS s298 同法验证
├─ 05_ASIC/                  阶段之外：大规模 ASIC 流程
│  └─ bailu_picorv32/        PicoRV32 锁存器化 + ORFS + EQY 等价性证明
└─ docs/
   ├─ merge_notes_2026-11-24.md   合并来源、提交号、筛选规则
   └─ merge_filter.ps1            重新生成合并树的脚本
```

**六个编号目录 = 四个实验阶段 + 工具层 + 理论/ASIC 支撑。** 编号不代表重要性，只代表顺序：
0 是底座，1–3 是 zqilin 原仓库的实验时间线（PDS → Vivado），4–5 是阶段之外的支撑。

---

## 2. 按人查：我的东西在哪

### 2.1 Bailu（原仓库 `BailuFrost/LatchSTA_Code@55c8553`）

| 原路径 | 现在的位置 | 内容 |
|---|---|---|
| `src/` `include/` `CMakeLists.txt` `cmake/` `tests/` | `00_工具与算法/bailu_tool/` | latch 时序图、借用、Howard、LP、椭圆法、YTO、SDC 导出 |
| `benchmark/` `benchmark_rslt/` | `00_工具与算法/bailu_tool/` | ISCAS/工业基准与结果摘要 |
| `CSTIC/` | `00_工具与算法/bailu_tool/CSTIC/` | 早期 FPGA 时序报告解析（SLICE / IMSP / HSPICE 模型） |
| `pdk/` | `00_工具与算法/bailu_tool/pdk/` | SKY130 时序数据 |
| `examples/counter/` | `01_FF与Latch/bailu_examples/counter/` | SKY130 4 位主从锁存器计数器：Yosys→OpenSTA→OpenROAD→SPEF→ngspice + 后布线 STA |
| `examples/picorv32/` | `05_ASIC/bailu_picorv32/` | PicoRV32 锁存器化（ORFS）+ EQY 两阶段等价性证明 |

构建入口：`00_工具与算法/bailu_tool/CMakeLists.txt`（Boost 必需；GLPK/LEDA 仅 LP/椭圆路径需要）。
注意：`examples/` 里的脚本用的是他本机绝对路径（`/home/bailufrost/eda/...`），换机器要改路径——这是原有状态，未做修改。

### 2.2 zqilin（原仓库 `zqilin641-jpg/latch_STA_CODE@bf3f1b2`）

| 原路径 | 现在的位置 | 内容 |
|---|---|---|
| `算法/` | `00_工具与算法/zqilin_algorithms/` | 算法实现 + 基准 + 历史构建与验证 |
| `阶段一_FF与Latch/` | `01_FF与Latch/zqilin_phase1/` | `ff_and_latch/`、`time_borrow/`、三份 docx 报告 |
| `阶段二_PDS时钟调度/` | `02_PDS时钟调度/zqilin_phase2/` | FINAL_CLOCKS / FINAL_RESULTS / build_howard_app / tools/pds_howard.cpp |
| `阶段三_Vivado混合电路/` | `03_Vivado实验/zqilin_phase3/` | 27 组 Vivado 实验，每组有 `REPORT.md` + `*.json` + `*.tcl` + 精选 `*.rpt` |
| `目录说明.md` `.gitignore` `.gitattributes` | `00_工具与算法/zqilin_repo_meta/` | 他原仓库的目录说明（描述的是**拆分前**的结构） |
| 旧分支 `S27行为级验证/` | `04_理论/S27行为级验证/` | 来自分支 `add-s27-validation` |
| 旧分支 `S298行为级验证/` | `04_理论/S298行为级验证/` | 来自分支 `S298行为级验证` |
| 旧分支 `T_W_Th可行域分析/` | `04_理论/T_W_Th可行域分析/` | 来自分支 `add-t-w-feasibility` |
| 旧分支 `两级锁存器理论模型/` | `04_理论/两级锁存器理论模型/` | 来自分支 `two-stage-latch-model` |

> ⚠️ 这 4 个理论目录**不在** zqilin 11-23「工程整理」后的主树里，只存在于他的旧分支。
> 为了不丢东西，这次从分支原样取回（文件数：60 / 16 / 9 / 14）。

### 2.3 flipped（本项目自己的成果）

| 原路径 | 现在的位置 | 内容 |
|---|---|---|
| 整包 | `01_FF与Latch/flipped/` | `REPORT.md`（全 latch 边界 + 借用仲裁两篇）、`EVIDENCE_INDEX.md`、`PRESENTATION_GUIDE.md`、`data/`（13 个 CSV）、`figures/`（7 张）、`rtl/`、`sim/`、`scripts/`、`waves/` |

入口：先 `REPORT.md`，再 `EVIDENCE_INDEX.md`（每条结论对应哪个文件、哪个数值）。
说明：借用仲裁实验（延迟链 + 三变体）主题上属于阶段三，但成果包是一份不可拆的交付物，所以整体放 01，
在 `03_Vivado实验/README.md` 里有指向。

---

## 3. 按阶段查：这个阶段有谁的东西

### 阶段 0 —— 工具与算法（`00_工具与算法/`）

- **目标**：把“时序报告 → latch 时序图 → 借用/偏斜求解 → SDC”这条链做成工具。
- **入口**：`bailu_tool/CMakeLists.txt`、`zqilin_algorithms/CMakeLists.txt`（两套都源自同一 C++ 工程谱系，各自带 CSTIC 配套工程）
- **怎么跑**：
  ```bash
  cd 00_工具与算法/bailu_tool
  cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build -j
  ```
  zqilin 那份请**从他自己的 `算法/` 目录新建构建目录**（他原 CMake 缓存里有旧绝对路径）。

### 阶段 1 —— FF vs Latch 与时间借用（`01_FF与Latch/`）

- **要回答**：latch 的透明窗与时间借用，到底能不能换来频率/延迟收益？在 PDS 和 Vivado 上分别是什么结果？
- **三方证据**：
  | 谁 | 在哪 | 做了什么 | 关键结论 |
  |---|---|---|---|
  | zqilin | `zqilin_phase1/` | PDS 上的 FF/latch 对照 + 三案例借用实验 | 最大借用 3.514 ns，下一级 adjustment 3.264 ns；不能证明 Fmax 提升 |
  | bailu | `bailu_examples/counter/` | SKY130 4 位锁存器计数器，后布线 STA + ngspice | 模型最优 1.584538 ns vs 实测工作点 1.80 ns |
  | flipped | `flipped/` | Vivado/A7 上把 IO 边界也换成 latch；相位扫描；Tmin；hold/SDF | 全 latch 成立（FDCE=0/48 LDCE），但 Tmin 11.5–12.0 ns 与全 FF 打平；借用只在边界 1.66–1.82 ns |

### 阶段 2 —— PDS 时钟调度（`02_PDS时钟调度/`）

- **要回答**：给定 latch 网表的借用约束，如何解出全局最优的时钟到达时间（CSS）。
- **入口**：`zqilin_phase2/FINAL_CLOCKS.csv`（调度结果）、`FINAL_RESULTS.json`（汇总）、`build_howard_app/`（扫频时调用的程序）、`tools/pds_howard.cpp`（PDS 约束图接口）。

### 阶段 3 —— Vivado 混合电路实验（`03_Vivado实验/`）

- **要回答**：FF/latch 混合、MMCM 相位、pulse latch、pairl 迭代、retiming 在真实 Vivado 实现下的行为。
- **入口**：`zqilin_phase3/` 下 27 个实验目录，每个都有自己的 `REPORT.md`（先看这个）。
  主要几组：`controlled_search/`（受控搜索）、`frequency_search/`（扫频）、`pairl_iteration/`、`mmcm_howard/`、`pulse_direct/` `pulse_cycle/`、`mixed_stage1-3/`、`retiming_benchmark/`、`modelsim_timing_crosscheck/`。
- 相关：`01_FF与Latch/flipped/` 里的**借用仲裁**（LUT 延迟链 + 单沿 FF / 两相 FF / 两相 latch 三变体）属于本阶段主题。

### 阶段 4 —— 理论（`04_理论/`）

| 目录 | 内容 | 入口 |
|---|---|---|
| `两级锁存器理论模型/` | 周期级 latch vs FF 模型，含 setup/hold、借用、phase shift | `model.py`、`sweep.py`、`results/` |
| `T_W_Th可行域分析/` | 周期 T × 窗口 W × 保持时间 Th 的可行域扫描 | `feasibility.py`、`results/feasibility_map.svg` |
| `S27行为级验证/` | ISCAS s27 行为级仿真 + skew 网格 + hold 检查 | `sim.py`、`sweep.py`、`hold_check.py`、`results/` |
| `S298行为级验证/` | 同上，s298 | — |

> 这四份是“理论/行为级”，与阶段 1–3 的实测对照使用。例如：理论预测不均衡阶段下 latch 10.30 ns vs FF 16.40 ns；
> 实测（`flipped/`）表明该结论只在 **FF 基线也做成两相**时成立。

### 阶段 5 —— ASIC 大电路（`05_ASIC/`）

- `bailu_picorv32/`：PicoRV32 的 DFF 版与锁存器版 ORFS 流程、两阶段 EQY 等价性证明。
- 与阶段 1 的 `bailu_examples/counter` 配套：小电路先验证，大电路再确认。

---

## 4. 三条约定（以后维护请遵守）

1. **源文件不修改**：本仓库只搬位置，不改内容。2026-11-25 重排时已用 SHA-256 全量核对：
   原有 4380 个文件的哈希全部保留，新增的 99 个文件全部来自 zqilin 的旧分支（4 个理论目录）。
2. **新增产物放对应阶段**：新的实验目录放进 `0X_.../` 下对应的子目录；新写的说明放 `docs/`。
3. **报告与代码同处**：每个实验目录尽量保留自己的 `REPORT.md` / `README.md`，方便按阶段追溯。

---

## 5. 没有进仓库的东西

- 构建产物与仿真输出：`build*/`、`.runs/`、`.cache/`、`.Xil/`、`.dcp/.bit/.odb/.def/.spef/.gds`、ngspice 波形、大型基准转储（约 1.9 GB，见 `docs/merge_notes_2026-11-24.md` 的筛选规则）。
- 上游 git 历史（本仓库是快照合并，`git log` 只有合并与重排两个阶段的提交）。
- 需要完整内容时克隆上游：
  ```bash
  git clone https://github.com/BailuFrost/LatchSTA_Code
  git clone https://github.com/zqilin641-jpg/latch_STA_CODE
  ```

---

## 6. 变更记录

| 日期 | 变化 |
|---|---|
| 2026-11-24 | 合并两个上游仓库（bailu + zqilin）+ 加入 flipped 成果包，按人分目录（`bailu/`、`zqilin/`、`flipped/`） |
| 2026-11-25 | 改为按阶段分目录（`00`–`05`）；从 zqilin 旧分支取回 4 个理论目录；新增本文件与各阶段 README；源文件内容零修改 |
