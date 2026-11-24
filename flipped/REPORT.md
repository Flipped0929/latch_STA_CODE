# All-Latch Timing Study on Artix-7 — Technical Report

**Device** `xc7a35tcpg236-1` (Artix-7, -1 speed grade)
**Tools** Vivado / XSim 2026.1 (win64), Basic license
**Artifacts** 62 fully placed and routed implementations, 5 gate-level (SDF) simulations,
6 RTL simulations, 4 STA re-constraint sweeps

---

## Abstract

Two experiments are reported.

**Experiment 1** replaces the I/O boundary flip-flops of an 8-bit two-stage pipeline
with master–slave latch pairs, so that the whole design contains zero edge-triggered
registers. It is functionally correct, but it brings **no frequency benefit**: measured
minimum period (Tmin) is 11.47 ns for the all-FF baseline, 11.66 ns for "latch core with FF
boundary", and 11.7–12.0 ns for the fully latched design. The design is I/O- and
clock-insertion-bound, and time borrowing never occurs in the core
(the reported 1.66–1.82 ns is entirely at the I/O latches, against a 160 ns window).

**Experiment 2** builds a circuit in which core borrowing actually happens: a parameterised
LUT delay chain between two latch stages. On 24 implementations it yields a quantitative
borrowing law, `borrow = d2_delay + 2.75 ns − W` (independent of the clock period), with a
maximum measured borrow of **15.9 ns**. It then arbitrates a published theoretical model
that claims latches are 37–60 % faster: that claim holds **only if the flip-flop baseline is
a two-phase FF pipeline**. Against a conventional single-edge FF pipeline the latch design is
**27 % slower in frequency but one cycle lower in latency**.

---

## 1. Scope and evidence levels

| Level | Meaning | Reached |
|---|---|---|
| V-E1 | on-board measurement | no (no board) |
| V-E2 | post-route gate-level timing simulation (SDF) | yes, **restricted** (no `$setup`/`$hold` checks, see §5.4) |
| V-E3 | post-route static timing analysis | yes, 62 implementations |
| V-E4 | post-route functional simulation | yes |
| V-E5 | RTL simulation / models | yes |

Nothing in this report is silicon measurement. Absolute timings are valid only for this
device, speed grade and library.

---

## 2. Experiment 1 — all-latch I/O boundary

### 2.1 Variants

| Variant | Storage | Top module | Note |
|---|---|---|---|
| `ff` | 32 × FDCE | `ff_timing_top` | baseline: FF core + FF boundary |
| `latch_ff` | 16 FDCE + 16 LDCE | `latch_timing_top` | latch core + FF boundary |
| `all_latch` | 48 LDCE (BLOCKS=1) | `latch_chain_top_1` | latch core + latch-pair boundary |

The boundary is `latch_boundary_pair`: a master latch transparent while the reference clock
is low and a slave transparent while it is high — edge-equivalent sampling with no FDCE.
It is instantiated as `LDCE` primitives under `` `define USE_LDCE_PRIMITIVES ``; without
that, Vivado re-maps the pair to an edge-triggered `FDCE` and "all-latch" is lost.

Constraints: `transaction_clock` 640 ns {0, 320}, `phase_a` {40, 200}, `phase_b` {320, 480},
clock uncertainty 0.2 ns, I/O delay max 2.0 / min 0.2 ns, `IOB FALSE`.

### 2.2 Resource and timing result (T = 640 ns)

| Variant | FDCE | LDCE | LUT | WNS | WHS | WPWS | Worst setup path |
|---|---:|---:|---:|---:|---:|---:|---|
| `ff` | 32 | 0 | 9 | 628.243 | 0.027 | 319.5 | `result_reg[5]/C → result[5]`, req = T (output I/O) |
| `latch_ff` | 16 | 16 | 14 | 36.902 | 0.316 | 319.5 | `core_input_reg[2]/C → stage_one_reg[7]/D`, req = 40 |
| `all_latch` b1 | **0** | **48** | 14 | **0.000** | 0.029 | 319.5 | `stage_two_reg[1]/G → u_out/…/u_master/D`, req = 0, borrow 1.662 |
| `all_latch` b2 | 0 | 64 | 28 | 0.000 | 0.038 | 319.5 | same, borrow 1.820 |

Per path group (only same-group numbers are comparable):

| Variant | WNS phase_a | WNS phase_b | WNS transaction_clock |
|---|---:|---:|---:|
| `ff` | — | — | 628.243 |
| `latch_ff` | 36.902 | 277.762 | 317.970 |
| `all_latch` b1 | 36.059 | 277.425 | **0.000** |

**`FDCE = 0` and `LDCE = 48` (16 core + 32 boundary) match the design intent exactly**;
`utilization.rpt` independently shows `Register as Latch = 48`, `Register as Flip Flop = 0`.

### 2.3 `WNS = 0.000` is a borrowing fixed point, not a tight design

```text
Slack (MET) : 0.000ns
  Source:      stage_two_reg[3]/G        (level-sensitive latch, phase_b)
  Destination: u_out/g_bit[3].u_master/D (level-sensitive latch, transaction_clock)
  Requirement: 0.000ns  (transaction_clock fall@320 - phase_b rise@320)
  Time Borrowing:
    Nominal pulse width:          320.000ns
    Computed max time borrow:     319.933ns
    Time borrowed from endpoint:    1.662ns
    Time given to startpoint:       1.427ns
