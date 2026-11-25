#include <algorithm>
#include <cstdint>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#include "clock_gate.hpp"

namespace {
using Json = nlohmann::json;
using Bit = std::int64_t;

const std::unordered_map<std::string, std::string> dffe_to_dff{
    {"$_DFFE_PP_", "$_DFF_P_"},
    {"$_DFFE_PN0P_", "$_DFF_PN0_"},
    {"$_DFFE_PN1P_", "$_DFF_PN1_"},
    {"$_DFFE_PP0P_", "$_DFF_PP0_"},
    {"$_DFFE_PP1P_", "$_DFF_PP1_"},
};
const std::unordered_set<std::string> dff_types{
    "$_DFF_P_", "$_DFF_PN0_", "$_DFF_PN1_", "$_DFF_PP0_", "$_DFF_PP1_",
};
const std::unordered_set<std::string> combinational_types{
    "$_BUF_", "$_NOT_", "$_AND_", "$_NAND_", "$_OR_", "$_NOR_", "$_XOR_",
    "$_XNOR_", "$_ANDNOT_", "$_ORNOT_", "$_MUX_", "$_NMUX_", "$_MUX4_",
    "$_MUX8_", "$_MUX16_", "$_AOI3_", "$_OAI3_", "$_AOI4_", "$_OAI4_",
};

void duplicate(Json& module, const std::string& clock, bool gated)
{
    auto& ports = module.at("ports");
    auto& netnames = module.at("netnames");
    auto& cells = module.at("cells");
    auto name_taken = [&](const std::string& name) {
        return netnames.contains(name) || ports.contains(name) || cells.contains(name);
    };
    if ((clock != "clk_1" && name_taken("clk_1")) || name_taken("clk_2")) {
        throw std::runtime_error("clk_1 or clk_2 already exists");
    }
    const auto& clock_port = ports.at(clock);
    const auto& clock_bits = clock_port.at("bits");
    if (clock_port.at("direction") != "input" || clock_bits.size() != 1 ||
        !clock_bits.at(0).is_number_integer()) {
        throw std::runtime_error(clock + " must be a one-bit clock input");
    }
    const Bit phi1 = clock_bits.at(0).get<Bit>();
    auto uses_clock = [&](const Json& bits) {
        return std::find(bits.begin(), bits.end(), Json(phi1)) != bits.end();
    };

    Bit last_bit = 1;
    auto count_bits = [&](const Json& bits) {
        for (const auto& bit : bits) {
            if (bit.is_number_integer()) {
                last_bit = std::max(last_bit, bit.get<Bit>());
            }
        }
    };
    for (const auto& [name, port] : ports.items()) {
        if (name != clock && uses_clock(port.at("bits"))) {
            throw std::runtime_error(name + " exposes the clock as another port");
        }
        count_bits(port.at("bits"));
    }
    for (const auto& net : netnames) {
        if (net.at("attributes").contains("init")) {
            throw std::runtime_error("initialized nets are unsupported");
        }
        count_bits(net.at("bits"));
    }

    std::vector<std::string> originals;
    for (const auto& [name, cell] : cells.items()) {
        const auto type = cell.at("type").get<std::string>();
        const bool flip_flop = dff_types.count(type) || dffe_to_dff.count(type);
        const auto& pins = cell.at("connections");
        for (const auto& [pin, bits] : pins.items()) {
            count_bits(bits);
            if (!(flip_flop && pin == "C") && uses_clock(bits)) {
                throw std::runtime_error(name + "." + pin + " uses the clock as data");
            }
        }
        if (flip_flop) {
            if (pins.at("C") != Json::array({phi1})) {
                throw std::runtime_error(name + " is not driven by " + clock);
            }
            originals.push_back(name);
        } else if (!combinational_types.count(type)) {
            throw std::runtime_error(name + " has unsupported cell type " + type);
        }
    }
    if (originals.empty()) {
        throw std::runtime_error("no supported flip-flops found");
    }

    std::size_t serial = 0;
    auto unique_name = [&](const std::string& prefix) {
        std::string name;
        do {
            name = prefix + std::to_string(serial++);
        } while (name_taken(name));
        return name;
    };
    auto add_wire = [&](const std::string& name) {
        if (last_bit == std::numeric_limits<Bit>::max()) {
            throw std::runtime_error("net bit IDs exhausted");
        }
        const Bit bit = ++last_bit;
        netnames[name] = {{"hide_name", 0}, {"bits", Json::array({bit})},
                          {"attributes", Json::object()}};
        return bit;
    };

    if (clock != "clk_1") {
        auto old_port = ports.at(clock);
        auto old_net = netnames.at(clock);
        ports.erase(clock);
        netnames.erase(clock);
        ports["clk_1"] = std::move(old_port);
        netnames["clk_1"] = std::move(old_net);
    }
    const Bit phi2 = add_wire("clk_2");
    ports["clk_2"] = {{"direction", "input"}, {"bits", Json::array({phi2})}};

    std::unordered_map<Bit, Bit> sampled_enables;
    std::vector<ClockGateTarget> gate_targets;
    for (const auto& name : originals) {
        auto& second = cells.at(name);
        auto& second_pins = second.at("connections");
        const auto base = dffe_to_dff.find(second.at("type").get<std::string>());
        if (base != dffe_to_dff.end() && second_pins.at("E") == Json::array({"1"})) {
            remove_enable(second, base->second);
        }

        auto first = second;
        auto& first_pins = first.at("connections");
        const Bit q1 = add_wire(unique_name("dup_q1_"));
        first_pins["Q"] = Json::array({q1});
        second_pins["D"] = Json::array({q1});
        second_pins["C"] = Json::array({phi2});

        if (first_pins.contains("E")) {
            const auto& enable = first_pins.at("E").at(0);
            if (enable.is_number_integer()) {
                auto [sample, inserted] = sampled_enables.try_emplace(enable.get<Bit>(), 0);
                if (inserted) {
                    sample->second = add_wire(unique_name("dup_en1_"));
                    cells[unique_name("dup_enable_")] = {
                        {"hide_name", 0}, {"type", "$_DFF_P_"},
                        {"parameters", Json::object()}, {"attributes", Json::object()},
                        {"port_directions", {{"C", "input"}, {"D", "input"}, {"Q", "output"}}},
                        {"connections", {{"C", Json::array({phi1})}, {"D", first_pins.at("E")},
                                         {"Q", Json::array({sample->second})}}},
                    };
                }
                second_pins["E"] = Json::array({sample->second});
            } else if (enable != "0") {
                throw std::runtime_error(name + " has an undefined enable");
            }
        }
        first["hide_name"] = 0;
        const auto first_name = unique_name("dup_phi1_");
        if (gated && base != dffe_to_dff.end() && first_pins.contains("E")) {
            gate_targets.push_back({first_name, name, base->second});
        }
        cells[first_name] = std::move(first);
    }
    if (gated) {
        gate_clocks(cells, gate_targets, unique_name, add_wire);
    }
}
} // namespace

int main(int argc, char** argv)
{
    const bool gated = argc == 4 && std::string(argv[3]) == "--clock-gate";
    if (argc != 3 && !gated) {
        std::cerr << "Usage: duplicate <top> <clock> [--clock-gate] < input.json > output.json\n";
        return 1;
    }
    try {
        Json design = Json::parse(std::cin);
        auto& modules = design.at("modules");
        if (modules.size() != 1) {
            throw std::runtime_error("expected a flattened, single-module netlist");
        }
        duplicate(modules.at(argv[1]), argv[2], gated);
        std::cout << design << '\n';
        if (!std::cout) {
            throw std::runtime_error("could not write output JSON");
        }
    } catch (const std::exception& error) {
        std::cerr << "duplicate: " << error.what() << '\n';
        return 1;
    }
}
