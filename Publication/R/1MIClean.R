library(Orcs)
setwdOS(
    lin = "~/uio/", win = "M:/",
    ext = "pc/Dokumenter/MSc/Thesis/Publication/Mplus"
)

# Save var names from Mplus .out file
pub.header <- c(
    "STRATIO",
    "EDUSHORT",
    "MALE",
    "IMMI1GEN",
    "IMMI2GEN",
    "ESCS",
    "FCFMLRTY",
    "FLCONFIN",
    "FLSCHOOL",
    "FLFAMILY",
    "NOBULLY",
    "BRA",
    "BGR",
    "CAN",
    "CHL",
    "EST",
    "FIN",
    "GEO",
    "IDN",
    "ITA",
    "LVA",
    "LTU",
    "NLD",
    "PER",
    "POL",
    "PRT",
    "RUS",
    "SRB",
    "SVK",
    "ESP",
    "USA",
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
    "CNTRYID",
    "W_STU",
    "W_SCH",
    "CNTSCHID")

# Use data.table for better RAM management
library(data.table); setDTthreads(0) # 0 means all the available cores

# Call in the first imputation data set
pub1 <- fread("pub_mi_1.dat", header = F, col.names = pub.header)
pub2 <- fread("pub_mi_2.dat", header = F, col.names = pub.header)
pub3 <- fread("pub_mi_3.dat", header = F, col.names = pub.header)
pub4 <- fread("pub_mi_4.dat", header = F, col.names = pub.header)
pub5 <- fread("pub_mi_5.dat", header = F, col.names = pub.header)
pub6 <- fread("pub_mi_6.dat", header = F, col.names = pub.header)
pub7 <- fread("pub_mi_7.dat", header = F, col.names = pub.header)
pub8 <- fread("pub_mi_8.dat", header = F, col.names = pub.header)
pub9 <- fread("pub_mi_9.dat", header = F, col.names = pub.header)
pub10 <- fread("pub_mi_10.dat", header = F, col.names = pub.header)


    # 12:31, # Country dummies
    # 62, # CNTRYID
    # 65, # CNTSCHID
    # 63, # W_STU
    # 52:61, # PVxFLIT
    # 3, # MALE
    # 4, # IMMI1GEN
    # 5, # IMMI2GEN
    # 6, # ESCS
    # 7, # FCFMLRTY
    # 8, # FLCONFIN
    # 9, # FLSCHOOL
    # 10, # FLFAMILY
    # 11, # NOBULLY
    # 64, # W_SCH
    # 1, # STRATIO
    # 2 # EDUSHORT

# c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)

# Re-arrange columns
pub1 <- pub1[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]
pub2 <- pub2[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]
pub3 <- pub3[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]
pub4 <- pub4[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]
pub5 <- pub5[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]
pub6 <- pub6[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]
pub7 <- pub7[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]
pub8 <- pub8[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]
pub9 <- pub9[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]
pub10 <- pub10[, c(12:31, 62, 65, 63, 52:61, 3:11, 64, 1:2)]

# Save pubx.dat to home directory
fwrite(pub1, "~/pub1.dat", row.names = F, col.names = F)
fwrite(pub2, "~/pub2.dat", row.names = F, col.names = F)
fwrite(pub3, "~/pub3.dat", row.names = F, col.names = F)
fwrite(pub4, "~/pub4.dat", row.names = F, col.names = F)
fwrite(pub5, "~/pub5.dat", row.names = F, col.names = F)
fwrite(pub6, "~/pub6.dat", row.names = F, col.names = F)
fwrite(pub7, "~/pub7.dat", row.names = F, col.names = F)
fwrite(pub8, "~/pub8.dat", row.names = F, col.names = F)
fwrite(pub9, "~/pub9.dat", row.names = F, col.names = F)
fwrite(pub10, "~/pub10.dat", row.names = F, col.names = F)