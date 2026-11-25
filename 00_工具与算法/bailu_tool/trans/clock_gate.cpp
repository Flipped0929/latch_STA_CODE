#include "clock_gate.hpp"

#include <unordered_map>

using Json = nlohmann::json;
using Bit = std::int64_t;

void remove_enable(Json& cell, const std::string& base_type)
{
    cell["type"] = base_type;
    cell.at("connections").erase("E");
    cell.at("port_directions").erase("E");
}

void gate_clocks(Json& cells, const std::vector<ClockGateTarget>& targets,
                 const std::function<std::string(const std::string&)>& unique_name,
                 const std::function<Bit(const std::string&)>& add_wire)
{
    std::unordered_map<Bit, Bit> gated_clocks;
    for (const auto& target : targets) {
        auto& first = cells.at(target.first);
        auto& second = cells.at(target.second);
        auto& pins = second.at("connections");
        const auto& enable = pins.at("E").at(0);

        // The first phase can capture unconditionally because only the gated second phase reads it.
        if (enable == "0") {
            pins["C"] = Json::array({"0"});
        } else {
            auto [clock, inserted] = gated_clocks.try_emplace(enable.get<Bit>(), 0);
            if (inserted) {
                clock->second = add_wire(unique_name("gated_clk_2_"));
                cells[unique_name("gate_phi2_")] = {
                    {"hide_name", 0}, {"type", "$_AND_"},
                    {"parameters", Json::object()}, {"attributes", Json::object()},
                    {"port_directions", {{"A", "input"}, {"B", "input"}, {"Y", "output"}}},
                    {"connections", {{"A", pins.at("C")}, {"B", pins.at("E")},
                                     {"Y", Json::array({clock->second})}}},
                };
            }
            pins["C"] = Json::array({clock->second});
        }
        remove_enable(first, target.base_type);
        remove_enable(second, target.base_type);
    }
}
