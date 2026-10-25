# Two-Latch Timing Model

This directory contains a theory-only, cycle-level comparison of a two-stage
pipeline implemented with opposite-phase level-sensitive latches or with
edge-triggered FFs. It does not use a vendor FPGA model or physical layout
delays.

```text
source -> logic d1 -> L1 -> logic d2 -> L2 -> output
```

The source launches one transaction every period `T`. L1 is transparent from
the launch boundary to `phase = T/2 + phase_shift`; L2 is transparent from
`phase` to the next cycle boundary. The FF comparison captures at `phase` and
`T`, so both implementations use the same two phase boundaries. A data change
that reaches L2 after it opens but before its close uses part of L2's
transparency window; that interval is reported as `borrow`.

The model checks maximum-delay setup and minimum-delay hold separately:

- Setup at L1: `tcq_src_max + d1_max + setup1 <= phase`.
- Setup at L2 with latches: the L1 output may update while L1 is transparent;
  the resulting `L2 D` arrival must be no later than `T - setup2`.
- Setup at L2 with FFs: `phase + tcq_ff_max + d2_max + setup2 <= T`.
- Hold uses the next transaction's minimum-delay arrival at each capture
  boundary. A design passes only when every setup and hold slack is
  non-negative.

Run the unit tests and default sweep from this directory:

```powershell
py -3.12 -m unittest -v
py -3.12 sweep.py
```

The sweep writes `sweep.csv`, `summary.csv`, `period_boundary.png`,
`slack_sweep.png`, and `timing_trace.png` under `results/`. Parameters can be
changed on the command line, for example:

```powershell
py -3.12 sweep.py --d1-max 2 --d1-min 1.8 --d2-max 8 --d2-min 7.8 --phase-shifts -1 0 1
```

The default delays are chosen to make the borrowing effect visible, not to
represent a measured FPGA path. The model assumes deterministic delays,
non-overlapping latch phases, one path per stage, and a fixed setup/hold check
at each phase boundary. It omits logic hazards, metastability, clock jitter,
recovery/removal, pulse-width constraints, and transistor-level behavior.

With the defaults and a 0 ns phase shift, the 0.02 ns sweep grid first passes
at 10.30 ns for the latch pipeline and 16.40 ns for the phase-matched FF
pipeline. At the latch boundary, L2 uses about 5.05 ns of its transparent
window. These are outputs of the illustrative model, not device measurements.
