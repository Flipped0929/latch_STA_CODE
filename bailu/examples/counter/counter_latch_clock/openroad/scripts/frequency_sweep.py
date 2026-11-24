"""Re-run SPEF STA over clock periods, preserving waveform ratios and I/O budgets."""
from pathlib import Path
import hashlib
import json
import os
import re
import shutil
import subprocess
from clock_metrics import analyze_clock_paths

flow = Path(__file__).resolve().parents[1]
root = flow / "frequency_sweep"
inputs = root / "inputs"
inputs.mkdir(parents=True, exist_ok=True)
template = (flow.parent / "counter.sdc").read_text()
(inputs / "template.sdc").write_text(template)
for filename in ("counter_routed.v", "counter.spef"):
    shutil.copy2(flow / "results" / filename, inputs / filename)
pattern = re.compile(
    r"(create_clock\s+-name\s+(\w+)\s+-period\s+)([\d.]+)(\s+-waveform\s+\{)([\d.]+)\s+([\d.]+)(\})"
)
waveforms = {m[2]: (float(m[3]), float(m[5]), float(m[6])) for m in pattern.finditer(template)}
assert set(waveforms) == {"phi1", "phi2"}
assert waveforms["phi1"][0] == waveforms["phi2"][0]
base_period = waveforms["phi1"][0]


def make_sdc(period):
    clean = re.sub(r"^# (?:Each phase is high|Setup-limited estimate:|Use [\d.]+ ns).*\n", "", template, flags=re.M)
    text = pattern.sub(lambda m: f"{m[1]}{period:.7f}{m[4]}"
                       f"{float(m[5])/float(m[3])*period:.9f} "
                       f"{float(m[6])/float(m[3])*period:.9f}{m[7]}", clean)
    text = (f"# STA sweep: period {period:.7f} ns; two phases remain at 49% high.\n"
            "# Edge offsets and non-overlap scale with period; all other constraints are unchanged.\n" + text)
    assert pattern.sub("CLOCK", text).split("# Read the SKY130", 1)[-1] == \
           pattern.sub("CLOCK", clean).split("# Read the SKY130", 1)[-1]
    return text


def instances(text):
    return {name: (cell, dict(re.findall(r"\.(\w+)\s*\(\s*([^()]+?)\s*\)", pins)))
            for cell, name, pins in re.findall(r"\b(sky130_fd_sc_hd__\w+)\s+(\w+)\s*\((.*?)\);", text, re.S)}


def paths(text):
    result = []
    for block in text.split("Startpoint: ")[1:]:
        slack = re.search(r"([-\d.]+)\s+slack \((\w+)\)", block)
        if slack:
            result.append({"startpoint": block.splitlines()[0],
                           "endpoint": re.search(r"Endpoint: (.+)", block)[1],
                           "slack_ns": float(slack[1])})
    return result


