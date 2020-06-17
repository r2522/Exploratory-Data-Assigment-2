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

#3 Question 3
library(ggplot2)
library(plyr)
Baltimore <- subset(NEI, fips == "24510")
# Total all emissions in Baltimore
TypeBalt <- ddply(Baltimore, .(year, type), function(x) sum(x$Emissions))
# Rename the column which was modified by R
colnames(TypeBalt)[3] <- "emissions"
# Plot
qplot(year, emissions, data = TypeBalt, color = type, geom = "line") + ggtitle("PM2.5 Emission by Type and Year in Baltimore") + xlab("Year") + ylab("Total PM2.5 Emissions (Tons)") + theme(legend.position = c(0.9, 0.85))
## Save file and close device
dev.copy(png,"Plot3.png", width=480, height=480)
dev.off()
