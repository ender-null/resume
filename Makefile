# Local builds. Before this there was no way to see the CV without pushing to GitHub:
# the last local attempt (15 Mar 2026) died on a missing moresize.sty, and this repo's
# class also needs raleway and fontawesome5, none of which ship with BasicTeX.
#
# Tectonic needs no TeX installation at all and fetches those automatically:
#   brew install tectonic
# Or use `make docker`, which needs only Docker and reproduces CI exactly.

TEX    := tectonic
IMAGE  := dxjoke/tectonic-docker:0.15.0-alpine-biber

# Both documents share the class and the contact/keyword data, so either one changing
# must rebuild both PDFs. identity.tex was easy to miss here.
DEPS   := developercv.cls identity.tex

OUT_EN := alin_trandafir_resume.pdf
OUT_ES := alin_trandafir_curriculum.pdf
OUT_ETT := alin_trandafir_curriculum_ett.pdf
JUNK   := *.aux *.log *.out *.fls *.fdb_latexmk *.synctex.gz *.xdv

.PHONY: all en es ett docker clean
.DEFAULT_GOAL := all

all: en es ett
en: $(OUT_EN)
es: $(OUT_ES)
ett: $(OUT_ETT)

$(OUT_EN): resume.tex $(DEPS)
	$(TEX) $<
	mv resume.pdf $@

$(OUT_ES): curriculum.tex $(DEPS)
	$(TEX) $<
	mv curriculum.pdf $@

# moderncv, not developercv.cls -- only identity.tex and the photo are shared.
$(OUT_ETT): curriculum-ett.tex identity.tex photo.jpg
	$(TEX) $<
	mv curriculum-ett.pdf $@

## Same toolchain as CI, no local TeX needed. CI invokes this exact target, so the
## docker invocation and the output filenames live in one place rather than being
## kept in sync by hand between here and the workflow.
docker:
	docker run --rm --mount src=$(PWD),target=/usr/src/tex,type=bind $(IMAGE) \
	  /bin/sh -c "tectonic resume.tex && tectonic curriculum.tex && tectonic curriculum-ett.tex"
	mv resume.pdf $(OUT_EN)
	mv curriculum.pdf $(OUT_ES)
	mv curriculum-ett.pdf $(OUT_ETT)

clean:
	rm -f $(JUNK) $(OUT_EN) $(OUT_ES) $(OUT_ETT) resume.pdf curriculum.pdf curriculum-ett.pdf
