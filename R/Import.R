# Housekeeping
library(Orcs)
setwdOS(lin = "~/", win = "C:/Users/Tony/")


#########################  Extract variable names  ################################

#install.packages("intsvy")     # Install intsvy package if not yet done so
library(intsvy)

## Only need to extract variable names once
#pisa.var.label(
#    student.file="CY07_MSU_FLT_QQQ.SAV",
#    name="QQQ"      # File name of the .txt output file
#)   # Close pisa.var.lable

#pisa.var.label(
#    student.file="CY07_MSU_FLT_QQQ.SAV",
#    school.file="CY07_MSU_FLT_COG.SAV",
#    name="COG"      # File name of the .txt output file
#)   # Close pisa.var.lable

#pisa.var.label(
#    student.file="CY07_MSU_FLT_QQQ.SAV",
#    parent.file="CY07_MSU_FLT_TIM.SAV",
#    name="TIM"      # File name of the .txt output file
#)   # Close pisa.var.lable

## When importing data to Excel from CSV, use "--Fixed Width--" and type "0,13"

## In Excel, use formula D4=trim(clean(A4)) and drag down, in order to delete leading and trailing white spaces.

## Copy D4 into F4 but use "text only" option to strip off the formula.


library(data.table); setDTthreads(0) # 0 means all the availabe cores

var.names <- fread("Var_lab.txt", header=T, nThread=4)
var.names <- as.character(unlist(var.names[which(var.names$Source=="QQQ_student")][ , 2]))
country <- c("BGR", "BRA", "CAN", "CHL", "ESP", "EST", "FIN", "GEO", "IDN", "ITA", "LTU", "LVA", "NLD", "PER", "POL", "PRT", "QMR", "QRT", "RUS", "SRB", "SVK", "USA")

#########################  Stitch datasets together  ################################

# Only in Windows: Double the memory allocated to R
# Turn it off in Linux
#memory.limit(size=64988)

# Import SPSS file into R
FL <- pisa.select.merge(
    student.file="CY07_MSU_FLT_QQQ.SAV",
    student=var.names,
    countries=country
)   # Close pisa2015.select.merge

# Intsvy automatically re-generate country code, plausible values, etc.
# They are identical to the original dataset. Delete the newly generated variables (those end with .1)
FL <- FL[ , -grep("\\.1$", names(FL))]

# Export data into a CSV file for faster import next time
fwrite(FL, file="FL.csv", na="NA", row.names=F, col.names=T)


# Calculate mean achievement scores using 10 plausible values
pisa.tab <- pisa2015.mean.pv(pvlabel=subject, by=c("CNT", sex), data=pisa)
# Plots
plot(na.omit(pisa.tab))

# Produce frequency tables
for(.i in 1:length(unfair)){
    print(pisa2015.table(variable=unfair[.i], by=c("CNT", sex), data=pisa))
}

# Proficiency levels
pisa2015.ben.pv(
    pvlabel=subject,
#    cutoff=c(),    # If you want different cutoff points
    by=sex,
    data=pisa
)   # Close pisa2015.ben.pv

# Regression analysis
pisa2015.reg.pv(pvlabel=subject, x=unfair, by=c("CNT", sex), data=pisa)

