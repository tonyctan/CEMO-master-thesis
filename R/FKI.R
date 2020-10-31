######
# Section 0: Housekeeping
library(Orcs) # Set working directory depending on operating system
setwdOS(lin = "~/uio/", win = "M:/", ext = "pc/Dokumenter/MSc/Thesis/Data/L3/")

# Set up a "bookshelf" to hold variables nessary to compute FKI
fki_raw <- matrix(NA,
    nrow = 20, ncol = 10, dimnames = list(
        c(
            "BRA", "BGR", "CAN", "CHL", "EST",
            "FIN", "GEO", "IDN", "ITA", "LVA",
            "LTU", "NLD", "PER", "POL", "PRT",
            "RUS", "SRB", "SVK", "ESP", "USA"
        ), # row names
        c(
            "gdp_per_capita", # economic capability (sub_ind_ec)
            "highly_skilled", "mean_year_of_schooling", # (sub_ind_et)
            "gpea", "ica", "ius", # use (sub_ind_u)
            "pfa", "ac", "gdp", "ageing" # need (sub_ind_n)
        ) # column names
    ) # End list()
) # End matrix()

######
# Section 1: Economic capacity

gdp_per_capita <- read.csv("gdp_per_capita.csv", header = T, sep = "\t")

fki_raw[, 1] <- log(gdp_per_capita[, 2])

rm(gdp_per_capita)

######
# Section 2: Educational training

## Subsection 2.1: Highly skilled

# Masters
isced_7 <- read.csv("isced_7.csv", header = T, sep = "\t")

# PhDs
isced_8 <- read.csv("isced_8.csv", header = T, sep = "\t")

# Total tertiary
total_tertiary <- read.csv("total_tertiary.csv", header = T, sep = "\t")

# Compute highly skilled (master + PhD) to total tertiary ratio
highly_skilled <- ts(
    (isced_7 + isced_8) / total_tertiary,
    start = 2013, end = 2018, frequency = 1
)

pdf("../../Figures/skilled.pdf")
# Visualise these ratios. Turn off GEO, IDN, SRB and RUS
ts.plot(100 * highly_skilled[, -c(7, 8, 16, 17)],
    type = "b", col = 1:16,
    xlab = "Year", ylab = "Percent"
)
legend("topright", colnames(highly_skilled[, -c(7, 8, 16, 17)]),
    col = 1:16, lty = 1, cex = 0.65
)
dev.off()

# Decision: naive forcasts, i.e., copy-paste nearest available year
library(forecast)
# Create a placeholder matrix
placeholder <- matrix(NA, nrow = 20, ncol = 1)

data.frame(unlist(naive(highly_skilled[, 1], h = 1)[5])[6])[1, 1]

# Run a loop to foreecast all 20 countries, using naive method
for (.i in 1:20) {
    m_naive_i <- naive(highly_skilled[, .i], h = 1)
    placeholder[.i] <- data.frame(unlist(m_naive_i[5])[6])[1, 1]
}
# [5] = fitted values; [6] = 2018; [1,1] = only the numeric value

# GEO, IDN and SRB do have 2018 data, plug actual numbers back
placeholder[c(7, 8, 17)] <- highly_skilled[6, c(7, 8, 17)]

# Compute ratio for Russia
## PhD (Type 1) = 15465, PhD (Type 2) = 330
## Master (Type 1) = 101766, Master (Type 2) = 170437
## Total tertiary WITHOUT PhD = 933153
placeholder[16] <- (15465 + 330 + 101766 + 170437) / (933153 + 15465 + 330)

# Save results to "bookshelf"
fki_raw[, 2] <- placeholder * 100

rm(isced_7, isced_8, total_tertiary, highly_skilled, placeholder, m_naive_i)

## Sub-section 2.2: Mean year of schooling
mean_year_of_schooling <- read.csv("mean_year_of_schooling.csv",
    header = F, sep = "\t"
)
fki_raw[, 3] <- mean_year_of_schooling[, 2]

rm(mean_year_of_schooling)

######
# Section 3: Use

## Import data

gpea <- read.csv("gpea.csv", header = T, sep = "\t")
gpea <- ts(gpea, start = 2011, end = 2017, frequency = 1)

ica <- read.csv("ica.csv", header = T, sep = "\t")
ica <- ts(ica, start = 2011, end = 2017, frequency = 1)

# Visualise data in both original and ln forms. Contain trend?
pdf("../../Figures/use.pdf", width = 12.94, height = 9.15)

# Re-set canvas layout to 2x2
par(mfcol = c(2, 2))

# Add extra space to the right of plot area
par(mar = c(5.1, 4.1, 4.1, 2.1), xpd = TRUE)

# Plot GPEA in original form
ts.plot(gpea,
    type = "b", col = 1:20,
    xlab = "Year", ylab = "Percent", main = "GPEA to GDP ratio"
)
# Add the legend
#legend("topright",
#    inset = c(-0.2, 0), colnames(gpea),
#    col = 1:20, lty = 1, cex = 0.65
#)

