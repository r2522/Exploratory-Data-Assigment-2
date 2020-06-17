# 1 Loading the data:
setwd("~/Desktop/Coursera")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
File <- "./FNEI_data.zip"
if (!file.exists(File)) {
  download.file(URL, File, method = "curl")
  unzip(File, overwrite = T, exdir = "./")
}

# 2 Load the data:
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#3 Question 4
library(ggplot2)
SCCcoal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T),]
NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC,]
TotalCoal <- aggregate(Emissions ~ year + type, NEIcoal, sum)

ggplot(TotalCoal, aes(year, Emissions, col = type)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Coal Emission by Type and Year")) +
  xlab("Year") +
  ylab(expression("US " ~ PM[2.5] ~ "Coal Emission")) +
  scale_colour_discrete(name = "Type of sources") +
  theme(legend.title = element_text(face = "bold"))

## Save file and close device
dev.copy(png,"Plot4.png", width=480, height=480)
dev.off()

