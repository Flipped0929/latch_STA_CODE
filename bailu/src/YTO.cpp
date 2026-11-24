#include "YTO.hpp"

#include <algorithm>
#include <cmath>
#include <limits>
#include <queue>
#include <set>
#include <utility>
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/strong_components.hpp>

using namespace boost;

double YTO::getRatio() const
{
    return _r;
}

std::vector<Edge> YTO::getCycle() const
{
    return _minRatioCycle;
}

McrResult YTO::getResult() const
{
    return _result;
}

bool YTO::validIndex(size_t idx) const
{
    return idx < _n;
}

bool YTO::inActiveScc(size_t idx) const
{
    return validIndex(idx) && _sccId[idx] == _activeScc;
}

bool YTO::sameActiveScc(size_t u, size_t v) const
{
    return inActiveScc(u) && inActiveScc(v);
}

double YTO::reducedCost(const Edge &e) const
{
    const size_t u = _g[source(e, _g)].nodeIndex;
    const size_t v = _g[target(e, _g)].nodeIndex;
    const double delta_t = _transit[u] + _g[e].delay - _transit[v];
    const double delta_d = _dist[u] + _g[e].weight - _dist[v];
    return delta_d - _r * delta_t;
}

double YTO::findArcKey(const Edge &e) const
{
    const size_t u = _g[source(e, _g)].nodeIndex;
    const size_t v = _g[target(e, _g)].nodeIndex;
    if (!sameActiveScc(u, v))
        return std::numeric_limits<double>::infinity();

    const double delta_t = _transit[u] + _g[e].delay - _transit[v];
    const double delta_d = _dist[u] + _g[e].weight - _dist[v];
    if (!std::isfinite(delta_t) || !std::isfinite(delta_d))
        return std::numeric_limits<double>::infinity();

    const double rc = delta_d - _r * delta_t;
    const double slack = _eps * (1.0 + std::fabs(_r));

    // Increasing-parameter YTO: a future pivot exists only if reduced cost
    // falls as lambda grows, i.e. Delta-t > 0.
    if (delta_t > _transitEps)
    {
        const double key = delta_d / delta_t;
        if (!std::isfinite(key))
            return std::numeric_limits<double>::infinity();
        if (rc < -slack)
            return key;
        if (key + slack < _r)
            return std::numeric_limits<double>::infinity();
        return key;
    }

    // Delta-t < 0: reduced cost increases with lambda, so it is not a pivot
    // while searching for the minimum positive-transit cycle ratio.
    // Delta-t == 0: reduced cost is constant; a negative value is a violation
    // handled by hasReducedCostViolation(), not by a finite key.
    (void)rc;
    return std::numeric_limits<double>::infinity();
}

bool YTO::hasReducedCostViolation() const
{
    const double slack = _eps * (1.0 + std::fabs(_r));
    EdgeIterator ei, eiend;
    for (tie(ei, eiend) = edges(_g); ei != eiend; ++ei)
    {
        const size_t u = _g[source(*ei, _g)].nodeIndex;
        const size_t v = _g[target(*ei, _g)].nodeIndex;
        if (!sameActiveScc(u, v))
            continue;
        const double rc = reducedCost(*ei);
        if (!std::isfinite(rc) || rc < -slack)
            return true;
    }
    return false;
}

double YTO::computeMaxViolation() const
{
    double maxViolation = 0.0;
    EdgeIterator ei, eiend;
    for (tie(ei, eiend) = edges(_g); ei != eiend; ++ei)
    {
        const size_t u = _g[source(*ei, _g)].nodeIndex;
        const size_t v = _g[target(*ei, _g)].nodeIndex;
        if (!sameActiveScc(u, v))
            continue;
        const double rc = reducedCost(*ei);
        if (!std::isfinite(rc))
            return std::numeric_limits<double>::infinity();
        if (-rc > maxViolation)
            maxViolation = -rc;
    }
    return maxViolation;
}

