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
    "MALE",
    "IMMI1GEN",
    "IMMI2GEN",
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
    "W_SCH",
    "CNTSCHID"
)
# Inspect data
head(finlit_mmi_1); dim(finlit_mmi_1)

# Rearrange data to this order
#    FKI CNTRYID CNTSCHID W_STU          ! Admin variables
#    MATH READ FLIT                      ! PISA achievement variables
#    MALE IMMI1GEN IMMI2GEN ESCS         ! Demographic info
#    FCFMLRTY FLCONFIN                   ! Affect
#    FLSCHOOL                            !   Lat var "Academic"
#    NOBULLY                             !   Lat var "Safety"
#    FLFAMILY                            !   Lat var "Community"
#    W_SCH STRATIO                       ! School character
#    EDUSHORT                            !   Lat var "inst. env."
names(finlit_mmi_1)
fl1 <- finlit_mmi_1[, c(42:43, 47, 45, 3, 13, 23, 33:41, 46, 1:2)]
head(fl1); dim(fl1)

# Now I am happy. I can apply the same procedure to all 10 versions

finlit_mmi_2 <- fread("FLIT_MMI_2.dat")
names(finlit_mmi_2) <- names(finlit_mmi_1) # Give version 2 a heading
finlit_mmi_3 <- fread("FLIT_MMI_3.dat")
finlit_mmi_4 <- fread("FLIT_MMI_4.dat")
finlit_mmi_5 <- fread("FLIT_MMI_5.dat")
finlit_mmi_6 <- fread("FLIT_MMI_6.dat")
finlit_mmi_7 <- fread("FLIT_MMI_7.dat")
finlit_mmi_8 <- fread("FLIT_MMI_8.dat")
finlit_mmi_9 <- fread("FLIT_MMI_9.dat")
finlit_mmi_10 <- fread("FLIT_MMI_10.dat")
names(finlit_mmi_10) <- names(finlit_mmi_1) # Give version 10 a heading

fl2 <- finlit_mmi_2[, c(42:43, 47, 45, 4, 14, 24, 33:41, 46, 1:2)]
fl3 <- finlit_mmi_3[, c(42:43, 47, 45, 5, 15, 25, 33:41, 46, 1:2)]
fl4 <- finlit_mmi_4[, c(42:43, 47, 45, 6, 16, 26, 33:41, 46, 1:2)]
fl5 <- finlit_mmi_5[, c(42:43, 47, 45, 7, 17, 27, 33:41, 46, 1:2)]
fl6 <- finlit_mmi_6[, c(42:43, 47, 45, 8, 18, 28, 33:41, 46, 1:2)]
fl7 <- finlit_mmi_7[, c(42:43, 47, 45, 9, 19, 29, 33:41, 46, 1:2)]
fl8 <- finlit_mmi_8[, c(42:43, 47, 45, 10, 20, 30, 33:41, 46, 1:2)]
fl9 <- finlit_mmi_9[, c(42:43, 47, 45, 11, 21, 31, 33:41, 46, 1:2)]
fl10 <- finlit_mmi_10[, c(42:43, 47, 45, 12, 22, 32, 33:41, 46, 1:2)]

head(fl2); head(fl10) # Inspect version 2 and 10 to make sure they make sense

# Save these clean data sets to the Data folder
setwdOS(lin = "~/uio", win = "M:/", ext = "pc/Dokumenter/MSc/Thesis/Data/Mplus/")

# Use the correct end-of-line marker depending on the operating system
switch(Sys.info()[["sysname"]],
    Linux = {EOL = "\r\n"},
    Windows = {EOL = "\n"}
)

write.table(fl1, "finlit1.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(fl2,
    "finlit2.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(fl3,
    "finlit3.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(fl4,
    "finlit4.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(fl5,
    "finlit5.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(fl6,
    "finlit6.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(fl7,
    "finlit7.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(fl8,
    "finlit8.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(fl9,
    "finlit9.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)

write.table(fl10,
    "finlit10.dat",
    row.names = F, col.names = F,
    sep= ",", eol = EOL
)
