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

# # Create input file
# createModels("finlit_sg_msem.txt")

# # Run the input file
# runModels(
#     target = getwd(),
#     recursive = F,
#     replaceOutfile = "never"
# )


# Read the model results
sg_msem_fixed <- readModels(
    target = getwd(),
    recursive = F,
    what = "all"
)

# MODEL SUMMARY

# MODEL FIT

# Extract the relevant model fit indices

# Chi-sq test statistics (ChiSqM_Mean)
chisqM <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$ChiSqM_Mean,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$ChiSqM_Mean,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$ChiSqM_Mean,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$ChiSqM_Mean,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$ChiSqM_Mean
)

# Standard deviation of Chi-sq test statistics (ChiSqM_SD)
chisqSD <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$ChiSqM_SD,
    #    sg_msem_fixed$finlit_sg_msem_528.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$ChiSqM_SD,
    #    sg_msem_fixed$finlit_sg_msem_620.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$ChiSqM_SD,
    #    sg_msem_fixed$finlit_sg_msem_703.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$ChiSqM_SD,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$ChiSqM_SD
)

# Chi-sq degrees of freedom (ChiSqM_DF)
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
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$ChiSqM_DF,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$ChiSqM_DF,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$ChiSqM_DF,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$ChiSqM_DF
)

# CFI_Mean
cfiM <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$CFI_Mean,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$CFI_Mean,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$CFI_Mean,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$CFI_Mean,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$CFI_Mean
)

# CFI_SD
cfiSD <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$CFI_SD,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$CFI_SD,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$CFI_SD,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$CFI_SD,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$CFI_SD
)

# TLI_Mean
tliM <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$TLI_Mean,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$TLI_Mean,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$TLI_Mean,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$TLI_Mean,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$TLI_Mean
)

# TLI_Mean
tliSD <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$TLI_SD,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$TLI_SD,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$TLI_SD,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$TLI_SD,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$TLI_SD
)

# RMSEA
rmsea <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$RMSEA_Mean,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$RMSEA_Mean,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$RMSEA_Mean,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$RMSEA_Mean,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$RMSEA_Mean
)

# SRMR.Within
srmr_w <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$SRMR.Within_Mean,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$SRMR.Within_Mean,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$SRMR.Within_Mean,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$SRMR.Within_Mean,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$SRMR.Within_Mean
)

# SRMR.Between
srmr_b <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$SRMR.Between_Mean,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$SRMR.Between_Mean,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$SRMR.Between_Mean,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$SRMR.Between_Mean,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$SRMR.Between_Mean
)

# AIC_Mean
aicM <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$AIC_Mean,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$AIC_Mean,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$AIC_Mean,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$AIC_Mean,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$AIC_Mean
)

# AIC_SD
aicSD <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$AIC_SD,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$AIC_SD,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$AIC_SD,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$AIC_SD,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$AIC_SD
)

# BIC_Mean
bicM <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$BIC_Mean,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$BIC_Mean,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$BIC_Mean,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$BIC_Mean,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$BIC_Mean
)

# BIC_SD
bicSD <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$BIC_SD,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$BIC_SD,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$BIC_SD,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$BIC_SD,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$BIC_SD
)

# Adjusted BIC_Mean
abicM <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$aBIC_Mean,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$aBIC_Mean,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$aBIC_Mean,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$aBIC_Mean,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$aBIC_Mean
)

# Adjusted BIC_SD
abicSD <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_100.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_124.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_152.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_233.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_246.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_268.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_360.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_380.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_428.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_440.out$summaries$aBIC_SD,
#    sg_msem_fixed$finlit_sg_msem_528.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_604.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_616.out$summaries$aBIC_SD,
#    sg_msem_fixed$finlit_sg_msem_620.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_643.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_688.out$summaries$aBIC_SD,
#    sg_msem_fixed$finlit_sg_msem_703.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_724.out$summaries$aBIC_SD,
    sg_msem_fixed$finlit_sg_msem_840.out$summaries$aBIC_SD
)

