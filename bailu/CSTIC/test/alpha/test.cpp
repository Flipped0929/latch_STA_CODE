#include <fstream>
#include <iostream>
#include <vector>
#include <string>
#include <cmath>
#include <cstdlib>
#include <unistd.h>
#include <fcntl.h>

using namespace std;


int benchmark_vtr(const char *s)
{
    string cmd = s;
    string command_1 = "mkdir " + cmd;
    system(command_1.c_str());
    string command_2 = "cd " + cmd;
    system(command_2.c_str());
    string command_3 = "~/Documents/vtr-verilog-to-routing-8.0.0/vpr/vpr ~/Documents/vtr-verilog-to-routing-8.0.0/vtr_flow/arch/timing/k6_frac_N10_mem32K_40nm.xml ~/Documents/vtr-verilog-to-routing-8.0.0/vtr_flow/benchmarks/blif/" + cmd + " --timing_report_detail aggregated";
    //cout << command_3;
    system(command_3.c_str());
    /*
    char outfile[255];
    char *name =s.data();
    sprintf(outfile, "%s.blif.out", name);
    benchmarkConversion("report_timing.hold.rpt","hold.out");
    benchmarkConversion("report_timing.setup.rpt","setup.out");
    printrsltfile("setup.out","hold.out",outfile);
    return 0;
    */
}

int main()
{
    benchmark_vtr("s38417.blif");
}