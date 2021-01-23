# Housekeeping
library(Orcs) # Set working directory depending on operating system
setwdOS(
    lin = "~/uio/", win = "M:/",
    ext = "pc/Dokumenter/MSc/Thesis/Mplus/M0/"
)

# Load necessary packages
library(MplusAutomation)
library(metafor)
library(ggpubr)

# Create input files
createModels("Null.txt")

# # Run the input file
# runModels(
#     target = getwd(),
#     recursive = F,
#     replaceOutfile = "never"
# )

