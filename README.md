# Latch STA — merged team repository

One place for both teammates' latch-based timing analysis work. This repository is a
**curated snapshot** of two upstream repositories, merged on **2026-11-24**:

| Folder | Upstream repository | Commit | Date |
|---|---|---|---|
| `bailu/` | https://github.com/BailuFrost/LatchSTA_Code | `55c8553` | 2026-11-14 |
| `zqilin/` | https://github.com/zqilin641-jpg/latch_STA_CODE | `bf3f1b2` | 2026-11-23 |

Both upstreams are public and remain the authoritative source for history and for the
generated artefacts that are not copied here (see `MERGE_NOTES.md`).

---

## What is inside

```
bailu/    C++ latch timing analysis / optimisation tool + ASIC flows
zqilin/   PDS / algorithm work + three experiment phases (FF vs latch, clock scheduling,
          Vivado mixed circuits) + theory results
```

### `bailu/` — LatchSTA_Code

A timing-analysis and optimisation tool for latch-based circuits: it builds a latch timing
graph from a register-based timing report, applies time borrowing and an ellipsoid/LP
optimiser, solves the cycle-ratio problem with Howard's policy iteration, and exports the
resulting schedule as SDC.

| Path | Contents |
|---|---|
| `src/`, `include/` | C++17 sources and headers (timing graph, Howard, LP, ellipsoid, YTO, SDC export) |
| `examples/counter/` | SKY130 4-bit master–slave latch counter: Yosys → OpenSTA → OpenROAD → SPEF → ngspice, plus post-route STA reports |
| `examples/tiny_3_latch_circuit/` | Three-latch circuit used for Howard/OpenSTA cross-validation |
| `examples/picorv32/` | PicoRV32-based latch conversion example (ORFS flow) |
| `CSTIC/` | Early FPGA timing-report parsing work (SLICE / IMSP / HSPICE models) |
| `benchmark/`, `benchmark_rslt/` | ISCAS/industrial benchmark inputs and result summaries |
| `pdk/` | SKY130 timing data needed by the flows |
| `CMakeLists.txt` | Build entry (requires Boost; GLPK/LEDA only for the LP/ellipsoid paths) |

### `zqilin/` — latch_STA_CODE

Three experiment phases around PDS (a domestic FPGA toolchain) plus the algorithm side.

| Path | Contents |
|---|---|
| `阶段一_FF与Latch/` | Phase 1: FF vs latch comparison |
| `阶段二_PDS时钟调度/` | Phase 2: clock-skew scheduling experiments |
| `阶段三_Vivado混合电路/` | Phase 3: Vivado mixed FF/latch circuits — controlled search, retiming benchmark, frequency search, MMCM/Howard, pairl iteration, pulse experiments; each variant has its `REPORT.md`, `*.json` summaries, `*.tcl` scripts and curated `*.rpt` reports |
| `算法/` | Solver and algorithm work, including historical builds/validation |
| `目录说明.md` | The author's own directory guide (Chinese) |

---

## Quick start

```bash
# Bailu's tool: configure and build (Boost required)
cd bailu
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j

# An example flow (SKY130 counter) needs Yosys / OpenSTA / OpenROAD
cd examples/counter && cat README.md
```

```text
# zqilin's phase-3 experiments: each variant folder has its own REPORT.md
zqilin/阶段三_Vivado混合电路/controlled_search/REPORT.md
```

---

## What is *not* here

The two upstream repositories are about 1 GB each; most of that is generated output
(Vivado run directories, `.dcp`, `.odb`, `.gds`, ngspice waveforms, large benchmark dumps,
`.git` history). This snapshot keeps sources, scripts, constraints, documentation,
JSON/CSV summaries and curated text reports (files < 2 MB, excluding bulk output
directories), and drops the rest — **178 MB instead of 2.1 GB**.

To get the complete trees with full git history:

```bash
git clone https://github.com/BailuFrost/LatchSTA_Code
git clone https://github.com/zqilin641-jpg/latch_STA_CODE
```

See `MERGE_NOTES.md` for the exact filter rules and the commands used to rebuild this tree.

---

## Related repository

`Flipped0929/LatchSTA_Integrated` (2026-11-09) is a *semantically re-organised* integration
of the same two projects, with each file placed into `src/`, `examples/`, `experiments/`,
`docs/upstream/` according to its role. This repository instead keeps each upstream's own
layout under `bailu/` and `zqilin/`, so a file can always be traced back to its origin by
path. Use the integrated repository when you want a unified build tree; use this one when
you need to diff against either teammate's repository.

---

## 中文说明

本仓库把两位队友的仓库按原目录结构合并到 `bailu/` 与 `zqilin/` 两个文件夹下，
保留源码、脚本、约束、文档、JSON/CSV 摘要和少量文本报告，去掉了约 1.9 GB 的生成产物
（Vivado 运行目录、`.dcp`/`.odb`/`.gds`、ngspice 波形、大型 benchmark 转储、`.git` 历史）。
需要完整内容时请直接克隆上游仓库，命令见上。合并来源、精确提交号与过滤规则记录在
`MERGE_NOTES.md`。
