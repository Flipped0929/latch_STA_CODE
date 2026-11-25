"""Audit exported connectivity and SPEF coverage, and summarize this run."""
from pathlib import Path
import hashlib
import json
import os
import re
from clock_metrics import analyze_clock_paths

FLOW = Path(__file__).resolve().parents[1]
ROOT = Path(os.environ.get("OPENROAD_RUN_DIR", FLOW)).resolve()
PLATFORM = Path(os.environ["SKY130_PLATFORM"])
RESULTS, REPORTS = ROOT / "results", ROOT / "reports"


def instances(text):
    return {
        name: (cell, dict(re.findall(r"\.(\w+)\s*\(\s*([^()]+?)\s*\)", pins)))
        for cell, name, pins in re.findall(
            r"\b(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);", text, re.S
        )
    }


def paths(filename):
    result = []
    for block in (REPORTS / filename).read_text().split("Startpoint: ")[1:]:
        slack = re.search(r"([-\d.]+)\s+slack \((\w+)\)", block)
        if slack:
            result.append({
                "startpoint": block.splitlines()[0],
                "endpoint": re.search(r"Endpoint: (.+)", block)[1],
                "group": re.search(r"Path Group: (.+)", block)[1],
                "slack_ns": float(slack[1]),
            })
    return result


original = instances((FLOW.parent / "counter_sky130.v").read_text())
routed = instances((RESULTS / "counter_routed.v").read_text())
size_file = FLOW / "inputs/output_latch_sizes.tsv"
size_targets = dict(
    line.split() for line in size_file.read_text().splitlines()
    if line.strip() and not line.lstrip().startswith("#")
)
reference_file = FLOW / "inputs/mux_reference_counter_routed.v"
reference = instances(reference_file.read_text())
assert set(size_targets) == {f"state_phi2_bit{bit}" for bit in range(4)}
for name, target in size_targets.items():
    assert reference[name][0] == target, (name, "Reference size mismatch")
    assert original[name][0].rsplit("_", 1)[0] == target.rsplit("_", 1)[0]
buffers = {}
dummy_outputs = set()
for name, (cell, pins) in routed.items():
    if name not in original:
        if set(pins) == {"A"}:
            assert name.startswith("clkload"), (name, cell)
            assert cell.startswith(("sky130_fd_sc_hd__clkbuf_", "sky130_fd_sc_hd__clkinv_")), (name, cell)
            dummy_outputs.add(f"{name}/{'Y' if '__clkinv_' in cell else 'X'}")
        else:
            assert cell.startswith("sky130_fd_sc_hd__clkbuf_"), (name, cell)
            assert set(pins) == {"A", "X"}, (name, pins)
            buffers[pins["X"]] = pins["A"]


def unbuffer(net):
    seen = set()
    while net in buffers:
        assert net not in seen, "Buffer cycle"
        seen.add(net)
        net = buffers[net]
    return net


# insert_buffer can keep the old net name on its output and rename the
# upstream driver net. Match nets by their original driver pins as well.
net_renames = {}
for name, (cell, pins) in original.items():
    output_pin = "Q" if "__dl" in cell else ("Y" if "__inv_" in cell else "X")
    net_renames[pins[output_pin]] = unbuffer(routed[name][1][output_pin])
for name, (cell, pins) in original.items():
    assert name in routed and routed[name][0] == size_targets.get(name, cell), name
    actual = {pin: unbuffer(net) for pin, net in routed[name][1].items()}
    expected = {pin: net_renames.get(net, net) for pin, net in pins.items()}
    assert actual == expected, (name, expected, actual)
for bit in range(4):
    assert re.search(
        rf"assign\s+count\[{bit}\]\s*=\s*count_o\[{bit}\]\s*;",
        (RESULTS / "counter_routed.v").read_text(),
    ), f"Output alias {bit}"

def_text = (RESULTS / "counter_routed.def").read_text()
component_section = re.search(r"^COMPONENTS \d+ ;\n(.*?)^END COMPONENTS", def_text, re.M | re.S)[1]
physical_masters = dict(re.findall(r"^\s+-\s+(\S+)\s+(\S+)\s+\+", component_section, re.M))
power_view = instances((RESULTS / "counter_power.v").read_text())
for name, target in size_targets.items():
    assert physical_masters[name] == power_view[name][0] == routed[name][0] == target
