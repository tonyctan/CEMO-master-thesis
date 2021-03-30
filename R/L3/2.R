setwd("~/Desktop/MSc/Thesis/R/L3")

# Read Skilled data
Skilled <- read.csv("~/Desktop/MSc/Thesis/Data/L3/2.csv" ,header=T, sep="\t")
attach(Skilled)
# Let R know this is a time series data
Skilled <- ts(Skilled, start=2013, end=2018, frequency=1)



# Generate a quick visual
pdf("~/Desktop/MSc/Thesis/Figures/L3-2.pdf", width=10, height=14, paper="a4")
par(mfrow=c(2,1))
ts.plot(Skilled, type="b", col=1:20, xlab="Year", ylab="Proportion", main="Post-graduate (ISCED 7 and 8) relative to total tertiary graduation", sub="All 20 countries")
legend("topright", colnames(Skilled), col=1:20, lty=1, cex=0.65)

# GEO (#7), IDN (#8) and SRB (#17) do not have missing data problem. Remove them.
# RUS (#16) is too different. Check Russian national statistics office website.
ts.plot(Skilled[ , -c(7,8,16,17)], type="b", col=1:16, xlab="Year", ylab="Proportion", sub="Removed: GEO, IDN and SRB (2018 data available); RUS (consult other sources)")
legend("topright", colnames(Skilled[ , -c(7,8,16,17)]), col=1:16, lty=1, cex=0.65)
dev.off()


