#!/usr/bin/env python3
"""Parse every Sieve filter with a real Sieve parser.

    python tools/validate_sieve.py [path ...]      # default: filter/

sievelib does not know Proton's dialect out of the box, so `tools/sieve_eval`
teaches it the `extlists` :list match-type and the vnd.proton.expire `expire`
command before parsing. Exit code 1 if any file fails to parse.
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from sieve_eval import parse  # noqa: E402


def main(argv):
    targets = argv[1:] or ["filter"]
    files = []
    for t in targets:
        if os.path.isdir(t):
            files.extend(sorted(glob.glob(os.path.join(t, "*.sieve"))))
        else:
            files.append(t)
    if not files:
        sys.stderr.write("no .sieve files found\n")
        return 2

    bad = 0
    for f in files:
        try:
            parse(f)
            print("OK    %s" % f)
        except SyntaxError as e:
            bad += 1
            print("FAIL  %s\n        %s" % (f, str(e).split(": ", 1)[-1]))

    print("\n%d/%d parsed" % (len(files) - bad, len(files)))
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
