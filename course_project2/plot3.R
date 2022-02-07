NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimoresubset <- NEI[grep("^24510", NEI$fips),]
B_cityEmissions <- aggregate(Emissions~year, Baltimoresubset, FUN = sum)

install.packages("ggplot2")
install.packages("colorspace")
library(ggplot2)

gg_plot <- ggplot(Baltimoresubset, aes(factor(year), Emissions, fill=type))+
  geom_bar(stat="identity") + facet_grid(.~type)+xlab("Year")+
  ylab("Emissions from four sources")+
  ggtitle("Baltimore_City PM2.5 Emissions By Four Sources")+
  theme(axis.text= element_text(size=13),plot.title = element_text(hjust =0.5, size = 25, face = "bold"))
gg_plot

dev.copy(png, width=980, height=540, units="px", file="plot3.png")
dev.off()