net_section = re.search(r"^NETS \d+ ;\n(.*?)^END NETS", def_text, re.M | re.S)[1]
def_nets = set(re.findall(r"^\s+-\s+(\S+)", net_section, re.M))
spef_text = (RESULTS / "counter.spef").read_text()
name_map = dict(re.findall(r"^\*(\d+)\s+(\S+)\s*$", spef_text, re.M))
spef_nets = {name_map[n] for n in re.findall(r"^\*D_NET \*(\d+) ", spef_text, re.M)}
assert def_nets == spef_nets, (def_nets - spef_nets, spef_nets - def_nets)
assert not (REPORTS / "check_setup.rpt").read_text().strip(), "Constraint coverage warnings"
assert not (REPORTS / "route_drc.rpt").read_text().strip(), "Routing DRC violations"
assert not (REPORTS / "electrical_violations.rpt").read_text().strip(), "Electrical violations"
annotation = (REPORTS / "parasitic_annotation.rpt").read_text()
assert "Found 0 partially unannotated drivers." in annotation
unannotated = set(re.findall(r"^ (\S+)\s*$", annotation, re.M))
assert unannotated == dummy_outputs, (unannotated, dummy_outputs)
pnr_log = (ROOT / "logs/pnr.log").read_text()
for marker in ["PNR_AND_RCX_COMPLETE", "All shapes on net VDD are connected.",
               "All shapes on net VSS are connected.", "Found 0 net violations.",
               "Found 0 pin violations."]:
    assert marker in pnr_log, marker
assert "POST_ROUTE_SPEF_STA_COMPLETE" in (ROOT / "logs/sta.log").read_text()

max_paths, min_paths = paths("setup.rpt"), paths("hold.rpt")
clock_metrics = analyze_clock_paths(ROOT, routed, FLOW.parent / "counter.sdc")
timing = dict(re.findall(
    r"^(worst slack max|worst slack min|tns max|tns min) ([-\d.]+)$",
    (REPORTS / "timing_summary.rpt").read_text(), re.M,
))
provenance_files = [
    FLOW.parent / "counter_sky130.v", FLOW.parent / "counter.sdc",
    PLATFORM / "lib/sky130_fd_sc_hd__tt_025C_1v80.lib",
    PLATFORM / "lef/sky130_fd_sc_hd.tlef",
    PLATFORM / "lef/sky130_fd_sc_hd_merged.lef",
    PLATFORM / "rcx_patterns.rules",
    size_file, reference_file,
    FLOW / "scripts/clock_tree.tcl",
]
summary = {
    "corner": "TT, 25 C, 1.80 V; ORFS sky130hd default RCX model index 0",
    "period_ns": 1.75,
    "die_um": [60, 60],
    "core_um": [48.76, 48.96],
    "original_cells": len(original),
    "routed_timing_cells": len(routed),
    "clock_buffers": len(buffers),
    "clock_dummy_loads": len(routed) - len(original) - len(buffers),
    "clock_metrics": clock_metrics,
    "clock_tree_mode": (REPORTS / "clock_tree_mode.rpt").read_text().strip().split()[-1]
        if (REPORTS / "clock_tree_mode.rpt").exists() else "two_level",
    "physical_instances": int(re.search(r"^COMPONENTS (\d+)", def_text, re.M)[1]),
    "routed_nets": len(def_nets),
    "spef_nets": len(spef_nets),
    "timing_ns": {k: float(v) for k, v in timing.items()},
    "max_violating_endpoints": sorted({p["endpoint"] for p in max_paths if p["slack_ns"] < 0}),
    "min_violating_endpoints": sorted({p["endpoint"] for p in min_paths if p["slack_ns"] < 0}),
    "worst_max": min(max_paths, key=lambda p: p["slack_ns"]),
    "worst_min": min(min_paths, key=lambda p: p["slack_ns"]),
    "original_cell_connectivity_preserved": True,
    "output_latch_sizes_match_mux_reference": True,
    "intentional_cell_resizing": {
        name: {"input": original[name][0], "routed": target}
        for name, target in size_targets.items()
    },
    "spef_coverage_complete": True,
    "sha256": {str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in provenance_files},
}
(REPORTS / "summary.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2) + "\n")
(REPORTS / "validation.rpt").write_text(
    f"PASS: All {len(original)} original cells and pin connections preserved after resolving CTS buffers.\n"
    "PASS: Only the four configured output latch drive sizes changed; all other original cell types match.\n"
    "PASS: Output latch sizes match the counter_latch_mux_1 reference snapshot (4, 4, 2, 2).\n"
    "PASS: Output latch masters agree in routed DEF, power netlist and timing netlist.\n"
    "PASS: All four output aliases preserved.\n"
    f"PASS: All {len(def_nets)} routed signal/clock nets are present in SPEF.\n"
    f"PASS: No partially annotated drivers; unannotated outputs are only unconnected CTS dummies: {', '.join(sorted(dummy_outputs))}.\n"
    "PASS: No check_setup constraint coverage warnings on the signal timing view.\n"
    "PASS: Routing DRC and electrical violation reports are empty.\n"
    "PASS: VDD/VSS connectivity and antenna checks pass.\n"
    "Timing violations remain; see timing_summary.rpt and violations.rpt.\n"
)
(REPORTS / "output_latch_sizes.rpt").write_text(
    "Instance             Input master                   Routed/reference master\n"
    + "".join(f"{name:20s} {original[name][0]:30s} {target}\n" for name, target in size_targets.items())
)
print(json.dumps({k: summary[k] for k in ["routed_nets", "spef_nets", "timing_ns"]}))
