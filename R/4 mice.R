# Set working directory to HOME
library(Orcs)
setwdOS(lin = "~/", win = Sys.getenv("USERPROFILE"))

# Read in financial literacy data
library(data.table)
setDTthreads(0)
finlit <- fread("data/finlit.csv")
head(finlit)
names(finlit)
dim(finlit)

# Check how many missings each variabel has
colSums(is.na(finlit))

# Check data type of each variable
str(finlit)
# Turn MALE, IMMI1GEN and IMMI2GEN to factors...
# ...so that jomo knows to treat them as binary variables
finlit <- within(finlit, MALE <- factor(MALE))
finlit <- within(finlit, IMMI1GEN <- factor(IMMI1GEN))
finlit <- within(finlit, IMMI2GEN <- factor(IMMI2GEN))

# Multiple imputation
library(jomo)
library(mitml)
library(mice)

# The type interface is designed to provide quick-and-easy imputations using jomo. The type argument must be an integer vector denoting the role of each variable in the imputation model:
# 1: target variables containing missing data
# 2: predictors with fixed effect on all targets (completely observed)
# 3: predictors with random effect on all targets (completely observed)
# -1: grouping variable within which the imputation is run separately
# -2: cluster indicator variable
# 0: variables not featured in the model

# Specify L1 types
type.L1 <- c(
    0, -1, -2, 0, 0,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    1, 1, 1, 1, 1,
    1, 1, 1, 1, 0,
    0, 0
)
# Assign var names
names(type.L1) <- colnames(finlit)

# Specify L2 types
type.L2 <- c(
    0, -1, -2, 0, 0,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    2, 2, 2, 2, 2,
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    1, 1
)
# Assign var names
names(type.L2) <- colnames(finlit)

# Stitch L1 and L2 type lists together
type <- list(type.L1, type.L2)

# Perform multilevel multiple imputation
imp <- mice.impute.jomoImpute(
    data = finlit,
    type = type,
    n.burn = 1000,
    n.iter = 1000,
    m = 10,
    format = "imputes"
)
