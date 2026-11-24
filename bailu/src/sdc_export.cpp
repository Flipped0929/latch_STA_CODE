#include "sdc_export.hpp"
#include <cmath>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <regex>
#include <sstream>
#include <stdexcept>

void exportHowardSdc(const std::string &output, const DelayGraph &dg, double initial,
                     double duty, const McrResult &howard, const McrResult &lp)
{
    const auto &io = dg[boost::graph_bundle];
    const bool counterModel = !io.timingModel.empty();
    if (!validDelayGraph(dg, initial) ||
        (counterModel ? !validCounterMcr(dg, duty) : (!io.enabled || !io.staConditions)) ||
        !std::isfinite(duty) || duty <= 0.0 || duty > 0.5)
        throw std::invalid_argument("SDC export requires v3 STA conditions or supported zero-skew counter v4 data");
    Graph graph;
    getMcrGraph(dg, graph, initial, duty);
    const auto validated = [&](const McrResult &result) {
        if (result.status != McrStatus::Optimal || !std::isfinite(result.period) || result.period <= 0.0 ||
            !std::isfinite(result.ratio) || !std::isfinite(result.maxViolation) ||
            result.maxViolation > kMcrFeasibilityEps || result.skew.size() != boost::num_vertices(dg) ||
            std::fabs(initial - 2.0 * result.ratio - result.period) > kMcrFeasibilityEps ||
            mcrPotentialViolation(graph, result.ratio, result.potential) > kMcrFeasibilityEps ||
            mcrScheduleViolation(dg, result.period, result.potential, duty) > kMcrFeasibilityEps)
            return false;
        for (size_t k = 0; k < result.skew.size(); ++k)
            if (!std::isfinite(result.skew[k]) ||
                std::fabs(result.skew[k] - result.potential[mcrIndex(k, kMcrSkew)]) > kMcrFeasibilityEps)
                return false;
        return true;
    };
    if (!validated(howard) || !validated(lp) || std::fabs(howard.period - lp.period) > kMcrPeriodEps)
        throw std::invalid_argument("SDC export requires feasible Howard and LP results with matching periods; no fallback is exported");
    const auto name = [](const std::string &value) {
        // shortcut: flat names and numeric bus bits only; reject other Tcl/glob syntax.
        if (!std::regex_match(value, std::regex("[A-Za-z_][A-Za-z0-9_]*(\\[[0-9]+\\])?")))
            throw std::invalid_argument("SDC export supports flat identifiers and numeric bus bits only: " + value);
        return "{" + value + "}";
    };
    std::ostringstream sdc;
    if (counterModel)
    {
        const auto &counter = *io.counterTiming;
        const auto clock = name(counter.clockName), clockPort = name(counter.clockPort);
        sdc << std::setprecision(17)
            << "# Counter MCR Howard + independent LP; fixed scalar timing envelopes; ideal zero skew.\n"
            << "# model=" << io.timingModel << "; min-delay hold certified by opening-response bounds.\n"
            << "# Reported pulse checks only; independent OpenSTA validation is required.\n"
            << "# period_ns=" << howard.period << " frequency_MHz=" << 1000.0 / howard.period << "\n"
            << "if {[llength [get_ports " << clockPort << "]] != 1} {error {Missing clock port}}\n"
            << "create_clock -name " << clock << " -period " << howard.period << " -waveform {"
            << 0.5 * howard.period << " " << howard.period << "} [get_ports " << clockPort << "]\n"
            << "set_clock_latency -source 0.0 [get_clocks " << clock << "]\n"
            << "set_clock_latency 0.0 [get_clocks " << clock << "]\n"
            << "set_clock_transition " << counter.clockTransition << " [get_clocks " << clock << "]\n"
            << "set_clock_uncertainty -setup " << io.setupUncertainty << " [get_clocks " << clock << "]\n"
            << "set_clock_uncertainty -hold " << io.holdUncertainty << " [get_clocks " << clock << "]\n";
        for (const auto &entry : counter.inputs)
        {
            const auto port = name(entry.first);
            sdc << "if {[llength [get_ports " << port << "]] != 1} {error {Missing input port}}\n"
                << "set_input_delay -clock " << clock << " -min " << entry.second.minDelay << " [get_ports " << port << "]\n"
                << "set_input_delay -clock " << clock << " -max " << entry.second.maxDelay << " [get_ports " << port << "]\n"
                << "set_input_transition " << entry.second.transition << " [get_ports " << port << "]\n";
        }
        for (const auto &entry : counter.outputs)
        {
            const auto port = name(entry.first);
            sdc << "if {[llength [get_ports " << port << "]] != 1} {error {Missing output port}}\n"
                << "set_output_delay -clock " << clock << " -min " << entry.second.minDelay << " [get_ports " << port << "]\n"
                << "set_output_delay -clock " << clock << " -max " << entry.second.maxDelay << " [get_ports " << port << "]\n"
                << "set_load " << entry.second.load << " [get_ports " << port << "]\n";
        }
        size_t latches = 0;
        for (size_t k = 1; k < boost::num_vertices(dg); ++k)
            if (dg[k].kind == NodeIdx::Kind::Latch)
            {
                ++latches;
                name(dg[k].name);
                const auto pin = "{" + dg[k].name + (dg[k].polarity == NodeIdx::Polarity::Negative ? "/GATE_N}" : "/GATE}");
                sdc << "if {[llength [get_pins " << pin << "]] != 1} {error {Missing latch clock pin}}\n"
                    << "set_clock_latency -clock [get_clocks " << clock << "] 0.0 [get_pins " << pin << "]\n";
            }
        sdc << "if {[llength [all_registers -level_sensitive -cells]] != " << latches
            << "} {error {Candidate latch count mismatch}}\n";
    }
    else
    {
        const auto &sta = *io.staConditions;
        const auto clock = name(sta.clockName), port = name(sta.clockPort);
        const auto inputs = io.inputPorts.empty() ? std::vector<std::string>{io.inputPort} : io.inputPorts;
        const auto outputPort = name(io.outputPort);
        for (double value : {sta.clockTransition, sta.inputTransition, sta.outputLoad})
            if (!std::isfinite(value) || value < 0.0)
                throw std::invalid_argument("Invalid STA operating condition");
        sdc << std::setprecision(17)
            << "# MCR Howard candidate; ideal clock only; not an OpenSTA pass certificate.\n"
            << "# clock_skew_optimization=" << (io.optimizeSkew ? "enabled" : "disabled (zero skew)") << "\n"
            << "# Units: ns, pF. model=single_clock_rise_dag_v1; setup/hold capture cycles=1/0.\n"
            << "# solver=Howard period_ns=" << howard.period << " duty=" << duty
            << " LP_period_ns=" << lp.period << "\n";
        for (const auto &object : {port, outputPort})
            sdc << "if {[llength [get_ports " << object << "]] != 1} {error {Missing candidate port}}\n";
        for (const auto &input : inputs)
            sdc << "if {[llength [get_ports " << name(input) << "]] != 1} {error {Missing candidate input port}}\n";
        size_t latches = 0;
        for (size_t k = 1; k < boost::num_vertices(dg); ++k)
            latches += dg[k].kind == NodeIdx::Kind::Latch;
        sdc << "if {[llength [all_registers -level_sensitive -cells]] != " << latches
            << "} {error {Candidate latch count mismatch}}\n"
            << "create_clock -name " << clock << " -period " << howard.period << " -waveform {"
            << (1.0 - duty) * howard.period << " " << howard.period << "} [get_ports " << port << "]\n"
            << "set_clock_transition " << sta.clockTransition << " [get_clocks " << clock << "]\n"
            << "set_output_delay -clock " << clock << " -min " << io.outputMin << " [get_ports " << outputPort << "]\n"
            << "set_output_delay -clock " << clock << " -max " << io.outputMax << " [get_ports " << outputPort << "]\n"
            << "set_load " << sta.outputLoad << " [get_ports " << outputPort << "]\n"
            << "set_clock_uncertainty -setup " << io.setupUncertainty << " [get_clocks " << clock << "]\n"
            << "set_clock_uncertainty -hold " << io.holdUncertainty << " [get_clocks " << clock << "]\n";
        for (const auto &input : inputs)
            sdc << "set_input_delay -clock " << clock << " -min " << io.inputMin << " [get_ports " << name(input) << "]\n"
                << "set_input_delay -clock " << clock << " -max " << io.inputMax << " [get_ports " << name(input) << "]\n"
                << "set_input_transition " << sta.inputTransition << " [get_ports " << name(input) << "]\n";
        for (size_t k = 1; k < boost::num_vertices(dg); ++k)
            if (dg[k].kind == NodeIdx::Kind::Latch)
            {
                const auto instance = name(dg[k].name);
                const auto pin = "{" + dg[k].name + "/GATE}";
                sdc << "# " << instance << " skew_ns=" << howard.skew[k]
                    << " opening_ns=" << howard.skew[k] + (1.0 - duty) * howard.period
                    << " closing_ns=" << howard.skew[k] + howard.period << "\n"
                    << "if {[llength [get_pins " << pin << "]] != 1} {error {Missing latch GATE pin}}\n"
                    << "set_clock_latency -clock [get_clocks " << clock << "] " << howard.skew[k]
                    << " [get_pins " << pin << "]\n";
            }
    }
    namespace fs = std::filesystem;
    const fs::path path(output);
    if (path.extension() != ".sdc" || fs::exists(path) || fs::is_symlink(path))
        throw std::invalid_argument("SDC output must be a new .sdc file; refusing to overwrite: " + output);
    std::ofstream stream(path, std::ios::binary);
    if (!stream)
        throw std::runtime_error("Cannot create candidate SDC: " + output);
    stream << sdc.str();
    stream.close();
    if (!stream)
    {
        fs::remove(path);
        throw std::runtime_error("Cannot finish candidate SDC: " + output);
    }
}
