library(Orcs) # Set working directory depending on operating system
setwdOS(
    lin = "~/uio/", win = "M:/",
    ext = "pc/Dokumenter/MSc/Thesis/R/"
)

# Read direct-indirect effect data
effect <- read.table("../Data/dir_ind_eff.txt", header = T, sep = "\t")
# Remove Estonia due to HUGE variance
#effect <- effect[-c(5),]

# Generate (direct, indirect) pair (means)
mu_sch <- matrix(NA, nrow = dim(effect)[1], ncol=2)
mu_sch <- cbind(effect[, 8], effect[, 6])

# Generate (direct, indirect) pair (variances)
sigma_sch <- matrix(0, nrow = 2 * dim(effect)[1], ncol = 2)
for (i in 1:dim(effect)[1]) {
    sigma_sch[I(i * 2 - 1), 1] <- effect[i, 9]
    sigma_sch[I(i * 2), 2] <- effect[i, 7]
}
# Turn standard deviations to variances
sigma_sch <- sigma_sch^2

# Set up a colour scale
library(viridis)
col_scale <- rev(viridis(100)) # red = high FKI, yellow = low FKI
col_pos <- round(effect$fki*100, digits=0)
# Enable ellipse plot
library(mixtools)

# Save FLSCHOOL
pdf("../Figures/FLSCHOOL.pdf", width=210, height=297, paper="a4")

# Set up multi-figure on the same page
par(mfrow = c(2, 1))

# Plot total effects
# Set up canvas
plot(effect$fki ~ effect$sch_tot_m,
    xlim = c(-0.15, 0.25), ylim = c(0, 1),
    xlab = "Total effect", ylab = "Financial Knowledge Index",
    main = "FLSCHOOL: Total Effect",
    col = "white"
)
abline(v = 0, col = "blue")
# Plot error bars
for (i in 1:dim(effect)[1]) {
    arrows(
        effect$sch_tot_m[i] - 1.96 * effect$sch_tot_sd[i],
        effect$fki[i],
        effect$sch_tot_m[i] + 1.96 * effect$sch_tot_sd[i],
        effect$fki[i],
        length = 0.05, angle = 90, code = 3, col = col_scale[col_pos[i]]
    )
}
# Plot country names
for (i in 1:dim(effect)[1]) {
    text(effect$fki[i] ~ effect$sch_tot_m[i],
        labels = effect$cnt_name[i],
        col = col_scale[col_pos[i]]
        )
}

# Set up canvas
ellipse(
    mu_sch[1, ], sigma_sch[c(1:2), ],
    alpha = 0.05, npoints = 250, col="white",
    xlim = c(-0.4, 0.1), ylim = c(-0.02, 0.15),
    xlab = "Direct Effect (Cognitive Pathway)",
    ylab = "Indirect Effect (Affective Pathways)",
    main = "FLSCHOOL: Direct-Indirect Effects Decomposition",
    newplot = T
)
# Draw zero scale lines
abline(h = 0, col = "red")
abline(v = 0, col = "red")
# Draw the negative 45 degree line
abline(coef = c(0, -1), col = "blue")

# Insert country names
for (i in 1:dim(mu_sch)[1]) {
    text(mu_sch[i, 2] ~ mu_sch[i, 1],
        labels = effect[i, 1],
        col = col_scale[col_pos[i]]
    )
}

# Draw the rest
for (i in 1:dim(mu_sch)[1]) {
    ellipse(mu_sch[i,], sigma_sch[c(I(2*i-1):I(2*i)),],
        alpha = 0.05, npoints = 250, col=col_scale[col_pos[i]],
        xlim = c(-0.4, 0.1), ylim = c(-0.02, 0.15),
        xaxt = "n", yaxt = "n",
        newplot = F
    )
}
dev.off()












# Generate (direct, indirect) pair (means)
mu_fam <- matrix(NA, nrow = dim(effect)[1], ncol=2)
mu_fam <- cbind(effect[, 14], effect[, 12])

# Generate (direct, indirect) pair (variances)
sigma_fam <- matrix(0, nrow = 2 * dim(effect)[1], ncol = 2)
for (i in 1:dim(effect)[1]) {
    sigma_fam[I(i * 2 - 1), 1] <- effect[i, 15]
    sigma_fam[I(i * 2), 2] <- effect[i, 13]
}
# Turn standard deviations to variances
sigma_fam <- sigma_fam^2

# Save FLFAMILY
pdf("../Figures/FLFAMILY.pdf", width=210, height=297, paper="a4")

# Set up multi-figure on the same page
par(mfrow = c(2, 1))

# Plot total effects
# Set up canvas
plot(effect$fki ~ effect$fam_tot_m,
    xlim = c(-0.15, 0.25), ylim = c(0, 1),
    xlab = "Total effect", ylab = "Financial Knowledge Index",
    main = "FLFAMILY: Total Effect",
    col = "white"
)
abline(v = 0, col = "blue")
# Plot error bars
for (i in 1:dim(effect)[1]) {
    arrows(
        effect$fam_tot_m[i] - 1.96 * effect$fam_tot_sd[i],
        effect$fki[i],
        effect$fam_tot_m[i] + 1.96 * effect$fam_tot_sd[i],
        effect$fki[i],
        length = 0.05, angle = 90, code = 3, col = col_scale[col_pos[i]]
    )
}
# Plot country names
for (i in 1:dim(effect)[1]) {
    text(effect$fki[i] ~ effect$fam_tot_m[i],
        labels = effect$cnt_name[i],
        col = col_scale[col_pos[i]]
        )
}

# Set up canvas
ellipse(
    mu_fam[1, ], sigma_fam[c(1:2), ],
    alpha = 0.05, npoints = 250, col="white",
    xlim = c(-0.4, 0.1), ylim = c(-0.02, 0.15),
    xlab = "Direct Effect (Cognitive Pathway)",
    ylab = "Indirect Effect (Affective Pathways)",
    main = "FLFAMILY: Direct-Indirect Effects Decomposition",
    newplot = T
)
# Draw zero scale lines
abline(h = 0, col = "red")
abline(v = 0, col = "red")
# Draw the negative 45 degree line
abline(coef = c(0, -1), col = "blue")

# Insert country names
for (i in 1:dim(mu_fam)[1]) {
    text(mu_fam[i, 2] ~ mu_fam[i, 1],
        labels = effect[i, 1],
        col = col_scale[col_pos[i]]
    )
}

# Draw the rest
for (i in 1:dim(mu_fam)[1]) {
    ellipse(mu_fam[i,], sigma_fam[c(I(2*i-1):I(2*i)),],
        alpha = 0.05, npoints = 250, col=col_scale[col_pos[i]],
        xlim = c(-0.4, 0.1), ylim = c(-0.02, 0.15),
        xaxt = "n", yaxt = "n",
        newplot = F
    )
}

dev.off()
