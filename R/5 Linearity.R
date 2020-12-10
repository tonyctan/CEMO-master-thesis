library(Orcs)
setwdOS(lin = "~/", win = Sys.getenv("USERPROFILE"))

# Import CSV
library(data.table); setDTthreads(0)




country <- fread("country_list.csv", header = T)
mod_coef_line <- matrix(NA, nrow = 2 * 19, ncol = 4)
mod_coef_quad <- matrix(NA, nrow = 3 * 19, ncol = 4)


for (i in 1:dim(country)[1]){
CNT <- country[i,2]

finlit1_CNT <- fread(paste0("finlit1_", CNT, ".dat"), na.strings = "-99")
# Turn data into a data frame
finlit1_CNT <- data.frame(finlit1_CNT)
# Assign student ID as row name
row.names(finlit1_CNT) <- finlit1_CNT[, 4]
# Remove Student ID column
finlit1_CNT <- finlit1_CNT[, -4]
# Give column name
names(finlit1_CNT) <- c(
    "FKI", "CNTID", "SCHID", "W_STU",
    "MATH", "READ", "FLIT",
    "MALE", "IMMI1GEN", "IMMI2GEN", "SES",
    "FCFMLRTY", "FLCONFIN",
    "PERFEED", "TEACHINT", "FLSCHOOL",
    "BELONG", "NOBULLY",
    "FLFAMILY",
    "W_SCH", "STRATIO", "EDUSHT", "STAFFSHT"
)

# # Combine ACADEMIC lat var
# ACADEMIC <- finlit1_CNT$PERFEED + finlit1_CNT$TEACHINT + finlit1_CNT$FLSCHOOL
# data <- cbind(ACADEMIC, finlit1_CNT$FLIT)
# data <- data.frame(data[complete.cases(data), ])
# names(data) <- c("ACADEMIC", "FLIT")
# # Detect non-linearity
# mod_1 <- lm(FLIT ~ ACADEMIC, data = data); summary(mod_1)
# mod_2 <- lm(FLIT ~ I(ACADEMIC^2) + ACADEMIC, data = data); summary(mod_2)
# # Generate prediction lines
# ACADEMICx <- seq(min(data$ACADEMIC), max(data$ACADEMIC), length.out = dim(data)[1])
# pred_1 <- mod_1$coef[1] + mod_1$coef[2] * ACADEMICx
# pred_2 <- mod_2$coef[1] + mod_2$coef[2] * ACADEMICx + mod_2$coef[3] * ACADEMICx

# pdf(file = paste0("~/uio/pc/Dokumenter/MSc/Thesis/Model building/Linearity/ACADEMIC/", CNT, ".pdf"))
#     plot(data$ACADEMIC, data$FLIT, xlim=c(-6,6), ylim=c(100,900), xlab = "ACADEMIC", ylab = "FLIT", main = CNT)
#     lines(ACADEMICx, pred_1, col = "blue")
#     lines(ACADEMICx, pred_2, col = "red")
# dev.off()

# Financial socialisation
data <- cbind(finlit1_CNT$FLFAMILY, finlit1_CNT$FLIT)
data <- data.frame(data[complete.cases(data), ])
names(data) <- c("FLFAMILY", "FLIT")
# Detect non-linearity
mod_1 <- lm(FLIT ~ FLFAMILY, data = data)
mod_2 <- lm(FLIT ~ I(FLFAMILY^2) + FLFAMILY, data = data)
# Extract coef, SE and t-values. Save them to a spreadsheet
mod_coef_line[c(I(2 * i - 1):I(2 * i)), c(1:4)] <- summary(mod_1)$coefficients
mod_coef_quad[c(I(3 * i - 2):I(3 * i)), c(1:4)] <- summary(mod_2)$coefficients
# Generate prediction lines
FLFAMILYx <- seq(min(data$FLFAMILY), max(data$FLFAMILY), length.out = dim(data)[1])
pred_1 <- mod_1$coef[1] + mod_1$coef[2] * FLFAMILYx
pred_2 <- mod_2$coef[1] + mod_2$coef[2] * FLFAMILYx + mod_2$coef[3] * FLFAMILYx

pdf(file = paste0("~/uio/pc/Dokumenter/MSc/Thesis/Model building/Linearity/FLFAMILY/", CNT, ".pdf"))
    plot(data$FLFAMILY, data$FLIT, xlim=c(-2.5,2.5), ylim=c(100,900), xlab = "FLFAMILY", ylab = "FLIT", main = CNT)
    lines(FLFAMILYx, pred_1, col = "blue")
    lines(FLFAMILYx, pred_2, col = "red")
dev.off()
}

mod_coef_line
mod_coef_quad