```

For a latch destination Vivado adds the lateness back as `time borrowed`, so the slack is
pinned to 0 whenever the borrow fits the window. Consequences:

- such paths can only report 0 or a negative number;
- `WNS = 0.000` means "borrowing is active and approved", not "no margin";
- a pass/fail decision must use `WNS < 0`, and the global WNS of the three variants
  (628 / 36.9 / 0.0) must never be compared with each other — they sit on three different
  interfaces (output I/O, input-to-latch, latch borrow).

### 2.4 The cost of the latch boundary on one identical path

| Variant | Boundary | Slack | Data path | Delta |
|---|---|---:|---:|---:|
| `latch_ff` | single FDCE | 36.902 | 2.478 | baseline |
| `all_latch` | master–slave LDCE pair | 36.059 | ~3.32 | **−0.84 ns** |

The same input path (requirement 40 ns in both cases) is 0.84 ns slower through the latch
pair: one extra clock-to-Q plus one extra route.

### 2.5 Phase sweep (E2): borrowing is constant and lives at the I/O boundary

`arise` (phase_a opening) swept 2…40 ns with a fixed 160 ns window, at T = 640 ns.

| BLOCKS | arise | max borrow | WNS phase_a | WNS phase_b |
|---:|---:|---:|---:|---:|
| 1 | 2 | 1.751 | 0.000 | 314.188 |
| 1 | 10 | 1.685 | 6.708 | 307.510 |
| 1 | 40 | 1.662 | 36.059 | 277.425 |
| 2 | 2 | 1.757 | 0.000 | 314.982 |
| 2 | 40 | 1.820 | 36.024 | 277.302 |
| 4 | 2 | 1.757 | 0.000 | 315.053 |
| 4 | 22 | 1.757 | 18.345 | 295.238 |

Three observations:

1. `Time borrowed from endpoint` stays at **1.66–1.82 ns** across the whole sweep — it is set
   by the routed delay from `stage_two_reg/G` to the output master, not by the phase.
2. What does vary linearly is the `phase_a` group: `WNS ≈ arise − 3.9 ns`; below `arise ≈ 4 ns`
   that path switches to borrowing and its slack becomes 0.
3. The core path `phase_a → phase_b` keeps 277–315 ns of margin: **1.7 ns of logic against a
   160–280 ns window, so core borrowing never happens.** The 1/2/4-block results differ by
   0.07 ns, i.e. routing noise — this circuit cannot demonstrate borrow cascading.

### 2.6 Minimum period: a measurement-method correction

Two methods were used:

| Method | What it does | Cost |
|---|---|---|
| A. re-implement | full synth → opt → place → route per period | ~75 s per point, 10× slower when timing fails |
| B. STA re-constraint | open the 640 ns `routed.dcp`, override `create_clock`, re-report | < 0.5 s per point, exact for the *same* netlist |

Method B is exact while the netlist is unchanged (ff: measured = swept within 0.039 ns at
40/80/160/320/640 ns), but it is **pessimistic at small periods** because a netlist routed
for 640 ns does not represent what a router does under a 12 ns constraint.

Real implementations (each with its own place & route):

| Design | T = 10 | T = 11 | T = 12 | Tmin |
|---|---:|---:|---:|---:|
| `ff` | −1.474 | −0.474 | +0.526 | **≈11.47 ns** |
| `latch_ff` | −1.624 | −0.624 | +0.323 | **≈11.66 ns** |
| `all_latch` b1 | −1.719 | −0.719 | 0.000 (borrow, MET) | **≈11.7–12.0 ns** |

At T = 12 ns all four designs pass; at T = 11 ns all fail, and the failing group is
`transaction_clock` (I/O and boundary) in every case — `phase_a` is at 0.000 (borrow, MET)
and `phase_b` still has 0.6–1.1 ns. **The differences (≤0.5 ns) are inside routing noise:
the honest statement is "no significant difference", not "latches are 13.7 % slower".**

> Correction: an earlier version of this work reported `all_latch` Tmin = 13.50 ns
> (13.7 % slower) from method B. Re-measurement by full implementation showed that figure
> was a method artifact; it is retracted. Method B over-estimates small-period Tmin by
> 1.5–2 ns.

### 2.7 Hold analysis

Worst hold path at T = 640 ns:

| Variant | Path | Group | Req | Data | WHS | Failing endpoints |
|---|---|---|---:|---:|---:|---:|
| `ff` | `stage_two_reg[7]/C → result_reg[7]/D` | transaction_clock | 0 | 0.308 | 0.027 | 0 |
| `latch_ff` | `data_in[6] → core_input_reg[6]/D` | transaction_clock | 0 | 2.384 | 0.316 | 0 |
| `all_latch` b1 | `u_in/g_bit[1].u_master/G → u_slave/D` | transaction_clock | 0 | 0.311 | 0.029 | 0 |
| `all_latch` b2 | `u_out/g_bit[0].u_master/G → u_slave/D` | transaction_clock | 0 | 0.324 | 0.038 | 0 |

Two different laws apply:

1. **Same-edge short paths do not scale with the period.** Their requirement is 0 and their
   data delay is fixed, so WHS stays at 0.027 / 0.316 / 0.029 ns from T = 640 down to T = 10.
   An FF design therefore has no "hold problem at low frequency".
2. **Cross-phase latch paths scale linearly**: the `phase_a→phase_b` group follows
   `WHS ≈ 0.3125·T − 0.59` and the `transaction_clock→phase_a` group `≈ 0.6875·T − 0.343`.
   Extrapolated, they fail at T ≈ 1.9 ns and ≈ 0.5 ns — far below the setup boundary of
   11.5–12 ns. **Hold is not the binding constraint in this design.**

The absolute WHS values (27–45 ps) are an artifact of `set_input_delay -min 0.2`; they are
not design margin.

The two-phase windows never overlap under proportional scaling: the gap from `phase_a` close
to `phase_b` open is `0.1875·T` (120 ns at T = 640) and from `phase_b` close to the next
`phase_a` open is `0.3125·T` (200 ns). No race is possible.

### 2.8 Functional and gate-level verification

| Variant | RTL | Post-route functional | SDF max | SDF min |
|---|---|---|---|---|
| `ff` | PASS 259 | — | PASS 259 | — |
| `latch_ff` | PASS 259 | — | — | — |
| `all_latch` b1 | PASS 259 | PASS 259 | PASS 259 | PASS 259 |
| `all_latch` b2 | PASS 259 | — | — | — |
| `all_latch` b4 | PASS 259 | — | — | — |

Checks: 256 transactions (`result === f^BLOCKS(v[n−BLOCKS−1])`), asynchronous reset,
recovery after reset.

**SDF caveat (important).** XSim cannot annotate the LDCE/FDCE setup/hold arcs. The working
recipe required four fixes: a `timesim` netlist (`write_verilog -mode timesim`), filtering
`TIMINGCHECK` / `CLR→Q` / `PATHPULSE` out of the SDF, quoting the `-sdfmax "root=file"`
argument (the Vivado `.bat` wrapper splits unquoted `=`), and moving the testbench sampling
point later than the clock-tree insertion delay (1.9–4.7 ns). The result is a real
delay-annotated simulation, but it contains **no `$setup`/`$hold` checks** — hold evidence
comes from STA only.

---

## 3. Experiment 2 — borrow arbitration

### 3.1 Motivation

Experiment 1 showed that the all-latch design is functionally correct but not faster,
because its period is dominated by I/O and clock insertion and because borrow never occurs
in the core.

A published theoretical model in the team (`two-latch timing model`) predicts the opposite:
with d1 = 2 ns and d2 = 8 ns it gives **latch 10.30 ns vs FF 16.40 ns (37 % faster)**.
The model is self-consistent, but its FF baseline is a *two-phase* FF pipeline:

```python
phase = period / 2 + phase_shift
ff2_setup_slack = period - setup2 - (phase + tcq_ff + d2)   # only half a period per stage
```

A conventional single-edge FF pipeline gives every stage a full period. **This assumption had
never been measured.** Experiment 2 measures it.

### 3.2 Circuit

```text
data_in -> B_in(FF) -> [d1 LUT chain] -> R1 -> [d2 LUT chain] -> R2 -> B_out(FF) -> result
```

| Variant | Middle two stages | Time per stage |
|---|---|---|
| `ff1` | all on `posedge clk_reference` | T |
| `ff2` | R1 on `posedge phase_a` (T/2), R2 on `posedge phase_b` (0/T) | T/2 |
| `lat` | R1 transparent while `phase_a` high (0…W), R2 while `phase_b` high (W…T) | T (borrowing) |

All three share the same FF boundary, so the only variable is the register architecture.

Delay chain: one `LUT1 INIT=2'b10` buffer per bit per stage, `(* keep *)` on the nets and
`(* dont_touch *)` on the instances. **Verification: LUT count = 8 × (d1 + d2)**
(80 / 144 / 256 / 416 for d2 = 8 / 16 / 30 / 50) and the critical path reports
`Logic Levels: 30 (LUT1=30)`. Without the attributes synthesis collapses the chain into a
single LUT and the experiment measures nothing.