void YTO::markCyclicSccs()
{
    _sccId.assign(_n, -1);
    _inCyclic.assign(_n, 0);

    const size_t nv = num_vertices(_g);
    std::vector<int> component(nv, 0);
    const int ncc = strong_components(_g, make_iterator_property_map(
                                              component.begin(), get(vertex_index, _g)));

    std::vector<size_t> sccSize(static_cast<size_t>(ncc), 0);
    std::vector<char> hasLoop(static_cast<size_t>(ncc), 0);

    VertexIterator vi, viend;
    for (tie(vi, viend) = vertices(_g); vi != viend; ++vi)
    {
        const size_t idx = _g[*vi].nodeIndex;
        if (!validIndex(idx))
            continue;
        const int cid = component[*vi];
        _sccId[idx] = cid;
        ++sccSize[static_cast<size_t>(cid)];
    }

    EdgeIterator ei, eiend;
    for (tie(ei, eiend) = edges(_g); ei != eiend; ++ei)
    {
        const Vertex u = source(*ei, _g);
        const Vertex v = target(*ei, _g);
        if (u != v)
            continue;
        const size_t idx = _g[u].nodeIndex;
        if (!validIndex(idx) || _sccId[idx] < 0)
            continue;
        hasLoop[static_cast<size_t>(_sccId[idx])] = 1;
    }

    for (size_t i = 0; i < _n; ++i)
    {
        if (_sccId[i] < 0)
            continue;
        const size_t cid = static_cast<size_t>(_sccId[i]);
        if (sccSize[cid] > 1 || hasLoop[cid])
            _inCyclic[i] = 1;
    }
}

void YTO::resetTree()
{
    _Tp = ShortestPathTree(_n);
    _treePred.assign(_n, graph_traits<Graph>::edge_descriptor());
    _treePredValid.assign(_n, 0);
    _dist.assign(_n, 0.0);
    _transit.assign(_n, 0.0);
    _pq = PriorityQueue();
    _itemValid.assign(_n, 0);
}

bool YTO::inSubTree(size_t root, size_t u) const
{
    if (u == root)
        return true;
    size_t cur = u;
    size_t guard = 0;
    while (_treePredValid[cur])
    {
        if (++guard > _n)
            return false;
        const Vertex p = source(_treePred[cur], _g);
        const size_t pIdx = _g[p].nodeIndex;
        if (!validIndex(pIdx))
            return false;
        if (pIdx == root)
            return true;
        cur = pIdx;
    }
    return false;
}

bool YTO::extractCycle(size_t u, size_t v, const Edge &closing, std::vector<Edge> &cycle) const
{
    cycle.clear();
    size_t cur = u;
    size_t guard = 0;
    while (cur != v)
    {
        if (!validIndex(cur) || !_treePredValid[cur])
        {
            cycle.clear();
            return false;
        }
        cycle.push_back(_treePred[cur]);
        cur = _g[source(_treePred[cur], _g)].nodeIndex;
        if (++guard > _n)
        {
            cycle.clear();
            return false;
        }
    }
    std::reverse(cycle.begin(), cycle.end());
    cycle.push_back(closing);
    return !cycle.empty();
}

bool YTO::cycleRatio(const std::vector<Edge> &cycle, double &ratio, double &weightSum, double &transitSum) const
{
    weightSum = 0.0;
    transitSum = 0.0;
    if (cycle.empty())
        return false;
    for (const Edge &e : cycle)
    {
        weightSum += _g[e].weight;
        transitSum += _g[e].delay;
    }
    if (!std::isfinite(weightSum) || !std::isfinite(transitSum) || transitSum <= _transitEps)
        return false;
    ratio = weightSum / transitSum;
    return std::isfinite(ratio);
}

