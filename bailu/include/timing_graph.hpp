#pragma once
#include <boost/graph/adjacency_list.hpp>
#include <cstddef>
#include <map>
#include <optional>
#include <string>
#include <utility>
#include <vector>
#include "strOperation.hpp"

using namespace std;
struct LatchTiming
{
    double tsu = 0.0;
    double thd = 0.0;
    double tdqMin = 0.0;
    double tdqMax = 0.0;
    double tcqMin = 0.0;
    double tcqMax = 0.0;
};

struct NodeIdx
{
    size_t idx;
    LatchTiming timing;
    string name;
    struct ClockChecks
    {
        bool characterized = false;
        std::optional<double> minPulseHigh;
        std::optional<double> minPulseLow;
    } clockChecks{};
    enum class Kind { Latch, Input, Output, Unknown } kind = Kind::Latch;
    enum class Polarity { Positive, Negative } polarity = Polarity::Positive;
    pair<double, double> windowFraction{0.5, 1.0};
    // A report supplies only this polarity's pulse check, not complete Liberty coverage.
    std::optional<double> reportedPulseWidth{};
};

struct IoConstraints
{
    struct StaConditions
    {
        string clockName, clockPort;
        double clockTransition, inputTransition, outputLoad;
    };
    bool enabled = false;
    string inputPort, outputPort;
    double inputMin = 0.0, inputMax = 0.0;
    double outputMin = 0.0, outputMax = 0.0;
    double setupUncertainty = 0.0, holdUncertainty = 0.0;
    double dutyCycle = 0.5;
    std::optional<StaConditions> staConditions;
    // Physical ports sharing the input node's clock, delay budgets and slew.
    vector<string> inputPorts;
    bool optimizeSkew = true;
    string timingModel{};
    struct CounterTiming
    {
        struct Port
        {
            double minDelay, maxDelay;
            double transition = 0.0, load = 0.0;
        };
        string clockName, clockPort;
        double period, rise, fall, skew, clockTransition;
        map<string, Port> inputs, outputs;
    };
    std::optional<CounterTiming> counterTiming{};
};

constexpr size_t kIoNodeIdx = 0;
enum McrVariable : size_t { kMcrA, kMcrLatestA, kMcrD, kMcrLatestD, kMcrSkew, kMcrVarsPerNode };
// shortcut: s_k < T uses a fixed ns margin, revisit when timing scales approach that margin.
constexpr double kMcrSkewMargin = 1e-8;
constexpr double kMcrFeasibilityEps = 1e-7;
constexpr double kMcrPeriodEps = 1e-4;
static_assert(kMcrVarsPerNode == 5 && kMcrSkewMargin > 0.0, "Invalid MCR layout or phase margin");

inline size_t mcrIndex(size_t node, McrVariable variable)
{
    return kMcrVarsPerNode * node + variable;
}
struct EdgeDelay
{
    double maxDelay;
    double minDelay;
};

struct NodeProperties
{
    size_t nodeIndex; /**< node index, range: [0, num_vertices-1] */
};

/**
 * Definitions for Arc Properties.
 *
 */
struct ArcProperties
{
    int mode;      /*the flag of different constraint edge*/
    double weight; /* weight */
    double delay;  /*max delay of setup edge or min delay of hold edge in ell, transit time in mcr*/
};

using Graph = boost::adjacency_list<boost::multisetS, boost::vecS, boost::bidirectionalS, NodeProperties,
                                    ArcProperties>;
using DelayGraph = boost::adjacency_list<boost::vecS, boost::vecS, boost::bidirectionalS, NodeIdx,
                                         EdgeDelay, IoConstraints>; // store the delay information (max & min) between two
                                                     // flip-flops
using Vertex = boost::graph_traits<Graph>::vertex_descriptor;
using Edge = boost::graph_traits<Graph>::edge_descriptor;
using InEdgeIterator = boost::graph_traits<Graph>::in_edge_iterator;
using OutEdgeIterator = boost::graph_traits<Graph>::out_edge_iterator;
using VertexIterator = boost::graph_traits<Graph>::vertex_iterator;
using EdgeIterator = boost::graph_traits<Graph>::edge_iterator;
//use graph to imitate tree
using ShortestPathTree = boost::adjacency_list<boost::listS, boost::vecS, boost::bidirectionalS>;
using SPTVertex = boost::graph_traits<ShortestPathTree>::vertex_descriptor;
using SPTEdge = boost::graph_traits<ShortestPathTree>::edge_descriptor;

void generateSimpleGraph(Graph &g);
/**
 * Read blif out file into a delay graph
 *
 * @param fileName
 * @param string
 * @param nodeIdxMap
 * @param g
 * @param tInitial
 *
 * @return
 */
bool getDelayGraph(const string &fileName, DelayGraph &dg, double &tInitial);
/**
 * @brief Get the Delay Graph from rslt file
 * 
 * @param fileName 
 * @param g 
 * @param tInitial 
 * @return true 
 * @return false 
 */
bool getRsltDelayGraph(const string &fileName, DelayGraph &dg, double &tInitial);
bool readDelayGraph(const string &fileName, DelayGraph &dg, double &tInitial);
// Marked counter inputs keep distinct endpoints; readLatchTiming loads their required v4 JSON.
// v1: six parameters; v2: pulse checks; v3: SDC DAG IO; v4: zero-skew counter.
void readLatchTiming(const string &fileName, DelayGraph &dg);
// Counter topology may be valid before JSON loading; counterTiming indicates classified metadata.
bool validDelayGraph(const DelayGraph &dg, double tInitial);
// Counter solving requires loaded v4 data, opposite-phase paths, 50% duty and zero skew.
bool validCounterMcr(const DelayGraph &dg, double dutyCycle);
// Constant part of the earliest input envelope; requires a validated counter node with incoming paths.
double counterMinArrival(const DelayGraph &dg, size_t node);
// Infinity denotes unsupported data/duty cycle or an overflowing pulse bound.
double mcrPulsePeriodMin(const DelayGraph &dg, double dutyCycle);
bool validMcrGraph(const Graph &g);
/**
 * @brief Generate constraint graph for MCR
 * 
 * @param g 
 * @param tInitial 
 */
// dutyCycle is a fixed high-level fraction in (0, 0.5]; the window opens at s+(1-dutyCycle)*T.
void getMcrGraph(const string &fileName, Graph &g, double &tInitial, double dutyCycle = 0.5);
void getMcrGraph(const DelayGraph &dg, Graph &g, double tInitial, double dutyCycle = 0.5);
// Potentials use x[v] - x[u] <= weight - ratio * transit on u -> v.
double mcrPotentialViolation(const Graph &g, double ratio, const vector<double> &potential);
double mcrScheduleViolation(const DelayGraph &dg, double period, const vector<double> &potential,
                            double dutyCycle = 0.5);
bool fillMcrSkew(const Graph &g, double ratio, double period, double eps,
                 vector<double> &skew, vector<double> &potential);
/**
 * @brief Generate constraint graph for ellipsoid
 * 
 * @param g 
 * @param tInitial 
 */
void getEllGraph(const string &fileName, Graph &g, double &tInitial);