### 3.3 Borrowing law (20 implementations, ±0.2 ns)

```text
borrow = d2_delay + 2.75 ns − W          (independent of the clock period)
```

| Sweep | Setting | d2 delay | W | borrow | borrow + W − d2 |
|---|---|---:|---:|---:|---:|
| d2 | T=100, W=10, d2=16 | 12.768 | 10 | 5.751 | 2.983 |
| d2 | T=100, W=10, d2=30 | 14.488 | 10 | 7.256 | 2.768 |
| d2 | T=100, W=10, d2=50 | 23.148 | 10 | **15.900** | 2.752 |
| W | T=100, d2=30, W=4 | 14.058 | 4 | **12.823** | 2.765 |
| W | T=100, d2=30, W=8 | 14.228 | 8 | 9.164 | 2.936 |
| W | T=100, d2=30, W=12 | 14.745 | 12 | 5.511 | 2.766 |
| W | T=100, d2=30, W=16 | 13.684 | 16 | 0.138 | 2.454 |
| T | T=20, W=10 | 14.201 | 10 | 7.182 | 2.981 |
| T | T=60, W=10 | 14.488 | 10 | 7.256 | 2.768 |
| T | T=100, W=10 | 14.488 | 10 | 7.256 | 2.768 |

Findings:

1. Borrowing depends only on "chain delay minus window"; **the period is irrelevant**
   (T = 20, 60 and 100 ns at W = 10 all give 7.18–7.26 ns).
