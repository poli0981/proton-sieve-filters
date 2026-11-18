<!-- This project is in maintenance mode: see MAINTENANCE.md.
     Pull requests are accepted for DOMAIN FIXES ONLY -- adding, removing or correcting a
     domain in an existing data/categories/*.yml file. A pull request that changes
     anything else (new categories, keywords, tools, docs, workflows) is labelled
     `out-of-scope` and closed automatically. -->

## What changed and why

<!-- Which domain, what was wrong (wrong category, renamed, defunct, 404, missing), and
     how you know -- a link to the company's site or an announcement is ideal. -->

## Checklist

- [ ] This only adds, removes or corrects domains in an **existing** `data/categories/*.yml`
- [ ] I edited `data/`, not `filter/*.sieve` — those are generated
- [ ] `python tools/generate.py` and `python tools/gen_docs.py` run, and what they regenerated is committed
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
