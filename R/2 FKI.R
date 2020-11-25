# Section 0: Housekeeping
library(Orcs) # Set working directory depending on operating system
setwdOS(
    lin = "~/uio/", win = "M:/",
    ext = "pc/Dokumenter/MSc/Thesis/Data/L3/"
)

# Set up a "bookshelf" to hold variables nessary to compute FKI
fki_raw <- matrix(NA,
    nrow = 13, ncol = 10, dimnames = list(
        c( # row names
            "BRA", "CHL", "EST", "GEO", "IDN",
            "ITA", "LTU", "PER", "POL", "PRT",
            "SVK", "ESP", "USA"
        ),
        c( # column names
            "gdp_per_capita", # economic capability (sub_ind_ec)
            "highly_skilled", "mean_year_of_schooling", # (sub_ind_et)
            "gpea", "ica", "ius", # use (sub_ind_use)
            "pfa", "ac", "gdp", "ageing" # need (sub_ind_need)
        )
    ) # End list()
) # End matrix()


# Section 1: Economic capacity

gdp_per_capita <- read.csv("gdp_per_capita.csv", header = T, sep = "\t")
# Only keep "the 13 countries"
gdp_per_capita <- gdp_per_capita[-c(2, 3, 6, 10, 12, 16, 17), ]

fki_raw[, 1] <- log(gdp_per_capita[, 2])

rm(gdp_per_capita)


# Section 2: Educational training

# Subsection 2.1: Highly skilled

# Masters
isced_7 <- read.csv("isced_7.csv", header = T, sep = "\t")
isced_7 <- isced_7[, -c(2, 3, 6, 10, 12, 16, 17)]

# PhDs
isced_8 <- read.csv("isced_8.csv", header = T, sep = "\t")
isced_8 <- isced_8[, -c(2, 3, 6, 10, 12, 16, 17), ]

# Total tertiary
total_tertiary <- read.csv("total_tertiary.csv", header = T, sep = "\t")
total_tertiary <- total_tertiary[, -c(2, 3, 6, 10, 12, 16, 17)]

# Compute highly skilled (master + PhD) to total tertiary ratio
highly_skilled <- ts(
    (isced_7 + isced_8) / total_tertiary,
    start = 2013, end = 2018, frequency = 1
)

# pdf("../../Figures/skilled.pdf")
# # Visualise these ratios. Turn off GEO, IDN, SRB and RUS
# ts.plot(100 * highly_skilled[, -c(7, 8, 16, 17)],
#     type = "b", col = 1:16,
#     xlab = "Year", ylab = "Percent"
# )
# legend("topright", colnames(highly_skilled[, -c(7, 8, 16, 17)]),
#     col = 1:16, lty = 1, cex = 0.65
# )
# dev.off()

# Decision: naive forcasts, i.e., copy-paste nearest available year
library(forecast)
# Create a placeholder matrix
placeholder <- matrix(NA, nrow = 13, ncol = 1)

# Run a loop to foreecast all 13 countries, using naive method
for (.i in 1:13) {
    m_naive_i <- naive(highly_skilled[, .i], h = 1)
    placeholder[.i] <- data.frame(unlist(m_naive_i[5])[6])[1, 1]
}
# [5] = fitted values; [6] = 2018; [1,1] = only the numeric value

# GEO and IDN have 2018 data, plug actual numbers back
placeholder[c(4, 5)] <- highly_skilled[6, c(4, 5)]

# Save results to "bookshelf"
fki_raw[, 2] <- placeholder * 100

rm(
    isced_7, isced_8, total_tertiary,
    highly_skilled, placeholder, m_naive_i
)

# Sub-section 2.2: Mean year of schooling
mean_year_of_schooling <- read.csv("mean_year_of_schooling.csv",
    header = F, sep = "\t"
)
fki_raw[, 3] <- mean_year_of_schooling[-c(2, 3, 6, 10, 12, 16, 17), 2]

