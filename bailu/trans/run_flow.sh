# cd /path/to/code/trans

# INPUT_DIR=../examples/picorv32 \
# OUTPUT_DIR=../examples/picorv32/picorv32_latch \
# PDK_DIR=../pdk \
# TOP=picorv32 \
# CLOCK=clk \
# bash run_flow.sh


#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd -- "$script_dir"

# Relative paths below are resolved from the trans directory.
input_dir=${INPUT_DIR:-../examples/fetch}
pdk_dir=${PDK_DIR:-../pdk}
top=${TOP:-fetch}
clock=${CLOCK:-clk_i}
yosys=${YOSYS:-yosys}
cmake=${CMAKE:-cmake}
duplicate=${DUPLICATE:-"$script_dir/build/duplicate"}

[[ "$top" =~ ^[A-Za-z_][A-Za-z_0-9]*$ ]] || {
    printf 'Invalid top module name: %s\n' "$top" >&2
    exit 1
}
if [[ -n "${INPUT_FILE:-}" ]]; then
    input_dir=$(cd -- "$(dirname -- "$INPUT_FILE")" && pwd)
    input_files=("$input_dir/$(basename -- "$INPUT_FILE")")
    [[ -f "${input_files[0]}" ]] || {
        printf 'RTL file not found: %s\n' "${input_files[0]}" >&2
        exit 1
    }
else
    input_dir=$(cd -- "$input_dir" && pwd)
    shopt -s nullglob
    input_files=("$input_dir"/*.v)
    shopt -u nullglob
    [[ ${#input_files[@]} -gt 0 ]] || {
        printf 'No Verilog design files found in: %s\n' "$input_dir" >&2
        exit 1
    }
fi
output_dir=${OUTPUT_DIR:-"$input_dir/$(basename -- "$input_dir")_latch"}
pdk_dir=$(cd -- "$pdk_dir" && pwd)
yosys=$(command -v "$yosys")
cmake=$(command -v "$cmake")
yosys="$(cd -- "$(dirname -- "$yosys")" && pwd)/$(basename -- "$yosys")"
cmake="$(cd -- "$(dirname -- "$cmake")" && pwd)/$(basename -- "$cmake")"

if [[ -z "${DUPLICATE:-}" ]]; then
    "$cmake" -S "$script_dir" -B "$script_dir/build"
    "$cmake" --build "$script_dir/build"
fi
[[ -x "$duplicate" ]] || { printf 'Executable not found: %s\n' "$duplicate" >&2; exit 1; }
duplicate="$(cd -- "$(dirname -- "$duplicate")" && pwd)/$(basename -- "$duplicate")"

mkdir -p -- "$output_dir"
output_dir=$(cd -- "$output_dir" && pwd)
work_dir=$(mktemp -d "$output_dir/.run.XXXXXX")
trap 'cd -- "$script_dir"; rm -f -- "$work_dir"/*; rmdir -- "$work_dir"' EXIT
cd -- "$work_dir"
cp -- "$script_dir/export.ys" "$script_dir/retiming_core.ys" .

printf 'Exporting %s RTL\n' "$top"
"$yosys" -b "verilog -noattr -noexpr" -o "${top}_yosys.v" \
    -p "hierarchy -check -top $top; script export.ys" "${input_files[@]}"

printf 'Duplicating DFFs and converting clock enables\n'
"$cmake" "-DINPUT=$work_dir/${top}_yosys.v" "-DOUTPUT=$work_dir/${top}_dup.v" \
    "-DGATED_OUTPUT=$work_dir/${top}_gated.v" "-DTOP=$top" "-DCLOCK=$clock" \
    "-DDUPLICATE=$duplicate" "-DYOSYS=$yosys" -P "$script_dir/duplicate.cmake"

printf 'Retiming first-phase data DFFs\n'
"$yosys" -f "verilog -icells" "${top}_gated.v" \
    -p "hierarchy -check -top $top; script retiming_core.ys" \
    -b "verilog -noattr -noexpr" -o "${top}_retimed.v"

printf 'Mapping cells and replacing DFFs with SKY130 latches\n'
"$cmake" "-DINPUT=$work_dir/${top}_retimed.v" "-DOUTPUT=$work_dir/${top}_sky130.v" \
    "-DTOP=$top" "-DPDK_DIR=$pdk_dir" -DPDK=sky130 "-DYOSYS=$yosys" \
    -P "$script_dir/map_cells.cmake"

# Publish the five netlists only after every conversion step succeeds.
for stage in yosys dup gated retimed sky130; do
    mv -f -- "${top}_${stage}.v" "$output_dir/"
done
printf 'Netlists written to %s\n' "$output_dir"
