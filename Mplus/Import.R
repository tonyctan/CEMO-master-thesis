# This is where SPSS files are to be read from (local!)
library(Orcs)
setwdOS(lin = "~/", win = "C:\\Users\\Tony\\")

library(data.table)
setDTthreads(0)
finlit <- fread("finlit.csv", nThread = getDTthreads())

library(car)
# Enter countries' FKI
FKI <- recode(finlit$CNT, "
    'BRA' = 0.131;
    'CHL' = 0.589;
    'EST' = 0.576;
    'GEO' = 0.369;
    'IDN' = 0.104;
    'ITA' = 0.810;
    'LTU' = 0.609;
    'PER' = 0.289;
    'POL' = 0.546;
    'PRT' = 0.606;
    'SVK' = 0.552;
    'ESP' = 0.661;
    'USA' = 1.029
")

# Enter countries' Quality of maths and science education
# FKI <- recode(finlit$CNT, "
#     'BRA' = 2.6;
#     'CHL' = 3.5;
#     'EST' = 5.1;
#     'GEO' = 3.4;
#     'IDN' = 4.6;
#     'ITA' = 4.5;
#     'LTU' = 5.1;
#     'PER' = 2.3;
#     'POL' = 4.4;
#     'PRT' = 4.5;
#     'SVK' = 4.0;
#     'ESP' = 3.9;
#     'USA' = 4.4
# ")

W_CNT <- recode(finlit$CNT, "
    'BRA' = 8.637;
    'CHL' = 16.005;
    'EST' = 7.668;
    'GEO' = 16.612;
    'IDN' = 10.063;
    'ITA' = 7.818;
    'LTU' = 17.611;
    'PER' = 15.163;
    'POL' = 16.713;
    'PRT' = 15.714;
    'SVK' = 21.044;
    'ESP' = 7.668;
    'USA' = 19.203
")

# Stitch new variables to data frame
names(finlit) # in order to know where to insert

finlit_1 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(6, 16, 26)], finlit[, 36:52])
finlit_2 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(7, 17, 27)], finlit[, 36:52])
finlit_3 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(8, 18, 28)], finlit[, 36:52])
finlit_4 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(9, 19, 29)], finlit[, 36:52])
finlit_5 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(10, 20, 30)], finlit[, 36:52])
finlit_6 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(11, 21, 31)], finlit[, 36:52])
finlit_7 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(12, 22, 32)], finlit[, 36:52])
finlit_8 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(13, 23, 33)], finlit[, 36:52])
finlit_9 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(14, 24, 34)], finlit[, 36:52])
finlit_10 <- cbind(W_CNT, FKI, finlit[, c(2:5)], finlit[, c(15, 25, 35)], finlit[, 36:52])

# This is where the imputation files are to be written to
setwdOS(
    lin = "~/uio/", win = "M:\\",
    ext = "pc/Dokumenter/MSc/Thesis/Data/Mplus/"
)

# End-of-line encoding
# \r = CR (Mac); \n = LF (Unix); \r\n = CRLF (Windows)

f <- file("finlit_1.dat", open = "wb")
write.table(finlit_1,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_2.dat", open = "wb")
write.table(finlit_2,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_3.dat", open = "wb")
write.table(finlit_3,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_4.dat", open = "wb")
write.table(finlit_4,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_5.dat", open = "wb")
write.table(finlit_5,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_6.dat", open = "wb")
write.table(finlit_6,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_7.dat", open = "wb")
write.table(finlit_7,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_8.dat", open = "wb")
write.table(finlit_8,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_9.dat", open = "wb")
write.table(finlit_9,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)

f <- file("finlit_10.dat", open = "wb")
write.table(finlit_10,
    file = f,
    row.names = F, col.names = F, sep = ",", na = "-99", eol = "\r\n"
)
close(f)