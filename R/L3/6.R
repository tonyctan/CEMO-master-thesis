setwd("~/Desktop/MSc/Thesis/R/L3")

# Read Skilled data.
internet <- read.csv("~/Desktop/MSc/Thesis/Data/L3/6.csv",
header = T, sep = "\t")
# Let R know this is a time series data
internet <- ts(internet, start = 2009, end = 2017, frequency = 1)

# Generate a quick visual
pdf("~/Desktop/MSc/Thesis/Figures/L3-6.pdf",
width = 10, height = 14, paper = "a4")
par(mfrow = c(2, 1))
# Add extra space to the right of plot area
par(mar = c(5.1, 4.1, 4.1, 6.1), xpd = TRUE)
# Plot the time series
ts.plot(internet, type = "b", col = 1:20, xlab = "Year", ylab = "Percent",
main = "Individuals using the Internet (% of population)")
# Add the legend
legend("topright", inset = c(-0.2, 0), colnames(internet),
col = 1:20, lty = 1, cex = 0.65)
# Repeat, but for the ln()
ts.plot(log(internet), type = "b", col = 1:20,
xlab = "Year", ylab = "ln(percent)",
main = "ln(Individuals using the Internet (% of population))")
# Add the legend
legend("topright", inset = c(-0.2, 0), colnames(internet),
col = 1:20, lty = 1, cex = 0.65)
dev.off()

# Run a time series forecast using Holt method

# Create a placeholder matrix
placeholder <- matrix(NA, nrow = 20, ncol = 1)

# Run a loop to forecast all 20 countries, using Holt method
library(forecast)
for (.i in 1:20) {
    m_holt_i <- holt(internet[, .i], h = 1); summary(m_holt_i)
    placeholder[i] <- m_holt_i[2]
}

# Have a look at 2018 forecast
placeholder <- as.numeric(unlist(placeholder))

internet2018 <- c(70.4342825, 64.7820107, NA, NA, 89.3570078,
88.88996, 62.7179082, 39.9046386, 74.3871829, 83.5771749,
79.7225828, 94.7120737, 52.5403102, 77.5417345, 74.6609681,
80.8647214, 73.3607092, 80.6603356, 86.1072355, NA)

# Calculate disagreement/inaccuracy of the forecast
inaccuracy <- (placeholder - internet2018) / internet2018 * 100
forecast <- data.frame(placeholder, internet2018, inaccuracy)
rownames(forecast) <- colnames(internet)
colnames(forecast) <- c("forecasted", "actual", "inaccuracy")
forecast

# Restore plot margins
par(mar = c(5.1, 4.1, 4.1, 2.1))
# Actually, close the R plot window to clear the margin settings earlier
# otherwise the regression line with run outside of the box.

pdf("~/Desktop/MSc/Thesis/Figures/L3-6F.pdf",
width = 10, height = 14, paper = "a4")
par(mfrow = c(2, 1))
barplot(forecast[, 2], names.arg = rownames(forecast), xlab = "Country",
las = 2, ylab = "Percentage", ylim = c(-15, 10),
main = "Forecast error for 2018 Internet usage")
# Some countries have sizable over-prediction and others have under-prediction.
# Could the level of over/under-prediction related to the actual levels?
# Run a linear regression:
m_forecast <- lm(forecast[, 2]~forecast[, 1]); summary(m_forecast)
# The relationship fails to reach 0.05 statistical significance
# but the trend is definitely there.

plot(forecast[, 1], forecast[, 2],
xlab = "Actual Internet usage 2018 (% of population)",
ylab = "Forecast error (%)",
main = "Relationship between forecast error and level of Internet usage 2018",
col = "white")
abline(m_forecast, col = "red", lwd = 1)
text(forecast[, 2]~forecast[, 1], labels = rownames(forecast),
cex = 0.9, font = 1)
dev.off()
