LATEX=pdflatex
LATEXOPT=--shell-escape
#NONSTOP=--interaction=nonstopmode
NONSTOP=

LATEXMK=latexmk
LATEXMKOPT=-pdf
#CONTINUOUS=-pvc
CONTINUOUS=

MAIN=editorial-ccr-review-process-update
SOURCES=$(MAIN).tex Makefile 

all:    $(MAIN).pdf

live:
		$(LATEXMK) -f -pdf -pvc -interaction=nonstopmode $(MAIN).tex

.refresh:
	touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES)
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
		-pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)

force:
	touch .refresh
	rm $(MAIN).pdf
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
	-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

clean:
	cp $(MAIN).pdf $(MAIN).bak
	$(LATEXMK) -C $(MAIN)
	rm -f $(MAIN).pdfsync
	rm -rf *~ *.tmp
	rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk
	mv $(MAIN).bak $(MAIN).pdf

once:
	$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

debug:
	$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY: clean force once all
