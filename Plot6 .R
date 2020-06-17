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

#3 Question 6
library(ggplot2)
BaltLAMot <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD")
BaltLAMotAGG <- aggregate(Emissions ~ year + fips, BaltLAMot, sum)

ggplot(BaltLAMotAGG, aes(year, Emissions, col = fips)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Baltimore & Los Angeles" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  labs(x = "Year", y = expression(~PM[2.5]~ "Motor Vehicle Emissions") ) +
  scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore")) +
  theme(legend.title = element_text(face = "bold"))

## Save file and close device
dev.copy(png,"Plot6.png", width=480, height=480)
dev.off()















