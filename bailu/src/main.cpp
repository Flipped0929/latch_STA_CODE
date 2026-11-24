#include <algorithm>
#include <cmath>
#include <chrono>
#include <iomanip>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <string>
#include <vector>
#include "ell.hpp"
#include "cutting_plane.hpp"
#include "timing_oracle.hpp"
#include "howard.hpp"
#include "YTO.hpp"
#include "LP.hpp"
#include "sdc_export.hpp"

using namespace std;
using namespace chrono;
using Arr = xt::xarray<double, xt::layout_type::row_major>;
double a = 1.0; // Objective coefficient referenced by the legacy ELL oracle.

static void printSkewSchedule(const string &tag, const vector<double> &skew, const DelayGraph &dg)
{
    cout << "Skew schedule s_k from " << tag << " (index 0 = reference, unit ns):" << endl;
    if (skew.empty())
    {
        cout << "\t(unavailable)" << endl;
        return;
    }
    size_t latches = 0;
    for (size_t k = 1; k < skew.size(); ++k)
        latches += dg[k].kind == NodeIdx::Kind::Latch;
    cout << "\tn_latch = " << latches << endl;
    for (size_t k = 0; k < skew.size(); ++k)
        if (k == kIoNodeIdx || dg[k].kind == NodeIdx::Kind::Latch)
            cout << "\ts[" << k << "] = " << skew[k] << "  (" << dg[k].name << ")" << endl;
}

static void invalidateMcrResult(McrResult &result)
{
    result.status = McrStatus::NumericalError;
    result.ratio = result.period = numeric_limits<double>::quiet_NaN();
    result.skew.clear();
    result.potential.clear();
}

static void checkMcrResult(const DelayGraph &dg, const Graph &g, McrResult &result, double dutyCycle)
{
    if (result.status != McrStatus::Optimal)
        return;
    result.maxViolation = max(mcrPotentialViolation(g, result.ratio, result.potential),
                              mcrScheduleViolation(dg, result.period, result.potential, dutyCycle));
    if (result.skew.size() != boost::num_vertices(dg))
        result.maxViolation = numeric_limits<double>::infinity();
    if (isfinite(result.maxViolation))
        for (size_t k = 0; k < result.skew.size(); ++k)
        {
            if (!isfinite(result.skew[k]))
            {
                result.maxViolation = numeric_limits<double>::infinity();
                break;
            }
            result.maxViolation = max(result.maxViolation,
                fabs(result.skew[k] - result.potential[mcrIndex(k, kMcrSkew)]));
        }
    if (!isfinite(result.maxViolation) || result.maxViolation > kMcrFeasibilityEps)
        invalidateMcrResult(result);
}

static void printMcrResult(const string &tag, const McrResult &result, nanoseconds elapsed, int iterations, const DelayGraph &dg)
{
    cout << '\t' << "T_" << tag << " = " << result.period << " ns, time is "
         << elapsed.count() / (1e6 * iterations) << " ms, status = " << mcrStatusToString(result.status)
         << ", cycle_len = " << result.criticalCycle.size() << ", max_violation = "
         << result.maxViolation << ", iters = " << result.iterations << endl;
    if (result.status == McrStatus::Optimal && dg[boost::graph_bundle].optimizeSkew)
        printSkewSchedule(tag, result.skew, dg);
}

