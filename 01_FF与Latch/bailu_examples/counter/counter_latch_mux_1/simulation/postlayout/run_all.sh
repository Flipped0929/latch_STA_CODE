#!/usr/bin/env bash
set -euo pipefail
postlayout_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
postlayout_python="${POSTLAYOUT_PYTHON:-/usr/bin/python3}"
"$postlayout_python" "$postlayout_dir/run.py"
"$postlayout_python" "$postlayout_dir/analyze.py"
"$postlayout_python" "$postlayout_dir/run.py" --name refined --max-step-ps 2.5
"$postlayout_python" "$postlayout_dir/analyze.py" --name refined
"$postlayout_python" "$postlayout_dir/summarize.py"
