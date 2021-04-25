# Import science inquiry data
library(Orcs)
setwdOS(lin = "~/uio/", win = "M:/", ext = "pc/Dokumenter/MSc/Thesis/Model building/Shiny/")
flit <- read.csv("flit.csv", sep = ",", header = T)

# # Install these packages to enable map-making if not yet done so
# install.packages(c("rgeos", "tmap", "rworldmap", "rworldxtra"))

# Load high resolution world map
library(rworldmap)
world <- getMap(resolution = "high") # Need package rworldxtra installed

# Combine financial literacy data with world map data
dim(flit)
flit <- cbind(world, flit[, c(2:36)])

# Turn on tmap
library(tmap)

# Turn back to plot mode
tmap_mode("plot")

# Short-cut to generate a map. DO NOT USE THESE.
# qtm(inquiry.learning, fill="Multi", style="white")
# tm_shape(inquiry.learning) + tm_polygons("Single")

# "Proper" way to generate a map
pdf("FLSCHOOL.pdf", paper = "a4r")
tm_shape(flit) +
    tm_polygons(
        "FLSCHOOL_total",
        style = "fixed",
        breaks = c(-0.20, -0.10, 0, 0.10, 0.20),
        midpoint = NA,
        # palette=list(c("mediumblue","darkorange","gray70","gold"), c("mediumblue","darkorange","gray70","gold","deepskyblue","forestgreen")),
        palette = "RdBu",
        title = c("FLSCHOOL"),
        textNA = "No data",
        colorNA = "gray95",
        legend.hist = T
    ) +
    tm_legend(
        text.size = 1,
        title.size = 1.2,
        position = c("left", "bottom"),
        bg.color = "white", # get rid of the box around the legend
        bg.alpha = 0.2,
        frame = F,
        height = 0.6,
        hist.width = 0.2,
        hist.height = 0.2,
        hist.bg.color = "gray60",
        hist.bg.alpha = 0.5
    )
dev.off()

# Turn on interactive view mode
tmap_mode("view")

tm_shape(flit) +
tm_polygons(
        "FLSCHOOL_total",
        style = "fixed",
        breaks = c(-0.20, -0.10, 0, 0.10, 0.20),
        midpoint = NA,
        # palette=list(c("mediumblue","darkorange","gray70","gold"), c("mediumblue","darkorange","gray70","gold","deepskyblue","forestgreen")),
        palette = "RdBu",
        title = c("FLSCHOOL"),
        textNA = "No data",
        colorNA = "gray95",
        legend.hist = T
) +
tm_legend(
    text.size = 1,
    title.size = 1.2,
    position = c("left", "bottom"),
    bg.color = "white", # get rid of the box around the legend
    bg.alpha = 0.2,
    frame = F,
    height = 0.6,
    hist.width = 0.2,
    hist.height = 0.2,
    hist.bg.color = "gray60",
    hist.bg.alpha = 0.5
) +
tm_view(
    set.view = c(10.7522, 59.9139, 2),
    view.legend.position = c("left", "bottom")
)
