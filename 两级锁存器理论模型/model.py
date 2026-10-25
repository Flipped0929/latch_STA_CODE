"""Cycle-level timing model for a two-stage FF/latch pipeline."""
from dataclasses import dataclass
from typing import Dict, Any


@dataclass(frozen=True)
class Circuit:
    d1_max: float = 2.0
    d1_min: float = 1.8
    d2_max: float = 8.0
    d2_min: float = 7.8
    tcq_src_max: float = 0.10
    tcq_src_min: float = 0.05
    tcq_ff_max: float = 0.10
    tcq_ff_min: float = 0.05
    tdq_l1_max: float = 0.10
    tdq_l1_min: float = 0.04
    tcq_l1_max: float = 0.12
    tcq_l1_min: float = 0.05
    tdq_l2_max: float = 0.10
    tcq_l2_max: float = 0.12
    setup1: float = 0.10
    hold1: float = 0.05
    setup2: float = 0.10
    hold2: float = 0.05

    def __post_init__(self) -> None:
        for name, value in vars(self).items():
            if value < 0:
                raise ValueError(f"{name} must be non-negative")
        if self.d1_min > self.d1_max or self.d2_min > self.d2_max:
            raise ValueError("minimum logic delays cannot exceed maximum delays")
        if self.tcq_src_min > self.tcq_src_max:
            raise ValueError("minimum source clock-to-Q cannot exceed its maximum")
        if self.tcq_ff_min > self.tcq_ff_max:
            raise ValueError("minimum FF clock-to-Q cannot exceed its maximum")
        if self.tdq_l1_min > self.tdq_l1_max:
            raise ValueError("minimum latch data-to-Q cannot exceed its maximum")
        if self.tcq_l1_min > self.tcq_l1_max:
            raise ValueError("minimum latch clock-to-Q cannot exceed its maximum")


def _latch_q_time(
    d_arrival: float,
    close: float,
    setup: float,
    tdq_max: float,
    tcq_max: float,
) -> float:
    """Estimate when a latch output reflects data that meets setup."""
    if d_arrival + tdq_max <= close:
        return d_arrival + tdq_max
    if d_arrival <= close - setup:
        return close + tcq_max
    return d_arrival + tdq_max


def _latch_q_time_min(
    d_arrival: float,
    close: float,
    setup: float,
    tdq_min: float,
    tcq_min: float,
) -> float:
    if d_arrival + tdq_min <= close:
        return d_arrival + tdq_min
    if d_arrival <= close - setup:
        return close + tcq_min
    return d_arrival + tdq_min


def evaluate(
    period: float,
    circuit: Circuit = Circuit(),
    phase_shift: float = 0.0,
    *,
    window: float | None = None,
) -> Dict[str, Any]:
    """Evaluate one period with a movable boundary between latch phases.

    L1 is transparent from cycle start to ``phase``; L2 is transparent from
    ``phase`` to the next cycle boundary. Pass ``window`` to set the L1 width
    directly, or use ``phase_shift`` relative to ``period / 2``. The FF
    comparison captures on those same phase boundaries. All times are in ns.
    """
    if period <= 0:
        raise ValueError("period must be positive")

    if window is not None and phase_shift != 0.0:
        raise ValueError("use either window or phase_shift, not both")

    phase = period / 2.0 + phase_shift if window is None else window
    if not 0 < phase < period:
        raise ValueError("L1 window must satisfy 0 < window < period")

    l1_d_arrival = circuit.tcq_src_max + circuit.d1_max
    ff1_setup_slack = phase - circuit.setup1 - l1_d_arrival
    ff2_d_arrival = phase + circuit.tcq_ff_max + circuit.d2_max
    ff2_setup_slack = period - circuit.setup2 - ff2_d_arrival

    ff1_hold_slack = (
        period + circuit.tcq_src_min + circuit.d1_min - phase - circuit.hold1
    )
    ff2_hold_slack = (
        phase + circuit.tcq_ff_min + circuit.d2_min - circuit.hold2
    )
    ff_pass = min(ff1_setup_slack, ff2_setup_slack, ff1_hold_slack, ff2_hold_slack) >= 0

    latch1_setup_slack = ff1_setup_slack
    latch1_q_time = _latch_q_time(
        l1_d_arrival,
        phase,
        circuit.setup1,
        circuit.tdq_l1_max,
        circuit.tcq_l1_max,
    )
    latch2_d_arrival = latch1_q_time + circuit.d2_max
    latch2_setup_slack = period - circuit.setup2 - latch2_d_arrival
    latch1_hold_slack = ff1_hold_slack

    next_l1_d_arrival = circuit.tcq_src_min + circuit.d1_min
    next_l1_q_time = _latch_q_time_min(
        next_l1_d_arrival,
        phase,
        circuit.setup1,
        circuit.tdq_l1_min,
        circuit.tcq_l1_min,
    )
    latch2_next_d_arrival = next_l1_q_time + circuit.d2_min
    latch2_hold_slack = latch2_next_d_arrival - circuit.hold2
    latch_pass = min(
        latch1_setup_slack,
        latch2_setup_slack,
        latch1_hold_slack,
        latch2_hold_slack,
    ) >= 0

    borrow = max(0.0, latch2_d_arrival - phase)
    borrow_capacity = period - phase - circuit.setup2
    latch2_q_time = (
        max(phase, latch2_d_arrival) + circuit.tdq_l2_max
        if max(phase, latch2_d_arrival) + circuit.tdq_l2_max <= period
        else period + circuit.tcq_l2_max
    )

    return {
        "period": period,
        "phase": phase,
        "window": phase,
        "l2_window": period - phase,
        "phase_shift": phase_shift,
        "ff_pass": ff_pass,
        "latch_pass": latch_pass,
        "ff_setup_slack": min(ff1_setup_slack, ff2_setup_slack),
        "ff_hold_slack": min(ff1_hold_slack, ff2_hold_slack),
        "latch_setup_slack": min(latch1_setup_slack, latch2_setup_slack),
        "latch_hold_slack": min(latch1_hold_slack, latch2_hold_slack),
        "ff1_setup_slack": ff1_setup_slack,
        "ff2_setup_slack": ff2_setup_slack,
        "ff1_hold_slack": ff1_hold_slack,
        "ff2_hold_slack": ff2_hold_slack,
        "latch1_setup_slack": latch1_setup_slack,
        "latch2_setup_slack": latch2_setup_slack,
        "latch1_hold_slack": latch1_hold_slack,
        "latch2_hold_slack": latch2_hold_slack,
        "l1_d_arrival": l1_d_arrival,
        "l1_q_time": latch1_q_time,
        "l2_d_arrival": latch2_d_arrival,
        "l2_q_time": latch2_q_time,
        "ff2_d_arrival": ff2_d_arrival,
        "borrow": borrow,
        "borrow_capacity": borrow_capacity,
    }
