import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

import optimize_s27


class S27OptimizerTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.edges = optimize_s27.read_edges(ROOT / "data" / "s27_edges.csv")
        cls.nodes = sorted({edge.source for edge in cls.edges} | {edge.target for edge in cls.edges})
        cls.arcs = optimize_s27.make_arcs(cls.edges, 0.10)
        cls.constraints, cls.cycles = optimize_s27.build_constraints(cls.nodes, cls.arcs)
        cls.period, cls.window = optimize_s27.solve_min_period(cls.constraints)
        cls.skews = optimize_s27.find_potentials(cls.nodes, cls.arcs, cls.period, cls.window)

    def test_g6_self_loop_is_a_hard_period_lower_bound(self):
        g6_loop = next(edge for edge in self.edges if edge.source == "G6" and edge.target == "G6")
        self.assertGreaterEqual(self.period + 1e-9, g6_loop.max_delay)
        self.assertAlmostEqual(g6_loop.max_delay, 5.06070, places=5)
        self.assertAlmostEqual(self.period, 5.06070, places=8)
        self.assertAlmostEqual(self.window, 0.39099, places=8)

    def test_all_static_setup_and_hold_constraints_pass(self):
        slacks = optimize_s27.compute_edge_slacks(
            self.edges, self.skews, self.period, self.window, 0.10
        )
        for row in slacks:
            for key in ("setup_slack_ns", "extended_setup_slack_ns", "hold_slack_ns"):
                self.assertGreaterEqual(row[key] + 1e-7, 0.0, (row["source"], row["target"], key))

    def test_skew_reference_is_zero_and_g7_hold_bound_is_respected(self):
        self.assertAlmostEqual(self.skews["IO"], 0.0, places=9)
        g7_loop = next(edge for edge in self.edges if edge.source == "G7" and edge.target == "G7")
        self.assertLessEqual(self.window + 0.10, g7_loop.min_delay + 1e-8)

    def test_cycle_halfplanes_are_satisfied(self):
        self.assertTrue(optimize_s27.satisfies((self.period, self.window), self.constraints))
        self.assertEqual(len(self.cycles), 108)
        self.assertFalse(optimize_s27.satisfies((self.period, self.window + 1e-6), self.constraints))

    def test_cycle_constraints_match_negative_cycle_check(self):
        for period in (0.0, 2.0, 5.0607, 6.0, 8.0):
            for window in (0.0, period / 4.0, period / 2.0):
                distance = {node: 0.0 for node in self.nodes}
                has_negative_cycle = False
                for iteration in range(len(self.nodes)):
                    changed = False
                    for arc in self.arcs:
                        candidate = distance[arc.source] + optimize_s27.arc_weight(
                            arc, period, window
                        )
                        if distance[arc.target] > candidate + 1e-10:
                            distance[arc.target] = candidate
                            changed = True
                    if not changed:
                        break
                    if iteration == len(self.nodes) - 1:
                        has_negative_cycle = True
                self.assertEqual(
                    optimize_s27.satisfies((period, window), self.constraints),
                    not has_negative_cycle,
                    (period, window),
                )


if __name__ == "__main__":
    unittest.main()