# Country information

# Country name
cnt_name <- c(
    "BRA", "BGR", "CAN", "CHL", "EST",
    "FIN", "GEO", "IND", "ITA", "LVA",
    "LTU", "PER", "POL",
    "RUS", "SRB", "ESP", "USA"
)

# Country code
cnt_code <- c(
    76, 100, 124, 152, 233,
    246, 268, 360, 380, 428,
    440, 604, 616,
    643, 688, 724, 840
)

# Summarise model fit information

# Store results in a table
sg_msem_fit <- data.frame(
    cnt_name, cnt_code,
    chisqM, chisqSD, chisqDF,
    cfiM, cfiSD,
    tliM, tliSD,
    rmsea, srmr_w, srmr_b,
    aicM, aicSD,
    bicM, bicSD,
    abicM, abicSD
)

# Add column names
colnames(sg_msem_fit) <- c(
    "Country Name", "Country Code",
    "Chi-Sq", "Chi-Sq SD", "Chi-sq DF",
    "CFI", "CFI SD",
    "TLI", "TLI SD",
    "RMSEA", "SRMR Within", "SRMR Between",
    "AIC", "AIC SD",
    "BIC", "BIC SD",
    "aBIC", "aBIC SD"
)

# Add some summary statistics and the values for the entire sample
sg_msem_fit2 <- rbind(
    sg_msem_fit,
    c(
        "Summary", "Median",
        round(median(chisqM), 3),
        "", "",
        round(median(cfiM), 3),
        "",
        round(median(tliM), 3),
        "",
        round(median(rmsea), 3),
        round(median(srmr_w), 3),
        round(median(srmr_b), 3),
        round(median(aicM), 3),
        "",
        round(median(bicM), 3),
        "",
        round(median(abicM), 3),
        ""
    ),
    c(
        "", "Mean",
        round(mean(chisqM), 3),
        "", "",
        round(mean(cfiM), 3),
        "",
        round(mean(tliM), 3),
        "",
        round(mean(rmsea), 3),
        round(mean(srmr_w), 3),
        round(mean(srmr_b), 3),
        round(mean(aicM), 3),
        "",
        round(mean(bicM), 3),
        "",
        round(mean(abicM), 3),
        ""
    ),
    c(
        "", "SD",
        round(sd(chisqM), 3),
        "", "",
        round(sd(cfiM), 3),
        "",
        round(sd(tliM), 3),
        "",
        round(sd(rmsea), 3),
        round(sd(srmr_w), 3),
        round(sd(srmr_b), 3),
        round(sd(aicM), 3),
        "",
        round(sd(bicM), 3),
        "",
        round(sd(abicM), 3),
        ""
    ),
    c(
        "", "Min",
        round(min(chisqM), 3),
        "", "",
        round(min(cfiM), 3),
        "",
        round(min(tliM), 3),
        "",
        round(min(rmsea), 3),
        round(min(srmr_w), 3),
        round(min(srmr_b), 3),
        round(min(aicM), 3),
        "",
        round(min(bicM), 3),
        "",
        round(min(abicM), 3),
        ""
    ),
    c(
        "", "Max",
        round(max(chisqM), 3),
        "", "",
        round(max(cfiM), 3),
        "",
        round(max(tliM), 3),
        "",
        round(max(rmsea), 3),
        round(max(srmr_w), 3),
        round(max(srmr_b), 3),
        round(max(aicM), 3),
        "",
        round(max(bicM), 3),
        "",
        round(max(abicM), 3),
        ""
    )
)

sg_msem_fit2

# Export the data frame to a spreadsheet
write.csv(sg_msem_fit2,
    file = "sg_msem_by_country_model_fit.csv", row.names = F
)

sg_msem_fixed$finlit_sg_msem_76.out$parameters$stdyx.standardized$est[1]


