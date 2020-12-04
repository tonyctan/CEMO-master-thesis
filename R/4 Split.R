library(Orcs)
setwdOS(lin = "~/", win = "C:/Users/Tony/")

# Import CSV
library(data.table); setDTthreads(0)
finlit <- fread("finlit.csv", header = T)

# Show column position
names(finlit)

# Split dataset into 10. One PV each.
finlit1 <- finlit[, c(c(1:5), 6, 16, 26, c(36:52))]
finlit2 <- finlit[, c(c(1:5), 7, 17, 27, c(36:52))]
finlit3 <- finlit[, c(c(1:5), 8, 18, 28, c(36:52))]
finlit4 <- finlit[, c(c(1:5), 9, 19, 29, c(36:52))]
finlit5 <- finlit[, c(c(1:5), 10, 20, 30, c(36:52))]
finlit6 <- finlit[, c(c(1:5), 11, 21, 31, c(36:52))]
finlit7 <- finlit[, c(c(1:5), 12, 22, 32, c(36:52))]
finlit8 <- finlit[, c(c(1:5), 13, 23, 33, c(36:52))]
finlit9 <- finlit[, c(c(1:5), 14, 24, 34, c(36:52))]
finlit10 <- finlit[, c(c(1:5), 15, 25, 35, c(36:52))]

# Use the correct end-of-line marker depending on the operating system
switch(Sys.info()[["sysname"]],
    Linux = {EOL = "\r\n"},
    Windows = {EOL = "\n"}
)

write.table(finlit1, "finlit1.dat",
    row.names = F, col.names = F, sep= ",", na = "-99", eol = EOL
)

write.table(finlit2, "finlit2.dat",
    row.names = F, col.names = F, sep= ",", na = "-99", eol = EOL
)

write.table(finlit3, "finlit3.dat",
    row.names = F, col.names = F, sep= ",", na = "-99", eol = EOL
)

write.table(finlit4, "finlit4.dat",
    row.names = F, col.names = F, sep= ",", na = "-99", eol = EOL
)

write.table(finlit5, "finlit5.dat",
    row.names = F, col.names = F, sep= ",", na = "-99", eol = EOL
)

write.table(finlit6, "finlit6.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)

write.table(finlit7, "finlit7.dat",
    row.names = F, col.names = F, sep= ",", na = "-99", eol = EOL
)

write.table(finlit8, "finlit8.dat",
    row.names = F, col.names = F, sep= ",", na = "-99", eol = EOL
)

write.table(finlit9, "finlit9.dat",
    row.names = F, col.names = F, sep= ",", na = "-99", eol = EOL
)

write.table(finlit10, "finlit10.dat",
    row.names = F, col.names = F, sep = ",", na = "-99", eol = EOL
)
