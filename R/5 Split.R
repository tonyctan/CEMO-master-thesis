library(Orcs)
setwdOS(lin = "~/", win = Sys.getenv("USERPROFILE"))

# Import CSV
library(data.table); setDTthreads(0)
finlit <- fread("finlit.csv", header = T)

# Show column position
names(finlit)

# Split dataset into 10. One PV each.
finlit1 <- finlit[, c(c(1:5), 6, 16, 26, c(36:47))]
finlit2 <- finlit[, c(c(1:5), 7, 17, 27, c(36:47))]
finlit3 <- finlit[, c(c(1:5), 8, 18, 28, c(36:47))]
finlit4 <- finlit[, c(c(1:5), 9, 19, 29, c(36:47))]
finlit5 <- finlit[, c(c(1:5), 10, 20, 30, c(36:47))]
finlit6 <- finlit[, c(c(1:5), 11, 21, 31, c(36:47))]
finlit7 <- finlit[, c(c(1:5), 12, 22, 32, c(36:47))]
finlit8 <- finlit[, c(c(1:5), 13, 23, 33, c(36:47))]
finlit9 <- finlit[, c(c(1:5), 14, 24, 34, c(36:47))]
finlit10 <- finlit[, c(c(1:5), 15, 25, 35, c(36:47))]

# Use the correct end-of-line marker depending on the operating system
switch(Sys.info()[["sysname"]],
    Linux = {EOL = "\r\n"},
    Windows = {EOL = "\n"}
)

# Save data to Mplus-ready format: no heading, pure numbers, EOL=CRLF
write.table(finlit1, "finlit1.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit2, "finlit2.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit3, "finlit3.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit4, "finlit4.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit5, "finlit5.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit6, "finlit6.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit7, "finlit7.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit8, "finlit8.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit9, "finlit9.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit10, "finlit10.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

# Split PV1 by country
finlit1_CNT <- split(finlit1, finlit[, 2])

# Try writing to external files recursively
# country_list <- read.table("country_list.csv", header = T, sep = ",")
# So far, not working

finlit_BRA <- finlit1_CNT$"76"
finlit_BGR <- finlit1_CNT$"100"
finlit_CAN <- finlit1_CNT$"124"
finlit_CHL <- finlit1_CNT$"152"
finlit_EST <- finlit1_CNT$"233"
finlit_FIN <- finlit1_CNT$"246"
finlit_GEO <- finlit1_CNT$"268"
finlit_IND <- finlit1_CNT$"360"
finlit_ITA <- finlit1_CNT$"380"
finlit_LVA <- finlit1_CNT$"428"
finlit_LTU <- finlit1_CNT$"440"
finlit_NLD <- finlit1_CNT$"528"
finlit_PER <- finlit1_CNT$"604"
finlit_POL <- finlit1_CNT$"616"
finlit_PRT <- finlit1_CNT$"620"
finlit_RUS <- finlit1_CNT$"643"
finlit_SRB <- finlit1_CNT$"688"
finlit_SVK <- finlit1_CNT$"703"
finlit_ESP <- finlit1_CNT$"724"
finlit_USA <- finlit1_CNT$"840"

# Save data to Mplus-ready format: no heading, pure numbers, EOL=CRLF
write.table(finlit_BRA, "finlit1_BRA.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_BGR, "finlit1_BGR.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_CAN, "finlit1_CAN.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_CHL, "finlit1_CHL.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_EST, "finlit1_EST.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_FIN, "finlit1_FIN.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_GEO, "finlit1_GEO.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_IND, "finlit1_IND.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_ITA, "finlit1_ITA.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_LVA, "finlit1_LVA.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_LTU, "finlit1_LTU.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_NLD, "finlit1_NLD.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_PER, "finlit1_PER.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_POL, "finlit1_POL.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_PRT, "finlit1_PRT.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_RUS, "finlit1_RUS.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_SRB, "finlit1_SRB.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_SVK, "finlit1_SVK.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_ESP, "finlit1_ESP.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit_USA, "finlit1_USA.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)
