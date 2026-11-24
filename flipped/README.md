# All-Latch Timing Study — Submission Bundle

Self-contained upload package for two experiments on an Artix-7 FPGA:

1. **All-latch I/O boundary** — replacing every flip-flop, including the I/O boundary, with
   latch pairs: is it implementable, and is it faster?
2. **Borrow arbitration** — a purpose-built circuit in which core time borrowing actually
   happens, used to arbitrate a theoretical model that claims latches are 37–60 % faster.

**Headline results**

| Question | Answer |
|---|---|
| Is the all-latch design implementable? | Yes — `FDCE = 0`, `LDCE = 48`, 259 functional checks pass in RTL, post-route netlist and SDF simulation |
| Is it faster? | No — Tmin 11.47 / 11.66 / 11.7–12.0 ns for all-FF / latch-core-FF-boundary / all-latch; a tie inside routing noise |
| Why not? | 60 % of the period is I/O + clock insertion, and the core never borrows (1.7 ns of logic against a 160 ns window) |
| Can borrowing be measured? | Yes — `borrow = chain delay + 2.75 ns − window`, up to **15.9 ns**, independent of the clock period |
| Is the "latches are faster" claim true? | Only against a **two-phase FF** baseline; against a single-edge FF the latch is 27 % slower but one cycle lower in latency |

---

## 1. Contents

```text
submission_en/
├─ README.md                  this file
├─ REPORT.md                  full technical report (both experiments)
├─ EVIDENCE_INDEX.md          every claim → file → value
├─ PRESENTATION_GUIDE.md      Vivado demo path, screenshots, exports, 3-min script, Q&A
├─ data/                      13 machine-readable result tables
├─ figures/                   7 figures (PNG, 150 dpi)
├─ rtl/                       9 RTL sources (both experiments)
├─ sim/                       3 testbenches
├─ scripts/                   25 Vivado / XSim / Python automation scripts
└─ waves/                     2 XSim waveform databases (optional)
```

`MANIFEST.txt` lists every file with its byte size.

### data/

| File | Rows | Content |
|---|---:|---|
| `exp1_all_latch_runs.csv` | 38 | Experiment 1 master table: parameters, cell counts, WNS/TNS/WHS/THS/WPWS, per-group slack, borrow, worst hold path |
| `exp1_realtmin_validation.csv` | 30 | per-clock-group slack at T = 10/11/12 ns (the re-implementation used to correct the Tmin estimate) |
| `exp1_inter_clock.csv` | 116 | inter-clock slack table of every Experiment 1 run |
| `exp1_sweep_ff.csv`, `exp1_sweep_latch_ff.csv`, `exp1_sweep_all_latch_b1.csv`, `exp1_sweep_all_latch_b2.csv` | 57 each | fine STA re-constraint sweeps, 9–16 ns at 0.125 ns steps (design WNS/WHS/WPWS) |
| `exp1_sweep_*_coarse.csv` | 38 each | the same sweeps over the full range, 2–640 ns |
| `exp2_arb_runs.csv` | 24 | Experiment 2 master table: variant, period, window, chain length, LUT count, WNS/WHS, borrow on the `r1 → r2` path |
| `exp2_arb_paths.csv` | 960 | every parsed timing path of Experiment 2 |

### figures/

| File | Shows |
|---|---|
| `exp1_borrow_vs_phase.png` | borrowing versus phase-a opening (flat: 1.66–1.82 ns) |
| `exp1_wns_vs_period.png` | setup slack versus period, four topologies |
| `exp1_wns_zoom.png` | Tmin region, 0.125 ns sweep step |
| `exp1_hold_vs_period.png` | hold slack versus period (flat) and cross-phase hold (linear in T) |
| `exp2_borrow_law.png` | **20 implementations collapsing onto one line** |
| `exp2_borrow_vs_d2.png` | borrowing versus chain length |
| `exp2_borrow_vs_window.png` | borrowing versus window width |

### rtl/ and sim/

