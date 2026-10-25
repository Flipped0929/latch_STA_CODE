#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Regression checks for the S298 first reproduction."""

from __future__ import annotations

import importlib.util
import json
import sys
import unittest
from pathlib import Path


HERE = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location("s298_v1", HERE / "run_s298_v1.py")
assert SPEC is not None and SPEC.loader is not None
MODULE = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = MODULE
SPEC.loader.exec_module(MODULE)


class S298V1Tests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.edges = MODULE.read_edges()
        cls.nodes = MODULE.nodes_of(cls.edges)

    def test_normalized_graph_shape_and_intervals(self) -> None:
        self.assertEqual(len(self.edges), 78)
        self.assertEqual(len(self.nodes), 15)
        self.assertIn("IO", self.nodes)
        self.assertTrue(all(0 <= e.min_delay <= e.max_delay for e in self.edges))
        self.assertTrue(all(e.source != "OUTPUT" and e.target != "OUTPUT" for e in self.edges))

    def test_nominal_solution_is_static_feasible(self) -> None:
        solution = MODULE.optimize(self.edges)
        self.assertAlmostEqual(solution["T"], 10.89558999, places=6)
        self.assertAlmostEqual(solution["W"], 0.0, places=7)
        self.assertGreaterEqual(solution["minimum_edge_slack"], -1.1e-7)
        self.assertEqual(solution["worst_edge"], "G14->G16")

    def test_lower_period_is_rejected(self) -> None:
        solution = MODULE.optimize(self.edges)
        feasible, _, _ = MODULE.feasible_potentials(
            self.edges, self.nodes, solution["T"] - 1.0e-4, 0.0, MODULE.HOLD_MARGIN_NS
        )
        self.assertFalse(feasible)

    def test_behavior_crosscheck_checks_io_separately(self) -> None:
        solution = MODULE.optimize(self.edges)
        result = MODULE.run_xor_behavior(
            self.edges, solution["T"], solution["W"], solution["skews"], 0xAA
        )
        self.assertTrue(result["io_ok"])
        self.assertEqual(result["node_count"], 15)
        self.assertEqual(result["state_node_count"], 14)

    def test_negative_skew_initialization_first_input_one(self) -> None:
        solution = MODULE.optimize(self.edges)
        self.assertLess(min(solution["skews"].values()), -1.0)
        # A finite -1 ns history sentinel made negative-skew histories
        # unsorted and broke exactly the patterns starting with bit one.
        result = MODULE.run_xor_behavior(
            self.edges, solution["T"], solution["W"], solution["skews"], 0x01
        )
        self.assertTrue(result["pass"])
        self.assertEqual(result["state_match"], 1.0)

    def test_saved_summary_matches_reproduction(self) -> None:
        summary_path = HERE / "results" / "summary.json"
        self.assertTrue(summary_path.exists())
        summary = json.loads(summary_path.read_text(encoding="utf-8"))
        self.assertEqual(summary["node_count"], 15)
        self.assertEqual(summary["edge_count"], 78)
        self.assertEqual(summary["output_tap_count"], 6)
        self.assertEqual(summary["behavior_patterns"], 14)


if __name__ == "__main__":
    unittest.main()
