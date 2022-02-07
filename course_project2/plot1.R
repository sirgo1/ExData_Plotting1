## This code assumes both files are in your current working directories!

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#sum the total emissions by year
TotalEmission <- aggregate(Emissions ~ year, NEI, FUN = sum)

#make the plot
with(TotalEmission, 
     barplot((Emissions/1000)~year, col = c(1,3,4,7), 
             xlab = "Year", ylab = "PM2.5 in Kilotons",
             main = "Total PM2.5 Emissions for all sources from 1999 to 2008"))

#save plot in plot1.png
dev.copy(png, width=480, height=480, units="px", file="plot1.png")
dev.off()
