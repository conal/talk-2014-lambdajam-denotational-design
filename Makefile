TARG = bayhac-2014

.PRECIOUS: %.tex %.pdf %.web

all: $(TARG).pdf

see: $(TARG).see

%.pdf: %.tex Makefile
	pdflatex $*.tex

# --poly is default for lhs2TeX

%.tex: %.lhs macros.tex mine.fmt Makefile
	lhs2TeX -o $*.tex $*.lhs

showpdf = open -a Skim.app

%.see: %.pdf
	${showpdf} $*.pdf

clean:
	rm $(TARG).{tex,pdf,aux,nav,snm,ptb}

# web: $(TARG).web

# %.web: %.pdf
# 	scp $< conal@conal.net:/home/conal/web/talks
# 	touch $@

web: web-token

STASH=conal@conal.net:/home/conal/web/talks
# STASH=conal@conal-lin:/home/conal/talks
web: web-token

web-token: $(TARG).pdf
	scp $? $(STASH)/
	touch $@

#  $(TARG).lhs HScan.lhs
