#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
"""Extract the structure of a filter into plain data.

The 14 filters share one shape:

    if <address-book whitelist> { stop; }
    [ if <spam list> { discard; stop; } ]
    if <gate> {                       # domains / subjects / from-patterns
        addflag "\\Seen";
        fileinto "<Folder>";
        if <rule> { fileinto "<Folder/Sub>";
                    [ if <tier> { expire "day" "N"; } ]
                    stop; }
        ...
        [ default expire tiers ]
    }

This reads that back out so `data/categories/*.yml` can be generated from what
the filters actually do, rather than from the reference lists that drifted away
from them.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from sieve_eval import as_list, parse, unescape, unq  # noqa: E402


def _tests(test):
    """Flatten a test into (op, [leaf tests])."""
    if test.name in ("anyof", "allof"):
        return test.name, test.arguments["tests"]
    return "allof", [test]


def _classify(leaves):
    """Split leaf tests into the fields a rule can carry."""
    out = {
        "op": None,
        "domains": [],
        "subjects": [],
        "from_contains": [],
        "from_patterns": [],
        "addrbook": [],
        "size_under": None,
        "size_over": None,
        "exclude_subjects": [],
        "exclude_domains": [],
        "unhandled": [],
    }
    for t in leaves:
        if t.name == "address":
            hdrs = [h.lower() for h in as_list(t.arguments.get("header-list"))]
            if "from" in hdrs:
                out["domains"] += as_list(t.arguments["key-list"])
            else:
                out["unhandled"].append(t.name)
        elif t.name == "header":
            mt = t.arguments.get("match-type")
            hdrs = [h.lower() for h in as_list(t.arguments.get("header-names"))]
            keys = as_list(t.arguments["key-list"])
            if mt == ":list":
                out["addrbook"] += keys
            elif "subject" in hdrs:
                out["subjects"] += keys
            elif "from" in hdrs and mt == ":matches":
                out["from_patterns"] += keys
            elif "from" in hdrs:
                out["from_contains"] += keys
            else:
                out["unhandled"].append("%s:%s" % (t.name, ",".join(hdrs)))
        elif t.name == "size":
            key = "size_over" if t.arguments["comparator"] == ":over" else "size_under"
            out[key] = unq(t.arguments["limit"])
        elif t.name == "not":
            inner = t.arguments["test"]
            op2, leaves2 = _tests(inner)
            sub = _classify(leaves2)
            out["exclude_subjects"] += sub["subjects"]
            out["exclude_domains"] += sub["domains"]
            out["exclude_subjects"] += sub["from_contains"]
        elif t.name in ("anyof", "allof"):
            op2, leaves2 = _tests(t)
            sub = _classify(leaves2)
            for k in ("domains", "subjects", "from_contains", "from_patterns", "addrbook",
                      "exclude_subjects", "exclude_domains"):
                out[k] += sub[k]
            out["size_under"] = out["size_under"] or sub["size_under"]
            out["size_over"] = out["size_over"] or sub["size_over"]
        else:
            out["unhandled"].append(t.name)
    return out


def _actions(node):
    """Direct (non-if) actions of a block."""
    acts = {"fileinto": None, "flags": [], "unflags": [], "expire": None,
            "discard": False, "stop": False}
    for c in node.children:
        if type(c).__name__ == "IfCommand":
            continue
        name = getattr(c, "name", "")
        if name == "fileinto":
            acts["fileinto"] = unq(c.arguments["mailbox"])
        elif name in ("addflag", "setflag", "removeflag"):
            # sievelib exposes the flag list as "variable-name", and the value is
            # raw source: "\\Seen" holds the string \Seen.
            raw = c.arguments.get("variable-name", c.arguments.get("flags"))
            flags = [unescape(x) for x in as_list(raw)]
            acts["unflags" if name == "removeflag" else "flags"] += flags
        elif name == "expire":
            acts["expire"] = int(unq(c.arguments["value"]))
        elif name == "discard":
            acts["discard"] = True
        elif name == "stop":
            acts["stop"] = True
    return acts


def _rule_from(node):
    op, leaves = _tests(node.arguments["test"])
    match = _classify(leaves)
    match["op"] = op
    acts = _actions(node)

    tiers = []
    for c in node.children:
        if type(c).__name__ != "IfCommand":
            continue
        op2, leaves2 = _tests(c.arguments["test"])
        m2 = _classify(leaves2)
        m2["op"] = op2
        a2 = _actions(c)
        tiers.append({"match": m2, "actions": a2,
                      "tiers": [t for t in (_rule_from(c)["tiers"] or [])]})
    return {"match": match, "actions": acts, "tiers": tiers}


def extract(path):
    """Return {id, folder, preamble, gate, rules, defaults} for one filter."""
    tree = parse(path)
    ifs = [n for n in tree if type(n).__name__ == "IfCommand"]

    preamble = {"whitelist": [], "spam_discard": False}
    gate_node = None
    extra = []

    for n in ifs:
        r = _rule_from(n)
        m, a = r["match"], r["actions"]
        if m["addrbook"] and not a["fileinto"] and not a["discard"]:
            preamble["whitelist"] += m["addrbook"]
            continue
        if a["discard"]:
            preamble["spam_discard"] = True
            continue
        if gate_node is None:
            gate_node = r
        else:
            extra.append(r)

    top_folder = gate_node["actions"]["fileinto"] if gate_node else None
    return {
        "id": os.path.splitext(os.path.basename(path))[0],
        "folder": top_folder,
        "preamble": preamble,
        "gate": gate_node,
        "extra_blocks": extra,
    }


def _prune(d):
    """Drop empty fields so the YAML stays readable."""
    if isinstance(d, dict):
        return {k: _prune(v) for k, v in d.items()
                if v not in (None, [], {}, False, "")}
    if isinstance(d, list):
        return [_prune(x) for x in d]
    return d


if __name__ == "__main__":
    import json
    for p in sys.argv[1:] or ["filter/work.sieve"]:
        print(json.dumps(_prune(extract(p)), indent=2, ensure_ascii=False)[:4000])
