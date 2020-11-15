library(Orcs)
setwdOS(lin = "~/", win = "C:/Users/Tony/")

library(data.table); setDTthreads(0)
finlit <- fread("finlit.csv", nThread = getDTthreads())

library(dplyr)
# Record how many missings each country has for each var
missings <- finlit %>%
    select(everything()) %>%
    group_by(CNT) %>% 
    summarise_all(funs(sum(is.na(.))))
# Give me the headcount for each country
headcount <- finlit %>%
    group_by(CNT) %>%
    summarize(n())
# Stitch these two tables together
missing_table <- tibble(headcount, missings[, -1])
# Save this file
fwrite(missing_table,"missing_table.csv", row.names = F, col.names = T)

# Inspect the missing table using Excel
# Throw away the following countries
#   CAN: 100% missing on too many var
#   BRA, FIN, LVA, NLD, RUS, SRB: private/public info missing
# Throw away these var
#   DISCRIM, CURSUPP, PASCHPOL: Too many countries have 100% missing
