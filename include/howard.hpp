#pragma once

#include <vector>
#include <limits>
#include <tuple>
#include "timing_graph.hpp"
/**
 * @brief minimum cycle ratio solver using Howard's algorithm
 * 
 */
using namespace std;
class Howard
{
public:
    Howard(const Graph &g,size_t n, double x, double y) : _g{g}, _n{n},_r{x}, _eps{y},_minRatioCycle(0),_su(n),_dist(n,numeric_limits<double>::infinity())
    {
    }
    void run();
    double getRatio();
    vector<Edge> getCycle();
private:
    const Graph &_g;           //the given graph
    const size_t _n;//num of nodes
    double _r;                 //ratio
    const double _eps;               //precision
    
    vector<Edge> _minRatioCycle; //save the minimum ratio cycle
    vector<Edge> _su;//save the successor edge of nodes
    vector<double> _dist;
    tuple<double,Vertex> findRatio();
};