bool YTO::bellmanFord(double lambda, std::vector<char> &predValid, std::vector<Edge> &pred, std::vector<Edge> &negCycle)
{
    predValid.assign(_n, 0);
    pred.assign(_n, graph_traits<Graph>::edge_descriptor());
    negCycle.clear();

    std::vector<double> dist(_n, 0.0);
    size_t nActive = 0;
    for (size_t i = 0; i < _n; ++i)
    {
        if (inActiveScc(i))
            ++nActive;
    }
    if (nActive == 0)
        return true;

    const double slack = _eps * (1.0 + std::fabs(lambda));
    bool updated = true;
    for (size_t iter = 0; iter < nActive && updated; ++iter)
    {
        updated = false;
        EdgeIterator ei, eiend;
        for (tie(ei, eiend) = edges(_g); ei != eiend; ++ei)
        {
            const size_t i = _g[source(*ei, _g)].nodeIndex;
            const size_t j = _g[target(*ei, _g)].nodeIndex;
            if (!sameActiveScc(i, j))
                continue;
            const double c = _g[*ei].weight - lambda * _g[*ei].delay;
            const double candidate = dist[i] + c;
            if (!std::isfinite(candidate) || !std::isfinite(c))
                return false;
            if (dist[j] > candidate + slack)
            {
                dist[j] = candidate;
                pred[j] = *ei;
                predValid[j] = 1;
                updated = true;
            }
        }
    }

    EdgeIterator ei, eiend;
    size_t witness = _n;
    for (tie(ei, eiend) = edges(_g); ei != eiend; ++ei)
    {
        const size_t i = _g[source(*ei, _g)].nodeIndex;
        const size_t j = _g[target(*ei, _g)].nodeIndex;
        if (!sameActiveScc(i, j))
            continue;
        const double c = _g[*ei].weight - lambda * _g[*ei].delay;
        const double candidate = dist[i] + c;
        if (!std::isfinite(candidate) || !std::isfinite(c))
            return false;
        if (dist[j] > candidate + slack)
        {
            pred[j] = *ei;
            predValid[j] = 1;
            witness = j;
            break;
        }
    }
    if (witness == _n)
        return true;

    std::vector<int> seen(_n, 0);
    size_t cur = witness;
    for (size_t k = 0; k < nActive + 1; ++k)
    {
        if (!validIndex(cur) || !predValid[cur])
            return false;
        cur = _g[source(pred[cur], _g)].nodeIndex;
    }
    const size_t start = cur;
    do
    {
        if (!validIndex(cur) || !predValid[cur] || seen[cur])
            break;
        seen[cur] = 1;
        negCycle.push_back(pred[cur]);
        cur = _g[source(pred[cur], _g)].nodeIndex;
    } while (cur != start);
    return false;
}

void YTO::fillParametricFromForest()
{
    std::vector<char> visited(_n, 0);
    std::queue<size_t> q;
    for (size_t i = 0; i < _n; ++i)
    {
        if (!inActiveScc(i))
            continue;
        if (_treePredValid[i])
            continue;
        _dist[i] = 0.0;
        _transit[i] = 0.0;
        visited[i] = 1;
        q.push(i);
    }

    while (!q.empty())
    {
        const size_t u = q.front();
        q.pop();
        const SPTVertex uNode = vertex(u, _Tp);
        graph_traits<ShortestPathTree>::out_edge_iterator oei, oeiend;
        for (tie(oei, oeiend) = out_edges(uNode, _Tp); oei != oeiend; ++oei)
        {
            const size_t v = target(*oei, _Tp);
            if (!inActiveScc(v) || visited[v] || !_treePredValid[v])
                continue;
            const Edge e = _treePred[v];
            _dist[v] = _dist[u] + _g[e].weight;
            _transit[v] = _transit[u] + _g[e].delay;
            visited[v] = 1;
            q.push(v);
        }
    }
}

McrStatus YTO::buildFeasibleTree()
{
    double lo = -std::numeric_limits<double>::infinity();
    double hi = std::numeric_limits<double>::infinity();
    _r = 0.0;

    for (std::size_t iter = 0; iter < _maxIterations; ++iter)
    {
        std::vector<char> predValid;
        std::vector<Edge> pred;
        std::vector<Edge> negCycle;
        if (bellmanFord(_r, predValid, pred, negCycle))
        {
            resetTree();
            for (size_t v = 0; v < _n; ++v)
            {
                if (!inActiveScc(v) || !predValid[v])
                    continue;
                const Edge e = pred[v];
                const size_t u = _g[source(e, _g)].nodeIndex;
                if (!sameActiveScc(u, v))
                    continue;
                add_edge(u, v, _Tp);
                _treePred[v] = e;
                _treePredValid[v] = 1;
            }
            fillParametricFromForest();
            if (hasReducedCostViolation())
                return McrStatus::NumericalError;
            return McrStatus::Optimal;
        }

        double ratio = 0.0;
        double wsum = 0.0;
        double tsum = 0.0;
        // Initialization needs signed cycle transit; cycleRatio() accepts positive cycles only.
        cycleRatio(negCycle, ratio, wsum, tsum);
        if (negCycle.empty() || !std::isfinite(wsum) || !std::isfinite(tsum))
            return McrStatus::NumericalError;
        if (std::fabs(tsum) <= _transitEps)
            return wsum < -_eps ? McrStatus::Infeasible : McrStatus::NumericalError;
        ratio = wsum / tsum;
        if (!std::isfinite(ratio))
            return McrStatus::NumericalError;

        if (tsum > _transitEps)
            hi = std::min(hi, ratio);
        else
            lo = std::max(lo, ratio);

        if (std::isfinite(lo) && std::isfinite(hi) && lo > hi + _eps * (1.0 + std::fabs(hi)))
            return McrStatus::Infeasible;

        if (std::isfinite(lo) && std::isfinite(hi))
            _r = 0.5 * (lo + hi);
        else if (std::isfinite(hi))
            _r = hi;
        else
            _r = lo;
        if (!std::isfinite(_r))
            return McrStatus::NumericalError;
    }
    return McrStatus::IterationLimit;
}

