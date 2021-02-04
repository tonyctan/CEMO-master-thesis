# 0. Housekeeping
library(Orcs) # Set working directory depending on operating system
setwdOS(
    lin = "~/uio/", win = "M:/",
    ext = "pc/Dokumenter/MSc/Thesis/R/"
)

# Read direct-indirect effect data
effect <- read.table("../Data/dir_ind_eff.txt", header = T, sep = "\t")
# Remove Estonia due to HUGE variance
# effect <- effect[-c(5),]

# Set up a colour scale
library(viridis)
col_scale <- rev(viridis(100)) # red = high FKI, yellow = low FKI
col_pos <- round(effect$fki * 100, digits = 0)
effect <- cbind(col_pos, effect)

# Enable ellipse plot
library(mixtools)


# 1. Sort data by school total effect
effect_sch <- effect[order(effect$sch_tot_m), ]
row.names(effect_sch) <- seq(1:20) # Overwrite row order

# Generate (direct, indirect) pair (means)
mu_sch <- matrix(NA, nrow = dim(effect_sch)[1], ncol = 2)
mu_sch <- cbind(effect_sch$sch_dir_m, effect_sch$sch_ind_m)

# Generate (direct, indirect) pair (variances)
sigma_sch <- matrix(0, nrow = 2 * dim(effect_sch)[1], ncol = 2)
for (i in 1:dim(effect_sch)[1]) {
    sigma_sch[I(i * 2 - 1), 1] <- effect_sch[i, 10]
    sigma_sch[I(i * 2), 2] <- effect_sch[i, 8]
}
# Turn standard deviations to variances
sigma_sch <- sigma_sch^2


# Plot FLSCHOOL
pdf("../Figures/FLSCHOOL.pdf", width = 210, height = 297, paper = "a4")

# Set up multi-figure on the same page
par(mfrow = c(2, 1))

# Plot total effects

# Set up canvas
plot(effect_sch$sch_tot_m, row.names(effect_sch),
    xlim = c(-0.13, 0.21), col = "white",
    #    main= "FLSCHOOL: Total Effect",
    xlab = "Total Effect with 95% CI",
    ylab = "", yaxt = "n"
)
# Add zero reference line
abline(v = 0, col = "blue")

# Plot 95% CIs
for (i in 1:dim(effect_sch)[1]) {
    arrows(
        effect_sch$sch_tot_m[i] - 1.96 * effect_sch$sch_tot_sd[i],
        as.numeric(row.names(effect_sch))[i],
        effect_sch$sch_tot_m[i] + 1.96 * effect_sch$sch_tot_sd[i],
        as.numeric(row.names(effect_sch))[i],
        length = 0.05, angle = 90, code = 3,
        col = col_scale[effect_sch$col_pos[i]]
    )
}
# Plot country names
for (i in 1:dim(effect_sch)[1]) {
    text(effect_sch$sch_tot_m[i], as.numeric(row.names(effect_sch))[i],
        labels = effect_sch$cnt_name[i],
        col = col_scale[effect_sch$col_pos[i]]
    )
}

# Set up canvas
ellipse(
    mu_sch[1, ], sigma_sch[c(1:2), ],
    alpha = 0.05, npoints = 250, col = "white",
    xlim = c(-0.2, 0.15), ylim = c(-0.02, 0.15),
    xlab = "Direct Effect (Cognitive Pathway)",
    ylab = "Indirect Effect (Affective Pathways)",
    #    main = "FLSCHOOL: Decomposing Total Effect into Direct (x) and Indirect (y) effects",
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
        labels = effect_sch[i, 2],
        col = col_scale[effect_sch$col_pos[i]]
    )
}

# Draw bubbles
for (i in 1:dim(mu_sch)[1]) {
    ellipse(mu_sch[i, ], sigma_sch[c(I(2 * i - 1):I(2 * i)), ],
        alpha = 0.05, npoints = 250,
        col = col_scale[effect_sch$col_pos[i]],
        xlim = c(-0.2, 0.15), ylim = c(-0.02, 0.15),
        xaxt = "n", yaxt = "n",
        newplot = F
    )
}

dev.off()


# 2. Sort data by family total effect
effect_fam <- effect[order(effect$fam_tot_m), ]
row.names(effect_fam) <- seq(1:20) # Overwrite row order

# Generate (direct, indirect) pair (means)
mu_fam <- matrix(NA, nrow = dim(effect_fam)[1], ncol = 2)
mu_fam <- cbind(effect_fam$fam_dir_m, effect_fam$fam_ind_m)

# Generate (direct, indirect) pair (variances)
sigma_fam <- matrix(0, nrow = 2 * dim(effect_fam)[1], ncol = 2)
for (i in 1:dim(effect_fam)[1]) {
    sigma_fam[I(i * 2 - 1), 1] <- effect_fam[i, 16]
    sigma_fam[I(i * 2), 2] <- effect_fam[i, 14]
}
# Turn standard deviations to variances
sigma_fam <- sigma_fam^2

