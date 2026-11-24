#!/bin/sh
set -eu

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)

exec cmake \
    "-DINPUT=$script_dir/outputs/counter/counter_retimed.v" \
    "-DOUTPUT=$script_dir/outputs/counter_sky130.v" \
    -DTOP=counter \
    -P "$script_dir/map_cells.cmake"
