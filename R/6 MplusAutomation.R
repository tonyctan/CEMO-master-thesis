# Housekeeping
library(Orcs) # Set working directory depending on operating system
setwdOS(
    lin = "~/uio/", win = "M:/",
    ext = "pc/Dokumenter/MSc/Thesis/R/MplusAutomation/"
)

# Load necessary packages
library(MplusAutomation)
library(metafor)
library(ggpubr)

# Create input file
createModels("finlit_sg_msem.txt")

# Run the input file
runModels(
    target = getwd(),
    recursive = F,
    replaceOutfile = "never"
)


































# Read the model results
sg_msem_fixed <- readModels(
    target = getwd(),
    recursive = F,
    what = "all"
)

# MODEL SUMMARY

# MODEL FIT

# Extract the relevant model fit indices

# Chi-sq value ChiSqM_Value
chisq <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$ChiSqM_Value,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$ChiSqM_Value
)

# Degrees of freedom ChiSqM_DF
chisqDF <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$ChiSqM_DF
)

# P-value ChiSqM_PValue
chisqP <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$ChiSqM_PValue,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$ChiSqM_PValue
)

# Scaling correction factor SCF ChiSqM_ScalingCorrection
scf <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$ChiSqM_ScalingCorrection,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$ChiSqM_ScalingCorrection
)

# CFI
cfi <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$CFI,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$CFI
)

# RMSEA_Estimate
rmsea <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$RMSEA_Estimate,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$RMSEA_Estimate
)

# SRMR.Within
srmr_w <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$SRMR.Within,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$SRMR.Within
)

# SRMR.Between
srmr_b <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$SRMR.Between,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$SRMR.Between
)

# AIC
aic <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$AIC,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$AIC
)

# BIC
bic <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$BIC,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$BIC
)

# Corrected AICc
aicc <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_528.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_620.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_703.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$AICC,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$AICC
)

# Country information

# Country name
cnt_name <- c(
    "BRA", "BGR", "CAN", "CHL", "EST",
    "FIN", "GEO", "IND", "ITA", "LVA",
    "LTU", "NLD", "PER", "POL", "PRT",
    "RUS", "SRB", "SVK", "ESP", "USA",
    "Total Sample"
)

# Country code
cnt_code <- c(
    76, 100, 124, 152, 233,
    246, 268, 360, 380, 428,
    440, 528, 604, 616, 620,
    643, 688, 703, 724, 840,
    "PISA 2018"
)

# Summarise model fit information

# Store results in a table
sg_msem_fit <- data.frame(
    cnt_names, cnt_code,
    chisq, chisqDF, chisqP, scf,
    cfi, rmsea, srmr_w, srmr_b,
    aic, bic, aicc
)

# Add column names
colnames(sg_msem_fit) <- c(
    "Country Name", "Country Code",
    "Chi-Sq", "Chi-Sq DF", "Chi-sq p", "Chi-sq SCF",
    "CFI", "RMSEA", "SRMR Within", "SRMR Between",
    "AIC", "BIC", "AICc"
)

# Add some summary statistics and the values for the entire sample
sg_msem_fit2 <- rbind(
    sg_msem_fit,
    c(
        "Summary", "Median", "", "", "", "",
        round(median(cfi[-21], na.rm=T), 3),
        round(median(rmsea[-21]), 3),
        round(median(srmr_w[-21]), 3),
        round(median(srmr_b[-21]), 3),
        round(median(aic[-21]), 3),
        round(median(bic[-21]), 3),
        round(median(aicc[-21]), 3)
    ),
    c(
        "", "Mean", "", "", "", "",
        round(mean(cfi[-21], na.rm=T), 3),
        round(mean(rmsea[-21]), 3),
        round(mean(srmr_w[-21]), 3),
        round(mean(srmr_b[-21]), 3),
        round(mean(aic[-21]), 3),
        round(mean(bic[-21]), 3),
        round(mean(aicc[-21]), 3)
    ),
    c(
        "", "SD", "", "", "", "",
        round(sd(cfi[-21], na.rm=T), 3),
        round(sd(rmsea[-21]), 3),
        round(sd(srmr_w[-21]), 3),
        round(sd(srmr_b[-21]), 3),
        round(sd(aic[-21]), 3),
        round(sd(bic[-21]), 3),
        round(sd(aicc[-21]), 3)
    ),
    c(
        "", "Min", "", "", "", "",
        round(min(cfi[-21], na.rm=T), 3),
        round(min(rmsea[-21]), 3),
        round(min(srmr_w[-21]), 3),
        round(min(srmr_b[-21]), 3),
        round(min(aic[-21]), 3),
        round(min(bic[-21]), 3),
        round(min(aicc[-21]), 3)
    ),
    c(
        "", "Max", "", "", "", "",
        round(max(cfi[-21], na.rm=T), 3),
        round(max(rmsea[-21]), 3),
        round(max(srmr_w[-21]), 3),
        round(max(srmr_b[-21]), 3),
        round(max(aic[-21]), 3),
        round(max(bic[-21]), 3),
        round(max(aicc[-21]), 3)
    )
)
sg_msem_fit2

# Export the data frame to a spreadsheet
write.csv(sg_msem_fit2, file = "sg_msem_by_country_model_fit.csv")
