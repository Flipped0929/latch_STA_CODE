#pragma once

#include <cstdint>
#include <functional>
#include <string>
#include <vector>

#include <nlohmann/json.hpp>

struct ClockGateTarget {
    std::string first;
    std::string second;
    std::string base_type;
};

void remove_enable(nlohmann::json& cell, const std::string& base_type);

void gate_clocks(nlohmann::json& cells, const std::vector<ClockGateTarget>& targets,
                 const std::function<std::string(const std::string&)>& unique_name,
                 const std::function<std::int64_t(const std::string&)>& add_wire);
