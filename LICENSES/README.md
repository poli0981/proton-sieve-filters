# Licences

This project is three different kinds of thing, so it carries three licences.
Which one applies depends on the path.

| Path | Licence | Why |
| --- | --- | --- |
| `filter/`, `bundles/`, `tools/`, `tests/`, `data/schema/`, `data/bundles.yml` | **MIT** | Software: the Sieve scripts and the tooling that generates and validates them. |
| `data/categories/`, `data/shared/` | **CC0-1.0** | A dataset: which company sends from which domain, and which words appear in which kind of subject. Facts, dedicated to the public domain with no attribution required. |
| `README.md`, `README/`, `docs/`, `CHANGELOG.md`, `DISCLAIMER.md`, `PRIVACY.md`, `ACKNOWLEDGMENTS.md`, `MIGRATION-REPORT.md`, `data/README.md` | **CC-BY-4.0** | Prose. Reuse it freely; credit the project. |

`LICENSE` at the repository root is the MIT text, so GitHub reports this as an MIT
project — which is right for the part most people will actually use.

## Does the mix work?

Yes. The generated `.sieve` files are MIT, and they are produced by MIT tooling from
CC0 data. CC0 imposes no conditions at all, so nothing is inherited and there is no
share-alike clause to satisfy. If you take only the domain lists, you owe nothing.

## Files

- [`MIT.txt`](MIT.txt)
- [`CC0-1.0.txt`](CC0-1.0.txt)
- [`CC-BY-4.0.txt`](CC-BY-4.0.txt)

Texts are the canonical SPDX versions, unmodified.

## Third-party material

None is vendored. The domain and keyword lists were compiled for this project rather
than imported from another list, and the only runtime dependencies are Python packages
installed from PyPI (`sievelib`, `PyYAML`, `jsonschema`) that are not redistributed here.
