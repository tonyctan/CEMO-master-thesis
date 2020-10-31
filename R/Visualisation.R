# Housekeeping
library(Orcs)
setwdOS(lin = "~/", win = "C:/Users/Tony/")

# WARNING: Do NOT use read.csv() because it's too slow and kills RAM
library(data.table); setDTthreads(4)
# Linux
FL <- fread("~/FL.csv", nThread=4); attach(FL)
# Windows (UiO)
FL <- fread("C:\\Users\\tctan\\FL.csv", nThread=4); attach(FL)
# Windows (ThinkPad)
FL <- fread("D:\\M Drive\\Thesis\\Data\\FL.csv")
# WAIT for the progress bar to finish


# Inspect the distribution of the 10 FLIT PVs
#par(mfrow=c(2,5))
#hist(PV1FLIT); hist(PV2FLIT); hist(PV3FLIT); hist(PV4FLIT); hist(PV5FLIT); hist(PV6FLIT); hist(PV7FLIT); hist(PV8FLIT); hist(PV9FLIT); hist(PV10FLIT)
#par(mfrow=c(1,1))


library(dplyr)
# Construct a detection device to see which countries participated in ICT
#detection <- data.frame(country=factor(CNT), variable=IC001Q01TA)
# Count the number of missings in each country
#missings <- detection %>%
#    filter(is.na(variable)) %>%
#    count(country)
# Count the number of participants in each country
#obs <- detection %>%
#    group_by(country) %>%
#    summarize(n())
#Country <- data.frame(missings)[,1]
#Missing <- data.frame(missings)[,2]/data.frame(obs)[,2]*100
#tibble(Country, Missing)


# Count the column position of PV1FLIT to PV10FLIT
#names(FL)
# Extract the 10 PVs
PV <- cbind(FL[,c(1163:1172)])
# Compute average PV
PV.mean <- rowSums(PV)/10


slow <- data.frame(country=factor(CNT), finlit=ST021Q01TA, sex=factor(ST004D01T-1, labels=c("Girl", "Boy")))
dim(slow); dim(FL)

missings <- slow %>%
    filter(is.na(sex)) %>%
    count(country)
missings # So, two NAs in Canada

# Since NAs are going to mess up my plots, and there are only a tiny amount missing, I am just going to remove them.
quick <- na.omit(data.frame(country=factor(CNT), finlit=PV.mean, sex=factor(ST004D01T-1, labels=c("Girl", "Boy"))))
dim(quick); dim(FL)

# Extract group sizes by country x sex
size.group <- quick %>%
    group_by(country, sex) %>%
    summarize(n())
print(size.group, n=40)
# Compute total size
size.total <- colSums(size.group[,3])
# Compute total boys and total girls
dummy.girl <- rep(c(1,0),20)
dummy.boy <- rep(c(0,1),20)
size.girl <- colSums(size.group[,3]*dummy.girl)
size.boy <- colSums(size.group[,3]*dummy.boy)
# Coerce a list to numeric
size.girl <- as.numeric(unlist(size.girl)) # 53396
size.boy <- as.numeric(unlist(size.boy)) # 53376
size.both <- rep(c(size.girl,size.boy),20)

# Compute relative group size by country x sex
size.relative <- as.numeric(unlist(size.group[,3]))/size.both
# To verify total sums to 2 (because you counted girls once and boys once, so double counting)
sum(size.relative)

# Generate an unordered "transparency indices"
size.stand <- (size.relative-min(size.relative))/(max(size.relative) - min(size.relative))
alpha.unordered <- tibble(paste0(size.group$country,size.group$sex), size.stand)
colnames(alpha.unordered) <- c("tag", "alpha")

# Extract the ordered country list
country.ordered <- reorder(quick$country, -quick$finlit, FUN=mean)[1] # Does not have to be [1]. Any individual will do. I just want the country list down the bottom.
country.ordered <- row.names(data.frame(summary(country.ordered)))
country.ordered <- rep(country.ordered, each=2) # 2 because there are two sexes
suffix <- rep(c("Girl", "Boy"), times = 20)
country.ordered <- paste0(country.ordered, suffix); rm(suffix)

