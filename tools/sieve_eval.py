# SPDX-License-Identifier: MIT
"""A small evaluator for the subset of Sieve these filters use.

Enough to answer "where does this message end up?" so the P0 fixes can be
regression-tested. Not a general Sieve implementation.
"""
import fnmatch, os, re
import sievelib.commands as sc
from sievelib.parser import Parser

sc.match_type["extension_values"][":list"] = "extlists"


class ExpireCommand(sc.Command):
    args_definition = [
        {"name": "unit", "type": ["string"], "required": True},
        {"name": "value", "type": ["string"], "required": True},
    ]
    _type = "action"
    is_extension = True


if "expire" not in sc.get_command_instance.__globals__.get("commands", {}):
    try:
        sc.add_commands([ExpireCommand])
    except Exception:
        pass


def unq(s):
    return s[1:-1] if isinstance(s, str) and len(s) >= 2 and s[0] == '"' else s


def unescape(s):
    """Undo Sieve string escaping: the source "\\Seen" holds a single backslash."""
    out, i = [], 0
    while i < len(s):
        if s[i] == "\\" and i + 1 < len(s):
            out.append(s[i + 1])
            i += 2
        else:
            out.append(s[i])
            i += 1
    return "".join(out)


def as_list(v):
    if v is None:
        return []
    if isinstance(v, list):
        return [unq(x) for x in v]
    v = unq(v)
    return [v]


SIZE_RE = re.compile(r"^(\d+)([KMG]?)$", re.I)


def parse_size(s):
    m = SIZE_RE.match(unq(str(s)).strip())
    if not m:
        raise ValueError(f"bad size {s!r}")
    return int(m.group(1)) * {"": 1, "K": 1024, "M": 1024**2, "G": 1024**3}[m.group(2).upper()]


class Message:
    """headers: dict name -> str ; size in bytes ; lists: name -> set of addrs"""

    def __init__(self, headers=None, size=1000, lists=None):
        self.headers = {k.lower(): v for k, v in (headers or {}).items()}
        self.size = size
        self.lists = lists or {}

    def header(self, name):
        return self.headers.get(name.lower(), "")

    def addr_part(self, name, part):
        raw = self.header(name)
        m = re.search(r"<([^>]+)>", raw)
        addr = m.group(1) if m else raw.strip()
        if part == ":domain":
            return addr.split("@")[-1] if "@" in addr else ""
        if part == ":localpart":
            return addr.split("@")[0]
        return addr


def match(value, key, mt):
    v, k = value.lower(), key.lower()
    if mt == ":is":
        return v == k
    if mt == ":contains":
        return k in v
    if mt == ":matches":
        return fnmatch.fnmatchcase(v, k)
    raise NotImplementedError(mt)


def evaluate(test, msg):
    n = test.name
    a = test.arguments
    if n == "anyof":
        return any(evaluate(t, msg) for t in a["tests"])
    if n == "allof":
        return all(evaluate(t, msg) for t in a["tests"])
    if n == "not":
        return not evaluate(a["test"], msg)
    if n == "true":
        return True
    if n == "false":
        return False
    if n == "size":
        limit = parse_size(a["limit"])
        return msg.size > limit if a["comparator"] == ":over" else msg.size < limit
    if n == "exists":
        return all(msg.header(h) for h in as_list(a["header-names"]))
    if n in ("header", "address"):
        mt = a.get("match-type") or ":is"
        names = as_list(a.get("header-names") or a.get("header-list"))
        keys = as_list(a["key-list"])
        if mt == ":list":
            for h in names:
                val = msg.addr_part(h, ":all") if n == "address" else msg.header(h)
                for lst in keys:
                    if val.lower() in {x.lower() for x in msg.lists.get(lst, set())}:
                        return True
            return False
        for h in names:
            val = msg.addr_part(h, a.get("address-part") or ":all") if n == "address" else msg.header(h)
            if any(match(val, k, mt) for k in keys):
                return True
        return False
    raise NotImplementedError(f"test {n}")


class Result:
    def __init__(self):
        self.folder = None      # last fileinto wins within one script
        self.flags = set()
        self.expire_days = None
        self.discarded = False
        self.stopped = False
        self.trace = []

    def __repr__(self):
        return (f"Result(folder={self.folder!r}, flags={sorted(self.flags)}, "
                f"expire={self.expire_days}, discarded={self.discarded})")


def run(nodes, msg, res):
    for node in nodes:
        t = type(node).__name__
        if t == "RequireCommand":
            continue
        if t == "IfCommand":
            if evaluate(node.arguments["test"], msg):
                res.trace.append(f"if@{getattr(node, 'lineno', '?')} TAKEN")
                run(node.children, msg, res)
                if res.stopped:
                    return
            continue
        if t == "ElsifCommand":
            continue  # handled inline by sievelib's tree in practice
        name = getattr(node, "name", "")
        if name == "fileinto":
            res.folder = unq(node.arguments["mailbox"])
        elif name == "addflag":
            res.flags |= set(as_list(node.arguments.get("flags")))
        elif name == "setflag":
            res.flags = set(as_list(node.arguments.get("flags")))
        elif name == "removeflag":
            res.flags -= set(as_list(node.arguments.get("flags")))
        elif name == "expire":
            res.expire_days = int(unq(node.arguments["value"]))
        elif name == "discard":
            res.discarded = True
        elif name == "stop":
            res.stopped = True
            return


_PARSE_CACHE = {}


def parse(path):
    """Parse a filter, memoised on (path, mtime, size).

    check_roundtrip runs tens of thousands of messages through a handful of
    files; re-parsing each time dominated its runtime.
    """
    try:
        st = os.stat(path)
        key = (os.path.abspath(path), st.st_mtime_ns, st.st_size)
    except OSError:
        key = None

    if key is not None and key in _PARSE_CACHE:
        return _PARSE_CACHE[key]

    p = Parser()
    if not p.parse_file(path):
        raise SyntaxError(f"{path}: {p.error}")
    if key is not None:
        _PARSE_CACHE[key] = p.result
    return p.result


def deliver(path, msg):
    res = Result()
    run(parse(path), msg, res)
    return res
