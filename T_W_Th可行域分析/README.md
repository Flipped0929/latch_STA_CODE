# T/W/Th 可行域分析

本目录包含双锁存器模型的窗口可行域扩展。模型方程和默认电路参数由同级目录 `../两级锁存器理论模型/model.py` 提供。

脚本扫描周期 `T`、L1 透明窗口 `W` 和共同保持要求 `Th`，输出 setup 裕量、最大可容忍保持时间、网格摘要和 SVG 热图。分析是纯理论模型，不使用真实器件或布局布线数据。

在本目录运行：

```powershell
py -3.12 -m unittest -v
py -3.12 feasibility.py
py -3.12 feasibility.py --hold-time 0.5 --t-step 0.05 --w-step 0.05
```

默认扫描范围为 `T=8..18 ns`、`W=1..17 ns`，步进均为 `0.1 ns`，并检查 `Th=0.1 ns`。结果写入 `results/`：

- `feasibility_surface.csv`：每个 `(T,W)` 点的建立时间裕量、保持时间容量和通过状态。
- `feasibility_summary.csv`：给定 `Th` 时网格上首次通过的周期及对应窗口范围。
- `feasibility_map.svg`：灰色表示 setup 不通过，颜色表示最大共同保持要求。

网格结果受步进大小量化；模型没有施加锁存器最小脉宽限制，所以 L2 透明窗口很窄的通过点属于理想化结果。