routed = instances((inputs / "counter_routed.v").read_text())
executable = os.environ.get("OPENROAD_EXE", "/home/bailufrost/.local/bin/openroad")
platform = os.environ.get("SKY130_PLATFORM", "/home/bailufrost/eda/OpenROAD-flow-scripts-live/flow/platforms/sky130hd")
periods = [2.0, 1.75, 1.73, 1.725, 1.7221, 1.7220, 1.72, 1.70]
rows = []
for period in periods:
    run = root / ("T_" + f"{period:.4f}".replace(".", "p") + "ns")
    reports, logs = run / "reports", run / "logs"
    reports.mkdir(parents=True, exist_ok=True)
    logs.mkdir(exist_ok=True)
    sdc = run / "counter.sdc"
    sdc.write_text(make_sdc(period))
    env = dict(os.environ, SKY130_PLATFORM=platform, OPENROAD_RUN_DIR=str(run),
               COUNTER_RESULTS_DIR=str(inputs), COUNTER_SDC_FILE=str(sdc))
    with (logs / "console.log").open("w") as output:
        subprocess.run([executable, "-no_init", "-exit", "-log", str(logs / "sta.log"),
                        str(flow / "scripts/sta.tcl")], env=env, stdout=output, stderr=subprocess.STDOUT, check=True)
    assert not (reports / "check_setup.rpt").read_text().strip()
    assert not (reports / "electrical_violations.rpt").read_text().strip()
    annotation = (reports / "parasitic_annotation.rpt").read_text()
    assert "Found 0 partially unannotated drivers." in annotation
    assert set(re.findall(r"^ (\S+)\s*$", annotation, re.M)) == {"clkload0/Y"}
    maximum = paths((reports / "setup.rpt").read_text())
    minimum = paths((reports / "hold.rpt").read_text())
    metrics = analyze_clock_paths(run, routed, sdc)
    raw = (reports / "timing_summary.rpt").read_text()
    timing = {key: float(value) for key, value in re.findall(
        r"^(worst slack max|worst slack min|tns max|tns min) ([-\d.]+)$", raw, re.M)}
    data_holds = [p["slack_ns"] for p in minimum if "positive level-sensitive latch" in p["startpoint"]
                  and "positive level-sensitive latch" in p["endpoint"]]
    row = {
        "period_ns": period, "frequency_mhz": 1000 / period,
        "max_slack_ns": timing["worst slack max"], "max_tns_ns": timing["tns max"],
        "min_slack_ns": timing["worst slack min"], "min_tns_ns": timing["tns min"],
        "en_hold_ns": min(p["slack_ns"] for p in minimum if p["startpoint"].startswith("en ")),
        "internal_latch_hold_ns": min(data_holds),
        "max_critical": min(maximum, key=lambda p: p["slack_ns"]),
        "output_slacks_ns": {f"count[{bit}]": min(p["slack_ns"] for p in maximum
                              if p["endpoint"].startswith(f"count[{bit}] ")) for bit in range(4)},
        "nominal_phase_gaps": metrics["nominal_phase_gaps"],
        "reports": str(reports.relative_to(root)),
    }
    rows.append(row)
    print(json.dumps(row), flush=True)

base_slack = next(row["max_slack_ns"] for row in rows if row["period_ns"] == 1.75)
coefficient = 1 + waveforms["phi1"][2] / base_period - waveforms["phi2"][1] / base_period
estimate = 1.75 - base_slack / coefficient
manifest = {
    "corner": "SKY130 HD TT / 25 C / 1.80 V, fixed routed netlist and SPEF",
    "waveform_fractions": {name: [rise / period, fall / period]
                           for name, (period, rise, fall) in waveforms.items()},
    "output_setup_period_coefficient": coefficient,
    "estimated_setup_limit_ns": estimate, "estimated_setup_fmax_mhz": 1000 / estimate,
    "selected_period_ns": 1.73, "selected_frequency_mhz": 1000 / 1.73,
    "limitation": "Setup-limited estimate; en hold and reset removal remain violated at every tested period.",
    "points": rows,
    "sha256": {str(p.relative_to(flow)): hashlib.sha256(p.read_bytes()).hexdigest()
               for p in (inputs / "counter_routed.v", inputs / "counter.spef", inputs / "template.sdc",
                         flow / "scripts/sta.tcl", flow / "scripts/common.tcl")},
}
(root / "summary.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")
lines = ["period_ns,frequency_mhz,max_slack_ns,max_tns_ns,min_slack_ns,en_hold_ns,internal_latch_hold_ns"]
for row in rows:
    lines.append(",".join(str(row[key]) for key in lines[0].split(",")))
(root / "sweep.csv").write_text("\n".join(lines) + "\n")
assert next(row for row in rows if row["period_ns"] == 1.7220)["max_slack_ns"] < 0
assert next(row for row in rows if row["period_ns"] == 1.7221)["max_slack_ns"] > 0
assert next(row for row in rows if row["period_ns"] == 1.73)["max_slack_ns"] > 0
print(f"SETUP_LIMIT ~{estimate:.7f} ns / {1000/estimate:.4f} MHz; selected 1.73 ns.")
