#pragma once

#include <algorithm>
#include <cstddef>
#include <limits>
#include <tuple>
#include <vector>
#include "mcr_result.hpp"

/**
 * @brief minimum cycle ratio solver using Howard's algorithm
 *
 */
class Howard
{
public:
    Howard(const Graph &g, size_t n, double t0, double eps)
        : _g{g},
          _n{n},
          _t0{t0},
          _r{t0},
          _eps{eps},
          _transitEps{eps},
          _maxIterations{std::max<std::size_t>(10000, 10 * n)},
          _minRatioCycle(),
          _su(n),
          _suValid(n, 0),
          _dist(n, std::numeric_limits<double>::infinity()),
          _sccId(n, -1),
          _inCyclic(n, 0),
          _activeScc{-1}
    {
    }
    void run();
    double getRatio() const;
    std::vector<Edge> getCycle() const;
    McrResult getResult() const;

private:
    const Graph &_g;
    const size_t _n;
    const double _t0;
    double _r;
    const double _eps;
    const double _transitEps;
    const std::size_t _maxIterations;

    std::vector<Edge> _minRatioCycle;
    std::vector<Edge> _su;
    std::vector<char> _suValid;
    std::vector<double> _dist;
    std::vector<int> _sccId;
    std::vector<char> _inCyclic;
    int _activeScc;
    McrResult _result;

    bool validIndex(size_t idx) const;
    bool inActiveScc(size_t idx) const;
    bool sameActiveScc(size_t u, size_t v) const;
    void markCyclicSccs();
    bool initPolicy();
    std::tuple<double, Vertex, McrStatus> findRatio();
    bool saveAndCheckCycle(Vertex handle, double expectedRatio);
    void updateDistances(Vertex handle);
    bool improvePolicy();
    double computeMaxViolation() const;
    McrResult runOnActiveScc();
    void setResult(McrResult result);
};
