import unittest
from dataclasses import replace

from model import Circuit, evaluate


class TwoLatchTimingTests(unittest.TestCase):
    def test_transparent_latch_borrows_time_from_second_phase(self):
        result = evaluate(11.0)
        self.assertTrue(result["latch_pass"])
        self.assertFalse(result["ff_pass"])
        self.assertAlmostEqual(result["l1_d_arrival"], 2.1)
        self.assertAlmostEqual(result["l2_d_arrival"], 10.2)
        self.assertAlmostEqual(result["borrow"], 4.7)

    def test_latch_setup_boundary_is_swept_correctly(self):
        self.assertFalse(evaluate(10.29)["latch_pass"])
        self.assertTrue(evaluate(10.31)["latch_pass"])

    def test_first_latch_setup_failure_rejects_both_implementations(self):
        circuit = replace(Circuit(), d1_max=6.0)
        result = evaluate(10.0, circuit)
        self.assertFalse(result["latch_pass"])
        self.assertFalse(result["ff_pass"])
        self.assertLess(result["latch1_setup_slack"], 0)

    def test_short_minimum_path_can_fail_latch_hold(self):
        circuit = replace(
            Circuit(),
            d1_min=0.01,
            d2_min=0.01,
            tcq_src_min=0.0,
            tdq_l1_min=0.0,
            tcq_l1_min=0.0,
            hold2=0.1,
        )
        result = evaluate(12.0, circuit)
        self.assertLess(result["latch2_hold_slack"], 0)
        self.assertFalse(result["latch_pass"])

    def test_invalid_phase_is_rejected(self):
        with self.assertRaises(ValueError):
            evaluate(2.0, phase_shift=1.0)

    def test_explicit_window_matches_existing_phase_shift(self):
        period = 12.0
        window = 4.5
        by_shift = evaluate(period, phase_shift=window - period / 2.0)
        by_window = evaluate(period, window=window)
        self.assertEqual(by_shift["latch_pass"], by_window["latch_pass"])
        self.assertAlmostEqual(by_shift["latch_setup_slack"], by_window["latch_setup_slack"])
        self.assertAlmostEqual(by_window["l2_window"], period - window)

    def test_explicit_window_must_be_inside_period(self):
        with self.assertRaises(ValueError):
            evaluate(10.0, window=10.0)

    def test_window_and_phase_shift_cannot_both_be_set(self):
        with self.assertRaises(ValueError):
            evaluate(10.0, phase_shift=0.2, window=5.2)


if __name__ == "__main__":
    unittest.main()
