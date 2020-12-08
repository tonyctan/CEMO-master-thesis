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
        "PERFEED", # Perceived feedback (WLE)
        "TEACHINT", # Perceived teacher's interest (WLE)
        "FLSCHOOL", # Financial education in school lessons (WLE)
    # Safety
        "BELONG", # Sense of belonging to school (WLE)
        "BEINGBULLIED", # Student's experience of being bullied (WLE)
    # Community
        "FLFAMILY" # Parental involvement in matters of Financial Literacy (WLE)
    ),
    school = c(
        "STRATIO", # Student-teacher ratio
        "EDUSHORT", # Shortage of educational material (WLE)
        "STAFFSHORT" # Shortage of educational staff (WLE)
    ),
    countries = c(
        "BRA", "BGR", "CHL", "EST", "FIN",
        "GEO", "IDN", "ITA", "LVA", "LTU",
        "NLD", "PER", "POL", "PRT", "RUS",
        "SRB", "SVK", "ESP", "USA"
    )
)

names(finlit)
# Throw away columns that I do not need
finlit <- finlit[, -c(5,7:86)] # 5 = BOOKID; 7:86 = resampling weights

# Some var need recording
library(car)

# Re-code Russian territories to RUS
finlit$CNT <- recode(finlit$CNT, "
    'QMR' = 'RUS';
    'QRT' = 'RUS'
")

# Input country-level FKI
FKI <- recode(finlit$CNT, "
    'NLD' = 0.957;
    'USA' = 0.947;
    'ITA' = 0.771;
    'FIN' = 0.733;
    'ESP' = 0.637;
    'LTU' = 0.614;
    'PRT' = 0.598;
    'BGR' = 0.585;
    'EST' = 0.579;
    'SVK' = 0.562;
    'POL' = 0.559;
    'CHL' = 0.552;
    'LVA' = 0.547;
    'RUS' = 0.449;
    'SRB' = 0.424;
    'GEO' = 0.419;
    'PER' = 0.309;
    'BRA' = 0.145;
    'IDN' = 0.122
")

# Recode ST004D01T from Sex to Male
MALE <- finlit$ST004D01T - 1

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

# Revert coding direction: bigger number => safer school
NOBULLY <- finlit$BEINGBULLIED * (-1)

# Stitch spreadsheet together
names(finlit)
finlit <- cbind(FKI, finlit[, c(2:35)], MALE, IMMI1GEN, IMMI2GEN, finlit[, c(38:50)])

# Remove cases whose school weights (col #48) are NA
obs0 <- dim(finlit)[1]
finlit <- finlit[complete.cases(finlit[, 48]), ]
obs1 <- dim(finlit)[1]
obs0 - obs1 # 12 cases contained missing school weights and have been dropped
rm(obs0, obs1)

# Use data.table for better RAM management
library(data.table); setDTthreads(0) # 0 means all the available cores
# Export data into a CSV file for faster import next time
fwrite(finlit, file = "finlit.csv", na = "NA", row.names = F, col.names = T)
