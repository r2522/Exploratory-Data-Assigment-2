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

#3 Question 5
library(ggplot2)
BaltMot <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
BaltMotAGG <- aggregate(Emissions ~ year, BaltMot, sum)

ggplot(BaltMotAGG, aes(year, Emissions)) +
  geom_line(col = "steelblue3") +
  geom_point(col = "steelblue3") +
  ggtitle(expression("Baltimore " ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  xlab("Year") +
  ylab(expression(~PM[2.5]~ "Motor Vehicle Emissions"))

## Save file and close device
dev.copy(png,"Plot5.png", width=480, height=480)
dev.off()