2. The constant 2.75 ns is the fixed launch overhead (d1 + clock-insertion difference + tcq).
3. Borrowing is 0 once `W ≥ d2 + 2.75`.
4. **Maximum measured borrow 15.9 ns** — 4.5× the previous project maximum of 3.5 ns — and it
   occurs at the **second core latch**, not at an I/O boundary.

### 3.4 Three-variant minimum period

| Variant | Passing points | Failing point | Tmin | Chain delay in that run | Normalised (D = chain delay) | Latency |
|---|---:|---:|---:|---:|---|---|
| `ff1` | T=25 → +2.095; T=40 → +15.786 | — | **≈22.9 ns** | 22.672 | Tmin = D + 0.23 | 3 cycles |
| `ff2` | T=32 → +0.605; T=40 → +1.292 | — | **≈30.8 ns** | 14.878 | Tmin = 2D + 1.0 | 3 cycles |
| `lat` | T=18 → +0.897 | T=17 → −0.647 | **≈17.4 ns** | 13.5 | Tmin = **D + 3.9** | **2 cycles** |

Derivation: `ff1` has requirement T, so Tmin = T − slack; `ff2` has requirement T/2, so
Tmin = 2(T/2 − slack); `lat`'s slack is pinned to 0 by borrowing, so its Tmin is bracketed by
pass/fail (18 / 17 ns).

**Normalised interpretation** (same chain delay D):

