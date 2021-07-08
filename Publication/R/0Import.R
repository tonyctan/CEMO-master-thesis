# Housekeeping
library(Orcs)
setwdOS(lin = "~/", win = Sys.getenv("USERPROFILE"))

# Import SPSS file into R
library(intsvy)
finlit <- pisa.select.merge(
    student.file = "CY07_MSU_FLT_QQQ.SAV", # file ext in capital
    school.file = "CY07_MSU_SCH_QQQ.sav", # file ext in lower case
    student = c(
        # Demographic variables
        "ST004D01T", # Sex
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

# Inspect table header
names(finlit)

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

# Revert coding direction: bigger number => safer school
NOBULLY <- finlit$BEINGBULLIED * (-1)

# Stitch spreadsheets together
finlit <- cbind(
    finlit[, c(1:35)],
    MALE, IMMI1GEN, IMMI2GEN,
    finlit[, c(38:41)],
    NOBULLY,
    finlit[, c(43:47)]
)
rm(MALE, IMMI1GEN, IMMI2GEN, NOBULLY) # Keep object list clean

# Remove cases whose school weights (col #45) are NA
obs0 <- dim(finlit)[1]
finlit <- finlit[complete.cases(finlit$W_FSTUWT_SCH_SUM), ]
obs1 <- dim(finlit)[1]
obs0 - obs1 # 12 cases contained missing school weights and have been dropped
rm(obs0, obs1) # Keep object list clean

# Create country dummy variables
# Create an empty bookshelf
CNT_dummy <- matrix(NA, nrow = dim(finlit)[1], ncol = 20)
# Fill the bookshelf with country code
for (i in 1:20) {
    CNT_dummy[, i] <- finlit$CNT
}
# Turn matrix into a data frame
CNT_dummy <- data.frame(CNT_dummy)
# Name the columns
names(CNT_dummy) <- unique(finlit$CNT)
# Turn country codes to country dummies
for (j in 1:dim(CNT_dummy)[2]) {
    for (i in 1:dim(CNT_dummy)[1]) {
        if (CNT_dummy[i, j] == names(CNT_dummy)[j]) {
            CNT_dummy[i, j] <- 1
        } else {
            CNT_dummy[i, j] <- 0
        }
    }
}

# Stitch country dummies onto the main data frame
finlit <- cbind(CNT_dummy, finlit)
rm(CNT_dummy) # Keep object list clean
# Re-order the columns so that country dummies follows country code order
# Also, drop CNT column (Column 21)
finlit <- finlit[, c(2,1,3,4,6,7,8,9,10,12,11,13,14,15,16,17,18,19,5,20,22:62,64,63,65:67)]

# Turn texts "0" and "1" to numeric 0 and 1 respectively
finlit[,c(1:20)] <- lapply(finlit[,c(1:20)], as.numeric)

# Use data.table for better RAM management
library(data.table); setDTthreads(0) # 0 means all the available cores
# Export data to an Mplus-ready format
fwrite(finlit,
    file = "pub.dat",
    na = "-99", row.names = F, col.names = F, eol = "\r\n"
)
# N.B.: Mplus can only read CR or CRLF. Overwrite Linux's default LF to CRLF.
