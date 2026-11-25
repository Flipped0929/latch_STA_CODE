# Merge notes

> **Directory layout note (2026-11-25).** This file records the merge performed on 2026-11-24,
> when the tree was organised by person (`bailu/` + `zqilin/` + `flipped/`). The tree was later
> reorganised by phase (`00_工具与算法` … `03_Vivado实验`); see [`../STRUCTURE.md`](../STRUCTURE.md)
> for the current layout. File contents were not changed during that reorganisation, only moved.
>
> The four theory directories that were briefly recovered from zqilin's legacy branches were
> removed again on the author's request; they remain reachable on the branches
> `add-s27-validation`, `S298行为级验证`, `add-t-w-feasibility` and `two-stage-latch-model`.


Record of how this repository was produced, so the merge can be reproduced, audited or
refreshed.

## 1. Sources

| Folder | Repository | Branch | Commit | Commit date |
|---|---|---|---|---|
| `bailu/` | `https://github.com/BailuFrost/LatchSTA_Code` | `main` | `55c8553ad5c96f397f95faf247ea39a3bf25efd6` | 2026-11-14T14:43:06Z |
| `zqilin/` | `https://github.com/zqilin641-jpg/latch_STA_CODE` | `main` | `bf3f1b29baa0453079bd62f2e3162c850413ca6c` | 2026-11-23T07:48:31Z |

Both were cloned in full on **2026-11-24** and filtered locally. Working-tree sizes of the
full clones: `bailu` ≈ 1041 MB, `zqilin` ≈ 1102 MB.

## 2. Why the tree is filtered

The upstreams track their build outputs, so a plain copy is ≈ 2.1 GB — close to GitHub's
recommended repository limit and far beyond what a teammate needs to read the code. The
filter keeps the material that explains and reproduces the results and drops regenerable
output.

Result: **4312 files, 178.7 MB** (bailu 2332 files / 63.3 MB, zqilin 1980 files / 115.4 MB).

## 3. Filter rules

Files are dropped when any of the following holds.

**Directory names** (any component of the path):

```
.git  .runs  .cache  .Xil  .gen  .ip_user_files  .sim  .hw  xsim.dir  __pycache__
.codegraph  node_modules  .vscode  .ipynb_checkpoints  work  .metadata  .analytics
```

**Extensions:**

```
.dcp .bit .ltx .wdb .jou .log .tsv .raw .o .a .so .exe .dll .pyc .zip .tar .gz .rbt
.bin .str .pb .sdb .reloc .mem .xpr .hdf .rslt .odb .def .spef .gds .vcd .fst .saif
.cdb .ddc .swp .db .qdb .qpg .qtl .qor
```

**Size:** files ≥ 2 MB are dropped.

**Bulk output directories:** a file is dropped when its immediate parent directory holds
more than 50 files. This removes per-candidate report dumps (for example 23 189 `.rpt`
files inside one `adjacent/` directory of `阶段三_Vivado混合电路/controlled_search/`) while
keeping curated per-variant report sets (8 reports each) and documentation.

Files named `.DS_Store` or `Thumbs.db` are also dropped.

## 4. What this preserves and what it drops

Kept: C++ sources and headers, CMake files, Tcl/Python scripts, SDC/XDC constraints,
Markdown documentation, JSON/CSV summaries, netlists and RTL (`.v`), small reports and images.

Dropped: Vivado project runs and checkpoints, OpenROAD database/ODB/DEF/SPEF/GDS output,
ngspice waveforms, multi-megabyte benchmark dumps, complete `.git` history, caches and logs.

Consequences to be aware of:

1. `git log` here does not contain the upstream commit history; use the upstream repositories
   for `git blame` / `git log`.
2. Numbers that only exist inside dropped artefacts (for example raw `timing_summary.rpt`
   files larger than 2 MB, or full `benchmark_rslt/*.rslt` dumps) must be read from the
   upstream repositories.
3. Some example flows will not run end-to-end from this tree alone because their generated
   inputs were dropped; re-run the flow scripts, which are present.

## 5. Reproducing this merge

```bash
# 1. clone the upstreams in full
git clone https://github.com/BailuFrost/LatchSTA_Code       bailu
git clone https://github.com/zqilin641-jpg/latch_STA_CODE   zqilin

# 2. copy with the filter rules in §3 into merged/bailu and merged/zqilin
#    (the original PowerShell helper is kept in MERGE_FILTER.ps1)

# 3. build the repository
cd merged
git init -b main
git add -A
git commit -m "merge: BailuFrost/LatchSTA_Code@55c8553 + zqilin641-jpg/latch_STA_CODE@bf3f1b2"
```

To refresh later: re-clone, re-run the filter, and commit the delta. Because `bailu/` and
`zqilin/` mirror the upstream layout, a refresh can also be done file-by-file with
`rsync`/`robocopy` followed by a single commit.

## 6. Target repository
This snapshot is intended to replace the contents of
`https://github.com/Flipped0929/latch_STA_CODE`.

That repository's current HEAD is `bf392e2e71346bf86242679a88237bdc052767e6`
(“补充，明天更新latch的部分”, 2026-10-16), which is a commit **from zqilin's upstream**
repository. Replacing it therefore loses no unique content: the old tree is reachable from
`zqilin641-jpg/latch_STA_CODE`.

Suggested push (force, because the new history is unrelated to the old one):

```bash
git remote add origin https://github.com/Flipped0929/latch_STA_CODE.git
git push --force origin main
```

Before pushing, optionally preserve the old state:

```bash
git fetch https://github.com/Flipped0929/latch_STA_CODE main:old-main
git push origin old-main          # keeps the previous tree on a branch
```

## 7. Third folder: `flipped/`

`flipped/` is not an upstream import; it is this project's own result bundle, copied
verbatim from `D:\FDU\FDUROP\submission_en` (64 files, 1.08 MB) on 2026-11-24 and committed
in the same history.

Its sources are the working trees `07_vivado_lab/all_latch_work` (experiment 1) and
`07_vivado_lab/borrow_arb` (experiment 2), which are not part of this repository. Inside the
bundle, `flipped/REPORT.md` §6 documents how to regenerate every number, and
`flipped/scripts/` contains the automation used.

Two files in `flipped/waves/` (`.wdb`) are force-added because the repository `.gitignore`
excludes waveform databases; they are optional demonstration material.
