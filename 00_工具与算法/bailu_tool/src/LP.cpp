#include <glpk.h>
#include <algorithm>
#include <array>
#include <cassert>
#include <cmath>
#include <initializer_list>
#include <iostream>
#include <limits>
#include <memory>
#include <stdexcept>
#include <utility>
#include "LP.hpp"

nanoseconds mcrLP(const DelayGraph &dg, double tInitial, McrResult &result, double dutyCycle)
{
    result = McrResult{};
    result.status = McrStatus::InvalidInput;
    result.ratio = result.period = std::numeric_limits<double>::quiet_NaN();
    const size_t n = boost::num_vertices(dg), m = boost::num_edges(dg);
    const auto &boundary = dg[boost::graph_bundle];
    const bool counterModel = !boundary.timingModel.empty();
    const size_t limit = static_cast<size_t>(std::numeric_limits<int>::max() - 1);
    if ((counterModel && !validCounterMcr(dg, dutyCycle)) || !validDelayGraph(dg, tInitial) || !std::isfinite(dutyCycle) ||
        dutyCycle <= 0.0 || dutyCycle > 0.5 || n > (limit - 1) / kMcrVarsPerNode ||
        n > limit / 14 || m > (limit - 14 * n) / 4)
        return nanoseconds{0};
    const double pulseMinimum = mcrPulsePeriodMin(dg, dutyCycle);
    if (!std::isfinite(pulseMinimum))
        return nanoseconds{0};
    const int columns = static_cast<int>(1 + kMcrVarsPerNode * n);
    std::unique_ptr<glp_prob, decltype(&glp_delete_prob)> owner(glp_create_prob(), &glp_delete_prob);
    glp_prob *lp = owner.get();
    result.status = McrStatus::SolverError;
    if (!lp)
        return nanoseconds{0};
    glp_set_prob_name(lp, boundary.optimizeSkew ? "MCR_with_clock_skew" : "MCR_zero_skew");
    glp_set_obj_dir(lp, GLP_MIN);
    glp_add_cols(lp, columns);
    glp_set_col_bnds(lp, 1, GLP_LO, pulseMinimum, 0.0);
    glp_set_obj_coef(lp, 1, 1.0);
    const auto column = [](size_t node, McrVariable variable) {
        return static_cast<int>(2 + mcrIndex(node, variable));
    };
    for (int c = 2; c <= columns; ++c)
        glp_set_col_bnds(lp, c, GLP_FR, 0.0, 0.0);
    for (size_t k = 0; k < n; ++k)
    {
        const bool fixed = counterModel || !boundary.optimizeSkew || k == kIoNodeIdx ||
                           (boundary.enabled && dg[k].kind != NodeIdx::Kind::Latch);
        glp_set_col_bnds(lp, column(k, kMcrSkew), fixed ? GLP_FX : GLP_LO, 0.0, 0.0);
        if ((boundary.enabled || counterModel) && k == kIoNodeIdx)
            for (const auto variable : {kMcrA, kMcrLatestA, kMcrD, kMcrLatestD})
                glp_set_col_bnds(lp, column(k, variable), GLP_FX, 0.0, 0.0);
    }
    const auto constraint = [&](double upper, std::initializer_list<std::pair<int, double>> coefficients, bool equality = false) {
        if (coefficients.size() > 3 || !std::isfinite(upper))
            throw std::logic_error("Invalid MCR LP row layout");
        std::array<int, 4> indices{};
        std::array<double, 4> values{};
        int count = 0;
        for (const auto &coefficient : coefficients)
        {
            indices[++count] = coefficient.first;
            values[count] = coefficient.second;
        }
        const int row = glp_add_rows(lp, 1);
        glp_set_row_bnds(lp, row, equality ? GLP_FX : GLP_UP, equality ? upper : 0.0, upper);
        glp_set_mat_row(lp, row, count, indices.data(), values.data());
    };
    // Independent primal formulation of PDF MCR constraints (4)-(12).
    for (size_t k = 0; k < n; ++k)
    {
        const int a = column(k, kMcrA), A = column(k, kMcrLatestA);
        const int d = column(k, kMcrD), D = column(k, kMcrLatestD), s = column(k, kMcrSkew);
        const auto &t = dg[k].timing;
        if (counterModel)
        {
            if (k == kIoNodeIdx)
                continue;
            if (dg[k].kind == NodeIdx::Kind::Input)
            {
                const auto &port = boundary.counterTiming->inputs.at(dg[k].name);
                constraint(port.minDelay, {{a, 1.0}, {1, -0.5}}, true);
                constraint(port.minDelay, {{d, 1.0}, {1, -0.5}}, true);
                constraint(port.maxDelay, {{A, 1.0}, {1, -0.5}}, true);
                constraint(port.maxDelay, {{D, 1.0}, {1, -0.5}}, true);
            }
            else
            {
                const bool output = dg[k].kind == NodeIdx::Kind::Output;
                const double open = dg[k].polarity == NodeIdx::Polarity::Negative ? 0.0 : 0.5;
                constraint(counterMinArrival(dg, k), {{a, 1.0}, {1, -(output ? 0.5 : open - 0.5)}}, true);
                if (output)
                {
                    constraint(0.0, {{d, 1.0}, {a, -1.0}}, true);
                    constraint(0.0, {{D, 1.0}, {A, -1.0}}, true);
                    constraint(-boundary.counterTiming->outputs.at(dg[k].name).maxDelay - boundary.setupUncertainty,
                               {{A, 1.0}, {1, -1.5}});
                }
                else
                {
                    constraint(min(t.tcqMin, t.tdqMin), {{d, 1.0}, {1, -open}}, true);
                    constraint(-t.tsu - boundary.setupUncertainty, {{A, 1.0}, {1, -(open + 0.5)}});
                    constraint(-t.tdqMax, {{A, 1.0}, {D, -1.0}});
                    constraint(-t.tcqMax, {{1, open}, {D, -1.0}});
                }
                constraint(0.0, {{a, 1.0}, {A, -1.0}});
                constraint(0.0, {{d, 1.0}, {D, -1.0}});
            }
            continue;
        }
        if (boundary.enabled && (k == kIoNodeIdx || dg[k].kind != NodeIdx::Kind::Latch))
        {
            if (k == kIoNodeIdx)
                continue;
            if (dg[k].kind == NodeIdx::Kind::Input)
            {
                constraint(boundary.inputMin, {{a, 1.0}, {1, -(1.0 - dutyCycle)}}, true);
                constraint(boundary.inputMin, {{d, 1.0}, {1, -(1.0 - dutyCycle)}}, true);
                constraint(boundary.inputMax, {{A, 1.0}, {1, -(1.0 - dutyCycle)}}, true);
                constraint(boundary.inputMax, {{D, 1.0}, {1, -(1.0 - dutyCycle)}}, true);
            }
            else
            {
                constraint(0.0, {{d, 1.0}, {a, -1.0}}, true);
                constraint(0.0, {{D, 1.0}, {A, -1.0}}, true);
                constraint(0.0, {{a, 1.0}, {A, -1.0}});
                constraint(boundary.outputMin - boundary.holdUncertainty, {{1, 1.0 - dutyCycle}, {a, -1.0}});
                constraint(-boundary.outputMax - boundary.setupUncertainty, {{A, 1.0}, {1, -(2.0 - dutyCycle)}});
            }
            continue;
        }
        if (k != kIoNodeIdx)
            constraint(-kMcrSkewMargin, {{s, 1.0}, {1, -1.0}});
        constraint(-t.thd - boundary.holdUncertainty, {{s, 1.0}, {a, -1.0}});
        constraint(-t.tsu - boundary.setupUncertainty, {{A, 1.0}, {s, -1.0}, {1, -1.0}});
        constraint(0.0, {{a, 1.0}, {A, -1.0}});
        constraint(0.0, {{d, 1.0}, {D, -1.0}});
        constraint(-t.tdqMin, {{a, 1.0}, {d, -1.0}});
        constraint(-t.tdqMax, {{A, 1.0}, {D, -1.0}});
        constraint(-t.tcqMin, {{s, 1.0}, {1, 1.0 - dutyCycle}, {d, -1.0}});
        constraint(-t.tcqMax, {{s, 1.0}, {1, 1.0 - dutyCycle}, {D, -1.0}});
    }
    auto range = boost::edges(dg);
    for (auto e = range.first; e != range.second; ++e)
    {
        const size_t i = dg[boost::source(*e, dg)].idx, j = dg[boost::target(*e, dg)].idx;
        if (counterModel)
        {
            const double cycles = dg[j].kind == NodeIdx::Kind::Latch &&
                dg[j].polarity == NodeIdx::Polarity::Negative ? 1.0 : 0.0;
            constraint(-dg[*e].maxDelay, {{column(i, kMcrLatestD), 1.0}, {column(j, kMcrLatestA), -1.0}, {1, -cycles}});
            continue;
        }
        const double shift = boundary.enabled ? 0.0 : 1.0;
        constraint(dg[*e].minDelay, {{1, shift}, {column(j, kMcrA), 1.0}, {column(i, kMcrD), -1.0}});
        constraint(-dg[*e].maxDelay, {{1, -shift}, {column(i, kMcrLatestD), 1.0}, {column(j, kMcrLatestA), -1.0}});
        if (boundary.enabled && dg[i].kind == NodeIdx::Kind::Latch)
        {
            const double earliest = std::min(dg[i].timing.tcqMin, dg[i].timing.tdqMin) + dg[*e].minDelay;
            if (dg[j].kind == NodeIdx::Kind::Output)
                constraint(earliest + boundary.outputMin - boundary.holdUncertainty, {{column(i, kMcrSkew), -1.0}});
            else
                constraint(earliest - dg[j].timing.thd - boundary.holdUncertainty,
                           {{column(j, kMcrSkew), 1.0}, {column(i, kMcrSkew), -1.0}, {1, -(1.0 - dutyCycle)}});
        }
    }
    glp_smcp parameters;
    glp_init_smcp(&parameters);
    parameters.tol_bnd = 1e-9;
    parameters.tol_dj = 1e-9;
    const auto beginTime = high_resolution_clock::now();
    const int solverCode = glp_simplex(lp, &parameters);
    const auto elapsed = duration_cast<nanoseconds>(high_resolution_clock::now() - beginTime);
    result.iterations = static_cast<size_t>(std::max(0, glp_get_it_cnt(lp)));
    const int status = glp_get_status(lp);
    if (status == GLP_NOFEAS || solverCode == GLP_ENOPFS)
        result.status = McrStatus::Infeasible;
    else if (solverCode == 0 && status == GLP_OPT)
    {
        const double period = glp_get_col_prim(lp, 1);
        std::vector<double> potential(kMcrVarsPerNode * n);
        for (size_t i = 0; i < potential.size(); ++i)
            potential[i] = glp_get_col_prim(lp, static_cast<int>(i + 2));
        result.maxViolation = mcrScheduleViolation(dg, period, potential, dutyCycle);
        if (!std::isfinite(result.maxViolation) || result.maxViolation > kMcrFeasibilityEps)
            result.status = McrStatus::NumericalError;
        else
        {
            result.status = McrStatus::Optimal;
            result.period = period;
            result.ratio = (tInitial - period) / 2.0;
            result.potential = std::move(potential);
            result.skew.resize(n);
            for (size_t k = 0; k < n; ++k)
                result.skew[k] = result.potential[mcrIndex(k, kMcrSkew)];
        }
    }
    return elapsed;
}