# Remove extra gap between the two graphs
par(mar = c(5.1, 4.1, 0, 2.1), xpd = TRUE)

# Repeat GPEA, but for the ln() version
ts.plot(log(gpea),
    type = "b", col = 1:20,
    xlab = "Year", ylab = "ln( percent )"
)
# Add the legend
#legend("topright",
#    inset = c(-0.2, 0), colnames(gpea),
#    col = 1:20, lty = 1, cex = 0.65
#)

# Plot ICA in original form
par(mar = c(5.1, 4.1, 4.1, 6.1), xpd = TRUE)
ts.plot(ica,
    type = "b", col = 1:20,
    xlab = "Year", ylab = "Percent", main = "ICA to GDP ratio"
)
# Add the legend
legend("topright",
    inset = c(-0.2, 0), colnames(ica),
    col = 1:20, lty = 1, cex = 0.875
)

# Remove extra gap between the two graphs
par(mar = c(5.1, 4.1, 0, 6.1), xpd = TRUE)

# Repeat, but for the ln()
ts.plot(log(ica),
    type = "b", col = 1:20,
    xlab = "Year", ylab = "ln( percent )"
)
# Add the legend
legend("topright",
    inset = c(-0.2, 0), colnames(ica),
    col = 1:20, lty = 1, cex = 1.07
)
dev.off()

# Decision: since the ln() version is not flat, original time series contain
# trend. Use Holt method rather than simple expential smoothing.

# Run a time series forecast using Holt method

# Create a placeholder matrix
placeholder <- matrix(NA, nrow = 20, ncol = 1)

# Run a loop to forecast all 20 countries, using Holt method
for (.i in 1:20) {
    m_holt_i <- holt(gpea[, .i], h = 1)
    placeholder[.i] <- m_holt_i[2]
}

# Only keep the 2018 forecasts
placeholder <- unlist(placeholder)

# Run a separate one for PER (#13) because it misses both 2017 and 2018 data
m_holt_PER <- holt(gpea[, 13], h = 2)
summary(m_holt_PER)
placeholder[13] <- 16.02698

# Push placeholder to fki_raw
fki_raw[, 4] <- placeholder

rm(gpea, placeholder, m_holt_i, m_holt_PER)

## Sub-section 3.2: Insurance company assets (ica)

ica <- read.csv("ica.csv", header = T, sep = "\t")
ica <- ts(ica, start = 2011, end = 2017, frequency = 1)

placeholder <- matrix(NA, nrow = 20, ncol = 1)

for (.i in 1:20) {
    m_holt_i <- holt(ica[, .i], h = 1)
    placeholder[.i] <- m_holt_i[2]
}

placeholder <- unlist(placeholder)

m_holt_CAN <- holt(ica[, 3], h = 2); summary(m_holt_CAN)
m_holt_IND <- holt(ica[, 8], h = 2); summary(m_holt_IND)
m_holt_ITA <- holt(ica[, 9], h = 2); summary(m_holt_ITA)
m_holt_POL <- holt(ica[, 14], h = 2); summary(m_holt_POL)
m_holt_USA <- holt(ica[, 20], h = 2); summary(m_holt_USA)

placeholder[c(3, 8, 9, 14, 20)] <- c(
    77.72768, 4.611597, 51.2596, 9.534750, 30.18295
)

fki_raw[, 5] <- placeholder

rm(ica, placeholder, list = ls(pattern = "^m.holt"))

## Sub-section 3.3: Individuals using the Internet (ius)

ius <- read.csv("ius.csv", header = T, sep = "\t")
# Split dataset into training and test
ius_training <- ius[-10, ]
ius_test <- ius[10, ]
rm(ius)
ius_training <- ts(ius_training, start = 2009, end = 2017, frequency = 1)

placeholder <- matrix(NA, nrow = 20, ncol = 1)
for (.i in 1:20) {
    m_holt_i <- holt(ius_training[, .i], h = 1)
    summary(m_holt_i)
    placeholder[.i] <- m_holt_i[2]
}

ius_forecasted <- data.frame(unlist(placeholder)) # Only want 2018 forecasts
ius_test <- t(ius_test) # Transpose ius_test to portrait
row.names(ius_forecasted) <- row.names(ius_test)

verify <- cbind(
    ius_test,
    ius_forecasted,
    (ius_forecasted - ius_test) / ius_test * 100
)
colnames(verify) <- c("Actual", "Forecasted", "Inaccuracy")
verify

barplot(verify[, 3],
    names.arg = rownames(verify),
    xlab = "Country", las = 2,
    ylab = "Percentage", ylim = c(-15, 10),
    main = "Forecast error for 2018 Internet usage"
)

# Some countries have sizable over-prediction and others have under-prediction.
# Could the level of over/under-prediction related to the actual levels?
# Run a linear regression:
m_verify <- lm(verify[, 3] ~ verify[, 1])
summary(m_verify)
# The relationship fails to reach 0.05 statistical significance
# but the trend is definitely there.

