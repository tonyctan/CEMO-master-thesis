# Housekeeping
library(Orcs)
setwdOS(lin = "~/", win = "C:/Users/Tony/")

# Import CSV
library(data.table); setDTthreads(0)
finlit <- fread("finlit.csv", header = T)

# Create a MI method list
meth <- c(
    "", "", "", "", "", "",
    "", "", "", "", "", "",
    "", "", "", "", "", "",
    "", "", "", "", "", "",
    "", "", "", "", "", "",
    "", "", "", "", "", "",
    "logreg", "logreg", "pmm", "pmm", "pmm", "pmm",
    "pmm", "pmm", "pmm", "pmm", "pmm", "",
    "", "pmm", "pmm", "pmm"
)


# Multiple imputation using MICE
library(micemd) # Use micemd instead of mice for multi-core processing
mi.finlit <- mice.par(finlit, method = meth, m = 10, maxit = 10, seed = 1234)
summary(mi.finlit)

# Save MI results to the home directory
library(miceadds)
write.mice.imputation(mi.finlit, name="finlit")

# Clean up imputation data sets
setwdOS(lin = "~/", win = "C:/Users/Tony/", ext = "finlit")

imp1 <- fread("finlit__IMPDATA1.dat")
imp1 <- imp1[, c(1:5, 6, 16, 26, 36:52)]
write.table(imp1,
    "../finlit1.dat",
    row.names = F, col.names = F,
    sep= ",", eol = "\n" # Linux "\r\n"; Windows "\n"
)

imp2 <- fread("finlit__IMPDATA2.dat")
imp2 <- imp2[, c(1:5, 7, 17, 27, 36:52)]
write.table(imp1,
    "../finlit2.dat",
    row.names = F, col.names = F,
    sep= ",", eol = "\n"
)

imp3 <- fread("finlit__IMPDATA3.dat")
imp3 <- imp3[, c(1:5, 8, 18, 28, 36:52)]
write.table(imp1,
    "../finlit3.dat",
    row.names = F, col.names = F,
    sep= ",", eol = "\n"
)

imp4 <- fread("finlit__IMPDATA4.dat")
imp4 <- imp4[, c(1:5, 9, 19, 29, 36:52)]
write.table(imp1,
    "../finlit4.dat",
    row.names = F, col.names = F,
    sep= ",", eol = "\n"
)

imp5 <- fread("finlit__IMPDATA5.dat")
imp5 <- imp5[, c(1:5, 10, 20, 30, 36:52)]
write.table(imp1,
    "../finlit5.dat",
    row.names = F, col.names = F,
    sep= ",", eol = "\n"
)

imp6 <- fread("finlit__IMPDATA6.dat")
imp6 <- imp6[, c(1:5, 11, 21, 31, 36:52)]
write.table(imp1,
    "../finlit6.dat",
    row.names = F, col.names = F,
    sep= ",", eol = "\n"
)

imp7 <- fread("finlit__IMPDATA7.dat")
imp7 <- imp7[, c(1:5, 12, 22, 32, 36:52)]
write.table(imp1,
    "../finlit7.dat",
    row.names = F, col.names = F,
    sep= ",", eol = "\n"
)

imp8 <- fread("finlit__IMPDATA8.dat")
imp8 <- imp8[, c(1:5, 13, 23, 33, 36:52)]
write.table(imp1,
    "../finlit8.dat",
    row.names = F, col.names = F,
    sep= ",", eol = "\n"
)

imp9 <- fread("finlit__IMPDATA9.dat")
imp9 <- imp9[, c(1:5, 14, 24, 34, 36:52)]
write.table(imp1,
    "../finlit9.dat",
    row.names = F, col.names = F,
    sep= ",", eol = "\n"
)

imp10 <- fread("finlit__IMPDATA10.dat")
imp10 <- imp10[, c(1:5, 15, 25, 35, 36:52)]
write.table(imp1,
    "../finlit10.dat",
    row.names = F, col.names = F,
    sep = ",", eol = "\n"
)
