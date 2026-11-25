#include <algorithm>
#include <cmath>
#include <limits>
#include <queue>
#include <set>
#include <utility>
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/strong_components.hpp>
#include "howard.hpp"

using namespace boost;

double Howard::getRatio() const
{
    return _r;
}

std::vector<Edge> Howard::getCycle() const
{
    return _minRatioCycle;
}

McrResult Howard::getResult() const
{
    return _result;
}

bool Howard::validIndex(size_t idx) const
{
    return idx < _n;
}

bool Howard::inActiveScc(size_t idx) const
{
    return validIndex(idx) && _sccId[idx] == _activeScc;
}

bool Howard::sameActiveScc(size_t u, size_t v) const
{
    return inActiveScc(u) && inActiveScc(v);
}

void Howard::markCyclicSccs()
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

bool Howard::initPolicy()
{
    _su.assign(_n, graph_traits<Graph>::edge_descriptor());
    _suValid.assign(_n, 0);
    _dist.assign(_n, std::numeric_limits<double>::infinity());

    EdgeIterator ei, eiend;
    for (tie(ei, eiend) = edges(_g); ei != eiend; ++ei)
    {
        const size_t i = _g[source(*ei, _g)].nodeIndex;
        const size_t j = _g[target(*ei, _g)].nodeIndex;
        if (!sameActiveScc(i, j))
            continue;
        const double rc = _g[*ei].weight - _r * _g[*ei].delay;
        if (!_suValid[i] || rc < _dist[i])
        {
            _dist[i] = rc;
            _su[i] = *ei;
            _suValid[i] = 1;
        }
    }

    for (size_t i = 0; i < _n; ++i)
    {
        if (inActiveScc(i) && !_suValid[i])
            return false;
    }
    // Affine equalities can trap the cheapest-edge policy in zero-transit cycles.
    if (std::get<1>(findRatio()) == graph_traits<Graph>::null_vertex())
        for (tie(ei, eiend) = edges(_g); ei != eiend; ++ei)
        {
            const size_t root = source(*ei, _g);
            if (root != target(*ei, _g) || !inActiveScc(root) || _g[*ei].delay <= _transitEps)
                continue;
            std::vector<char> reached(_n, 0);
            std::queue<size_t> ready;
            _su[root] = *ei;
            reached[root] = 1;
            ready.push(root);
            while (!ready.empty())
            {
                const size_t v = ready.front(); ready.pop();
                auto incoming = in_edges(v, _g);
                for (auto edge = incoming.first; edge != incoming.second; ++edge)
                {
                    const size_t u = source(*edge, _g);
                    if (inActiveScc(u) && !reached[u])
                    {
                        reached[u] = 1;
                        _su[u] = *edge;
                        ready.push(u);
                    }
                }
            }
            break;
        }
    return true;
}

std::tuple<double, Vertex, McrStatus> Howard::findRatio()
{
    std::vector<int> visited(_n, -1);
    double best = std::numeric_limits<double>::infinity();
    Vertex handle = graph_traits<Graph>::null_vertex();
    bool sawBadTransit = false;
    bool sawNumerical = false;

    VertexIterator vi, viend;
    for (tie(vi, viend) = vertices(_g); vi != viend; ++vi)
    {
        const size_t startIdx = _g[*vi].nodeIndex;
        if (!validIndex(startIdx) || !inActiveScc(startIdx) || visited[startIdx] != -1)
            continue;

        Vertex u = *vi;
        bool broken = false;
        do
        {
            const size_t uIdx = _g[u].nodeIndex;
            if (!validIndex(uIdx))
                return {_r, graph_traits<Graph>::null_vertex(), McrStatus::InvalidVertexIndex};
            if (!_suValid[uIdx])
            {
                broken = true;
                break;
            }
            visited[uIdx] = static_cast<int>(startIdx);
            u = target(_su[uIdx], _g);
            const size_t nextIdx = _g[u].nodeIndex;
            if (!validIndex(nextIdx))
                return {_r, graph_traits<Graph>::null_vertex(), McrStatus::InvalidVertexIndex};
        } while (visited[_g[u].nodeIndex] == -1);

        if (broken)
            continue;
        if (visited[_g[u].nodeIndex] != static_cast<int>(startIdx))
            continue;

        Vertex x = u;
        double sum = 0.0;
        double len = 0.0;
        size_t guard = 0;
        do
        {
            const size_t xIdx = _g[x].nodeIndex;
            if (!validIndex(xIdx) || !_suValid[xIdx])
            {
                broken = true;
                break;
            }
            const Edge e = _su[xIdx];
            sum += _g[e].weight;
            len += _g[e].delay;
            x = target(e, _g);
            if (++guard > _n)
            {
                broken = true;
                break;
            }
        } while (x != u);

        if (broken)
            continue;
        if (!std::isfinite(sum) || !std::isfinite(len))
        {
            sawNumerical = true;
            continue;
        }
        if (len <= _transitEps)
        {
            sawBadTransit = true;
            continue;
        }

        const double cand = sum / len;
        if (!std::isfinite(cand))
        {
            sawNumerical = true;
            continue;
        }
        if (cand < best)
        {
            best = cand;
            handle = u;
        }
    }

    if (handle != graph_traits<Graph>::null_vertex())
        return {best, handle, McrStatus::Optimal};
    if (sawNumerical)
        return {_r, handle, McrStatus::NumericalError};
    if (sawBadTransit)
        return {_r, handle, McrStatus::NonPositiveTransit};
    return {_r, handle, McrStatus::NoCycle};
}

