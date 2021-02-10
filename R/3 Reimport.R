# Housekeeping
library(Orcs)
setwdOS(lin = "~/", win = Sys.getenv("USERPROFILE"))

# Import SPSS file into R
library(intsvy)
finlit <- pisa.select.merge(
    student.file = "CY07_MSU_FLT_QQQ.SAV", # file ext in capital
    school.file = "CY07_MSU_SCH_QQQ.sav", # file ext in lower case
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

# Stitch spreadsheet together
names(finlit)
finlit <- cbind(
    FKI, finlit[, c(2:35)], MALE, finlit[, c(37:41)], NOBULLY, finlit[, c(43:46)]
)
head(finlit)
names(finlit)

# Remove cases whose school weights (col #45) are NA
obs0 <- dim(finlit)[1]
finlit <- finlit[complete.cases(finlit$W_FSTUWT_SCH_SUM), ]
obs1 <- dim(finlit)[1]
obs0 - obs1 # 12 cases contained missing school weights and have been dropped
rm(obs0, obs1)

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
