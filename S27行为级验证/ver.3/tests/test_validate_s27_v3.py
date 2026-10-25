#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import importlib.util
import unittest
from pathlib import Path


HERE = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("validate_s27_v3", HERE / "validate_s27_v3.py")
module = importlib.util.module_from_spec(spec)
assert spec.loader is not None
spec.loader.exec_module(module)


class ValidateS27V3Tests(unittest.TestCase):
    def setUp(self):
        self.edges = module.load_edges()
        self.solution = module.load_solution()

    def test_all_8_cycle_patterns_are_generated(self):
        patterns = [module.pattern_bits(i) for i in range(256)]
        self.assertEqual(len(patterns), 256)
        self.assertEqual(len({tuple(x) for x in patterns}), 256)
        self.assertEqual(module.periodic_stim(0xA5, 16), module.pattern_bits(0xA5) * 2)

    def test_nominal_static_point_is_feasible(self):
        r = module.static_check(self.solution["T"], self.solution["W"],
                                self.solution["skew"], self.edges,
                                self.solution["hold_margin"])
        self.assertTrue(r["pass"])
        self.assertGreaterEqual(r["min_hold_slack_ns"], -module.TOL)
        self.assertGreaterEqual(r["half_window_slack_ns"], -module.TOL)

    def test_below_period_boundary_fails_static_setup(self):
        r = module.static_check(self.solution["T"] - 0.01, self.solution["W"],
                                self.solution["skew"], self.edges,
                                self.solution["hold_margin"])
        self.assertFalse(r["pass"])
        self.assertLess(r["min_setup_slack_ns"], 0.0)

    def test_one_nominal_pattern_cross_check(self):
        r = module.behavior_case(self.solution["T"], self.solution["W"],
                                 self.solution["skew"], 0xA5,
                                 cycles=32, c0=8, c1=28)
        self.assertTrue(r["io_ok"])
        self.assertTrue(r["pass"])
        self.assertGreaterEqual(r["state_match"], 0.995)

    def test_grid_contains_both_sides_of_optimum(self):
        Ts, Ws = module.choose_grid(self.solution["T"], self.solution["W"])
        self.assertLess(min(Ts), self.solution["T"])
        self.assertGreater(max(Ts), self.solution["T"])
        self.assertLess(min(Ws), self.solution["W"])
        self.assertGreater(max(Ws), self.solution["W"])

    def test_hold_requirement_boundary_is_visible(self):
        rows = module.hold_margin_sensitivity(
            self.solution["T"], self.solution["W"], self.solution["skew"], self.edges
        )
        self.assertEqual([row["hold_margin_ns"] for row in rows], [0.0, 0.05, 0.10, 0.20, 0.30])
        self.assertEqual([row["static_pass"] for row in rows], [True, True, True, False, False])

    def test_invalid_delay_interval_is_not_reported_as_static_pass(self):
        perturbed = [dict(edge) for edge in self.edges]
        perturbed[0]["max_delay_ns"] = perturbed[0]["min_delay_ns"] * 0.9
        result = module.static_check(
            self.solution["T"], self.solution["W"], self.solution["skew"],
            perturbed, self.solution["hold_margin"]
        )
        self.assertFalse(result["delay_range_valid"])
        self.assertFalse(result["pass"])


if __name__ == "__main__":
    unittest.main()
