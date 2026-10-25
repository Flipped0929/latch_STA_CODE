import unittest

from feasibility import evaluate_feasibility, scan, summarize


class FeasibilityTests(unittest.TestCase):
    def test_default_example_passes_and_reports_hold_capacity(self):
        result = evaluate_feasibility(10.3, 5.15, 0.1)
        self.assertTrue(result["setup_pass"])
        self.assertTrue(result["pass_at_common_hold"])
        self.assertAlmostEqual(result["latch1_setup_slack_ns"], 2.95)
        self.assertAlmostEqual(result["latch2_setup_slack_ns"], 0.0)
        self.assertAlmostEqual(result["max_common_hold_ns"], 7.0)

    def test_hold_requirement_above_window_dependent_capacity_fails(self):
        result = evaluate_feasibility(10.3, 10.2, 2.0)
        self.assertTrue(result["setup_pass"])
        self.assertAlmostEqual(result["max_common_hold_ns"], 1.95)
        self.assertFalse(result["pass_at_common_hold"])

    def test_setup_failure_makes_hold_capacity_unreported(self):
        result = evaluate_feasibility(10.2, 5.15, 0.1)
        self.assertFalse(result["setup_pass"])
        self.assertIsNone(result["max_common_hold_ns"])
        self.assertFalse(result["pass_at_common_hold"])

    def test_scan_summary_finds_first_passing_period_and_windows(self):
        rows = scan([10.2, 10.3], [2.1, 2.2, 5.0, 10.2], 0.1)
        result = summarize(rows, 0.1)
        self.assertEqual(result["first_passing_period_ns"], 10.3)
        self.assertEqual(result["min_passing_window_ns"], 2.2)
        self.assertEqual(result["max_passing_window_ns"], 10.2)

    def test_negative_hold_requirement_is_rejected(self):
        with self.assertRaises(ValueError):
            evaluate_feasibility(10.3, 5.15, -0.01)


if __name__ == "__main__":
    unittest.main()
