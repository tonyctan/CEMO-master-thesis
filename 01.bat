cd /d M:\pc\Dokumenter\Thesis
Rscript -e "library(knitr); knit('Master.Rnw')"
pdflatex Master.tex
biber Master
makeindex Master
pdflatex Master.tex
pdflatex Master.tex
Master.pdf
