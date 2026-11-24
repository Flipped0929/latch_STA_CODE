# Presentation Guide

How to show this work in Vivado, what to export, and what to say.

---

## 1. Five-minute demo path

Open Vivado in GUI mode (not batch). For each item below use
`File → Open Checkpoint…` and pick the `.dcp` listed.

| Step | Checkpoint | What to look at | What it proves |
|---|---|---|---|
| 1 | `…\all_latch_work\build\all_latch_b1_T640_r40_w160\routed.dcp` | `Reports → Utilization`: `Register as Latch = 48`, `Register as Flip Flop = 0`; primitive table `LDCE 48 / FDCE 0` | the fully latched design really contains no flip-flops |
| 2 | same | `Reports → Timing → Report Timing Summary`: `WNS 0.000`, `WHS 0.029`, 0 failing endpoints, then the **Inter Clock Table** (three rows) | timing closure with the three clocks related (no async groups) |
| 3 | same | `Reports → Timing → Report Timing`, Group `transaction_clock`, Delay type `max`: scroll to `Time Borrowing` | `Time borrowed from endpoint 1.662 ns` — the only place borrowing is visible |
| 4 | `…\all_latch_work\build\ff_b1_T640_r40_w160\routed.dcp` | same two reports | FDCE 32; worst path is the **output I/O** path — a different interface |
| 5 | `…\all_latch_work\build\latch_ff_b1_T640_r40_w160\routed.dcp` | same | FDCE 16 + LDCE 16; worst path is **input → first latch** |
| 6 | `…\_borrow_arb_runs\build\lat_T100_A0_4_B4_100_D2_30\routed.dcp` | `Report Timing`, Group `phase_b`, first path | `Source: r1_reg[*]/D → r2_reg[*]/D`, `Logic Levels: 30 (LUT1=30)`, **borrow 12.823 ns** |
| 7 | `…\_borrow_arb_runs\build\lat_T100_A0_10_B10_100_D2_50\routed.dcp` | same | **borrow 15.9 ns** |
| 8 | `…\_borrow_arb_runs\build\ff2_T32_A16_32_B0_16_D2_30\routed.dcp` | `Report Timing Summary`, group `phase_b` | `Requirement: 16.000 ns` at T = 32 → **half a period per stage**: the assumption the theory makes |
| 9 | `…\_borrow_arb_runs\build\lat_T18_A0_9_B9_18_D2_30\routed.dcp` vs `lat_T17_A0_8.5_B8.5_17_D2_30` | `transaction_clock` group | +0.897 vs −0.647 → latch Tmin bracket 17.4 ns |

Batch builds are stored outside the repository (see `README.md` §4):

```
C:\…\20261108\07_vivado_lab\all_latch_work\build\<tag>\      (Experiment 1)
D:\FDU\FDUROP\_borrow_arb_runs\build\<tag>\                  (Experiment 2)
```

Handy Tcl (paste in the GUI console):

```tcl
open_checkpoint {D:/FDU/FDUROP/_borrow_arb_runs/build/lat_T100_A0_4_B4_100_D2_30/routed.dcp}
report_timing -group phase_b -delay_type max -max_paths 3
report_utilization
get_cells -hier -filter {REF_NAME =~ LUT*}        ;# expect 256
get_cells -hier -filter {REF_NAME =~ LD*}         ;# latches
```

---

## 2. Screenshots to take (9 total)

| ID | Subject | Caption to write on the slide |
|---|---|---|
| S1 | Utilization of `all_latch` | "fully latched: 48 LDCE, 0 FDCE" |
| S2 | Design Timing Summary of `all_latch` | "WNS 0.000 is a borrowing fixed point, not a tight design" |
| S3 | Inter Clock Table of `all_latch` | "three clocks, fully related" |
| S4 | `Time Borrowing` block | "borrowed 1.662 ns at the output latch" |
| S5 | Utilization of `ff` | "baseline: 32 FDCE" |
| S6 | Worst path of `ff` | "the baseline's critical path is output I/O" |
| S7 | 30-LUT chain path in `lat` | "30 logic levels, borrow 12.8 ns" |
| S8 | `ff2` requirement = 16 ns at T = 32 | "the theory's FF baseline gets only half a period" |
| S9 | Device view of `all_latch` | "real placed and routed design" |

Every screenshot should carry: device `xc7a35tcpg236-1`, Vivado 2026.1,
period / phases, and the words **"post-route STA, not silicon"**.

---

## 3. What to export / upload

| # | Item | Source in this bundle | Format |
|---|---|---|---|
| 1 | This report | `REPORT.md` | PDF (export from any Markdown editor) |
| 2 | Evidence map | `EVIDENCE_INDEX.md` | PDF or appendix |
| 3 | Figures | `figures/*.png` (7 files) | PNG, 150 dpi |
| 4 | Raw result tables | `data/exp1_all_latch_runs.csv` (38 rows), `data/exp2_arb_runs.csv` (24 rows) | CSV / XLSX |
| 5 | Validity cross-check | `data/exp1_realtmin_validation.csv` | CSV |
| 6 | Screenshots | S1–S9 | PNG |
| 7 | Reproduction kit | `rtl/`, `sim/`, `scripts/`, case CSVs | source tree |
| 8 | (optional) waveforms | `waves/*.wdb` | open with `xsim --gui` then `open_wave_database <file>` |