par_a11 <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_100.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_124.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_152.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_233.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_246.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_268.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_360.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_380.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_428.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_440.out$parameters$stdyx.standardized$est[1],
#    sg_msem_fixed$finlit_sg_msem_528.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_604.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_616.out$parameters$stdyx.standardized$est[1],
#    sg_msem_fixed$finlit_sg_msem_620.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_643.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_688.out$parameters$stdyx.standardized$est[1],
#    sg_msem_fixed$finlit_sg_msem_703.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_724.out$parameters$stdyx.standardized$est[1],
    sg_msem_fixed$finlit_sg_msem_840.out$parameters$stdyx.standardized$est[1]
)

par_a21 <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_100.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_124.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_152.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_233.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_246.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_268.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_360.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_380.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_428.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_440.out$parameters$stdyx.standardized$est[2],
#    sg_msem_fixed$finlit_sg_msem_528.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_604.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_616.out$parameters$stdyx.standardized$est[2],
#    sg_msem_fixed$finlit_sg_msem_620.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_643.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_688.out$parameters$stdyx.standardized$est[2],
#    sg_msem_fixed$finlit_sg_msem_703.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_724.out$parameters$stdyx.standardized$est[2],
    sg_msem_fixed$finlit_sg_msem_840.out$parameters$stdyx.standardized$est[2]
)

par_a31 <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_100.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_124.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_152.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_233.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_246.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_268.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_360.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_380.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_428.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_440.out$parameters$stdyx.standardized$est[3],
#    sg_msem_fixed$finlit_sg_msem_528.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_604.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_616.out$parameters$stdyx.standardized$est[3],
#    sg_msem_fixed$finlit_sg_msem_620.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_643.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_688.out$parameters$stdyx.standardized$est[3],
#    sg_msem_fixed$finlit_sg_msem_703.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_724.out$parameters$stdyx.standardized$est[3],
    sg_msem_fixed$finlit_sg_msem_840.out$parameters$stdyx.standardized$est[3]
)

par_a12 <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_100.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_124.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_152.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_233.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_246.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_268.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_360.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_380.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_428.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_440.out$parameters$stdyx.standardized$est[4],
#    sg_msem_fixed$finlit_sg_msem_528.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_604.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_616.out$parameters$stdyx.standardized$est[4],
#    sg_msem_fixed$finlit_sg_msem_620.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_643.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_688.out$parameters$stdyx.standardized$est[4],
#    sg_msem_fixed$finlit_sg_msem_703.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_724.out$parameters$stdyx.standardized$est[4],
    sg_msem_fixed$finlit_sg_msem_840.out$parameters$stdyx.standardized$est[4]
)

par_a22 <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_100.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_124.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_152.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_233.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_246.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_268.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_360.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_380.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_428.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_440.out$parameters$stdyx.standardized$est[5],
#    sg_msem_fixed$finlit_sg_msem_528.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_604.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_616.out$parameters$stdyx.standardized$est[5],
#    sg_msem_fixed$finlit_sg_msem_620.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_643.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_688.out$parameters$stdyx.standardized$est[5],
#    sg_msem_fixed$finlit_sg_msem_703.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_724.out$parameters$stdyx.standardized$est[5],
    sg_msem_fixed$finlit_sg_msem_840.out$parameters$stdyx.standardized$est[5]
)

par_a32 <- c(
    sg_msem_fixed$finlit_sg_msem_76.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_100.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_124.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_152.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_233.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_246.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_268.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_360.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_380.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_428.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_440.out$parameters$stdyx.standardized$est[6],
#    sg_msem_fixed$finlit_sg_msem_528.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_604.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_616.out$parameters$stdyx.standardized$est[6],
#    sg_msem_fixed$finlit_sg_msem_620.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_643.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_688.out$parameters$stdyx.standardized$est[6],
#    sg_msem_fixed$finlit_sg_msem_703.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_724.out$parameters$stdyx.standardized$est[6],
    sg_msem_fixed$finlit_sg_msem_840.out$parameters$stdyx.standardized$est[6]
)