void YTO::recomputeKeys()
{
    VertexIterator vi, viend;
    for (tie(vi, viend) = vertices(_g); vi != viend; ++vi)
    {
        const size_t v = _g[*vi].nodeIndex;
        if (!inActiveScc(v))
            continue;
        _arcKey[v] = std::numeric_limits<double>::infinity();
        InEdgeIterator inei, ineiend;
        for (tie(inei, ineiend) = in_edges(*vi, _g); inei != ineiend; ++inei)
        {
            const size_t u = _g[source(*inei, _g)].nodeIndex;
            if (!sameActiveScc(u, v))
                continue;
            const double ak = findArcKey(*inei);
            if (ak < _arcKey[v])
            {
                _arcKey[v] = ak;
                _nodeKey[v] = *inei;
            }
        }
        if (_itemValid[v])
            _pq.del_item(_items[v]);
        _items[v] = _pq.insert(_arcKey[v], *vi);
        _itemValid[v] = 1;
    }
}

void YTO::applyPivot(size_t u, size_t v, const Edge &e)
{
    const double delta_t = _transit[u] + _g[e].delay - _transit[v];
    const double delta_d = _dist[u] + _g[e].weight - _dist[v];

    std::queue<SPTVertex> nodes;
    nodes.push(v);
    std::vector<char> seen(_n, 0);
    while (!nodes.empty())
    {
        const SPTVertex x = nodes.front();
        nodes.pop();
        if (seen[x])
            continue;
        seen[x] = 1;
        _dist[x] += delta_d;
        _transit[x] += delta_t;
        graph_traits<ShortestPathTree>::out_edge_iterator oei, oeiend;
        for (tie(oei, oeiend) = out_edges(x, _Tp); oei != oeiend; ++oei)
            nodes.push(target(*oei, _Tp));
    }

    graph_traits<ShortestPathTree>::in_edge_iterator ineispt, ineiendspt;
    tie(ineispt, ineiendspt) = in_edges(v, _Tp);
    if (ineispt != ineiendspt)
        remove_edge(source(*ineispt, _Tp), v, _Tp);
    add_edge(u, v, _Tp);
    _treePred[v] = e;
    _treePredValid[v] = 1;
}

