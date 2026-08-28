# Acknowledgments

<!-- SPDX-License-Identifier: CC-BY-4.0 -->

## Who built this

**[@poli0981](https://github.com/poli0981)** — the project, its direction, and every
decision in it.

**AI assistance** — GitHub Copilot (Claude Sonnet 4) and Grok 4 wrote much of the original
implementation, the translations, and the domain and keyword lists. Claude Opus 5 did the
v0.2.1–v0.3.0 rework: the defect fixes, the data model, the generator and the tooling.

This is disclosed rather than buried because it has consequences you should know about.
The domain and keyword lists were compiled by a model and are **not individually
verified**. The audit that produced v0.2.1 found 13 domains whose own comment said
"(defunct)", two attributed to the wrong company, and one that was not a valid hostname.
Treat the data as a well-organised starting point, not as fact-checked reference material.
See [DISCLAIMER.md](DISCLAIMER.md).

## What this is built on

- **[RFC 5228](https://datatracker.ietf.org/doc/html/rfc5228)** and its extensions —
  [RFC 5232](https://datatracker.ietf.org/doc/html/rfc5232) (imap4flags) and
  [RFC 6134](https://datatracker.ietf.org/doc/html/rfc6134) (extlists) — define the
  language these filters are written in.
- **[Proton AG](https://proton.me)** built the mail service and exposes Sieve to its
  users, which is the only reason this project can exist. This project is not affiliated
  with, endorsed by, or sponsored by Proton AG.
- **[sievelib](https://github.com/tonioo/sievelib)** by Antoine Nguyen (MIT) — the Sieve
  parser behind `tools/validate_sieve.py`. Taught Proton's dialect at runtime rather than
  forked. Installed from PyPI, not vendored here.
- **[PyYAML](https://pyyaml.org/)** and
  **[jsonschema](https://github.com/python-jsonschema/jsonschema)** — likewise.

## Contributors

There are none yet besides the author. When there are, they will be listed here by name.

## Attribution

The MIT licence asks only that you keep the copyright and permission notice with any
substantial portion of the software. That is the whole obligation, and this file does not
add to it.

The domain and keyword data under [`data/`](data/) is **CC0** — public domain, no
attribution required at all. Take it and use it anywhere.

Prose, including this file, is **CC-BY-4.0**: reuse it freely and credit the project. See
[LICENSES/README.md](LICENSES/README.md) for which licence covers which path, and
[CITATION.cff](CITATION.cff) if you want a citation.

---

*This file replaced `ACKNOWLEDGE.md`, which thanked static-analysis tools that did not
exist in the repository, beta testers for a project that had never had an external
contributor, and roughly thirty standards bodies and universities with no connection to
it. It also asked redistributors for more attribution than the MIT licence requires. None
of that was true, so none of it is here.*