rm(mean_year_of_schooling)


# Section 3: Use

gpea <- read.csv("gpea.csv", header = T, sep = "\t")
gpea <- gpea[, -c(2, 3, 6, 10, 12, 16, 17)]
gpea <- ts(gpea, start = 2011, end = 2017, frequency = 1)

# # Visualise data in both original and ln forms. Contain trend?
# pdf("../../Figures/use.pdf", width = 12.94, height = 9.15)

# # Re-set canvas layout to 2x2
# par(mfcol = c(2, 2))

# # Add extra space to the right of plot area
# par(mar = c(5.1, 4.1, 4.1, 2.1), xpd = TRUE)

# # Plot GPEA in original form
# ts.plot(gpea,
#     type = "b", col = 1:20,
#     xlab = "Year", ylab = "Percent", main = "GPEA to GDP ratio"
# )
# # Add the legend
# #legend("topright",
# #    inset = c(-0.2, 0), colnames(gpea),
# #    col = 1:20, lty = 1, cex = 0.65
# #)

# # Remove extra gap between the two graphs
# par(mar = c(5.1, 4.1, 0, 2.1), xpd = TRUE)

# # Repeat GPEA, but for the ln() version
# ts.plot(log(gpea),
#     type = "b", col = 1:20,
#     xlab = "Year", ylab = "ln( percent )"
# )
# # Add the legend
# #legend("topright",
# #    inset = c(-0.2, 0), colnames(gpea),
# #    col = 1:20, lty = 1, cex = 0.65
# #)

# # Plot ICA in original form
# par(mar = c(5.1, 4.1, 4.1, 6.1), xpd = TRUE)
# ts.plot(ica,
#     type = "b", col = 1:20,
#     xlab = "Year", ylab = "Percent", main = "ICA to GDP ratio"
# )
# # Add the legend
# legend("topright",
#     inset = c(-0.2, 0), colnames(ica),
#     col = 1:20, lty = 1, cex = 0.875
# )

# # Remove extra gap between the two graphs
# par(mar = c(5.1, 4.1, 0, 6.1), xpd = TRUE)

# # Repeat, but for the ln()
# ts.plot(log(ica),
#     type = "b", col = 1:20,
#     xlab = "Year", ylab = "ln( percent )"
# )
# # Add the legend
# legend("topright",
#     inset = c(-0.2, 0), colnames(ica),
#     col = 1:20, lty = 1, cex = 1.07
# )
# dev.off()

# Decision: since the ln() version is not flat, original time series
# contain trend. Use Holt method rather than simple expential smoothing.

# Run a time series forecast using Holt method

# Create a placeholder matrix
placeholder <- matrix(NA, nrow = 13, ncol = 1)

# Run a loop to forecast all 13 countries, using Holt method
for (.i in 1:13) {
    m_holt_i <- holt(gpea[, .i], h = 1)
    placeholder[.i] <- m_holt_i[2]
}

# Only keep the 2018 forecasts
placeholder <- unlist(placeholder)

# Run PER (#8) separately because it misses both 2017 and 2018 data
m_holt_PER <- holt(gpea[, 8], h = 2); summary(m_holt_PER)
placeholder[8] <- 16.02698

# Push placeholder to fki_raw
fki_raw[, 4] <- placeholder

rm(gpea, placeholder, m_holt_i, m_holt_PER)

# Sub-section 3.2: Insurance company assets (ica)

ica <- read.csv("ica.csv", header = T, sep = "\t")
ica <- ica[, -c(2, 3, 6, 10, 12, 16, 17)]
ica <- ts(ica, start = 2011, end = 2017, frequency = 1)

placeholder <- matrix(NA, nrow = 13, ncol = 1)

for (.i in 1:13) {
    m_holt_i <- holt(ica[, .i], h = 1)
    placeholder[.i] <- m_holt_i[2]
}

