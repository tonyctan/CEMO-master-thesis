cd /d M:\pc\Dokumenter\MSc\Thesis
Rscript -e "library(knitr); knit('Master.Rnw')"
lualatex Master.tex
biber Master
makeindex Master
lualatex Master.tex
lualatex Master.tex
