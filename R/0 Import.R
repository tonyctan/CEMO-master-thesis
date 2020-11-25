# Housekeeping
library(Orcs)
setwdOS(lin = "~/", win = "C:/Users/Tony/")

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
        "DISCRIM", # Discriminating school climate (WLE)
        "BELONG", # Sense of belonging to school (WLE)
        "BEINGBULLIED", # Student's experience of being bullied (WLE)
        # Community
        "FLFAMILY", # Parental involvement in matters of Financial Literacy (WLE)
        "CURSUPP", # Current parental support for learning at home (WLE)
        "PASCHPOL" # School policies for parental involvement (WLE)
    ),
    school = c(
        "PRIVATESCH", # School type (public, private, missing)
        "STRATIO", # Student-teacher ratio
        "EDUSHORT", # Shortage of educational material (WLE)
        "STAFFSHORT" # Shortage of educational staff (WLE)
    ),
    countries = c(
        "BGR", "BRA", "CAN", "CHL", "ESP",
        "EST", "FIN", "GEO", "IDN", "ITA",
        "LTU", "LVA", "NLD", "PER", "POL",
        "PRT", "QMR", "QRT", "RUS", "SRB",
        "SVK", "USA"
    )
)

# Remove columns that I do not need
finlit <- finlit[, -c(5, 7:86)] # 5 = BOOKID; 7:86 = resampling weights

# Some var need recording
library(car)

# Re-code Russian territories to RUS
finlit$CNT <- recode(finlit$CNT, "
    'QMR' = 'RUS';
    'QRT' = 'RUS'
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

# Recode PRIVATESCH from texts to numbers
finlit$PRIVATESCH <- recode(finlit$PRIVATESCH, "
    'public ' = 0;
    'private' = 1;
    'missing' = NA
")
finlit$PRIVATESCH <- as.numeric(finlit$PRIVATESCH) # Force "0" to 0.

# Stitch spreadsheets together
finlit <- cbind(
    finlit[, c(1:35)],
    MALE, IMMI1GEN, IMMI2GEN,
    finlit[, c(38:54)]
)

# Use data.table for better RAM management
library(data.table); setDTthreads(0) # 0 means all the available cores
# Export data into a CSV file for faster import next time
fwrite(finlit,
    file = "finlit.csv",
    na = "NA", row.names = F, col.names = T
)