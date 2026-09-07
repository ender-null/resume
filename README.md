# Alin Trandafir's resume

Two CVs built from one LaTeX class:

| Source | Output | Language |
| --- | --- | --- |
| `resume.tex` | `alin_trandafir_cv_en.pdf` | English |
| `resume-spanish.tex` | `alin_trandafir_cv_es.pdf` | Spanish |

Both use `developercv.cls` (bundled) — the [Developer CV](https://www.latextemplates.com)
class by Jan Vorisek, after a template by Jan Küster. MIT licensed.

## Building

```sh
make          # both PDFs (needs tectonic: brew install tectonic)
make en       # English only
make es       # Spanish only
make docker   # same toolchain as CI; needs only Docker
make clean
```

## Releases

Every push to `main` builds both PDFs as workflow artifacts. Pushing a `v*` tag also
publishes them to a GitHub Release, which gives a permanent link that needs no login:

```
https://github.com/ender-null/resume/releases/latest/download/alin_trandafir_cv_en.pdf
```