int main(int argc, char *const argv[])
{
    try
    {
        vector<string> positional;
        string sdcOutput;
        double dutyCycle = 0.5;
        bool dutySpecified = false;
        bool noSkew = false;
        bool readOnly = false;
        for (int i = 1; i < argc; ++i)
        {
            const string argument = argv[i];
            if (argument == "--read-only")
                readOnly = true;
            else if (argument == "--no-skew")
                noSkew = true;
            else if (argument == "--duty-cycle" || argument == "--export-sdc")
            {
                if (++i == argc || string(argv[i]).rfind("--", 0) == 0)
                    throw invalid_argument("Missing value for " + argument);
                if (argument == "--export-sdc")
                {
                    if (!sdcOutput.empty() || string(argv[i]).empty())
                        throw invalid_argument("Specify one nonempty --export-sdc path");
                    sdcOutput = argv[i];
                }
                else
                {
                    size_t consumed = 0;
                    dutyCycle = stod(argv[i], &consumed);
                    if (dutySpecified || consumed != string(argv[i]).size() || !isfinite(dutyCycle) ||
                        dutyCycle <= 0.0 || dutyCycle > 0.5)
                        throw invalid_argument("Specify one finite MCR duty cycle in (0, 0.5]");
                    dutySpecified = true;
                }
            }
            else if (argument.rfind("--", 0) == 0)
                throw invalid_argument("Unknown option: " + argument);
            else
                positional.push_back(argument);
        }
        if (positional.size() != 3 && positional.size() != 4)
            throw invalid_argument("Usage: main <input.out|input.rslt> <positive iterations> <positive ellipsoid radius> [latch_timing.json] [--read-only] [--no-skew] [--duty-cycle fraction] [--export-sdc new_file.sdc]");
        if (readOnly && !sdcOutput.empty())
            throw invalid_argument("--read-only cannot export a solver SDC");
        const string filename = positional[0];
        size_t used = 0;
        const int iter = stoi(positional[1], &used);
        if (used != positional[1].size() || iter <= 0)
            throw invalid_argument("Iterations must be a positive integer");
        const double alpha = stod(positional[2], &used);
        if (used != positional[2].size() || !isfinite(alpha) || alpha <= 0.0)
            throw invalid_argument("Ellipsoid radius must be finite and positive");
        cout << setprecision(17) << filename << endl;
        DelayGraph dg;
        double tInitial = 0.0;
        if (!readDelayGraph(filename, dg, tInitial))
            return 1;

        if (positional.size() == 4)
            readLatchTiming(positional[3], dg);
        else if (!dg[boost::graph_bundle].timingModel.empty())
            throw invalid_argument("Counter timing input requires its accompanying schema-v4 timing JSON");
        else if (!readOnly)
        {
            const LatchTiming timing{0.1948711, -0.0260762, 0.1956779,
                                     0.2897848, 0.2408861, 0.2727443};
            for (size_t k = 0; k < boost::num_vertices(dg); ++k)
                if (k != kIoNodeIdx)
                    dg[k].timing = timing;
        }
        auto &io = dg[boost::graph_bundle];
        if (readOnly)
        {
            if (!validDelayGraph(dg, tInitial))
                throw invalid_argument("Invalid delay graph");
            size_t latches = 0, inputs = 0, outputs = 0;
            for (size_t k = 1; k < boost::num_vertices(dg); ++k)
            {
                latches += dg[k].kind == NodeIdx::Kind::Latch;
                inputs += dg[k].kind == NodeIdx::Kind::Input;
                outputs += dg[k].kind == NodeIdx::Kind::Output;
            }
            cout << "Timing graph loaded (read only): vertices=" << boost::num_vertices(dg)
                 << " (including reference), edges=" << boost::num_edges(dg)
                 << ", latches=" << latches << ", inputs=" << inputs << ", outputs=" << outputs
                 << ", maximum combinational delay=" << tInitial << " ns" << endl;
            return 0;
        }
        io.optimizeSkew = !noSkew;
        const bool counterModel = !io.timingModel.empty();
        if (!sdcOutput.empty() && !counterModel && (!io.enabled || !io.staConditions))
            throw invalid_argument("--export-sdc requires v3 JSON with sta_conditions; regenerate the timing JSON");
        if ((io.enabled || counterModel) && !dutySpecified)
            dutyCycle = io.dutyCycle;
        Graph g_mcr, g_ell;
        getMcrGraph(dg, g_mcr, tInitial, dutyCycle);
        double tInitialEll = 0.0;
        if (!io.enabled && !noSkew)
            getEllGraph(filename, g_ell, tInitialEll);
        nanoseconds time_howard{0}, time_yto{0}, time_lp_mcr{0}, time_ell{0}, time_lp_ell{0};
        McrResult how_last, yto_last, lp_last;
        double t_ell = numeric_limits<double>::quiet_NaN(), w_ell = t_ell;
        double t_lp_ell = t_ell, w_lp_ell = t_ell;
        constexpr double solverEps = 1e-10;
        for (int iq = 0; iq < iter; ++iq)
        {
            Howard how(g_mcr, boost::num_vertices(g_mcr), tInitial, solverEps);
            auto beginTime = high_resolution_clock::now();
            how.run();
            time_howard += high_resolution_clock::now() - beginTime;
            how_last = how.getResult();
            checkMcrResult(dg, g_mcr, how_last, dutyCycle);

            if (!counterModel)
            {
                YTO yto(g_mcr, boost::num_vertices(g_mcr), tInitial, solverEps);
                beginTime = high_resolution_clock::now();
                yto.run();
                time_yto += high_resolution_clock::now() - beginTime;
                yto_last = yto.getResult();
                checkMcrResult(dg, g_mcr, yto_last, dutyCycle);
            }

            time_lp_mcr += mcrLP(dg, tInitial, lp_last, dutyCycle);
            checkMcrResult(dg, g_mcr, lp_last, dutyCycle);
            if (lp_last.status == McrStatus::Optimal)
                for (McrResult *solver : {&how_last, &yto_last})
                    if (solver->status == McrStatus::Optimal &&
                        fabs(solver->period - lp_last.period) > kMcrPeriodEps)
                    {
                        cerr << (solver == &how_last ? "Howard" : "YTO")
                             << " failed MCR-LP period check: gap = "
                             << fabs(solver->period - lp_last.period) << " ns" << endl;
                        invalidateMcrResult(*solver);
                    }

            if (!io.enabled && !noSkew)
            {
                auto P = timing_oracle<Graph>(g_ell);
                auto E = ell(alpha, Arr{tInitialEll, 0});
                const auto options = Options{1000000, 1e-6};
                auto t = numeric_limits<double>::max();
                beginTime = high_resolution_clock::now();
                auto [x, ell_info] = cutting_plane_dc(P, E, t, options);
                time_ell += high_resolution_clock::now() - beginTime;
                t_ell = x[0];
                w_ell = x[1];
                time_lp_ell += ellLP(filename, t_lp_ell, w_lp_ell);
            }
        }
        cout << "=====================SUMMARY====================" << endl;
        cout << "Input file is " << filename << "\nInitial T is " << tInitial << " ns" << endl;
        cout << "MCR latch timing: " << (positional.size() == 4 ? positional[3] : "legacy uniform constants")
             << (counterModel ? " (ns); counter input/output ports and independent zero reference."
                 : (io.enabled ? " (ns); separate SDC input/output ports, anchor s[0]=0." : " (ns); the merged IO placeholder uses zero timing parameters.")) << endl;
        if (counterModel)
            cout << "Counter v4: opposite-phase feedback, master->slave cycles=0, slave/input->master cycles=1; "
                 << "independent IO budgets, 50% duty, zero skew; conservative min-delay hold certificate." << endl;
        if (io.enabled)
            cout << "SDC IO: " << io.inputPort << " (physical input ports="
                 << (io.inputPorts.empty() ? 1 : io.inputPorts.size()) << ") min/max=" << io.inputMin << "/" << io.inputMax
                 << " ns; " << io.outputPort << " min/max=" << io.outputMin << "/" << io.outputMax
                 << " ns; setup/hold uncertainty=" << io.setupUncertainty << "/" << io.holdUncertainty
                 << " ns; output setup/hold capture cycles=1/0; path cycle shift=0. Conservative hold guards enabled." << endl;
        size_t pulseCovered = 0, latchCount = 0;
        for (size_t k = 1; k < boost::num_vertices(dg); ++k)
            if (dg[k].kind == NodeIdx::Kind::Latch)
            {
                ++latchCount;
                pulseCovered += counterModel ? dg[k].reportedPulseWidth.has_value() : dg[k].clockChecks.characterized;
            }
        cout << "MCR pulse-width coverage: " << pulseCovered << "/" << latchCount
             << " latch instances" << (counterModel ? " (reported polarity only)" : "")
             << "; period lower bound = " << mcrPulsePeriodMin(dg, dutyCycle) << " ns."
             << (pulseCovered == latchCount ? "" : " Uncharacterized instances have no pulse-width constraint.") << endl;
        cout << "MCR: duty_cycle=" << dutyCycle << ", W=" << dutyCycle
             << "*T, s_IO=0, s_k <= T - " << kMcrSkewMargin
             << " ns; feasibility tolerance = " << kMcrFeasibilityEps << " ns." << endl;
        if (noSkew)
            cout << "Clock skew optimization disabled: all latch offsets are fixed to 0 ns." << endl;
        cout << "\t#vertices = " << boost::num_vertices(g_mcr)
             << ", #edges = " << boost::num_edges(g_mcr) << endl;
        printMcrResult("Howard", how_last, time_howard, iter, dg);
        if (!counterModel)
            printMcrResult("YTO", yto_last, time_yto, iter, dg);
        printMcrResult("LP_MCR", lp_last, time_lp_mcr, iter, dg);
        if (lp_last.status == McrStatus::Optimal)
        {
            if (how_last.status == McrStatus::Optimal)
                cout << "\t|T_Howard - T_LP_MCR| = " << fabs(how_last.period - lp_last.period) << " ns" << endl;
            if (yto_last.status == McrStatus::Optimal)
                cout << "\t|T_YTO - T_LP_MCR| = " << fabs(yto_last.period - lp_last.period) << " ns" << endl;
        }
        const McrResult *selected = nullptr;
        string selectedName;
        if (how_last.status == McrStatus::Optimal)
        {
            selected = &how_last;
            selectedName = "Howard";
        }
        else if (yto_last.status == McrStatus::Optimal)
        {
            selected = &yto_last;
            selectedName = "YTO (Howard failed)";
        }
        else if (lp_last.status == McrStatus::Optimal)
        {
            selected = &lp_last;
            selectedName = "LP (Howard/YTO failed)";
        }
        if (selected)
        {
            cout << "Selected MCR solver: " << selectedName << ", period = " << selected->period << " ns" << endl;
            if (!noSkew)
            {
                printSkewSchedule("selected " + selectedName, selected->skew, dg);
                cout << "Feasible optimum skew schedules can differ at the same period." << endl;
            }
            if (selected->period > 0.0)
                cout << "Model maximum clock frequency = " << 1000.0 / selected->period
                     << " MHz" << (noSkew ? " (zero skew)." : " (optimized skew).") << endl;
            else
                cout << "Model has no positive period bound; no finite maximum frequency is reported." << endl;
        }
        else
            cerr << "No validated MCR result; no clock period or schedule selected." << endl;
        if (!io.enabled && !noSkew)
        {
            cout << "ELL (independent legacy model):" << endl;
            cout << "\t#vertices = " << boost::num_vertices(g_ell) << ", #edges = " << boost::num_edges(g_ell) << endl;
            cout << "\tT_ELL = " << t_ell << " ns, W_ELL = " << w_ell << " ns, time is "
                 << time_ell.count() / (1e6 * iter) << " ms" << endl;
            cout << "\tT_LP_ELL = " << t_lp_ell << " ns, W_LP_ELL = " << w_lp_ell << " ns, time is "
                 << time_lp_ell.count() / (1e6 * iter) << " ms" << endl;
        }
        else if (noSkew)
            cout << "ELL skipped: its independent legacy model does not enforce zero skew." << endl;
        else
            cout << "ELL skipped: the independent legacy model has no SDC IO constraints." << endl;
        if (!sdcOutput.empty())
        {
            exportHowardSdc(sdcOutput, dg, tInitial, dutyCycle, how_last, lp_last);
            cout << "Exported Howard candidate SDC: " << sdcOutput << "; independent OpenSTA validation is pending." << endl;
        }
        return selected ? 0 : 2;
    }
    catch (const exception &error)
    {
        cerr << "Error: " << error.what() << endl;
        return 1;
    }
}
