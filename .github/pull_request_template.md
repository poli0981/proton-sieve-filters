## What changed and why

<!-- One or two sentences. -->

## Checklist

- [ ] I edited `data/`, not `filter/*.sieve` — those are generated
- [ ] `python tools/generate.py` run, and the regenerated filters are committed
- [ ] Checks pass:

```bash
python tools/generate.py --check
python tools/gen_docs.py --check
python tools/validate_sieve.py
python tools/lint_proton.py
python tools/check_data.py
python tools/check_folders.py
python tools/check_links.py
python tests/test_regressions.py
```

## If filter behaviour changed

Paste the output of the routing comparison, and say why the differences are intended:

```bash
python tools/check_roundtrip.py OLD_DIR filter
```

<!-- Adding a category? It also needs a row in README.md and README/README.vi.md
     — CI checks both. -->