Do **not** upload: `routed.dcp` (62 files, ~11 MB), `funcsim.v` / `timesim.v`, `routed.sdf`,
`.Xil/`, `xsim.dir/`, or the full `*.rpt` set (60 MB). Keep three report files per demo case
(`timing_summary.rpt`, `paths_max.rpt`, `utilization.rpt`) if the reviewer asks for raw output.

---

## 4. Three-minute script

> **What I did.** I took an 8-bit two-stage pipeline on an Artix-7 `xc7a35tcpg236-1` and replaced
> every storage element — including the I/O boundary — with level-sensitive latches, using `LDCE`
> primitives so that Vivado cannot turn the master–slave pair back into a flip-flop.
> The result has **zero FDCE and 48 LDCE**, and it passes 259 functional checks in RTL, in the
> post-route netlist, and in gate-level timing simulation.
>
> **What it did not buy.** Frequency. Measured with full place-and-route, the minimum period is
> **11.47 ns for the all-FF baseline, 11.66 ns for a latch core with FF boundary, and 11.7–12.0 ns
> for the fully latched design** — a tie inside routing noise. The reason is that 60 % of the period
> is I/O delay and clock-tree insertion, and the core path keeps 277 ns of margin at 640 ns, so
> borrowing never happens: the 1.66–1.82 ns that the tool reports is all at the I/O latches.
>
> **So I built a circuit where borrowing actually happens.** Two latch stages with a 30-level LUT
> delay chain in between. Twenty implementations collapse onto one line:
> **borrow = chain delay + 2.75 ns − window**, independent of the clock period, with a maximum
> measured borrow of **15.9 ns** — 4.5× anything measured in this project before.
>
> **Then I arbitrated the theory.** The team's two-latch model predicts latches are 37–60 % faster.
> It is right — **if the flip-flop baseline is a two-phase pipeline**, where each stage gets only
> half a period; I reproduced that (17.4 vs 30.8 ns, 43 %). But against a conventional single-edge
> FF pipeline the latch is **27 % slower**, because it has to pay d1 plus the clock-tree insertion.
> What the latch does win is **one cycle of latency** (2 vs 3), i.e. about a third.
>
> **Bottom line.** All-latch is implementable and functionally correct; it is not a frequency
> technique on this device; and any claim that "latches are faster" must state which FF baseline it
> is compared against.

---

## 5. Questions you should expect

| Question | Answer | Backing |
|---|---|---|
| "Your WNS is 0.000 — isn't that a failing design?" | No. For a latch endpoint Vivado reports the lateness as `time borrowed` and pins slack to 0 once the borrow fits the window. The pass criterion is `WNS < 0`; use `Time borrowed` and `Computed max time borrow`. | REPORT §2.3, S4 |
| "Why is the all-latch design not faster?" | 60 % of the period is I/O and clock insertion; the core has 277 ns of margin at 640 ns, so borrowing is never used. | REPORT §2.2, §2.5 |
| "How do you know the delay chain was not optimised away?" | LUT count = 8 × (d1 + d2) (80/144/256/416) and the critical path reports `Logic Levels: 30 (LUT1=30)`. | REPORT §3.2, `data/exp2_arb_runs.csv` |
| "Is 15.9 ns of borrowing credible?" | It is consistent with `borrow = chain + 2.75 − W` across 12 independent runs; the window and the tool's own `Computed max time borrow` agree. | REPORT §3.3, `exp2_borrow_law.png` |
| "So are latches slower?" | Compared with a single-edge FF: yes on frequency (about 27 % here), no on latency (2 vs 3 cycles). Compared with a two-phase FF: yes, much faster. | REPORT §3.4–3.5 |
| "Why did your earlier report say 13.7 % slower?" | That number came from re-constraining a netlist routed for 640 ns; it over-estimates small-period Tmin by 1.5–2 ns. I re-implemented at 10/11/12 ns and retracted it. | REPORT §2.6 |
| "Can the SDF simulation prove hold?" | No. XSim cannot annotate the latch setup/hold arcs, so those checks were filtered; hold comes from STA only. | REPORT §2.8 |
| "Why do the three variants have different chain delays?" | The router trades route length against the constraint; the same 30-level chain measured 13.5–25.7 ns. That is why the comparison is normalised by measured chain delay; pinning placement (Pblock) is the next step. | REPORT §4.5 |
| "Does all-latch save area?" | Not on FPGA — LDCE and FDCE share the same slice registers (48 vs 32 here, i.e. more, because of the boundary pair). It can save area in ASIC. | REPORT §2.2 |
| "Can these absolute numbers be compared with the ASIC/PDS line?" | No. Only trends; the libraries and clock trees are different. | REPORT §5 |

---

## 6. If you only have one slide

> **Fully latched I/O boundary: implementable (0 FDCE, 48 LDCE, 259/259/259 checks), but no
> frequency gain (11.5–12.0 ns, tie) because the design is I/O- and clock-bound.**
>
> **Borrowing law measured on 24 implementations: `borrow = chain delay + 2.75 ns − window`,
> up to 15.9 ns, independent of the period.**
>
> **Theory arbitration: the "latches are 37–60 % faster" result requires a two-phase FF baseline;
> against a single-edge FF the latch is 27 % slower but one cycle lower in latency.**