# Plot FLFAMILY
pdf("../Figures/FLFAMILY.pdf", width = 210, height = 297, paper = "a4")

# Set up multi-figure on the same page
par(mfrow = c(2, 1))

# Plot total effects

# Set up canvas
plot(effect_fam$fam_tot_m, row.names(effect_fam),
    xlim = c(-0.13, 0.21), col = "white",
    #    main= "FLFAMILY: Total Effect",
    xlab = "Total Effect with 95% CI",
    ylab = "", yaxt = "n"
)
# Add zero reference line
abline(v = 0, col = "blue")

# Plot 95% CIs
for (i in 1:dim(effect_fam)[1]) {
    arrows(
        effect_fam$fam_tot_m[i] - 1.96 * effect_fam$fam_tot_sd[i],
        as.numeric(row.names(effect_fam))[i],
        effect_fam$fam_tot_m[i] + 1.96 * effect_fam$fam_tot_sd[i],
        as.numeric(row.names(effect_fam))[i],
        length = 0.05, angle = 90, code = 3,
        col = col_scale[effect_fam$col_pos[i]]
    )
}
# Plot country names
for (i in 1:dim(effect_fam)[1]) {
    text(effect_fam$fam_tot_m[i], as.numeric(row.names(effect_fam))[i],
        labels = effect_fam$cnt_name[i],
        col = col_scale[effect_fam$col_pos[i]]
    )
}

# Set up canvas
ellipse(
    mu_fam[1, ], sigma_fam[c(1:2), ],
    alpha = 0.05, npoints = 250, col = "white",
    xlim = c(-0.2, 0.15), ylim = c(-0.02, 0.15),
    xlab = "Direct Effect (Cognitive Pathway)",
    ylab = "Indirect Effect (Affective Pathways)",
    #    main = "FLFAMILY: Decomposing Total Effect into Direct (x) and Indirect (y) Effects",
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
        labels = effect_fam[i, 2],
        col = col_scale[effect_fam$col_pos[i]]
    )
}

# Draw bubbles
for (i in 1:dim(mu_fam)[1]) {
    ellipse(mu_fam[i, ], sigma_fam[c(I(2 * i - 1):I(2 * i)), ],
        alpha = 0.05, npoints = 250,
        col = col_scale[effect_fam$col_pos[i]],
        xlim = c(-0.2, 0.15), ylim = c(-0.02, 0.15),
        xaxt = "n", yaxt = "n",
        newplot = F
    )
}

dev.off()





# Sort countries by FKI
position <- data.frame(
    effect$col_pos, effect$cnt_name, effect$fki,
    order(effect$sch_tot_m), order(effect$fam_tot_m)
)
position <- position[order(position[, 3]), ]
row.names(position) <- seq(1:20)

pdf("../Figures/country_decomposition.pdf", width = 210, height = 297, paper = "a4")

par(
    mfrow = c(5, 4),
    oma = c(5, 4, 0, 0) + 0.1,
    mar = c(2, 1, 1, 1) + 0.1
)

for (j in 1:20) {

    # Set up canvas
    ellipse(
        mu_sch[1, ], sigma_sch[c(1:2), ],
        alpha = 0.05, npoints = 250, col = "white",
        xlim = c(-0.2, 0.15), ylim = c(-0.02, 0.15),
        xlab = "",
        ylab = "",
        main = paste0(position[j, 2], " (FKI=", position[j, 3], ")"),
        newplot = T
    )
    abline(h = 0, col = "red", lty=2)
    abline(v = 0, col = "red", lty=2)

    i <- position[j, 4]

    # Draw school bubbles
    ellipse(
        mu_sch[i, ], sigma_sch[c(I(2 * i - 1):I(2 * i)), ],
        alpha = 0.05, npoints = 250,
        col = col_scale[position$effect.col_pos[j]],
        xlim = c(-0.2, 0.15), ylim = c(-0.02, 0.15),
        xaxt = "n", yaxt = "n",
        newplot = F
    )

    text(mu_sch[i, 1], mu_sch[i, 2],
        labels = "FLSCHOOL",
        col = col_scale[position$effect.col_pos[j]]
    )

    i <- position[j, 5]

    # Draw family bubble
    ellipse(mu_fam[i, ], sigma_fam[c(I(2 * i - 1):I(2 * i)), ],
        alpha = 0.05, npoints = 250,
        col = col_scale[position$effect.col_pos[j]],
        xlim = c(-0.2, 0.15), ylim = c(-0.02, 0.15),
        xaxt = "n", yaxt = "n",
        newplot = F
    )

    text(mu_fam[i, 1], mu_fam[i, 2],
        labels = "FLFAMILY",
        col = col_scale[position$effect.col_pos[j]]
    )
}

dev.off()
