# Housekeeping

# Import the helper R code
source("~/mplus.R")
# Set working directory
library(Orcs)
setwdOS(lin = "~/uio", win = "M:/", ext = "pc/Dokumenter/MSc/Thesis/Mplus/MMI/")


# Save Bayesian distributions

pdf("../../Figures/Bayesian_dist1.pdf",height=16.8, width=10.5)
    par(mfrow = c(3, 3))
    for (i in 1:9) {
        mplus.plot.bayesian.distribution("mmi.gh5", i)
    }
dev.off()

pdf("../../Figures/Bayesian_dist_2.pdf",height=16.8, width=10.5)
    par(mfrow = c(3, 3))
    for (i in 10:18) {
        mplus.plot.bayesian.distribution("mmi.gh5", i)
    }
dev.off()

pdf("../../Figures/Bayesian_dist_3.pdf",height=16.8, width=10.5)
    par(mfrow = c(2, 2))
    for (i in 19:22) {
        mplus.plot.bayesian.distribution("mmi.gh5", i)
    }
dev.off()

# Save Bayesian trace plots

pdf("../../Figures/Bayesian_trace_1.pdf",height=16.8, width=10.5)
    par(mfrow = c(3, 3))
    for (i in 1:9) {
        mplus.plot.bayesian.traceplot("mmi.gh5", i)
    }
dev.off()

pdf("../../Figures/Bayesian_trace_2.pdf", height = 16.8, width = 10.5)
    par(mfrow = c(3, 3))
    for (i in 10:18) {
        mplus.plot.bayesian.traceplot("mmi.gh5", i)
    }
dev.off()

pdf("../../Figures/Bayesian_trace_3.pdf",height=16.8, width=10.5)
    par(mfrow = c(2, 2))
    for (i in 19:22) {
        mplus.plot.bayesian.traceplot("mmi.gh5", i)
    }
dev.off()

# Save autocorrelation plots

pdf("../../Figures/Bayesian_AR_1.pdf",height=16.8, width=10.5)
    par(mfrow = c(3, 4))
    for (j in 1:3) {
        for (i in 1:4) {
            mplus.plot.bayesian.autocorrelation("mmi.gh5", j, i)
        }
    }
dev.off()

pdf("../../Figures/Bayesian_AR_2.pdf",height=16.8, width=10.5)
    par(mfrow = c(3, 4))
    for (j in 4:6) {
        for (i in 1:4) {
            mplus.plot.bayesian.autocorrelation("mmi.gh5", j, i)
        }
    }
dev.off()

pdf("../../Figures/Bayesian_AR_3.pdf", height = 16.8, width = 10.5)
    par(mfrow = c(3, 4))
    for (j in 7:9) {
        for (i in 1:4) {
            mplus.plot.bayesian.autocorrelation("mmi.gh5", j, i)
        }
    }
dev.off()

pdf("../../Figures/Bayesian_AR_4.pdf", height = 16.8, width = 10.5)
    par(mfrow = c(3, 4))
    for (j in 10:12) {
        for (i in 1:4) {
            mplus.plot.bayesian.autocorrelation("mmi.gh5", j, i)
        }
    }
dev.off()

pdf("../../Figures/Bayesian_AR_5.pdf", height = 16.8, width = 10.5)
    par(mfrow = c(3, 4))
    for (j in 13:15) {
        for (i in 1:4) {
            mplus.plot.bayesian.autocorrelation("mmi.gh5", j, i)
        }
    }
dev.off()

pdf("../../Figures/Bayesian_AR_6.pdf",height=16.8, width=10.5)
    par(mfrow = c(3, 4))
    for (j in 16:18) {
        for (i in 1:4) {
            mplus.plot.bayesian.autocorrelation("mmi.gh5", j, i)
        }
    }
dev.off()

pdf("../../Figures/Bayesian_AR_7.pdf",height=16.8, width=10.5)
    par(mfrow = c(4, 4))
    for (j in 19:22) {
        for (i in 1:4) {
            mplus.plot.bayesian.autocorrelation("mmi.gh5", j, i)
        }
    }
dev.off()

# Save predictive scatter plot

# For some unkown reason, MpluAutomation refuses to run this code:
# mplus.plot.bayesian.predictive.scatterplot("mmi.gh5",1)
# mplus.plot.bayesian.predictive.distribution("mmi.gh5",1)
# I am just going to save Mplus plot's data into a .dat file
# and read it back in to R and generate a plot using R
scatter <- read.table("Plot_data/4_Predicative_scatter.dat", header = F)
dist <- read.table("Plot_data/5_Predicative_dist.dat", header = F)

pdf("../../Figures/Bayesian_chi2.pdf",height=16.8, width=10.5)
    par(mfrow=c(2,1))
    plot(scatter,
        xlim = c(0, 31000), ylim = c(0, 31000),
        xlab = "Observed", ylab = "Replicated",
        main = "Bayesian Predictive Scatter Plot",
        sub = "95% confidence interval for the difference (28404, 28912), p-value 0.000"
    )
    abline(coef = c(0, 1), col = "red")

    plot(dist,
        xlim = c(0, 30000),
        xlab = "Observed - Replicated", ylab = "Count",
        main = "Bayesian Predictive Distribution",
        sub = "Mean 28656 (blue), 95% confidence interval (28403, 28912) (green)",
        col = "red", type = "h", # for histogram-like visual effect
    )
    abline(h = 0, col="black") # Add horizontal axis
    abline(v = 28656.36715, col= "blue") # Add mean
    abline(v = 28403.12500, col = "green") # Add CI lower bound
    abline(v = 28912.03125,col="green") # Add CI upper bound
dev.off()
