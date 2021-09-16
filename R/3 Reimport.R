# Housekeeping
library(Orcs)
setwdOS(lin = "~/", win = Sys.getenv("USERPROFILE"))

# Import SPSS file into R
library(intsvy)
finlit <- pisa.select.merge(
    student.file = "data/CY07_MSU_FLT_QQQ.SAV", # file ext in capital
    school.file = "data/CY07_MSU_SCH_QQQ.sav", # file ext in lower case
    student = c(
    # Control variables
        "ST004D01T", # Student (Standardized) Gender
        "IMMIG", # Index Immigration status
        "ESCS", # Index of economic, social and cultural status
    # Mediators
        "FCFMLRTY", # Familiarity with concepts of finance (Sum)
        "FLCONFIN", # Confidence about financial matters (WLE)
    # Academic
        "FLSCHOOL", # Financial education in school lessons (WLE)
    # Safety
        "BEINGBULLIED", # Student's experience of being bullied (WLE)
    # Community
        "FLFAMILY" # Parental involvement in matters of Financial Literacy (WLE)
    ),
    school = c(
        "STRATIO", # Student-teacher ratio
        "EDUSHORT" # Shortage of educational material (WLE)
    ),
    countries = c(
        "BRA", "BGR", "CAN", "CHL", "EST",
        "FIN", "GEO", "IDN", "ITA", "LVA",
        "LTU", "NLD", "PER", "POL", "PRT",
        "RUS", "QMR", "QRT", # Russian Federation and other regions
        "SRB", "SVK", "ESP", "USA"
    )
)

names(finlit)
# Throw away columns that I do not need
finlit <- finlit[, -c(5, 7:86)] # 5 = BOOKID; 7:86 = resampling weights
names(finlit)

# Some var need recording
library(car)

# Re-code Russian territories to RUS
finlit$CNT <- recode(finlit$CNT, "
    'QMR' = 'RUS';
    'QRT' = 'RUS'
")

finlit$CNTRYID <- recode(finlit$CNTRYID, "
    982 = 643;
    983 = 643
")

# Input country-level FKI
FKI <- recode(finlit$CNT, "
    'NLD' = 0.940;
    'USA' = 0.937;
    'CAN' = 0.784;
    'ITA' = 0.762;
    'FIN' = 0.724;
    'ESP' = 0.627;
    'LTU' = 0.613;
    'PRT' = 0.591;
    'BGR' = 0.583;
    'EST' = 0.577;
    'SVK' = 0.559;
    'POL' = 0.555;
    'LVA' = 0.550;
    'CHL' = 0.544;
    'RUS' = 0.450;
    'GEO' = 0.424;
    'SRB' = 0.423;
    'PER' = 0.309;
    'BRA' = 0.141;
    'IDN' = 0.122
")

# Recode ST004D01T from Sex to Male
MALE <- finlit$ST004D01T - 1

# Revert coding direction: bigger number => safer school
NOBULLY <- finlit$BEINGBULLIED * (-1)

# Recode IMMIG to 1st and 2nd generation
IMMI1GEN <- recode(finlit$IMMIG, "
    1 = 0;
    2 = 0;
    3 = 1
")

IMMI2GEN <- recode(finlit$IMMIG, "
    1 = 0;
    2 = 1;
    3 = 0
")

# Stitch spreadsheet together
names(finlit)
finlit <- cbind(
    FKI, finlit[, c(2:35)], MALE, IMMI1GEN, IMMI2GEN,
    finlit[, c(38:41)], NOBULLY, finlit[, c(43:46)]
)
head(finlit)
names(finlit)

# Remove cases whose school weights (col #45) are NA
obs0 <- dim(finlit)[1]
finlit <- finlit[complete.cases(finlit$W_FSTUWT_SCH_SUM), ]
obs1 <- dim(finlit)[1]
obs0 - obs1 # 12 cases contained missing school weights and have been dropped
rm(obs0, obs1)

# === Option 1: Export data into Mplus-ready format

# Prepare dataset for Mplus multilevel multiple imputation

# Use the correct end-of-line marker depending on the operating system
switch(Sys.info()[["sysname"]],
    Linux = {EOL = "\r\n"},
    Windows = {EOL = "\n"}
)

write.table(finlit,
    "finlit.dat",
    row.names = F, col.names = F,
    sep= ",", na = "-99", eol = EOL
)

# === Option 2: Export data into jomo-ready format

write.table(finlit,
    "finlit.csv",
    row.names=F,col.names=T,
    sep=",", na="NA"
)


# Some quick statistics


# How many schools does each country have?
list_school <- aggregate(
    CNTSCHID ~ CNTRYID, finlit, function(x) length(unique(x))
)
list_school
# How many schools in total?
sum(list_school[, 2])

# How many students does each country have?
list_student <- aggregate(
    CNTSTUID ~ CNTRYID, finlit, function(x) length(unique(x))
)
list_student
sum(list_student[, 2])

# How many male students does each country have?
list_male <- aggregate(MALE ~ CNTRYID, finlit, sum)
sum(list_male[, 2])

# Balanced design by sex?
obs_sex <- list_male[, 2]
exp_sex <- list_student[,2] / 2
chisq.test(obs_sex, p = exp_sex, rescale.p = T)
# Yup, chi-sq = 20.90, p-value = 0.343. Fail to reject the null. Call it balanced.

# Balanced design by school?
obs_school <- list_school[, 2]
exp_school <- rep(sum(obs_school)/20, 20)
chisq.test(obs_school, p = exp_school, rescale.p = T)

# Balanced design by student?
obs_student <- list_student[, 2]
exp_student <- rep(sum(obs_student)/20, 20)
chisq.test(obs_student, p = exp_student, rescale.p = T)

attach(finlit)

# Average 10 PV only for variance and correlation matrices purposes
FLIT <- rowMeans(data.frame(
    PV1FLIT, PV2FLIT, PV3FLIT, PV4FLIT, PV5FLIT,
    PV6FLIT, PV7FLIT, PV8FLIT, PV9FLIT, PV10FLIT
))
library(psych)
print(describe(FLIT), digits = 3)

# Give me a variance-covariance matrix between the variables
L1 <- data.frame(
    FLSCHOOL, FLFAMILY, NOBULLY,
    ESCS, IMMI1GEN, IMMI2GEN, MALE,
    FCFMLRTY, FLCONFIN, FLIT
)
round(cov(L1, method = "pearson", use = "pairwise.complete.obs"), digits = 3)
round(cor(L1, method = "pearson", use = "pairwise.complete.obs"), digits = 3)

L2 <- data.frame(EDUSHORT, STRATIO)
round(cov(L2, method = "pearson", use = "pairwise.complete.obs"), digits = 3)
round(cor(L2, method = "pearson", use = "pairwise.complete.obs"), digits = 3)

# I also want the p-values of the correlations
library("Hmisc")
rcorr(as.matrix(L1), type = "pearson")
rcorr(as.matrix(L2), type = "pearson")