plot(verify[, 1], verify[, 3],
    xlab = "Actual 2018 IUS (% of population)",
    ylab = "Forecast error (%)",
    main = "Relationship between forecast error and actual 2018 IUS",
    col = "white"
)
abline(m_verify, col = "red", lwd = 1)
text(verify[, 3] ~ verify[, 1],
    labels = rownames(verify),
    cex = 0.9, font = 1
)

# Countries whose actual 2018 IUS between 80 and 90 tend to sit somewhere
# near forsub_ind_ecast error = 0.
# In 2017, CAN=91, CHL=82.3275, USA=87.2661. Their actual 2018 IUS shouldn't
# be too far off from [80, 90] interval, which gives good confidence in the
# forecasted figures.

ius <- verify[, 1]
ius[c(3, 4, 20)] <- verify[c(3, 4, 20), 2]
fki_raw[, 6] <- ius

rm(list = ls(pattern = "^ius"), m_holt_i, m_verify, placeholder, verify)

######
# Section 4: Need

# Subsection 4.1: Pension fund assets (pfa)
pfa <- read.csv("pfa.csv", header = T, sep = "\t")
# Delete GEO (#7) due to all missing
pfa <- ts(pfa[, -7], start = 2008, end = 2017, frequency = 1)

placeholder <- matrix(NA, nrow = 19, ncol = 1)

for (.i in 1:19) {
    m_holt_i <- holt(pfa[, .i], h = 1)
    placeholder[.i] <- m_holt_i[2]
}

placeholder <- unlist(placeholder)

# Calculate GEO
# From Georgia Pension Agency 2019 mesub_ind_eting minute: 372,113,933 GEL
# From GeoStat website: 2018 gdp = 44.6 billion GEL

fki_raw[, 7] <- c(
    placeholder[1:5],
    372113934 / 44600000000 * 100, # Insert GEO figure
    placeholder[6:19]
)

rm(pfa, placeholder, m_holt_i)

# Subsection 4.2: Aggregate consumption (ac)

ac <- read.csv("ac.csv", header = F, row.names = 1, sep = "\t")
gdp <- read.csv("gdp.csv", header = F, row.names = 1, sep = "\t")

dim(ac * 0.02 / gdp * 100)

fki_raw[, 8] <- unlist(ac * 0.02 / gdp * 100)

fki_raw[, 9] <- unlist(gdp)

rm(ac, gdp)

# Subsection 4.3: Ageing

ageing <- read.csv("ageing.csv", header = T, sep = "\t")
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
ageing_ratio <- (pop65plus_f + pop65plus_m) / (pop20to64_f + pop20to64_m)
# Split data into 2018 [ , 1] and 2009 [ , 2] portions
ageing <- cbind(ageing_ratio[1:20], ageing_ratio[21:40])
fki_raw[, 10] <- (ageing[, 1] - ageing[, 2]) / ageing[, 2]

rm(ageing, ageing_ratio, list = ls(pattern = "^pop"))

######
# Section 5: FKI

fki_raw <- fki_raw[, -9] # Throw away gdp (already in ac)
round(fki_raw, digits = 3) # Inspect data
write.csv(round(fki_raw, digits = 3), "fki_raw.csv", row.names = T)

## Subection 5.0: Standardise each variable to [0.01,0.99] range
fki_stand <- matrix(NA, nrow = dim(fki_raw)[1], ncol = dim(fki_raw)[2])
dimnames(fki_stand) <- dimnames(fki_raw)

library(scales) # I wish this function could have "by.col = T". Oh well.
for (.j in 1:dim(fki_raw)[2]) {
    fki_stand[, .j] <- rescale(fki_raw[, .j], to = c(0.01, 0.99))
}

rm(fki_raw)

fki_stand <- data.frame(fki_stand)
attach(fki_stand)

## Subsection 5.1: Eonomic capacity (sub_ind_ec)

sub_ind_ec <- gdp_per_capita

## Subsection 5.2: Education and training (sub_ind_et)

wt_highly_skilled <- 1 / sd(highly_skilled)
wt_mean_year_of_schooling <- 1 / sd(mean_year_of_schooling)

sub_ind_et <- (highly_skilled^wt_highly_skilled *
    mean_year_of_schooling^wt_mean_year_of_schooling)^
    (1 / (wt_highly_skilled + wt_mean_year_of_schooling))

rm(list = ls(pattern = "^wt"))

## Subsection 5.3: Use (sub_ind_u)

sub_ind_u <- (gpea + ica)^ius

## Subsection 5.4: Need (sub_ind_n)

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

barplot(l3_ordered$fki,
    names.arg = rownames(l3_ordered),
    xlab = "Country", las = 2, ylab = "Financial Knowledge Index (FKI)",
    ylim = c(0, 1), main = "FKI of the 20 participating countries"
)