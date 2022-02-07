
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimoresubset <- NEI[grep("^24510", NEI$fips),]
SCC_vehicle <- SCC[grep("[Vv][Ee][Hh][Ii][Cc][Ll][Ee][Ss]", SCC$EI.Sector), "SCC"]

library(dplyr)
Baltimore_vehicle <- Baltimoresubset %>% filter(SCC %in% SCC_vehicle)

Baltimore_vehicle <- aggregate(Emissions~year, Baltimore_vehicle, FUN = sum )

years <- factor(Baltimore_vehicle$year)

gg_plot <- ggplot(Baltimore_vehicle, aes(factor(year), Emissions, fill=years))+
          geom_bar(stat = "identity")+ xlab("Year")+
          ylab("PM2.5 Emissions")+
          geom_label(aes(label=round(Emissions,2)),colour="white", fontface = "bold")+
          theme(plot.title = element_text(hjust = 0.5))+
          ggtitle("Baltimore_City Vehicle Emissions from 1999 to 2008")
gg_plot

dev.copy(png, width=540, height=540, units="px", file="plot5.png")
dev.off()
