library(Orcs)
setwdOS(lin = "~/", win = Sys.getenv("USERPROFILE"))

# Import PV1 file
library(data.table); setDTthreads(0)
finlit1 <- fread("finlit1.dat", header = F)

# Split PV1 by country
finlit1_CNT <- split(finlit1, finlit1[, 2])


finlit1_76 <- finlit1_CNT$"76"
finlit1_100 <- finlit1_CNT$"100"
finlit1_124 <- finlit1_CNT$"124"
finlit1_152 <- finlit1_CNT$"152"
finlit1_233 <- finlit1_CNT$"233"
finlit1_246 <- finlit1_CNT$"246"
finlit1_268 <- finlit1_CNT$"268"
finlit1_360 <- finlit1_CNT$"360"
finlit1_380 <- finlit1_CNT$"380"
finlit1_428 <- finlit1_CNT$"428"
finlit1_440 <- finlit1_CNT$"440"
finlit1_528 <- finlit1_CNT$"528"
finlit1_604 <- finlit1_CNT$"604"
finlit1_616 <- finlit1_CNT$"616"
finlit1_620 <- finlit1_CNT$"620"
finlit1_643 <- finlit1_CNT$"643"
finlit1_688 <- finlit1_CNT$"688"
finlit1_703 <- finlit1_CNT$"703"
finlit1_724 <- finlit1_CNT$"724"
finlit1_840 <- finlit1_CNT$"840"


# Use the correct end-of-line marker depending on the operating system
switch(Sys.info()[["sysname"]],
    Linux = {EOL = "\r\n"},
    Windows = {EOL = "\n"}
)


# Save data to Mplus-ready format: no heading, pure numbers, EOL=CRLF
write.table(finlit1_76, "finlit1_76.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_100, "finlit1_100.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_124, "finlit1_124.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_152, "finlit1_152.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_233, "finlit1_233.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_246, "finlit1_246.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_268, "finlit1_268.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_360, "finlit1_360.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_380, "finlit1_380.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_428, "finlit1_428.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_440, "finlit1_440.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_528, "finlit1_528.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_604, "finlit1_604.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_616, "finlit1_616.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_620, "finlit1_620.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_643, "finlit1_643.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_688, "finlit1_688.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_703, "finlit1_703.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_724, "finlit1_724.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)

write.table(finlit1_840, "finlit1_840.dat",
    row.names = F, col.names = F, sep = ",", eol = EOL
)
