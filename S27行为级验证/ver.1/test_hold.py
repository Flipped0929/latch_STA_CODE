#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import unittest

from sim import DELAY, MIN_DELAY, analyze_hold, hold_slack_for_edge


class HoldWindowTests(unittest.TestCase):
    def test_next_transition_after_close_sets_clearance(self):
        result = hold_slack_for_edge([0.2, 0.7, 1.2], 0.6, 0.2)
        self.assertAlmostEqual(result['arrival'], 0.7)
        self.assertAlmostEqual(result['clearance'], 0.1)
        self.assertAlmostEqual(result['slack'], -0.1)

    def test_transition_at_close_has_zero_clearance(self):
        result = hold_slack_for_edge([0.6, 0.9], 0.6, 0.1)
        self.assertAlmostEqual(result['clearance'], 0.0)
        self.assertAlmostEqual(result['slack'], -0.1)

    def test_transition_at_end_of_hold_window_passes(self):
        result = hold_slack_for_edge([0.8], 0.6, 0.2)
        self.assertAlmostEqual(result['slack'], 0.0)

    def test_no_transition_after_close_is_unconstrained_by_this_trace(self):
        self.assertIsNone(hold_slack_for_edge([0.2, 0.5], 0.6, 0.1))

    def test_min_delay_map_matches_max_delay_topology(self):
        self.assertEqual(set(MIN_DELAY), set(DELAY))
        self.assertAlmostEqual(MIN_DELAY[('IO', 'G5')], 2.014120)
        self.assertTrue(all(MIN_DELAY[e] <= DELAY[e] for e in DELAY))

    def test_min_delay_s27_run_produces_hold_checks(self):
        result = analyze_hold(
            6.584, 0.0, [0.0, 0.0, 0.0, 0.0],
            cycles=24, c0=4, c1=16, seed=2701,
        )
        self.assertTrue(result['checks'])
        self.assertGreaterEqual(result['min_clearance'], 0.0)
        self.assertTrue(all(row['hold_slack'] >= -1e-9
                            for row in result['checks']))


if __name__ == '__main__':
    unittest.main()