# Re-order alpha.unordered to alpha.ordered (I call it [transparency])
alpha.ordered <- alpha.unordered[match(country.ordered, alpha.unordered$tag) , ]
transparency <- data.frame(alpha.ordered)[ , 2]

## Kernel density plot by country
# Calculate the group mean
#mu <- ddply(quick, "country", summarise, grp.mean=mean(finlit))
library(ggplot2)
#ggplot(quick, aes(x=finlit, color=country)) +
#    geom_density() +
#    geom_vline(data=mu, aes(xintercept=grp.mean, color=country), linetype="dashed")

pdf("../Figures/distribution.pdf", width=10, height=15)
par(xpd = NA)
ggplot(quick, aes(x=reorder(country, -finlit, FUN=mean), y=finlit, fill=sex)) + 
    geom_boxplot(alpha=transparency) +
#    facet_wrap(~country, scale="free")
#    facet_wrap(~sex)
#    ggtitle("Distribution of PISA 2018 Financial Literacy") +
#    theme(plot.title = element_text(hjust = 0.5)) + # Centring the main title
    labs(x= "Country", y="Financial Literacy", fill="Sex") +
#    labs(x= "Country", y="Financial Literacy", title="PISA 2018 Financial Literacy", subtitle="Segregated by country and by sex", caption="(The smaller the sample size, the lighter, more transparent, the box plot is.)", fill="Sex") +
#    theme(legend.position = c(0.96, 0.96), legend.background=element_rect(fill="transparent",size=0.5,linetype="solid",colour="transparent")) +
    theme_classic()
dev.off()

### Maps
# Break down FL by country*sex and by country
finlit.mean_country.sex <- quick %>%
    group_by(country, sex) %>%
    summarize(mean.finlit=mean(finlit))
finlit.mean_country <- quick %>%
    group_by(country) %>%
    summarize(mean.finlit=mean(finlit))
print(finlit.mean_country.sex, n=40)
print(finlit.mean_country, n=20)
# Save these numbers into the "standard map spreadsheet"

# Mark the 25%, 50% and 75% cut-off points so that each map contains four categories and the legends clearly mark the minimum, 25%, mean, 75% and maximum.
summary(finlit.mean_country)[,2][c(1,2,4,5,6)]
tapply(finlit.mean_country.sex$mean.finlit, finlit.mean_country.sex$sex, summary)

# Read in the "standard map spreadsheet"
map <- read.csv("FLIT.csv", sep=",", header=T)

# Load high resolution world map
library(rworldmap)
world <- getMap(resolution="high")

# Combine science inquiry data with world map data
finlit.map <- cbind(world,map[,c(2:4)])

# Turn on tmap
library(tmap)

pdf("../Figures/map.pdf", width=10, height=14)
par(xpd = NA)
tm_shape(finlit.map) +
tm_polygons(
    c("FLIT", "FLIT.girl", "FLIT.boy"),
    style="fixed",
    breaks=list(c(404.5,441.7,481.4,507.2,557.3), c(408.6,446.7,481.9,506.6,558.5), c(398.6,436.9,481.0,507.9,556.2)),
    palette=list("Greens", "Reds", "Blues"),
    title=c("Financial Literacy", "Financial Literacy (Girls)", "Financial Literacy (Boys)"),
    textNA="No data",
    colorNA="white",
    legend.hist=T
    ) +
tm_legend(
    text.size=1,
    title.size=1.2,
    position=c("left","bottom"),
    bg.color="white", # get rid of the box around the legend
    bg.alpha=0.2,
    frame=F,
    height=0.6,
    hist.width=0.2,
    hist.height=0.2,
    hist.bg.color="gray60",
    hist.bg.alpha=0.5
    ) +
tm_layout(frame=F)
dev.off()



