
setwd("~/Desktop/MSc/Thesis/R/L3")

# Read Skilled data.
Pension <- read.csv("~/Desktop/MSc/Thesis/Data/L3/7.csv" ,header=T, sep="\t")
# Let R know this is a time series data
Pension <- ts(Pension, start=2008, end=2017, frequency=1)

# Generate a quick visual
pdf("~/Desktop/MSc/Thesis/Figures/L3-7.pdf", width=10, height=14, paper="a4")
par(mfrow=c(2,1))
# Add extra space to the right of plot area
par(mar=c(5.1, 4.1, 4.1, 6.1), xpd=TRUE)
# Plot the time series
ts.plot(Pension, type="b", col=1:20, xlab="Year", ylab="Percent", main="Pension fund assets / GDP")
# Add the legend
legend("topright", inset=c(-0.2, 0), colnames(Pension), col=1:20, lty=1, cex=0.65)
# Repeat, but for the ln()
ts.plot(log(Pension), type="b", col=1:20, xlab="Year", ylab="ln(percent)", main="ln(Pension fund assets / GDP)")
# Add grid line to show the curves are not completely flat
#grid(nx=NULL, ny=NULL, col="black", lty="dotted")
#abline(h=c(-4,-2,0,2,4), col="black", lty="dotted")
# Add the legend
legend("topright", inset=c(-0.2, 0), colnames(Pension), col=1:20, lty=1, cex=0.65)
dev.off()

# Run a time series forecast using Holt method

# Create a placeholder matrix
placeholder <- matrix(NA, nrow=19, ncol=1)

# Run a loop to forecast all 20 countries, using Holt method
library(forecast)
for (i in 1:19){
    m.holt.i <- holt(Pension[ , i], h=1); summary(m.holt.i)
    placeholder[i] <- m.holt.i[2]
}

# Have a look at 2018 forecast
placeholder <- data.frame(as.numeric(unlist(placeholder)))
rownames(placeholder) <- colnames(Pension); colnames(placeholder) <- "2018 forecast"
placeholder

