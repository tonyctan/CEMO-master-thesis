# Set working directory to HOME
library(Orcs)
setwdOS(lin = "~/", win = Sys.getenv("USERPROFILE"))

# Read in financial literacy data
library(data.table); setDTthreads(0)
finlit <- fread("data/finlit.csv")
head(finlit); names(finlit); dim(finlit)

# Check how many missings each variabel has
colSums(is.na(finlit))

# Check data type of each variable
str(finlit)
# Turn MALE, IMMI1GEN and IMMI2GEN to factors...
# ...so that jomo knows to treat them as binary variables
finlit <- within(finlit, MALE <- factor(MALE))
finlit <- within(finlit, IMMI1GEN <- factor(IMMI1GEN))
finlit <- within(finlit, IMMI2GEN <- factor(IMMI2GEN))

# Specify Level 1 vars that need to be imputed
Y <- finlit[, c(
    "MALE", "IMMI1GEN", "IMMI2GEN", "ESCS",
    "FCFMLRTY", "FLCONFIN",
    "FLSCHOOL", "NOBULLY", "FLFAMILY"
)]
head(Y); colSums(is.na(Y)) # Verify

# Specify Level 2 vars that need to be imputed
Y2 <- finlit[, c(
    "STRATIO", "EDUSHORT"
)]
head(Y2); colSums(is.na(Y2)) # Verify

# Specify clustering indicator
clus <- finlit$CNTSCHID

# Specify vars that have FULL data
X <- finlit[, c(
    "PV1MATH", "PV2MATH", "PV3MATH", "PV4MATH", "PV5MATH",
    "PV6MATH", "PV7MATH", "PV8MATH", "PV9MATH", "PV10MATH",
    "PV1READ", "PV2READ", "PV3READ", "PV4READ", "PV5READ",
    "PV6READ", "PV7READ", "PV8READ", "PV9READ", "PV10READ",
    "PV1FLIT", "PV2FLIT", "PV3FLIT", "PV4FLIT", "PV5FLIT",
    "PV6FLIT", "PV7FLIT", "PV8FLIT", "PV9FLIT", "PV10FLIT"
)]
head(X); colSums(is.na(X)) # Verify

# Perform multilevel multiple imputation
library(jomo)
imp <- jomo(
    X = X, Y = Y, Y2 = Y2, clus = clus,
    nburn = 1000, nbetween = 1000,
    nimp = 10
)

