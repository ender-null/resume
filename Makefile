# Local builds. Before this there was no way to see the CV without pushing to GitHub:
# the last local attempt (15 Mar 2026) died on a missing moresize.sty, and this repo's
# class also needs raleway and fontawesome5, none of which ship with BasicTeX.
#
# Tectonic needs no TeX installation at all and fetches those automatically:
#   brew install tectonic
# Or use `make docker`, which needs only Docker and reproduces CI exactly.

TEX    := tectonic
IMAGE  := dxjoke/tectonic-docker:0.15.0-alpine-biber
OUT_EN := alin_trandafir_cv_en.pdf
OUT_ES := alin_trandafir_cv_es.pdf
JUNK   := *.aux *.log *.out *.fls *.fdb_latexmk *.synctex.gz

.PHONY: all en es docker watch clean
.DEFAULT_GOAL := all

all: en es
en: $(OUT_EN)
es: $(OUT_ES)

$(OUT_EN): resume.tex developercv.cls
	$(TEX) resume.tex
	mv resume.pdf $@

$(OUT_ES): resume-spanish.tex developercv.cls
	$(TEX) resume-spanish.tex
	mv resume-spanish.pdf $@

## Same toolchain as CI, no local TeX needed
docker:
	docker run --rm --mount src=$(PWD),target=/usr/src/tex,type=bind $(IMAGE) \
	  /bin/sh -c "tectonic resume.tex && tectonic resume-spanish.tex"
	mv resume.pdf $(OUT_EN)
	mv resume-spanish.pdf $(OUT_ES)

## Rebuild on save
watch:
	$(TEX) -X watch

clean:
	rm -f $(JUNK) $(OUT_EN) $(OUT_ES) resume.pdf resume-spanish.pdf
