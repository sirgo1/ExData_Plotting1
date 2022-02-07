NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
coal_SCC <- SCC[grep("[Cc][Oo][Aa][Ll]", SCC$EI.Sector), "SCC"]
coal_NEI <- NEI[NEI$SCC %in% coal_SCC,]

Coal_Combustion <- aggregate(Emissions~year, coal_NEI, FUN = sum)
years <- factor(Coal_Combustion$year)

gg_plot <- ggplot(Coal_Combustion,aes(factor(year),Emissions/1000,
                                      fill=years))+ 
  geom_bar(stat = "identity") + 
  xlab("Year") +
  ylab("PM2.5 Emissions in Kilotons")+
  geom_label(aes(label=round(Emissions/1000,2)),
             colour = "white", fontface="bold")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Coal Combustion Emissions from 1999 to 2008 in the United States")
          
gg_plot

dev.copy(png, width=540, height=480, units="px", file="plot4.png")
dev.off()