bool Howard::saveAndCheckCycle(Vertex handle, double expectedRatio)
{
    _minRatioCycle.clear();
    if (handle == graph_traits<Graph>::null_vertex())
        return false;

    Vertex u = handle;
    size_t guard = 0;
    do
    {
        const size_t i = _g[u].nodeIndex;
        if (!validIndex(i) || !_suValid[i])
        {
            _minRatioCycle.clear();
            return false;
        }
        const Edge e = _su[i];
        _minRatioCycle.push_back(e);
        u = target(e, _g);
        if (++guard > _n)
        {
            _minRatioCycle.clear();
            return false;
        }
    } while (u != handle);

    double sum = 0.0;
    double len = 0.0;
    for (const Edge &e : _minRatioCycle)
    {
        sum += _g[e].weight;
        len += _g[e].delay;
    }
    if (!std::isfinite(sum) || !std::isfinite(len) || len <= _transitEps)
        return false;

    const double cycleRatio = sum / len;
    if (!std::isfinite(cycleRatio))
        return false;
    return std::fabs(cycleRatio - expectedRatio) <= std::max(_eps, 1e-12);
}

void Howard::updateDistances(Vertex handle)
{
    const size_t handleIdx = _g[handle].nodeIndex;
    if (!validIndex(handleIdx))
        return;
    _dist[handleIdx] = 0.0;

    std::queue<Vertex> que;
    std::vector<char> visited(_n, 0);
    visited[handleIdx] = 1;

    InEdgeIterator inei, ineiend;
    for (tie(inei, ineiend) = in_edges(handle, _g); inei != ineiend; ++inei)
    {
        const Vertex pred = source(*inei, _g);
        const size_t predIdx = _g[pred].nodeIndex;
        if (!validIndex(predIdx) || !_suValid[predIdx])
            continue;
        if (_su[predIdx] == *inei)
            que.push(pred);
    }

    while (!que.empty())
    {
        const Vertex u = que.front();
        que.pop();
        const size_t i = _g[u].nodeIndex;
        if (!validIndex(i) || visited[i] || !_suValid[i])
            continue;
        visited[i] = 1;
        const Edge e = _su[i];
        const Vertex v = target(e, _g);
        const size_t j = _g[v].nodeIndex;
        if (!validIndex(j) || !std::isfinite(_dist[j]))
            continue;
        _dist[i] = _dist[j] + _g[e].weight - _r * _g[e].delay;
        for (tie(inei, ineiend) = in_edges(u, _g); inei != ineiend; ++inei)
        {
            const Vertex pred = source(*inei, _g);
            const size_t predIdx = _g[pred].nodeIndex;
            if (!validIndex(predIdx) || visited[predIdx] || !_suValid[predIdx])
                continue;
            if (_su[predIdx] == *inei)
                que.push(pred);
        }
    }
}

bool Howard::improvePolicy()
{
    bool changed = false;
    EdgeIterator ei, eiend;
    for (tie(ei, eiend) = edges(_g); ei != eiend; ++ei)
    {
        const size_t i = _g[source(*ei, _g)].nodeIndex;
        const size_t j = _g[target(*ei, _g)].nodeIndex;
        if (!sameActiveScc(i, j))
            continue;
        if (!std::isfinite(_dist[j]))
            continue;
        const double cand = _dist[j] + _g[*ei].weight - _g[*ei].delay * _r;
        if (!std::isfinite(cand))
            continue;
        if (!_suValid[i] || !std::isfinite(_dist[i]) || _dist[i] > cand + _eps)
        {
            _dist[i] = cand;
            _su[i] = *ei;
            _suValid[i] = 1;
            changed = true;
        }
    }
    return changed;
}

