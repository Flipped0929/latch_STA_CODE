import json
import math
import unittest

from extract_latch_timing import CELL, COMMON, ROOT, extract, extract_pulse_width, interpolate


class ExtractTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.common = json.loads((ROOT / COMMON).read_text(encoding="utf-8-sig"))
        cls.cell = json.loads((ROOT / CELL).read_text(encoding="utf-8-sig"))

    def test_published_grid_point_and_signed_hold(self):
        params, _ = extract(self.common, self.cell, 0.01, 0.01, 0.0005)
        expected = dict(zip(("tsu", "thd", "tdqMin", "tdqMax", "tcqMin", "tcqMax"),
                            (0.1948711, -0.0260762, 0.1956779, 0.2897848, 0.2408861, 0.2727443)))
        self.assertEqual(params, expected)

    def test_interpolation_and_endpoints(self):
        table = {"index_1": [1, 3], "index_2": [2, 6], "values": [[5, 17], [9, 21]]}
        self.assertEqual(interpolate(table, 2, 4), 13)
        self.assertEqual(interpolate(table, 1, 2), 5)
        self.assertEqual(interpolate(table, 3, 6), 21)

    def test_axis_order_for_setup(self):
        _, details = extract(self.common, self.cell, 0.01, 0.5, 0.0005)
        self.assertEqual(details["setup"]["fall_constraint"], -0.1365417)

    def test_extrapolation_and_nonfinite_rejected(self):
        for slew, load in ((0.001, 0.0005), (0.01, 1), (math.nan, 0.0005), (0.01, math.inf)):
            with self.assertRaises(ValueError):
                extract(self.common, self.cell, slew, 0.01, load)

    def test_units_and_conditional_arcs_rejected(self):
        with self.assertRaises(ValueError):
            extract({**self.common, "time_unit": "1ps"}, self.cell, 0.01, 0.01, 0.0005)
        cell = json.loads(json.dumps(self.cell))
        cell["pin,Q"]["timing"][0]["when"] = "GATE"
        with self.assertRaises(ValueError):
            extract(self.common, cell, 0.01, 0.01, 0.0005)

    def test_pulse_width_at_clock_slew_and_absent_low_check(self):
        checks = extract_pulse_width(self.common, self.cell, 0.05)
        expected = 0.1774742 + (0.8333333 - 0.1774742) * (0.05 - 0.01) / (0.5 - 0.01)
        self.assertAlmostEqual(checks["min_pulse_width_high"], expected, places=14)
        self.assertAlmostEqual(checks["min_pulse_width_high"], 0.231014, places=6)
        self.assertIsNone(checks["min_pulse_width_low"])
        for slew, value in ((0.01, 0.1774742), (0.5, 0.8333333), (1.5, 2.5)):
            self.assertEqual(extract_pulse_width(self.common, self.cell, slew)["min_pulse_width_high"], value)

    def test_low_pulse_table_and_invalid_pulse_data(self):
        cell = json.loads(json.dumps(self.cell))
        table = cell["pin,GATE"]["timing"]["rise_constraint,constraint_3_0_1"]
        cell["pin,GATE"]["timing"]["fall_constraint,constraint_3_0_1"] = table
        checks = extract_pulse_width(self.common, cell, 0.05)
        self.assertEqual(checks["min_pulse_width_high"], checks["min_pulse_width_low"])
        for slew in (0.001, 1.6, math.nan, math.inf):
            with self.assertRaises(ValueError):
                extract_pulse_width(self.common, cell, slew)
        for value in (-1, math.nan, math.inf):
            malformed = json.loads(json.dumps(self.cell))
            malformed["pin,GATE"]["timing"]["rise_constraint,constraint_3_0_1"]["values"][0] = value
            with self.assertRaises(ValueError):
                extract_pulse_width(self.common, malformed, 0.05)
        malformed = json.loads(json.dumps(self.cell))
        malformed["pin,GATE"]["timing"]["when"] = "D"
        with self.assertRaises(ValueError):
            extract_pulse_width(self.common, malformed, 0.05)
        with self.assertRaises(ValueError):
            extract_pulse_width({**self.common, "time_unit": "1ps"}, self.cell, 0.05)


if __name__ == "__main__":
    unittest.main()
