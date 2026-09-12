# Alin Trandafir's resume

Two CVs built from one LaTeX class:

| Source | Output | Language |
| --- | --- | --- |
| `resume.tex` | `alin_trandafir_resume.pdf` | English |
| `curriculum.tex` | `alin_trandafir_curriculum.pdf` | Spanish |

Both pull layout from `developercv.cls` and personal data from `identity.tex` — name,
contact details and the shared technology keyword list, so a changed phone number or
handle is edited once rather than once per language.

`developercv.cls` (bundled) is the [Developer CV](https://www.latextemplates.com)
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
https://github.com/ender-null/resume/releases/latest/download/alin_trandafir_resume.pdf
```
