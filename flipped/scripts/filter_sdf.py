#!/usr/bin/env python3
"""Strip (TIMINGCHECK ...) blocks from an SDF file.

Why: XSim's unisims LDCE model has no D->G / GE->G setup-hold specify arcs, so
annotating the Vivado-written SDF aborts with

    ERROR: [XSIM 43-3462] Unable to annotate SDF delays in the design.

The path delays (IOPATH / interconnect) are the part that a gate-level timing
simulation can actually use for a latch design; the setup/hold numbers are
reported by STA instead.  The filter therefore keeps every DELAY and drops
every TIMINGCHECK, and the result is labelled "..._delays_only.sdf" so nobody
mistakes it for the untouched Vivado output.

Usage: python filter_sdf.py <in.sdf> <out.sdf>
"""
import sys
from pathlib import Path


def strip_timingcheck(text: str) -> tuple:
    out = []
    i = 0
    removed = 0
    n = len(text)
    while i < n:
        j = text.find("(TIMINGCHECK", i)
        if j < 0:
            out.append(text[i:])
            break
        out.append(text[i:j])
        # find matching close paren, skipping quoted strings
        depth = 0
        k = j
        in_str = False
        while k < n:
            c = text[k]
            if in_str:
                if c == '"':
                    in_str = False
            elif c == '"':
                in_str = True
            elif c == "(":
                depth += 1
            elif c == ")":
                depth -= 1
                if depth == 0:
                    k += 1
                    break
            k += 1
        removed += 1
        i = k
    return "".join(out), removed


def main():
    src, dst = Path(sys.argv[1]), Path(sys.argv[2])
    text = src.read_text(encoding="utf-8", errors="replace")
    out, n = strip_timingcheck(text)
    # XSim cannot map the conditional clear arc of LDCE either.
    lines = out.splitlines(True)
    kept = [ln for ln in lines
            if "(IOPATH (posedge CLR) Q" not in ln and "PATHPULSE" not in ln]
    n_clr = len(lines) - len(kept)
    dst.write_text("".join(kept), encoding="utf-8")
    print("removed %d TIMINGCHECK blocks and %d CLR->Q arcs -> %s"
          % (n, n_clr, dst))


if __name__ == "__main__":
    main()
