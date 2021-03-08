library(Orcs)
setwdOS(lin = "~/", win = Sys.getenv("USERPROFILE"))

# Import CSV
library(data.table); setDTthreads(0)
country <- fread("country_list.csv", header = T)

mod_coef_ACADEMIC_line <- matrix(NA, nrow = 2 * 19, ncol = 4)
mod_coef_ACADEMIC_quad <- matrix(NA, nrow = 3 * 19, ncol = 4)

mod_coef_FLFAMILY_line <- matrix(NA, nrow = 2 * 19, ncol = 4)
mod_coef_FLFAMILY_quad <- matrix(NA, nrow = 3 * 19, ncol = 4)


for (i in 1:dim(country)[1]){
CNT <- country[i,2]

# Extract one country at a time
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

# ACADEMIC lat var
ACADEMIC <- finlit1_CNT$PERFEED + finlit1_CNT$TEACHINT + finlit1_CNT$FLSCHOOL
data_ACADEMIC <- cbind(ACADEMIC, finlit1_CNT$FLIT)
# Only keep complete cases
data_ACADEMIC <- data.frame(data_ACADEMIC[complete.cases(data_ACADEMIC), ])
names(data_ACADEMIC) <- c("ACADEMIC", "FLIT")
# Run a linear model, then a quadratic one
mod_ACADEMIC_1 <- lm(FLIT ~ ACADEMIC, data = data_ACADEMIC)
mod_ACADEMIC_2 <- lm(FLIT ~ I(ACADEMIC^2) + ACADEMIC, data = data_ACADEMIC)
# Save regression results
mod_coef_ACADEMIC_line[c(I(2 * i - 1):I(2 * i)), c(1:4)] <- summary(mod_ACADEMIC_1)$coefficients
mod_coef_ACADEMIC_quad[c(I(3 * i - 2):I(3 * i)), c(1:4)] <- summary(mod_ACADEMIC_2)$coefficients
# Generate prediction lines
xlim_ACADEMIC <- seq(min(data_ACADEMIC$ACADEMIC), max(data_ACADEMIC$ACADEMIC), length.out = dim(data_ACADEMIC)[1])
pred_ACADEMIC_1 <- mod_ACADEMIC_1$coef[1] + mod_ACADEMIC_1$coef[2] * xlim_ACADEMIC
pred_ACADEMIC_2 <- mod_ACADEMIC_2$coef[1] + mod_ACADEMIC_2$coef[2] * I(xlim_ACADEMIC^2) + mod_ACADEMIC_2$coef[3] * xlim_ACADEMIC

pdf(file = paste0("~/uio/pc/Dokumenter/MSc/Thesis/Model building/Linearity/ACADEMIC/", CNT, ".pdf"))
    plot(data_ACADEMIC$ACADEMIC, data_ACADEMIC$FLIT, xlim=c(-6,6), ylim=c(100,900), xlab = "ACADEMIC", ylab = "FLIT", main = CNT)
    lines(xlim_ACADEMIC, pred_ACADEMIC_1, col = "blue", lwd = 3)
    lines(xlim_ACADEMIC, pred_ACADEMIC_2, col = "red", lwd = 3)
dev.off()

# Financial socialisation
data_FLFAMILY <- cbind(finlit1_CNT$FLFAMILY, finlit1_CNT$FLIT)
data_FLFAMILY <- data.frame(data_FLFAMILY[complete.cases(data_FLFAMILY), ])
names(data_FLFAMILY) <- c("FLFAMILY", "FLIT")
# Detect non-linearity
mod_FLFAMILY_1 <- lm(FLIT ~ FLFAMILY, data = data_FLFAMILY)
mod_FLFAMILY_2 <- lm(FLIT ~ I(FLFAMILY^2) + FLFAMILY, data = data_FLFAMILY)
# Extract coef, SE and t-values. Save them to a spreadsheet
mod_coef_FLFAMILY_line[c(I(2 * i - 1):I(2 * i)), c(1:4)] <- summary(mod_FLFAMILY_1)$coefficients
mod_coef_FLFAMILY_quad[c(I(3 * i - 2):I(3 * i)), c(1:4)] <- summary(mod_FLFAMILY_2)$coefficients
# Generate prediction lines
xlim_FLFAMILY <- seq(min(data_FLFAMILY$FLFAMILY), max(data_FLFAMILY$FLFAMILY), length.out = dim(data_FLFAMILY)[1])
pred_FLFAMILY_1 <- mod_FLFAMILY_1$coef[1] + mod_FLFAMILY_1$coef[2] * xlim_FLFAMILY
pred_FLFAMILY_2 <- mod_FLFAMILY_2$coef[1] + mod_FLFAMILY_2$coef[2] * I(xlim_FLFAMILY^2) + mod_FLFAMILY_2$coef[3] * xlim_FLFAMILY

pdf(file = paste0("~/uio/pc/Dokumenter/MSc/Thesis/Model building/Linearity/FLFAMILY/", CNT, ".pdf"))
    plot(data_FLFAMILY$FLFAMILY, data_FLFAMILY$FLIT, xlim=c(-2.5,2.5), ylim=c(100,900), xlab = "FLFAMILY", ylab = "FLIT", main = CNT)
    lines(xlim_FLFAMILY, pred_FLFAMILY_1, col = "blue", lwd = 3)
    lines(xlim_FLFAMILY, pred_FLFAMILY_2, col = "red", lwd = 3)
dev.off()
}

mod_coef_ACADEMIC_line
mod_coef_ACADEMIC_quad
mod_coef_FLFAMILY_line
mod_coef_FLFAMILY_quad

# Extract slopes from linear models
position <- seq(2,38,2)
slope_ACADEMIC <- mod_coef_ACADEMIC_line[position,1]
slope_FLFAMILY <- mod_coef_FLFAMILY_line[position, 1]
slope <- cbind(slope_ACADEMIC, slope_FLFAMILY)
row.names(slope) <- unlist(country[, 2])

# Any substitution effect between school and family?
mod_slope <- lm(slope_ACADEMIC ~ slope_FLFAMILY)
summary(mod_slope)
pdf("~/uio/pc/Dokumenter/MSc/Thesis/Model building/Linearity/substitution.pdf")
    plot(slope_FLFAMILY, slope_ACADEMIC, col="white")
    text(slope_FLFAMILY, slope_ACADEMIC, row.names(slope), col = "black")
    abline(mod_slope, col = "red")
    abline(v = 0, col = "gray")
    abline(h = 0, col = "gray")
dev.off()