placeholder <- unlist(placeholder)

m_holt_IND <- holt(ica[, 5], h = 2); summary(m_holt_IND)
m_holt_ITA <- holt(ica[, 6], h = 2); summary(m_holt_ITA)
m_holt_POL <- holt(ica[, 9], h = 2); summary(m_holt_POL)
m_holt_USA <- holt(ica[, 13], h = 2); summary(m_holt_USA)

placeholder[c(5, 6, 9, 13)] <- c(
    4.611597, 51.2596, 9.534750, 30.18295
)

fki_raw[, 5] <- placeholder

rm(ica, placeholder, list = ls(pattern = "^m.holt"))

# Sub-section 3.3: Individuals using the Internet (ius)

ius <- read.csv("ius.csv", header = T, sep = "\t")
ius <- ius[, -c(2, 3, 6, 10, 12, 16, 17)]
ius <- ts(ius, start = 2009, end = 2018, frequency = 1)

m_holt_CHL <- holt(ius[1:9, 2], h = 1); summary(m_holt_CHL)
m_holt_USA <- holt(ius[1:9, 13], h = 1); summary(m_holt_USA)

ius_2018 <- ius[10, ] # Only want 2018 data
ius_2018[2] <- 89.5309 # CHL
ius_2018[13] <- 84.88108 # USA

fki_raw[, 6] <- ius_2018

rm(list = ls(pattern = "^ius"))
rm(list = ls(pattern = "^m_holt_"))


# Section 4: Need

# Subsection 4.1: Pension fund assets (pfa)
pfa <- read.csv("pfa.csv", header = T, sep = "\t")
pfa <- pfa[, -c(2, 3, 6, 10, 12, 16, 17)]
# Delete GEO (#4) due to all missing. Will come back to it later.
pfa <- ts(pfa[, -4], start = 2008, end = 2017, frequency = 1)

placeholder <- matrix(NA, nrow = 12, ncol = 1)

for (.i in 1:12) {
    m_holt_i <- holt(pfa[, .i], h = 1)
    placeholder[.i] <- m_holt_i[2]
}

placeholder <- unlist(placeholder)

# Calculate GEO
# From Georgia Pension Agency:
#   2019 mesub_ind_eting minute: 372,113,933 GEL
# From GeoStat website:
#   2018 gdp = 44.6 billion GEL

fki_raw[, 7] <- c(
    placeholder[1:3],
    372113934 / 44600000000 * 100, # Insert GEO figure
    placeholder[4:12]
)

rm(pfa, placeholder, m_holt_i)

# Subsection 4.2: Aggregate consumption (ac)

ac <- read.csv("ac.csv", header = F, row.names = 1, sep = "\t")
ac <- ac[-c(2, 3, 6, 10, 12, 16, 17), ]
gdp <- read.csv("gdp.csv", header = F, row.names = 1, sep = "\t")
gdp <- gdp[-c(2, 3, 6, 10, 12, 16, 17), ]

fki_raw[, 8] <- unlist(ac * 0.02 / gdp * 100)

fki_raw[, 9] <- unlist(gdp)

rm(ac, gdp)

# Subsection 4.3: Ageing

ageing <- read.csv("ageing.csv", header = T, sep = "\t")
ageing <- ageing[-c(
    2, 3, 6, 10, 12, 16, 17,
    22, 23, 26, 30, 32, 36, 37
), ]
attach(ageing)
names(ageing)

