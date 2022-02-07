## This code assumes both files are in your current working directories!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

class(NEI$fips)

Baltimoresubset <- NEI[grep("^24510", NEI$fips),]
Baltimore_City <- aggregate(Emissions~year, Baltimore_City, FUN = sum)

with(Baltimore_City, 
     barplot(Emissions~year, col=c(1,3,4,7), xlab = "Year", ylab = "PM2.5 Emission",
             main="Total PM2.5 Emissions in Baltimore City from 1999 to 2008", 
             cex.main=1.5))
dev.copy(png, width=960, height=480, units="px", file="plot2.png")
dev.off()