McrResult YTO::runOnActiveScc()
{
    McrResult local;
    local.iterations = 0;
    resetTree();

    const McrStatus initStatus = buildFeasibleTree();
    if (initStatus != McrStatus::Optimal)
    {
        local.status = initStatus;
        local.ratio = _r;
        local.period = _t0 - 2.0 * _r;
        local.iterations = 0;
        return local;
    }

    recomputeKeys();
    const double slack = _eps * (1.0 + std::fabs(_r));

    for (std::size_t iter = 1; iter <= _maxIterations; ++iter)
    {
        local.iterations = iter;
        if (_pq.empty())
            break;

        const pq_item item = _pq.find_min();
        const double key = _pq.prio(item);
        if (!std::isfinite(key))
            break;

        if (key + slack < _r)
        {
            local.status = McrStatus::NumericalError;
            local.ratio = key;
            local.period = _t0 - 2.0 * key;
            local.maxViolation = computeMaxViolation();
            return local;
        }

        const Vertex vNode = _pq.inf(item);
        const size_t v = _g[vNode].nodeIndex;
        if (!inActiveScc(v))
        {
            _pq.del_item(item);
            _itemValid[v] = 0;
            continue;
        }
        const Edge e = _nodeKey[v];
        const size_t u = _g[source(e, _g)].nodeIndex;
        if (!sameActiveScc(u, v))
        {
            _arcKey[v] = std::numeric_limits<double>::infinity();
            _pq.del_item(_items[v]);
            _items[v] = _pq.insert(_arcKey[v], vNode);
            continue;
        }

        _r = key;
        if (inSubTree(v, u))
        {
            if (!extractCycle(u, v, e, _minRatioCycle))
            {
                local.status = McrStatus::NumericalError;
                local.ratio = _r;
                local.period = _t0 - 2.0 * _r;
                return local;
            }
            double ratio = 0.0;
            double wsum = 0.0;
            double tsum = 0.0;
            if (!cycleRatio(_minRatioCycle, ratio, wsum, tsum))
            {
                local.status = McrStatus::NonPositiveTransit;
                local.ratio = _r;
                local.period = _t0 - 2.0 * _r;
                local.criticalCycle = _minRatioCycle;
                return local;
            }
            if (std::fabs(ratio - _r) > std::max(_eps, 1e-12) * (1.0 + std::fabs(ratio)))
            {
                local.status = McrStatus::NumericalError;
                local.ratio = _r;
                local.period = _t0 - 2.0 * _r;
                return local;
            }
            local.status = McrStatus::Optimal;
            local.ratio = _r;
            local.period = _t0 - 2.0 * _r;
            local.criticalCycle = _minRatioCycle;
            local.maxViolation = computeMaxViolation();
            return local;
        }

        applyPivot(u, v, e);
        if (hasReducedCostViolation())
        {
            local.status = McrStatus::NumericalError;
            local.ratio = _r;
            local.period = _t0 - 2.0 * _r;
            local.maxViolation = computeMaxViolation();
            return local;
        }
        recomputeKeys();
    }

    if (local.iterations >= _maxIterations)
        local.status = McrStatus::IterationLimit;
    else
        local.status = McrStatus::NoCycle;
    local.ratio = _r;
    local.period = _t0 - 2.0 * _r;
    local.criticalCycle = _minRatioCycle;
    local.maxViolation = computeMaxViolation();
    return local;
}

void YTO::setResult(McrResult result)
{
    _result = std::move(result);
    finalizeMcrResult(_g, _t0, _eps, _result);
    _r = _result.ratio;
    _minRatioCycle = _result.criticalCycle;
}

void YTO::run()
{
    _minRatioCycle.clear();
    if (_n != num_vertices(_g) || !validMcrGraph(_g) || !std::isfinite(_t0) || _t0 < 0.0 ||
        !std::isfinite(_eps) || _eps <= 0.0)
    {
        McrResult invalid;
        invalid.status = McrStatus::InvalidInput;
        setResult(std::move(invalid));
        return;
    }
    markCyclicSccs();

    std::set<int> cyclicSccs;
    for (size_t i = 0; i < _n; ++i)
    {
        if (_inCyclic[i])
            cyclicSccs.insert(_sccId[i]);
    }
    if (cyclicSccs.empty())
    {
        McrResult none;
        none.status = McrStatus::NoCycle;
        none.maxViolation = 0.0;
        setResult(std::move(none));
        return;
    }

    McrResult best;
    best.status = McrStatus::NoCycle;
    best.iterations = 0;
    McrStatus firstError = McrStatus::NoCycle;
    bool haveError = false;

    for (int scc : cyclicSccs)
    {
        _activeScc = scc;
        McrResult local = runOnActiveScc();
        best.iterations += local.iterations;
        if (local.status == McrStatus::Optimal)
        {
            if (local.ratio < best.ratio)
            {
                const std::size_t iters = best.iterations;
                best = local;
                best.iterations = iters;
            }
            continue;
        }
        if (local.status == McrStatus::NonPositiveTransit ||
            local.status == McrStatus::NoCycle)
            continue;
        if (!haveError)
        {
            firstError = local.status;
            haveError = true;
        }
    }

    if (best.status == McrStatus::Optimal && !haveError)
    {
        setResult(std::move(best));
        return;
    }

    McrResult failed;
    failed.status = haveError ? firstError : McrStatus::NoCycle;
    failed.iterations = best.iterations;
    setResult(std::move(failed));
}
