# This is where SPSS files are to be read from (local!)
library(Orcs)
setwdOS(lin = "~/", win = "C:\\Users\\Tony\\")

library(intsvy)
finlit <- pisa.select.merge(
    student.file = "CY07_MSU_FLT_QQQ.SAV", # CAPITAL .SAV
    school.file = "CY07_MSU_SCH_QQQ.sav", # lower case .sav
#    parent.file = "CY07_MSU_TCH_QQQ.sav", #lower case .sav
    countries = c("BGR", "BRA", "CAN", "CHL", "ESP", "EST", "FIN", "GEO", "IDN", "ITA", "LTU", "LVA", "NLD", "PER", "POL", "PRT", "QMR", "QRT", "RUS", "SRB", "SVK", "USA"),
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
        "FLFAMILY"#, # Parental involvement in matters of Financial Literacy (WLE)
        # "CURSUPP", # Current parental support for learning at home (WLE)
        # "PASCHPOL" # School policies for parental involvement (WLE)
    ),
    school = c(
        "PRIVATESCH", # School type (public, private, missing)
        "STRATIO", # Student-teacher ratio
        "EDUSHORT", # Shortage of educational material (WLE)
        "STAFFSHORT" # Shortage of educational staff (WLE)
    )
)

# How big is the data set?
dim(finlit)

# Now it's time for re-coding
library(car)

# Re-code Russian territories to RUS
finlit$CNT <- recode(finlit$CNT, "
    'QMR' = 'RUS';
    'QRT' = 'RUS'
")
# Verify:
table(unlist(finlit$CNT))

finlit$CNTRYID <- recode(finlit$CNTRYID, "
    982 = 643;
    983 = 643
")
table(unlist(finlit$CNTRYID))

# Enter countries' FKI
FKI <- recode(finlit$CNT, "
    'BRA' = 0.133;
    'BGR' = 0.579;
    'CAN' = 0.780;
    'CHL' = 0.536;
    'EST' = 0.577;
    'FIN' = 0.613;
    'GEO' = 0.413;
    'IDN' = 0.115;
    'ITA' = 0.760;
    'LVA' = 0.543;
    'LTU' = 0.607;
    'NLD' = 0.939;
    'PER' = 0.299;
    'POL' = 0.554;
    'PRT' = 0.586;
    'RUS' = 0.445;
    'SRB' = 0.419;
    'SVK' = 0.563;
    'ESP' = 0.624;
    'USA' = 0.925
")

# Enter countries' Quality of maths and science education
# FKI <- recode(finlit$CNT, "
#     'BRA' = 2.6;
#     'BGR' = 4.3;
#     'CAN' = 5.1;
#     'CHL' = 3.5;
#     'EST' = 5.1;
#     'FIN' = 6.3;
#     'GEO' = 3.4;
#     'IDN' = 4.6;
#     'ITA' = 4.5;
#     'LVA' = 4.9;
#     'LTU' = 5.1;
#     'NLD' = 5.4;
#     'PER' = 2.3;
#     'POL' = 4.4;
#     'PRT' = 4.5;
#     'RUS' = 4.3;
#     'SRB' = 4.3;
#     'SVK' = 4.0;
#     'ESP' = 3.9;
#     'USA' = 4.4
# ")

W_CNT <- recode(finlit$CNT, "
    'BRA' = 12.895;
    'BGR' = 26.076;
    'CAN' = 13.808;
    'CHL' = 23.896;
    'EST' = 25.720;
    'FIN' = 24.763;
    'GEO' = 24.803;
    'IDN' = 15.025;
    'ITA' = 11.672;
    'LVA' = 34.013;
    'LTU' = 26.294;
    'NLD' = 35.231;
    'PER' = 22.639;
    'POL' = 24.953;
    'PRT' = 23.462;
    'RUS' = 11.745;
    'SRB' = 27.665;
    'SVK' = 31.420;
    'ESP' = 11.449;
    'USA' = 28.671
")

# Recode PRIVATESCH from texts to numbers
finlit$PRIVATESCH <- recode(finlit$PRIVATESCH, "
    'public ' = 0;
    'private' = 1;
    'missing' = NA
")
finlit$PRIVATESCH <- as.numeric(finlit$PRIVATESCH) # Force "0" to 0.

# Recode ST004D01T from Sex to Male
finlit$ST004D01T <- finlit$ST004D01T - 1

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

# Stitch new variables to data frame
names(finlit) # in order to know where to insert

finlit_1 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(87, 97, 107)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])
finlit_2 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(88, 98, 108)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])
finlit_3 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(89, 99, 109)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])
finlit_4 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(90, 100, 110)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])
finlit_5 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(91, 101, 111)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])
finlit_6 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(92, 102, 112)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])
finlit_7 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(93, 103, 113)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])
finlit_8 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(94, 104, 114)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])
finlit_9 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(95, 105, 115)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])
finlit_10 <- cbind(W_CNT, FKI, finlit[, c(2:6)], finlit[, c(96, 106, 116)], finlit[, 117], IMMI1GEN, IMMI2GEN, finlit[, c(119:133)])

# This is where the imputation files are to be written to
setwdOS(
    lin = "~/uio/", win = "M:\\",
    ext = "pc/Dokumenter/MSc/Thesis/Data/Mplus/"
)

# End-of-line encoding
# \r = CR (Mac); \n = LF (Unix); \r\n = CRLF (Windows)

f <- file("finlit_1.dat", open="wb")
write.table(finlit_1,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_2.dat", open="wb")
write.table(finlit_2,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_3.dat", open="wb")
write.table(finlit_3,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_4.dat", open="wb")
write.table(finlit_4,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_5.dat", open="wb")
write.table(finlit_5,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_6.dat", open="wb")
write.table(finlit_6,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_7.dat", open="wb")
write.table(finlit_7,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_8.dat", open="wb")
write.table(finlit_8,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_9.dat", open="wb")
write.table(finlit_9,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_10.dat", open="wb")
write.table(finlit_10,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

# Export data frame to Mplus-ready format
f <- file("finlit.dat", open="wb")
write.table(finlit,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)