- single-edge FF needs `D + 0.23`;
- two-phase FF needs `2D + 1.0` — every stage pays half a period;
- two-phase latch needs `D + 3.9` — it must also cover d1 and the clock-tree insertion.

Therefore the latch is **slower than a single-edge FF** (by d1 + insertion ≈ 3.7 ns, measured
3.9) and **much faster than a two-phase FF** (by D − 2.9).

Latency: both FF variants need 4 register hops (3 cycles); the latch version overlaps two
hops inside one cycle (2 cycles). This is the same relationship as in Experiment 1, where the
two testbenches check 3-cycle and 2-cycle latency respectively, each with 259 passing checks.

### 3.5 Arbitration of the theoretical model

| Comparison | Model | Measured | Verdict |
|---|---|---|---|
| latch vs **two-phase FF** | 10.30 vs 16.40 (37 % faster) | 17.4 vs 30.8 (43 % faster) | direction and magnitude reproduced |
| latch vs **single-edge FF** | baseline absent | 17.4 vs ≈13.7 (27 % slower) | **sign flips** |
| borrow magnitude | ~5.05 ns | up to 15.9 ns, period-independent | law verified |

**The mathematics of the model is correct; its conclusion is baseline-dependent.**
"Latches are 37–60 % faster" holds only when the flip-flop pipeline is also clocked on two
phases. Against a conventional single-edge pipeline the latch pays d1 plus the clock-tree
insertion and is slower. **The latch's real gain is latency, not frequency.**

This also explains why Experiment 1 measured a tie: there the I/O and clock insertion were
60 % of the period, so a 0.23 ns FF overhead and a 3.9 ns latch overhead were both invisible.

---

## 4. Method notes (things that invalidated or would invalidate results)

1. **`WNS = 0.000` on latch endpoints is a borrowing fixed point.** Judge with `WNS < 0`,
   `Time borrowed from endpoint` and `Computed max time borrow`.
2. **Never compare global WNS across different register architectures.** The worst path sits
   on a different interface in each variant.
3. **Do not measure small-period Tmin by re-constraining a long-period netlist.** It
   over-estimates Tmin by 1.5–2 ns. Re-implement near Tmin.
4. **Delay chains need `keep`/`dont_touch` on every stage.** Acceptance test:
   LUT count = 8 × (d1 + d2) and path logic levels = chain length.
5. **The same LUT chain varies 13.5–25.7 ns (1.8×) depending on the constraint**, because the
   router spends different effort. Any Fmax comparison must be normalised by the measured
   chain delay, or the placement must be pinned (Pblock) — the latter is the recommended next
   step.
6. `delete_clock` fails on a checkpoint (`12-811`); re-declare `create_clock` with the same
   name to override.
7. The first `read_verilog` of a sandboxed Vivado session can abort with
   `'tclapp::load_apps' failed`; wrap module reads in a retry.

---

## 5. Limitations

1. `datapath_compare.v` is a reconstruction from the documented contract
   (`f(x) = rotl8((x+0x39) mod 256, 3) XOR 0xA7`); the original RTL is not in the snapshot.
2. Experiment 1's Test vehicle is too shallow to exercise borrowing (1.7 ns of logic against
   a 160 ns window). This is stated as a scope limit, not a result.
3. Experiment 2's three variants were not routed with equal chain delay, so the raw Tmin
   ordering is not a fair frequency comparison; only the normalised form is.
4. The latency figures (3 vs 2 cycles) come from the structure and from Experiment 1's
   testbench contracts; no dedicated simulation was run for the three arbitration variants.
5. No on-board measurement; no SDF run for Experiment 2 (the `write_sdf` output exists and
   the filtering recipe is reusable).
6. Absolute times are valid for this device and library only.

---

## 6. Reproduction

```powershell
# Experiment 1 (per case)
vivado -mode batch -nojournal -nolog -source scripts/run_case.tcl `
       -tclargs all_latch 1 640 40 160

# Experiment 1 (batch, sweeps, Tmin)
python scripts/run_matrix.py  cases_wave1.csv --workers 2
python scripts/sta_sweep.tcl  ...            # re-constraint sweep
python scripts/collect.py     ; python scripts/make_figures.py

# Experiment 2
python scripts/run_arb.py  <cases>.csv --workers 2
python scripts/analyze_arb.py
```

Case file format for Experiment 2:
`variant,period,pa_rise,pa_fall,pb_rise,pb_fall,d1,d2`.