double Howard::computeMaxViolation() const
{
    double maxViolation = 0.0;
    EdgeIterator ei, eiend;
    for (tie(ei, eiend) = edges(_g); ei != eiend; ++ei)
    {
        const size_t i = _g[source(*ei, _g)].nodeIndex;
        const size_t j = _g[target(*ei, _g)].nodeIndex;
        if (!sameActiveScc(i, j))
            continue;
        if (!std::isfinite(_dist[i]) || !std::isfinite(_dist[j]))
            return std::numeric_limits<double>::infinity();
        const double viol = _dist[i] - _dist[j] - _g[*ei].weight + _r * _g[*ei].delay;
        if (!std::isfinite(viol))
            return std::numeric_limits<double>::infinity();
        if (viol > maxViolation)
            maxViolation = viol;
    }
    return maxViolation;
}

void Howard::setResult(McrResult result)
{
    _result = std::move(result);
    finalizeMcrResult(_g, _t0, _eps, _result);
    _r = _result.ratio;
    _minRatioCycle = _result.criticalCycle;
}

McrResult Howard::runOnActiveScc()
{
    McrResult local;
    local.status = McrStatus::NoCycle;
    local.ratio = std::numeric_limits<double>::infinity();
    local.period = std::numeric_limits<double>::infinity();
    local.maxViolation = std::numeric_limits<double>::infinity();
    local.iterations = 0;

    _r = _t0;
    _minRatioCycle.clear();
    if (!initPolicy())
    {
        local.status = McrStatus::InvalidPolicy;
        return local;
    }

    bool changed = true;
    std::size_t iter = 0;
    while (changed)
    {
        if (iter >= _maxIterations)
        {
            local.status = McrStatus::IterationLimit;
            local.ratio = _r;
            local.period = _t0 - 2.0 * _r;
            local.criticalCycle = _minRatioCycle;
            local.maxViolation = computeMaxViolation();
            local.iterations = iter;
            return local;
        }
        ++iter;

        Vertex handle;
        McrStatus findStatus;
        std::tie(_r, handle, findStatus) = findRatio();
        if (findStatus == McrStatus::InvalidVertexIndex ||
            findStatus == McrStatus::NumericalError)
        {
            local.status = findStatus;
            local.iterations = iter;
            return local;
        }
        if (handle == graph_traits<Graph>::null_vertex())
        {
            local.status = findStatus;
            local.ratio = _r;
            local.period = _t0 - 2.0 * _r;
            local.iterations = iter;
            local.maxViolation = computeMaxViolation();
            return local;
        }
        if (!std::isfinite(_r))
        {
            local.status = McrStatus::NumericalError;
            local.iterations = iter;
            return local;
        }

        updateDistances(handle);
        if (!saveAndCheckCycle(handle, _r))
        {
            local.status = (findStatus == McrStatus::NonPositiveTransit)
                               ? McrStatus::NonPositiveTransit
                               : McrStatus::NumericalError;
            local.ratio = _r;
            local.period = _t0 - 2.0 * _r;
            local.iterations = iter;
            return local;
        }
        changed = improvePolicy();
    }

    local.status = McrStatus::Optimal;
    local.ratio = _r;
    local.period = _t0 - 2.0 * _r;
    local.criticalCycle = _minRatioCycle;
    local.maxViolation = computeMaxViolation();
    local.iterations = iter;
    if (!std::isfinite(local.maxViolation))
        local.status = McrStatus::NumericalError;
    return local;
}

void Howard::run()
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
        none.ratio = std::numeric_limits<double>::infinity();
        none.period = std::numeric_limits<double>::infinity();
        none.maxViolation = 0.0;
        none.iterations = 0;
        setResult(std::move(none));
        return;
    }

    McrResult best;
    best.status = McrStatus::NoCycle;
    best.ratio = std::numeric_limits<double>::infinity();
    best.period = std::numeric_limits<double>::infinity();
    best.maxViolation = std::numeric_limits<double>::infinity();
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
    failed.ratio = _t0;
    failed.period = _t0;
    failed.maxViolation = std::numeric_limits<double>::infinity();
    failed.iterations = best.iterations;
    setResult(std::move(failed));
}
