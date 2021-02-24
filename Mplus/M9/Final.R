# Housekeeping
library(Orcs) # Set working directory depending on operating system
setwdOS(
    lin = "~/uio/", win = "M:/",
    ext = "pc/Dokumenter/MSc/Thesis/Mplus/M9/"
)

# Load necessary packages
library(MplusAutomation)
library(metafor)
library(ggpubr)

# Create input files
createModels("Final.txt")

# # Run the input file
# runModels(
#     target = getwd(),
#     recursive = F,
#     replaceOutfile = "never"
# )

