#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Fast regression checks for the S298 sensitivity helpers."""

from __future__ import annotations

import importlib.util
import sys
import unittest
from pathlib import Path


HERE = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location("s298_sensitivity", HERE / "run_s298_sensitivity.py")
assert SPEC is not None and SPEC.loader is not None
MODULE = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = MODULE
SPEC.loader.exec_module(MODULE)


class S298SensitivityTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.edges = MODULE.V1.read_edges()

    def test_nominal_retuning_matches_nominal_solution(self) -> None:
        solution = MODULE.V1.optimize(self.edges)
        perturbed = MODULE.scale_edges(self.edges, 0.0, 0.0)
        retuned = MODULE.V1.optimize(perturbed)
        self.assertAlmostEqual(retuned["T"], solution["T"], places=7)
        self.assertAlmostEqual(retuned["W"], solution["W"], places=7)
        self.assertEqual(MODULE.invalid_edges(perturbed), [])

    def test_crossed_delay_factors_create_invalid_intervals(self) -> None:
        perturbed = MODULE.scale_edges(self.edges, -0.10, 0.10)
        bad = MODULE.invalid_edges(perturbed)
        self.assertGreater(len(bad), 0)

    def test_static_summary_rejects_invalid_window(self) -> None:
        solution = MODULE.V1.optimize(self.edges)
        bad = dict(solution)
        bad["W"] = solution["T"]
        report = MODULE.static_summary(self.edges, bad)
        self.assertFalse(report["static_pass"])


if __name__ == "__main__":
    unittest.main()
