#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import importlib.util
import json
import unittest
from pathlib import Path


HERE = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("retune_s27_v4", HERE / "retune_s27_v4.py")
module = importlib.util.module_from_spec(spec)
assert spec.loader is not None
spec.loader.exec_module(module)


class RetuneS27V4Tests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.edges, cls.nominal = module.read_nominal()

    def test_valid_and_invalid_partition(self):
        rows, invalid = module.perturbation_rows(self.edges, self.nominal)
        self.assertEqual(len(rows), 15)
        self.assertEqual(len(invalid), 10)
        self.assertTrue(all(row["delay_range_valid"] for row in rows))

    def test_retuned_static_schedule_passes_all_valid_points(self):
        rows, _ = module.perturbation_rows(self.edges, self.nominal)
        self.assertTrue(all(row["retuned_static_pass"] for row in rows))
        self.assertEqual(sum(row["fixed_static_pass"] for row in rows), 1)

    def test_retuned_behavior_and_active_constraints_are_recorded(self):
        rows, _ = module.perturbation_rows(self.edges, self.nominal)
        self.assertTrue(all(row["retuned_behavior_pass_count"] == row["behavior_patterns"]
                            for row in rows))
        self.assertTrue(all(row["retuned_active_constraints"] for row in rows))

    def test_nominal_retuning_matches_ver2_solution(self):
        result = module.solve_retuned(self.edges, module.HOLD_MARGIN_NS)
        self.assertAlmostEqual(result["T"], self.nominal["T"], places=7)
        self.assertAlmostEqual(result["W"], self.nominal["W"], places=7)
        self.assertTrue(result["static"]["static_pass"])

    def test_summary_files_have_expected_counts(self):
        summary = json.loads((HERE / "results" / "summary.json").read_text(encoding="utf-8"))
        self.assertEqual(summary["valid_perturbation_count"], 15)
        self.assertEqual(summary["invalid_perturbation_count"], 10)
        self.assertEqual(summary["retuned_static_pass_count"], 15)

    def test_retuned_period_increases_with_max_delay(self):
        rows, _ = module.perturbation_rows(self.edges, self.nominal)
        same_min = [row for row in rows if row["min_delay_factor"] == 0.0]
        same_min.sort(key=lambda row: row["max_delay_factor"])
        self.assertEqual([row["max_delay_factor"] for row in same_min], [0.0, 0.05, 0.10])
        self.assertLess(same_min[0]["retuned_T_ns"], same_min[1]["retuned_T_ns"])
        self.assertLess(same_min[1]["retuned_T_ns"], same_min[2]["retuned_T_ns"])


if __name__ == "__main__":
    unittest.main()
