#pragma once

#include <cstddef>
#include <limits>
#include <vector>
#include "timing_graph.hpp"

enum class McrStatus
{
    Optimal,
    NoCycle,
    InvalidPolicy,
    InvalidVertexIndex,
    NonPositiveTransit,
    InvalidInput,
    Infeasible,
    SolverError,
    NumericalError,
    IterationLimit
};

inline const char *mcrStatusToString(McrStatus status)
{
    switch (status)
    {
    case McrStatus::Optimal:
        return "Optimal";
    case McrStatus::NoCycle:
        return "NoCycle";
    case McrStatus::InvalidPolicy:
        return "InvalidPolicy";
    case McrStatus::InvalidVertexIndex:
        return "InvalidVertexIndex";
    case McrStatus::NonPositiveTransit:
        return "NonPositiveTransit";
    case McrStatus::InvalidInput:
        return "InvalidInput";
    case McrStatus::Infeasible:
        return "Infeasible";
    case McrStatus::SolverError:
        return "SolverError";
    case McrStatus::NumericalError:
        return "NumericalError";
    case McrStatus::IterationLimit:
        return "IterationLimit";
    }
    return "Unknown";
}

struct McrResult
{
    McrStatus status = McrStatus::NoCycle;
    double ratio = std::numeric_limits<double>::infinity();
    double period = std::numeric_limits<double>::infinity();
    std::vector<Edge> criticalCycle;
    double maxViolation = std::numeric_limits<double>::infinity();
    std::size_t iterations = 0;
    /** Clock arrival s_k for DelayGraph node k; s[0] is IO (pinned to 0). */
    std::vector<double> skew;
    /** IO-normalized a/A/d/D/s; counter a/d are conservative earliest bounds, A/D are latest envelopes. */
    std::vector<double> potential;
};

// Graph solvers require both a critical-cycle certificate and a feasible full-graph schedule.
void finalizeMcrResult(const Graph &g, double tInitial, double eps, McrResult &result);