# Calculate total population
poptotal_f <- pop0to14_f + pop15to64_f + pop65plus_f
poptotal_m <- pop0to14_m + pop15to64_m + pop65plus_m
# Calculate population between 15 and 19
# Need to divide by 100 to get decimals
pop15to19_f <- poptotal_f * per15to19_f / 100
pop15to19_m <- poptotal_m * per15to19_m / 100
# Calculate population between 0 and 19
pop0to19_f <- pop0to14_f + pop15to19_f
pop0to19_m <- pop0to14_m + pop15to19_m
# Calculate population between 20 and 64
pop20to64_f <- poptotal_f - pop0to19_f - pop65plus_f
pop20to64_m <- poptotal_m - pop0to19_m - pop65plus_m
# Calculate 64+ / 20-to-64 ratio
ageing_ratio <- I(
    (pop65plus_f + pop65plus_m) / (pop20to64_f + pop20to64_m)
)
# Split data into 2018 [ , 1] and 2009 [ , 2] portions
ageing <- cbind(ageing_ratio[1:13], ageing_ratio[14:26])
fki_raw[, 10] <- (ageing[, 1] - ageing[, 2]) / ageing[, 2]

rm(ageing, ageing_ratio, list = ls(pattern = "^pop"))


# Section 5: FKI

fki_raw <- fki_raw[, -9] # Throw away gdp (already in ac)
round(fki_raw, digits = 3) # Inspect data

# Save data to an external file
library(data.table); setDTthreads(0)
fwrite(round(fki_raw, digits = 3), file = "fki_raw.csv")

# Subection 5.0: Standardise each variable to [0.01,0.99] range
fki_stand <- matrix(NA, nrow = dim(fki_raw)[1], ncol = dim(fki_raw)[2])
dimnames(fki_stand) <- dimnames(fki_raw)

library(scales) # I wish this function could have "by.col = T". Oh well.
for (.j in 1:dim(fki_raw)[2]) {
    fki_stand[, .j] <- rescale(fki_raw[, .j], to = c(0.01, 0.99))
}

rm(fki_raw)

fki_stand <- data.frame(fki_stand)
attach(fki_stand)

# Subsection 5.1: Economic capacity (sub_ind_ec)

sub_ind_ec <- gdp_per_capita

# Subsection 5.2: Education and training (sub_ind_et)

wt_highly_skilled <- 1 / sd(highly_skilled)
wt_mean_year_of_schooling <- 1 / sd(mean_year_of_schooling)

sub_ind_et <- (highly_skilled^wt_highly_skilled *
    mean_year_of_schooling^wt_mean_year_of_schooling)^
    (1 / (wt_highly_skilled + wt_mean_year_of_schooling))

rm(list = ls(pattern = "^wt"))

# Subsection 5.3: Use (sub_ind_use)

sub_ind_u <- (gpea + ica)^ius

# Subsection 5.4: Need (sub_ind_need)

sub_ind_n <- (pfa + ac)^ageing

## Subsection 5.5: FKI

wt_ec <- 1 / sd(sub_ind_ec)
wt_et <- 1 / sd(sub_ind_et)
wt_u <- 1 / sd(sub_ind_u)
wt_n <- 1 / sd(sub_ind_n)

fki <- (
    sub_ind_ec^wt_ec *
        sub_ind_et^wt_et *
        sub_ind_u^wt_u *
        sub_ind_n^wt_n
) ^ (
    1 / (wt_ec + wt_et + wt_u + wt_n)
)

rm(list = ls(pattern = "^wt"))

l3 <- data.frame(
    round(
        cbind(fki, sub_ind_ec, sub_ind_et, sub_ind_u, sub_ind_n),
        digits = 3
    )
)
rownames(l3) <- rownames(fki_stand)
attach(l3)

rm(fki_stand, fki, sub_ind_ec, sub_ind_et, sub_ind_u, sub_ind_n)

# Display country-level FKI, default by country code
l3

# Sort FKI by country (highest to lowest)
l3_ordered <- l3[order(-fki), ]
l3_ordered
fwrite(l3_ordered, file = "fki.csv")

barplot(l3_ordered$fki,
    names.arg = rownames(l3_ordered),
    xlab = "Country", las = 2, ylab = "Financial Knowledge Index (FKI)",
    ylim = c(0, 1), main = "FKI of the 20 participating countries"
)
