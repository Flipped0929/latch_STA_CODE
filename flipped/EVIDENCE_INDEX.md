# Evidence Index

Every quantitative claim in `REPORT.md`, with the file that contains it and the value to look
for. `data/` and `figures/` are part of this bundle; paths under `build/` refer to the
routed-implementation trees listed in `README.md`.

---

## Experiment 1 — all-latch I/O boundary

| # | Claim | Evidence file | Row / field | Value |
|---|---|---|---|---|
| 1.1 | All-latch variant contains no flip-flops | `data/exp1_all_latch_runs.csv` | `variant = all_latch`, `fd_cells` / `ld_cells` | 0 / 48 (BLOCKS=1), 0 / 64 (BLOCKS=2) |
| 1.2 | FF baseline cell counts | same | `variant = ff` | 32 / 0 |
| 1.3 | Mixed variant cell counts | same | `variant = latch_ff` | 16 / 16 |
| 1.4 | WNS/WHS/WPWS at T=640 | same | `period_ns = 640`, `arise_ns = 40` | 628.243 / 36.902 / 0.000 and 0.027 / 0.316 / 0.029 |
| 1.5 | Per-group setup slack | same | `phase_a_max`, `phase_b_max`, `transaction_clock_max` | 36.902 / 277.762 / 317.970 (latch_ff); 36.059 / 277.425 / 0.000 (all_latch) |
| 1.6 | `WNS = 0.000` is a borrow fixed point | `build/all_latch_b1_T640_r40_w160/paths_max.rpt` | first path block, `Time Borrowing` section | `Time borrowed from endpoint: 1.662ns` |
| 1.7 | Boundary pair costs 0.84 ns on one path | `data/exp1_all_latch_runs.csv` | `phase_a_max` for `latch_ff` vs `all_latch` at T=640 | 36.902 vs 36.059 |
| 1.8 | Borrowing constant across phase sweep | same | `max_borrow_ns`, `arise_ns` 2…40 | 1.662 – 1.820 |
| 1.9 | Core path never borrows at T=640 | same | `phase_b_max` | 277.3 – 315.1 |
| 1.10 | Real Tmin of the three designs | `data/exp1_realtmin_validation.csv` + `data/exp1_all_latch_runs.csv` | WNS at T=10/11/12 | −1.474/−0.474/+0.526 (ff); −1.719/−0.719/0.000 (all_latch) |
| 1.11 | Sweep vs implementation parity | `data/exp1_sweep_ff.csv`, `data/exp1_all_latch_runs.csv` | 40/80/160/320/640 ns | delta 0.000–0.039 ns |
| 1.12 | Hold slack is period-independent | `data/exp1_sweep_latch_ff.csv`, `data/exp1_sweep_all_latch_b1.csv` | `check = min` columns | 0.027 / 0.316 / 0.029 from 640 down to 9 ns |
| 1.13 | Cross-phase hold scales with T | same | `phase_b` min row per period | 199.41 at 640 → 5.66 at 20 |
| 1.14 | Hold failure extrapolates to ≈1.9 ns | `REPORT.md` §2.7 | fit `0.3125·T − 0.59` | T ≈ 1.9 |
| 1.15 | Window gaps never overlap | `REPORT.md` §2.7 | `0.1875·T` / `0.3125·T` | 120 / 200 ns at T=640 |
| 1.16 | SDF annotation succeeded | `build/all_latch_b1_T640_r2_w160/` run log | `XSIM 43-3452` | "SDF backannotation was successful" |
| 1.17 | Gate-level simulation passes | same | end of log | `PASS: all-latch chain BLOCKS=1; checks=259; errors=0` |
| 1.18 | Borrow curve vs phase | `figures/exp1_borrow_vs_phase.png` | — | flat at 1.66–1.82 ns |
| 1.19 | Setup slack vs period | `figures/exp1_wns_vs_period.png`, `exp1_wns_zoom.png` | — | — |
| 1.20 | Hold vs period | `figures/exp1_hold_vs_period.png` | — | flat WHS, rising cross-phase WHS |

## Experiment 2 — borrow arbitration

