#!/usr/bin/env bash
set -euo pipefail
counter_project="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$counter_project"
counter_python_deps="${NGSPICE_PYTHON_DEPS:-/tmp/counter_ngspice_python}"
export PYTHONPATH="$counter_python_deps${PYTHONPATH:+:$PYTHONPATH}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-/tmp/counter_ngspice_cache}"
export NGSPICE_MAXSTEP_PS="${NGSPICE_MAXSTEP_PS:-1}"
python3 -c 'import numpy, matplotlib' || {
    echo 'Install the waveform analysis dependencies first:' >&2
    echo 'python3 -m pip install --target /tmp/counter_ngspice_python -r ngspice/requirements.txt' >&2
    exit 1
}
exec python3 ngspice/run_postlayout.py
