#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Check that every relative Markdown link resolves to a file that exists.

    python tools/check_links.py [path ...]      # default: the whole repo

`[LICENSE](LICENSE)` survived in four READMEs for a year because nothing checked.
External http(s) links and pure `#anchor` links are not followed.
"""
import os
import re
import sys

LINK = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
SKIP_DIRS = {".git", ".idea", "node_modules", "__pycache__", ".venv", "venv"}


def markdown_files(targets):
    for t in targets:
        if os.path.isfile(t):
            yield t
            continue
        for root, dirs, files in os.walk(t):
            dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
            for f in sorted(files):
                if f.endswith(".md"):
                    yield os.path.join(root, f)


def main(argv):
    targets = argv[1:] or ["."]
    bad = 0
    checked = 0
    for path in markdown_files(targets):
        base = os.path.dirname(path)
        for m in LINK.finditer(open(path, encoding="utf-8").read()):
            target = m.group(1).strip()
            if target.startswith(("http://", "https://", "mailto:", "#")):
                continue
            target = target.split("#", 1)[0].split(" ", 1)[0]
            if not target:
                continue
            checked += 1
            resolved = os.path.normpath(os.path.join(base, target))
            if not os.path.exists(resolved):
                bad += 1
                print("BROKEN  %s -> %s" % (path, m.group(1)))

    print("\n%d relative link(s) checked, %d broken" % (checked, bad))
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
