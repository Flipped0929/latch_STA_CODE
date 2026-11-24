#pragma once
#include <stdio.h>
#include <stdlib.h>
#include <chrono>
#include "mcr_result.hpp"

using namespace chrono;
/**
 * @brief Linear programing for mcr using GLPK
 * 
 * @param dg Shared delay graph, including per-node latch timing.
 * @param tInitial Coordinate-transform reference period.
 * @param result Validated primal solution or explicit failure status.
 */
nanoseconds mcrLP(const DelayGraph &dg, double tInitial, McrResult &result, double dutyCycle = 0.5);
/**
 * @brief Linear programing for ell using GLPK
 * 
 * @param fileName 
 */
nanoseconds ellLP(const string &fileName,double &tlp,double &wlp);
