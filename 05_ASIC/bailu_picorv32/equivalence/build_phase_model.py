#!/usr/bin/env python3
"""从 Yosys JSON 检查相位边界条件，并生成仅供形式验证的同步采样模型。"""

import hashlib
import json
from pathlib import Path
import re
import sys


# 只接受当前转换流程实际使用的标量单元，不猜测其他单元的功能。
EXPRESSIONS = {
    "$_NOT_": ("A", "~{A}"),
    "$_AND_": ("AB", "{A} & {B}"),
    "$_ANDNOT_": ("AB", "{A} & ~{B}"),
    "$_OR_": ("AB", "{A} | {B}"),
    "$_ORNOT_": ("AB", "{A} | ~{B}"),
    "$_NAND_": ("AB", "~({A} & {B})"),
    "$_NOR_": ("AB", "~({A} | {B})"),
    "$_XOR_": ("AB", "{A} ^ {B}"),
    "$_XNOR_": ("AB", "~({A} ^ {B})"),
    "$_MUX_": ("ABS", "{S} ? {B} : {A}"),
}


def require(condition, message):
    """结构检查不满足时停止，不能靠忽略连接或增加假设生成模型。"""
    if not condition:
        raise ValueError(message)


def build_model(design):
    """返回采样模型及结构证据；不修改输入 JSON，不初始化 CPU 状态。"""
    require(set(design.get("modules", {})) == {"picorv32"},
            "Expected one flattened module named picorv32")
    module = design["modules"]["picorv32"]
    require(not module.get("memories") and not module.get("processes"),
            "Memories/processes must be lowered before phase analysis")
    ports, cells = module["ports"], module["cells"]
    require("clk" not in ports, "The new model clock name clk is already used")
    for name, port in ports.items():
        require(re.fullmatch(r"[A-Za-z_][A-Za-z_0-9]*", name),
                f"Unsupported port name: {name}")
        require(port["direction"] in ("input", "output") and port["bits"],
                f"Invalid port direction/width: {name}")
        require(not port.get("offset", 0) and not port.get("upto", 0),
                f"Non-zero-based/ascending ports are unsupported: {name}")
    for name, net in module.get("netnames", {}).items():
        require("init" not in net.get("attributes", {}),
                f"Initialized net needs a separate initial-state mapping: {name}")

    inputs = set()
    for name, port in ports.items():
        if port["direction"] == "input":
            for bit in port["bits"]:
                require(type(bit) is int and bit not in inputs,
                        f"Constant or aliased input port: {name}")
                inputs.add(bit)
    clocks = []
    for name in ("clk_1", "clk_2"):
        require(name in ports and ports[name]["direction"] == "input" and
                len(ports[name]["bits"]) == 1, f"Missing scalar clock {name}")
        clocks.append(ports[name]["bits"][0])
    clk1, clk2 = clocks
    drivers, latches, all_bits = {}, {}, set(inputs)
    for name, cell in cells.items():
        kind, pins = cell["type"], cell["connections"]
        require(not cell.get("parameters"), f"Parameterized primitive: {name}")
        require(kind == "$_DLATCH_P_" or kind in EXPRESSIONS,
                f"Unsupported primitive {name}: {kind}")
        input_pins = "DE" if kind == "$_DLATCH_P_" else EXPRESSIONS[kind][0]
        output_pin = "Q" if kind == "$_DLATCH_P_" else "Y"
        require(set(pins) == set(input_pins + output_pin),
                f"Unexpected primitive pins: {name}")
        for pin, bits in pins.items():
            require(len(bits) == 1 and all(
                type(b) is int or (isinstance(b, str) and b in ("0", "1", "x"))
                for b in bits), f"Non-scalar/invalid connection: {name}.{pin}")
            require(cell["port_directions"][pin] ==
                    ("output" if pin == output_pin else "input"),
                    f"Invalid pin direction: {name}.{pin}")
            all_bits.update(b for b in bits if type(b) is int)
        q = pins[output_pin][0]
        require(type(q) is int and q not in inputs and q not in drivers,
                f"Multiple/invalid drivers at {name}.{output_pin}")
        drivers[q] = (name, cell)
        if kind == "$_DLATCH_P_":
            latches[q] = (name, cell)
    require(latches, "No latches found")

    # 叶节点以 latch Q 为边界，保留原始结构而不依赖实例名称匹配。
    roots_cache, visiting = {}, set()

    def roots(bit):
        if isinstance(bit, str) or bit in inputs or bit in latches:
            return {bit}
        if bit not in roots_cache:
            require(bit in drivers, f"Undriven bit {bit}")
            require(bit not in visiting, f"Combinational cycle through bit {bit}")
            visiting.add(bit)
            _, cell = drivers[bit]
            found = set()
            for pin, direction in cell["port_directions"].items():
                if direction == "input":
                    found.update(roots(cell["connections"][pin][0]))
            visiting.remove(bit)
            roots_cache[bit] = found
        return roots_cache[bit]

    # 第一相必须无条件透明；第二相仅接受直接时钟或由第一相 Q 控制的 AND 门控。
    phase1 = {q for q, (_, c) in latches.items() if c["connections"]["E"] == [clk1]}
    phase2 = set(latches) - phase1
    require(phase1 and phase2, "Both latch phases must exist")
    enables, gates = {}, set()
    for q in phase2:
        name, cell = latches[q]
        enable = cell["connections"]["E"][0]
        if enable == clk2:
            enables[q] = "1"
        else:
            require(enable in drivers, f"Unsupported phase-2 enable: {name}")
            gate_name, gate = drivers[enable]
            require(gate["type"] == "$_AND_", f"Unsupported clock gate: {gate_name}")
            a, b = (gate["connections"][p][0] for p in ("A", "B"))
            control = b if a == clk2 else a if b == clk2 else None
            require(control in phase1, f"Clock gate lacks a frozen phase-1 enable: {name}")
            enables[q] = control
            gates.add(gate_name)
        data_roots = roots(cell["connections"]["D"][0])
        require(data_roots <= phase1 | {"0", "1", "x"},
                f"Phase-2 data is not isolated by phase-1 latches: {name}")

    # 第一相内可以有前馈级联，但不能有透明反馈；时钟不得作为数据。
    finished, stack, depths = set(), set(), {}

    def visit(q):
        require(q not in stack, f"Transparent phase-1 feedback: {latches[q][0]}")
        if q in finished:
            return depths[q]
        stack.add(q)
        data_roots = roots(latches[q][1]["connections"]["D"][0])
        require(not data_roots.intersection(clocks),
                f"Clock used as data at {latches[q][0]}")
        depth = 1 + max((visit(p) for p in data_roots & phase1), default=0)
        stack.remove(q)
        finished.add(q)
        depths[q] = depth
        return depth

    for q in phase1:
        visit(q)
    for name, port in ports.items():
        if port["direction"] == "output":
            all_bits.update(b for b in port["bits"] if type(b) is int)
            for bit in port["bits"]:
                require(not roots(bit).intersection(phase1 | set(clocks)),
                        f"Output {name} exposes phase-1 state or clock; abstraction rejected")
    for bit in all_bits:
        roots(bit)

    def ref(bit):
        return f"n_{bit}" if type(bit) is int else f"1'b{bit}"

    model_ports = {n: p for n, p in ports.items() if n not in ("clk_1", "clk_2")}
    lines = ["`timescale 1ns / 1ps",
             "// Generated phase-boundary model; not a replacement implementation.",
             "// Valid only after the JSON structural checks and under the harness protocol.",
             "module picorv32 (", "    input clk,"]
    declarations = []
    for name, port in model_ports.items():
        width = len(port["bits"])
        vector = f"[{width - 1}:0] " if width > 1 else ""
        declarations.append(f"    {port['direction']} {vector}{name}")
    lines += [",\n".join(declarations), ");"]
    for bit in sorted(all_bits):
        lines.append(f"  {'reg' if bit in phase2 else 'wire'} {ref(bit)};")
    lines += [f"  assign {ref(clk1)} = 1'b0;", f"  assign {ref(clk2)} = 1'b1;"]
    for name, port in model_ports.items():
        for i, bit in enumerate(port["bits"]):
            pin = f"{name}[{i}]" if len(port["bits"]) > 1 else name
            if port["direction"] == "input":
                lines.append(f"  assign {ref(bit)} = {pin};")
            else:
                lines.append(f"  assign {pin} = {ref(bit)};")

    # 仅恢复真实第二相状态的直接别名，供 EQY 产生并证明局部状态对应关系。
    # 第一相/组合中间量不恢复为匹配点，不能凭同名假定它们在同一宏周期相等。
    state_aliases, named_bits = [], set()
    for name, net in module.get("netnames", {}).items():
        bits = net["bits"]
        if name in model_ports or net.get("hide_name", 0) or re.fullmatch(r"_\d+_", name):
            continue
        if not set(bits).intersection(phase2) or not set(bits) <= phase2 | {"0", "1", "x"}:
            continue
        require(name and not any(c.isspace() or c == "\x00" for c in name),
                f"Invalid state alias name: {name!r}")
        require(name != "clk" and not re.fullmatch(r"n_\d+", name),
                f"State alias conflicts with generated model names: {name}")
        offset, width = net.get("offset", 0), len(bits)
        require(type(offset) is int and offset >= 0, f"Invalid alias offset: {name}")
        if width > 1 or offset:
            high = offset + width - 1
            bounds = f"[{offset}:{high}]" if net.get("upto", 0) else f"[{high}:{offset}]"
            vector = bounds + " "
        else:
            vector = ""
        escaped = "\\" + name + " "
        lines.append(f"  (* keep *) wire {vector}{escaped};")
        value = "{" + ", ".join(ref(b) for b in reversed(bits)) + "}" if width > 1 else ref(bits[0])
        lines.append(f"  assign {escaped}= {value};")
        state_aliases.append(name)
        named_bits.update(set(bits) & phase2)
    for port in model_ports.values():
        if port["direction"] == "output":
            named_bits.update(set(port["bits"]) & phase2)
    for name, cell in cells.items():
        pins, kind = cell["connections"], cell["type"]
        if kind == "$_DLATCH_P_":
            q = pins["Q"][0]
            if q in phase1:
                lines.append(f"  assign {ref(q)} = {ref(pins['D'][0])};")
        else:
            ins, template = EXPRESSIONS[kind]
            expr = template.format(**{p: ref(pins[p][0]) for p in ins})
            lines.append(f"  assign {ref(pins['Y'][0])} = {expr};")
    lines += ["  // All RHS values are evaluated before the macrocycle state commit.",
              "  always @(posedge clk) begin"]
    for q in sorted(phase2):
        data = ref(latches[q][1]["connections"]["D"][0])
        if enables[q] == "1":
            lines.append(f"    {ref(q)} <= {data};")
        else:
            lines += [f"    if ({ref(enables[q])}) begin", f"      {ref(q)} <= {data};", "    end"]
    lines += ["  end", "endmodule", ""]
    report = {
        "phase1_latches": len(phase1), "phase2_latches": len(phase2),
        "gated_phase2_latches": sum(e != "1" for e in enables.values()),
        "clock_gates": len(gates), "max_phase1_depth": max(depths.values()),
        "phase2_data_isolated": True, "phase2_enables_frozen": True,
        "phase1_acyclic": True, "outputs_independent_of_phase1": True,
        "cpu_initialization_added": False,
        "phase2_state_aliases": sorted(state_aliases),
        "named_phase2_bits": len(named_bits),
        "contract": "phi1 then phi2, nonoverlapping, settled binary logic; inputs held for the macrocycle",
        "proof_scope": "Structural justification of the boundary abstraction; NOT RTL equivalence proof",
    }
    return "\n".join(lines), report


