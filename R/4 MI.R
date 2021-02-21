# This file is NOT about performing multilevel multiple imputation (MMI).
# MMI should be performed in Mplus.
# This file continues with the clean up process.


# Housekeeping
library(Orcs)
setwdOS(lin = "~/uio", win = "M:/", ext = "pc/Dokumenter/MSc/Thesis/Mplus/MMI/")

# Import data
library(data.table); setDTthreads(0)
# Import imputation No.1
finlit_mmi_1 <- fread("FLIT_MMI_1.dat")
# Add header to data
# I copy-pasted this list from Mplus output file, hence the vertical layout.
names(finlit_mmi_1) <- c(
    "STRATIO",
    "EDUSHORT",
    "MALE",
    "IMMI",
    "ESCS",
    "FCFMLRTY",
    "FLCONFIN",
    "FLSCHOOL",
    "NOBULLY",
    "FLFAMILY",
    "FKI",
    "CNTRYID",
    "CNTSTUID",
    "W_STU",
    "PV1MATH",
    "PV2MATH",
    "PV3MATH",
    "PV4MATH",
    "PV5MATH",
    "PV6MATH",
    "PV7MATH",
    "PV8MATH",
    "PV9MATH",
    "PV10MATH",
    "PV1READ",
    "PV2READ",
    "PV3READ",
    "PV4READ",
    "PV5READ",
    "PV6READ",
    "PV7READ",
    "PV8READ",
    "PV9READ",
    "PV10READ",
    "PV1FLIT",
    "PV2FLIT",
    "PV3FLIT",
    "PV4FLIT",
    "PV5FLIT",
    "PV6FLIT",
    "PV7FLIT",
    "PV8FLIT",
    "PV9FLIT",
    "PV10FLIT",
    "W_SCH",
    "CNTSCHID"
)
# Inspect data
head(finlit_mmi_1); dim(finlit_mmi_1)

# Rearrange data
names(finlit_mmi_1)
fl1 <- finlit_mmi_1[, c(11:12, 46, 14, 15, 25, 35, 3:10, 45, 1:2)]
head(fl1); dim(fl1)

# Now I am happy. I can apply the same procedure to all 10 versions

finlit_mmi_2 <- fread("FLIT_MMI_2.dat")
finlit_mmi_3 <- fread("FLIT_MMI_3.dat")
finlit_mmi_4 <- fread("FLIT_MMI_4.dat")
finlit_mmi_5 <- fread("FLIT_MMI_5.dat")
finlit_mmi_6 <- fread("FLIT_MMI_6.dat")
finlit_mmi_7 <- fread("FLIT_MMI_7.dat")
finlit_mmi_8 <- fread("FLIT_MMI_8.dat")
finlit_mmi_9 <- fread("FLIT_MMI_9.dat")
finlit_mmi_10 <- fread("FLIT_MMI_10.dat")

fl2 <- finlit_mmi_2[, c(11:12, 46, 14, 16, 26, 36, 3:10, 45, 1:2)]
fl3 <- finlit_mmi_3[, c(11:12, 46, 14, 17, 27, 37, 3:10, 45, 1:2)]
fl4 <- finlit_mmi_4[, c(11:12, 46, 14, 18, 28, 38, 3:10, 45, 1:2)]
fl5 <- finlit_mmi_5[, c(11:12, 46, 14, 19, 29, 39, 3:10, 45, 1:2)]
fl6 <- finlit_mmi_6[, c(11:12, 46, 14, 20, 30, 40, 3:10, 45, 1:2)]
fl7 <- finlit_mmi_7[, c(11:12, 46, 14, 21, 31, 41, 3:10, 45, 1:2)]
fl8 <- finlit_mmi_8[, c(11:12, 46, 14, 22, 32, 42, 3:10, 45, 1:2)]
fl9 <- finlit_mmi_9[, c(11:12, 46, 14, 23, 33, 43, 3:10, 45, 1:2)]
fl10 <- finlit_mmi_10[, c(11:12, 46, 14, 24, 34, 44, 3:10, 45, 1:2)]


# Recode IMMIG to 1st and 2nd generation
library(car)

for (i in 1:10) {
    IMMI <- get(paste0("fl", i))[, 9]
    IMMI <- as.numeric(unlist(IMMI)) # Turn this column to numbers

    IMMI1GEN <- recode(IMMI, "
    1 = 0;
    2 = 0;
    3 = 1
    ")

    IMMI2GEN <- recode(IMMI, "
    1 = 0;
    2 = 1;
    3 = 0
    ")

    assign(
        paste0("finlit", i),
        cbind(
            get(paste0("fl", i))[, c(1:8)],
            IMMI1GEN, IMMI2GEN,
            get(paste0("fl", i))[, c(10:18)]
        )
    )
}

# Save these clean data sets to the Data folder
setwdOS(lin = "~/uio", win = "M:/", ext = "pc/Dokumenter/MSc/Thesis/Data/Mplus/")

# Use the correct end-of-line marker depending on the operating system
switch(Sys.info()[["sysname"]],
    Linux = {EOL = "\r\n"},
    Windows = {EOL = "\n"}
)

write.table(finlit1, "finlit1.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(finlit2,
    "finlit2.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(finlit3,
    "finlit3.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(finlit4,
    "finlit4.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(finlit5,
    "finlit5.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(finlit6,
    "finlit6.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(finlit7,
    "finlit7.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(finlit8,
    "finlit8.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(finlit9,
    "finlit9.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(finlit10,
    "finlit10.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)