| # | Claim | Evidence file | Row / field | Value |
|---|---|---|---|---|
| 2.1 | Delay chain survives synthesis | `data/exp2_arb_runs.csv` | `lut` column | 80 / 144 / 256 / 416 = 8×(d1+d2) |
| 2.2 | Chain length visible in STA | `build/lat_T100_A0_4_B4_100_D2_30/paths_max.rpt` | `Logic Levels` | `30 (LUT1=30)` |
| 2.3 | Maximum borrowing 15.9 ns | `data/exp2_arb_runs.csv` | `tag = lat_T100_A0_10_B10_100_D2_50` | `borrow_r2 = 15.9` |
| 2.4 | Borrowing grows with chain length | same | W=10, d2 = 8/16/30/50 | 0 / 5.751 / 7.256 / 15.900 |
| 2.5 | Borrowing falls with window width | same | d2=30, W = 4/8/10/12/16 | 12.823 / 9.164 / 7.256 / 5.511 / 0.138 |
| 2.6 | Borrowing independent of period | same | W=10, T = 20/60/100 | 7.182 / 7.256 / 7.256 |
| 2.7 | Borrowing law | same | `borrow_r2`, `borrow_r2_data`, `pa_fall` | `borrow + W − d2 = 2.75 ± 0.2` |
| 2.8 | Law collapses 20 runs onto one line | `figures/exp2_borrow_law.png` | — | points on `y = x + 2.75` |
| 2.9 | Single-edge FF Tmin ≈22.9 ns | `data/exp2_arb_runs.csv` | `ff1`, T=25 / T=40 | WNS +2.095 / +15.786 |
| 2.10 | Two-phase FF requirement is T/2 | `build/ff2_T32_A16_32_B0_16_D2_30/paths_max.rpt` | `Requirement:` | 16.000 ns at T = 32 |
| 2.11 | Two-phase FF Tmin ≈30.8 ns | same | WNS at T=32 / T=40 | +0.605 / +1.292 |
| 2.12 | Latch Tmin ≈17.4 ns | same | `lat` T=18 / T=17 | +0.897 / −0.647 |
| 2.13 | Normalised period model | `REPORT.md` §3.4 | D = chain delay | ff1 D+0.23; ff2 2D+1.0; lat D+3.9 |
| 2.14 | Latch latency is one cycle lower | `REPORT.md` §3.4 | structural + Exp. 1 TB contracts | 2 vs 3 cycles |
| 2.15 | Model's 37 % claim reproduced vs two-phase FF | `REPORT.md` §3.5 | 17.4 vs 30.8 | 43 % faster |
| 2.16 | Sign flips vs single-edge FF | `REPORT.md` §3.5 | 17.4 vs ≈13.7 | 27 % slower |
| 2.17 | Router variation of the same chain | `data/exp2_arb_runs.csv` | `borrow_r2_data` across tags | 13.487 – 25.740 ns |

## Negative / retracted claims (keep visible)

| # | Claim | Status | Where |
|---|---|---|---|
| N.1 | "All-latch is 13.7 % slower (Tmin 13.50 ns)" | **retracted** — method artifact of STA re-constraint | `REPORT.md` §2.6 |
| N.2 | "Core borrow can be characterised on the 8-bit 2-stage circuit" | **not possible** — 1.7 ns logic vs 160 ns window | `REPORT.md` §2.5 |
| N.3 | "Borrowing cascades with BLOCKS" | **not demonstrated** — 1 block vs 4 blocks differ by 0.07 ns | `REPORT.md` §2.5 |
| N.4 | "SDF simulation verifies hold" | **not possible** — TIMINGCHECK filtered out | `REPORT.md` §2.8 |

---

## How to regenerate the data files

| File | Produced by |
|---|---|
| `data/exp1_all_latch_runs.csv` | `scripts/collect.py` (scans every `build/<tag>/`) |
| `data/exp1_realtmin_validation.csv` | the four T = 10/11/12 implementations (`run_real_tmin.py`) |
| `data/exp1_inter_clock.csv` | `scripts/collect.py` |
| `data/exp1_sweep_*.csv` | `scripts/sta_sweep.tcl` via `scripts/run_sweep.py` |
| `data/exp2_arb_runs.csv`, `data/exp2_arb_paths.csv` | `scripts/analyze_arb.py` |
| `figures/*` | `scripts/make_figures.py` (Exp. 1) and the plotting block in `REPORT.md` §3.3 (Exp. 2) |
