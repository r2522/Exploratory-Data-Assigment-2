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

#3 Question 2
Baltimore <- subset(NEI, fips == "24510")
EmissBalt <- tapply(Baltimore$Emissions, Baltimore$year, sum)
barplot(EmissBalt, col = rainbow(5, start = 0, end = 1), xlab = "Year", ylab = "Emissions (Tons)", main = "Yearly Emissions (Tons) in Baltimore Maryland")
## Save file and close device
dev.copy(png,"Plot2.png", width=480, height=480)
dev.off()