| File | Role |
|---|---|
| `datapath_compare.v` | 8-bit two-stage datapath, FF version and latch version |
| `timing_boundaries.v`, `ff_timing_top.v`, `latch_timing_top.v` | Experiment 1 baseline variants |
| `latch_boundary_pair.v` | **master–slave latch boundary built from `LDCE` primitives** (behavioural branch for RTL simulation) |
| `latch_chain_top.sv`, `latch_chain_wrappers.v` | parameterised `BLOCKS` all-latch chain + fixed wrappers |
| `delay_chain.v` | parameterised LUT delay chain (`keep` + `dont_touch` on every stage) |
| `arb_tops.v` | the three arbitration variants: `arb_ff1`, `arb_ff2`, `arb_latch` |
| `tb_latch_chain.sv`, `tb_latch_vivado.sv`, `tb_ff_vivado.sv` | 259-check testbenches |

### scripts/

| Script | Purpose |
|---|---|
| `run_case.tcl` | Experiment 1 single implementation (synth → opt → place → route → reports → SDF) |
| `run_matrix.py` | parallel batch driver for Experiment 1 |
| `sta_sweep.tcl`, `run_sweep.py` | STA re-constraint period sweep on a routed checkpoint |
| `analyze_sweep.py`, `find_tmin.py` | Tmin extraction and sweep-vs-implementation cross-check |
| `collect.py`, `make_figures.py`, `make_report.py` | report parsing, figures, markdown tables |
| `run_sim.py`, `filter_sdf.py`, `write_timesim.tcl` | RTL / post-route / SDF simulation, including the SDF filtering recipe |
| `arb_case.tcl`, `run_arb.py`, `analyze_arb.py`, `probe_synth.tcl` | Experiment 2 flow |
| `parse_reports.py`, `phase_sweep.py`, `sta_phase_sweep.tcl`, `run_phase_cases.py`, `run_real_tmin.py`, `probe_*.tcl`, `write_timesim_all.py`, `analyze.py` | helper and diagnostic scripts kept for reproducibility |

---

## 2. Environment

| Item | Value |
|---|---|
| Device | `xc7a35tcpg236-1` (Artix-7, -1 speed grade) |
| Tools | Vivado / XSim 2026.1 (win64), Basic license |
| Host OS | Windows 11 (PowerShell 5.1, Python 3.12) |

---

## 3. How to read this bundle

1. Start with `REPORT.md` — it is the complete technical document.
2. `EVIDENCE_INDEX.md` maps every number to a file and a field.
3. `PRESENTATION_GUIDE.md` gives the Vivado click-path, the screenshot list, the export list
   and a three-minute script.
4. The raw tables in `data/` reproduce every table in the report.

---

## 4. What is *not* in this bundle

The 62 routed implementations (`routed.dcp`, `timing_summary.rpt`, `paths_max.rpt`,
`paths_min.rpt`, `utilization.rpt`, `routed.sdf`, `funcsim.v`, `timesim.v`) are about 90 MB and
are kept on the building machine:

```text
D:\FDU\FDUROP\20261108\07_vivado_lab\all_latch_work\build\<tag>\      Experiment 1, 38 cases
D:\FDU\FDUROP\_borrow_arb_runs\build\<tag>\                           Experiment 2, 24 cases
```

They can be regenerated with the scripts in `scripts/` and the case files (see `REPORT.md` §6),
or copied into this bundle if the reviewer asks for the raw reports. Build tags follow
`<variant>_b<blocks>_T<period>_r<arise>_w<width>` (Experiment 1) and
`<variant>_T<period>_A<a_rise>_<a_fall>_B<b_rise>_<b_fall>_D<d1>_<d2>` (Experiment 2).

---

## 5. Known limitations (also stated in the report)

1. `datapath_compare.v` is reconstructed from the documented contract; the original RTL is not
   available. The contract is verified by 259 functional checks.
2. Experiment 1's circuit is too shallow to exercise core borrowing; this is a scope limit of
   the test vehicle, stated explicitly.
3. The three Experiment 2 variants were not routed with equal chain delay, so only the
   normalised comparison (Tmin versus measured chain delay) is fair; the raw ordering is not.
4. No on-board (silicon) measurement. The highest evidence level reached is post-route STA plus
   a **restricted** SDF simulation (delays annotated, no setup/hold checks).
5. Absolute times are valid for this device and library only.

---

## 6. Provenance

| Item | Where it came from |
|---|---|
| Test vehicle, constraints, testbenches | team repository `latch_STA_integrated`, `07_vivado_lab/smoke` |
| Theoretical model being arbitrated | team repository, `theory/two-latch-timing-model` (`model.py`) |
| All measurements, figures and scripts in this bundle | produced by this work, 2026-11-19 … 2026-11-24 |
