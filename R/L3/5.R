setwd("~/Desktop/MSc/Thesis/R/L3")

# Read Skilled data.
Insurance <- read.csv("~/Desktop/MSc/Thesis/Data/L3/5.csv" ,header=T, sep="\t")
attach(Insurance)
# Let R know this is a time series data
Insurance <- ts(Insurance, start=2011, end=2017, frequency=1)

# Generate a quick visual
pdf("~/Desktop/MSc/Thesis/Figures/L3-5.pdf", width=10, height=14, paper="a4")
par(mfrow=c(2,1))
# Add extra space to the right of plot area
par(mar=c(5.1, 4.1, 4.1, 6.1), xpd=TRUE)
# Plot the time series
ts.plot(Insurance, type="b", col=1:20, xlab="Year", ylab="Percent", main="Insurance company assets / GDP")
# Add the legend
legend("topright", inset=c(-0.2, 0), colnames(Insurance), col=1:20, lty=1, cex=0.65)
# Repeat, but for the ln()
ts.plot(log(Insurance), type="b", col=1:20, xlab="Year", ylab="ln(percent)", main="ln(Insurance company assets / GDP)")
# Add grid line to show the curves are not completely flat
#grid(nx=NULL, ny=NULL, col="black", lty="dotted")
#abline(h=c(-4,-2,0,2,4), col="black", lty="dotted")
# Add the legend
legend("topright", inset=c(-0.2, 0), colnames(Insurance), col=1:20, lty=1, cex=0.65)
dev.off()

# Run a time series forecast using Holt method

# Create a placeholder matrix
placeholder <- matrix(NA, nrow=20, ncol=1)

# Run a loop to forecast all 20 countries, using Holt method
library(forecast)
for (i in 1:20){
    m.holt.i <- holt(Insurance[ , i], h=1); summary(m.holt.i)
    placeholder[i] <- m.holt.i[2]
}
# Run a separate one for CAN (#3), IND (#8), ITA (#9), POL(#14) and USA (#20) because they miss both 2017 and 2018 data
m.holt.CAN <- holt(Insurance[ , 3], h=2); summary(m.holt.CAN)
m.holt.IND <- holt(Insurance[ , 8], h=2); summary(m.holt.IND)
m.holt.ITA <- holt(Insurance[ , 9], h=2); summary(m.holt.ITA)
m.holt.POL <- holt(Insurance[ , 14], h=2); summary(m.holt.POL)
m.holt.USA <- holt(Insurance[ , 20], h=2); summary(m.holt.USA)


# Have a look at 2018 forecast
data.frame(colnames(Insurance), unlist(placeholder))

