#pragma once

#include <algorithm>
#include <cstddef>
#include <limits>
#include <vector>
#include <LEDA/core/p_queue.h>
#include "mcr_result.hpp"

using PriorityQueue = leda::p_queue<double, Vertex>;
using pq_item = PriorityQueue::item;

/**
 * @brief Minimum cycle ratio solver using a generalized YTO parametric shortest path.
 *
 * Searches for the minimum ratio among cycles with positive total transit by
 * increasing the parameter from a feasible start. Zero/negative Delta-t edges
 * are classified instead of being silently ignored.
 */
class YTO
{
public:
    YTO(const Graph &g, size_t n, double t0, double eps)
        : _g{g},
          _n{n},
          _t0{t0},
          _r{0.0},
          _eps{eps},
          _transitEps{eps},
          _maxIterations{std::max<std::size_t>(10000, 20 * n)},
          _Tp(n),
          _dist(n, 0.0),
          _transit(n, 0.0),
          _nodeKey(n),
          _arcKey(n, std::numeric_limits<double>::infinity()),
          _pq(),
          _items(n),
          _itemValid(n, 0),
          _treePred(n),
          _treePredValid(n, 0),
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

    ShortestPathTree _Tp;
    std::vector<double> _dist;
    std::vector<double> _transit;
    std::vector<Edge> _nodeKey;
    std::vector<double> _arcKey;
    PriorityQueue _pq;
    std::vector<pq_item> _items;
    std::vector<char> _itemValid;
    std::vector<Edge> _treePred;
    std::vector<char> _treePredValid;
    std::vector<int> _sccId;
    std::vector<char> _inCyclic;
    int _activeScc;
    std::vector<Edge> _minRatioCycle;
    McrResult _result;

    bool validIndex(size_t idx) const;
    bool inActiveScc(size_t idx) const;
    bool sameActiveScc(size_t u, size_t v) const;
    double reducedCost(const Edge &e) const;
    double findArcKey(const Edge &e) const;
    bool hasReducedCostViolation() const;
    double computeMaxViolation() const;
    void markCyclicSccs();
    void resetTree();
    bool inSubTree(size_t root, size_t u) const;
    bool extractCycle(size_t u, size_t v, const Edge &closing, std::vector<Edge> &cycle) const;
    bool cycleRatio(const std::vector<Edge> &cycle, double &ratio, double &weightSum, double &transitSum) const;
    bool bellmanFord(double lambda, std::vector<char> &predValid, std::vector<Edge> &pred, std::vector<Edge> &negCycle);
    McrStatus buildFeasibleTree();
    void fillParametricFromForest();
    void recomputeKeys();
    void applyPivot(size_t u, size_t v, const Edge &e);
    McrResult runOnActiveScc();
    void setResult(McrResult result);
};
