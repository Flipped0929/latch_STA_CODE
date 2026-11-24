#pragma once
#include "mcr_result.hpp"

// Creates a new file only; v3 STA conditions or zero-skew counter v4 and validated Howard/LP are required.
void exportHowardSdc(const std::string &output, const DelayGraph &dg, double initial,
                     double duty, const McrResult &howard, const McrResult &lp);