def main():
    """验证成功后写模型；失败返回非零，使 EQY 停止而不读取旧模型。"""
    require(len(sys.argv) == 4, "Usage: build_phase_model.py INPUT.json OUTPUT.v REPORT.json")
    source, target, report_path = map(Path, sys.argv[1:])
    raw = source.read_bytes()
    text, report = build_model(json.loads(raw))
    report["json_sha256"] = hashlib.sha256(raw).hexdigest()
    report["generator_sha256"] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    # 为跨阶段验证链记录同一工程中的原 RTL、综合网表和 latch 网表版本。
    project = Path(__file__).resolve().parent.parent
    report["design_sha256"] = {
        path.relative_to(project).as_posix(): hashlib.sha256(path.read_bytes()).hexdigest()
        for path in (project / "picorv32.v", project / "picorv32_latch/picorv32_yosys.v",
                     project / "picorv32_latch/picorv32_latch.v")
        if path.is_file()
    }
    target.parent.mkdir(parents=True, exist_ok=True)
    report_path.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(text, encoding="utf-8")
    report_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print("PASS: phase-boundary structural checks " + json.dumps(report))


if __name__ == "__main__":
    try:
        main()
    except (ValueError, KeyError, TypeError, RecursionError, OSError) as error:
        print(f"ERROR: phase model rejected: {error}")
        sys.exit(1)
