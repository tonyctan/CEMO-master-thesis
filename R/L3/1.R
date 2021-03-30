setwd("~/Desktop/MSc/Thesis/R/L3")

# Read GDP_per_capita data
GDP <- read.csv("~/Desktop/MSc/Thesis/Data/L3/1.csv" ,header=T, sep="\t")
attach(GDP)
str(GDP)

# Generate a quick visual
plot(log(GDP_per_capita), xaxt="n", xlab="Country code", ylab="Natural logarithm of GDP_per_capita")
axis(1, at=1:20, labels=CNT, las=2)

