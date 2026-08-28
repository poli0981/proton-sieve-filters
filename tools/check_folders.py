#!/usr/bin/env python3
"""Check that each filter's `# Folders:` header block lists exactly the folders
it actually files into, and that README.md's top-level folder list is complete.

    python tools/check_folders.py [path ...]      # default: filter/

v0.2.0's README told users to create 14 folders, five of which no script used,
while omitting ~70 subfolders that every script depended on. This makes that
class of drift a build failure.
"""
import glob
import io
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from sieve_eval import parse, unq  # noqa: E402


def actual_folders(path):
    out = set()

    def walk(nodes):
        for n in nodes:
            if getattr(n, "name", "") == "fileinto":
                out.add(unq(n.arguments["mailbox"]))
            walk(getattr(n, "children", []))

    walk(parse(path))
    return out


def documented_folders(path):
    """Parse the `# Folders: a, b,` / `#          c` block from the header."""
    text = io.open(path, encoding="utf-8").read()
    lines = text.split("\n")
    try:
        start = next(i for i, l in enumerate(lines) if l.startswith("# Folders:"))
    except StopIteration:
        return None

    collected = lines[start][len("# Folders:"):]
    for l in lines[start + 1:]:
        if not l.startswith("#"):
            break
        body = l[1:].strip()
        if not body or body.endswith(":") or re.match(r"^[A-Z]+:", body):
            break
        collected += " " + body
    return {p.strip() for p in collected.split(",") if p.strip()}


def main(argv):
    targets = argv[1:] or ["filter"]
    files = []
    for t in targets:
        if os.path.isdir(t):
            files.extend(sorted(glob.glob(os.path.join(t, "*.sieve"))))
        else:
            files.append(t)

    bad = 0
    every = set()
    for f in files:
        actual = actual_folders(f)
        every |= actual
        documented = documented_folders(f)
        if documented is None:
            print("MISSING  %s has no `# Folders:` header block" % f)
            bad += 1
            continue
        undocumented = actual - documented
        phantom = documented - actual
        if undocumented:
            print("UNDOCUMENTED  %s files into %s but does not list them"
                  % (f, ", ".join(sorted(undocumented))))
            bad += 1
        if phantom:
            print("PHANTOM       %s documents %s but never files into them"
                  % (f, ", ".join(sorted(phantom))))
            bad += 1

    # Every top-level folder must appear in README.md's setup section.
    readme = "README.md"
    if os.path.exists(readme):
        text = io.open(readme, encoding="utf-8").read()
        tops = sorted({f.split("/")[0] for f in every})
        missing = [t for t in tops if t not in text]
        if missing:
            print("README        does not mention top-level folder(s): %s"
                  % ", ".join(missing))
            bad += 1

    print("\n%d filter(s), %d distinct folder(s), %d problem(s)"
          % (len(files), len(every), bad))
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
