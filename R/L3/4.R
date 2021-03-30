setwd("~/Desktop/MSc/Thesis/R/L3")

# Read Skilled data. Use 4clean.csv (2011--2017) rather than 4.csv (1999--2017)
# because 2008/2009 financial crisis messed up the pattern for these two years.
Assets <- read.csv("~/Desktop/MSc/Thesis/Data/L3/4clean.csv" ,header=T, sep="\t")
attach(Assets)
# Let R know this is a time series data
Assets <- ts(Assets, start=2011, end=2017, frequency=1)

# Generate a quick visual
pdf("~/Desktop/MSc/Thesis/Figures/L3-4.pdf", width=10, height=14, paper="a4")
par(mfrow=c(2,1))
# Add extra space to the right of plot area
par(mar=c(5.1, 4.1, 4.1, 6.1), xpd=TRUE)
# Plot the time series
ts.plot(Assets, type="b", col=1:20, xlab="Year", ylab="Percent", main="Gross portfolio equity assets / GDP")
# Add the legend
legend("topright", inset=c(-0.2, 0), colnames(Assets), col=1:20, lty=1, cex=0.65)
# Repeat, but for the ln()
ts.plot(log(Assets), type="b", col=1:20, xlab="Year", ylab="ln(percent)", main="ln(Gross portfolio equity assets / GDP)")
# Add grid line to show the curves are not completely flat
#grid(nx=NULL, ny=NULL, col="black", lty="dotted")
#abline(h=c(-4,-2,0,2,4), col="black", lty="dotted")
# Add the legend
legend("topright", inset=c(-0.2, 0), colnames(Assets), col=1:20, lty=1, cex=0.65)
dev.off()

# Run a time series forecast using Holt method

# Create a placeholder matrix
placeholder <- matrix(NA, nrow=20, ncol=1)

# Run a loop to forecast all 20 countries, using Holt method
library(forecast)
for (i in 1:20){
    m.holt.i <- holt(Assets[ , i], h=1); summary(m.holt.i)
    placeholder[i] <- m.holt.i[2]
}
# Run a separate one for PER (#13) because it misses both 2017 and 2018 data
m.holt.PER <- holt(Assets[ , 13], h=2); summary(m.holt.PER)


# Have a look at 2018 forecast
data.frame(colnames(Assets), unlist(placeholder))