nanoseconds ellLP(const string &fileName, double &tlp, double &wlp)
{
    auto change = high_resolution_clock::now() - high_resolution_clock::now();
    DelayGraph dg;
    double tInitial = 0;
    if (!readDelayGraph(fileName, dg, tInitial))
        throw std::runtime_error("Cannot read delay graph: " + fileName);
    if (!dg[boost::graph_bundle].timingModel.empty())
        throw std::invalid_argument("ELL LP does not support the counter timing model");
    auto _v = boost::num_vertices(dg);
    auto _c = boost::num_edges(dg);
    int numvar = _v + 2;
    int numcon = 3 * _c;
    int numcof = 0; //nums of cof
    boost::graph_traits<DelayGraph>::edge_iterator eibegin, eiend;
    for (tie(eibegin, eiend) = boost::edges(dg); eibegin != eiend; ++eibegin)
    {
        if (boost::source(*eibegin, dg) == boost::target(*eibegin, dg))
            numcof += 4;
        else
            numcof += 10;
    }

    glp_prob *lp;
    int *ia = new int[1 + numcof];
    int *ja = new int[1 + numcof]; //start from 1
    double *ar = new double[1 + numcof];
    double z;
    lp = glp_create_prob();
    glp_set_prob_name(lp, "timing");
    glp_set_obj_dir(lp, GLP_MIN);
    glp_add_rows(lp, numcon);
    glp_add_cols(lp, numvar);
    glp_set_col_bnds(lp, 1, GLP_LO, 0.0, 0.0);
    glp_set_col_bnds(lp, 2, GLP_LO, 0.0, 0.0);
    for (int i = 3; i <= numvar; i++)
    {
        //glp_set_col_name(lp, i);
        glp_set_col_bnds(lp, i, GLP_FR, 0.0, 0.0);
    }
    int row = 1; //rth constraint
    int cn = 1;  //the index of subi/subj

    for (tie(eibegin, eiend) = boost::edges(dg); eibegin != eiend && cn <= numcof && row <= numcon; ++eibegin)
    {
        int i = boost::source(*eibegin, dg) + 3;
        int j = boost::target(*eibegin, dg) + 3;
        double Dmin = dg[*eibegin].minDelay;
        double Dmax = dg[*eibegin].maxDelay;
        if (i == j)
        {
            //-T<=-Dmax
            ia[cn] = row;
            ja[cn] = 1;
            ar[cn++] = -1.;
            glp_set_row_bnds(lp, row, GLP_UP, 0.0, -Dmax);
            ++row;
            //-T-W<=-Dmax
            ia[cn] = row;
            ja[cn] = 1;
            ar[cn++] = -1.;
            ia[cn] = row;
            ja[cn] = 2;
            ar[cn++] = -1.;
            glp_set_row_bnds(lp, row, GLP_UP, 0.0, -Dmax);
            ++row;
            //W<=Dmin
            ia[cn] = row;
            ja[cn] = 2;
            ar[cn++] = 1.;
            glp_set_row_bnds(lp, row, GLP_UP, 0.0, Dmin);
            ++row;
        }
        else
        {
            //-T+ti-tj<=-Dmax
            ia[cn] = row;
            ja[cn] = 1;
            ar[cn++] = -1.;
            ia[cn] = row;
            ja[cn] = i;
            ar[cn++] = 1.;
            ia[cn] = row;
            ja[cn] = j;
            ar[cn++] = -1.;
            glp_set_row_bnds(lp, row, GLP_UP, 0.0, -Dmax);
            ++row;
            //-T-W+ti-tj<=-Dmax
            ia[cn] = row;
            ja[cn] = 1;
            ar[cn++] = -1.;
            ia[cn] = row;
            ja[cn] = 2;
            ar[cn++] = -1.;
            ia[cn] = row;
            ja[cn] = i;
            ar[cn++] = 1.;
            ia[cn] = row;
            ja[cn] = j;
            ar[cn++] = -1.;
            glp_set_row_bnds(lp, row, GLP_UP, 0.0, -Dmax);
            ++row;
            //W-ti+tj<=Dmin
            ia[cn] = row;
            ja[cn] = 2;
            ar[cn++] = 1.;
            ia[cn] = row;
            ja[cn] = i;
            ar[cn++] = -1.;
            ia[cn] = row;
            ja[cn] = j;
            ar[cn++] = 1.;
            glp_set_row_bnds(lp, row, GLP_UP, 0.0, Dmin);
            ++row;
        }
    }
    glp_set_obj_coef(lp, 1, 1.0);
    glp_set_obj_coef(lp, 2, 1.0);
    // for(int i=1;i<numcof;i++)
    // 	cout<<ia[i]<<" "<<ja[i]<<" "<<ar[i]<<endl;
    glp_load_matrix(lp, numcof, ia, ja, ar);
    auto beginTime = high_resolution_clock::now();
    glp_simplex(lp, NULL);
    auto endTime = high_resolution_clock::now();
    change = endTime - beginTime + change;

    z = glp_get_obj_val(lp);
    tlp = glp_get_col_prim(lp, 1);
    wlp = glp_get_col_prim(lp, 2);

    glp_delete_prob(lp);
    delete[] ar;
    delete[] ia;
    delete[] ja;
    return duration_cast<nanoseconds>(change);
}
