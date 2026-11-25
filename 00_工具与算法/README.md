# 00_工具与算法 — 工具层

整个项目的底座：把“寄存器时序报告 → latch 时序图 → 借用/偏斜求解 → SDC”做成工具。

| 子目录 | 谁的 | 内容 | 入口 |
|---|---|---|---|
| `bailu_tool/` | Bailu | C++ latch 时序分析/优化工具（时序图、借用、Howard、LP、椭圆法、YTO、SDC 导出）+ benchmark + CSTIC + pdk | `CMakeLists.txt`、`README.md` |
| `zqilin_algorithms/` | zqilin | 算法工程（src/include/benchmark/tests/CSTIC/历史构建与验证） | `CMakeLists.txt` |
| `zqilin_repo_meta/` | zqilin | 原仓库的 `目录说明.md` 与 `.gitignore/.gitattributes`（描述的是拆分前结构） | `目录说明.md` |

```bash
cd bailu_tool && cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build -j
```

完整说明见仓库根目录 [`STRUCTURE.md`](../STRUCTURE.md) §3「阶段 0」。
