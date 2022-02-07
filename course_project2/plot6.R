NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

counties <- data.frame(fips=c("24510", "06037"))
SCC_vehicle <- SCC[grep("[Vv][Ee][Hh][Ii][Cc][Ll][Ee][Ss]",SCC$EI.Sector),"SCC"]
counties_NEI <-NEI[NEI$SCC%in%SCC_vehicle & NEI$fips %in% counties$fips, ]


Baltimore_NEI <- counties_NEI[counties_NEI$fips=="24510",]
Baltimore_NEI$city <- "Baltimore City"
LosAngeles_NEI <- counties_NEI[counties_NEI$fips=="06037",]
LosAngeles_NEI$city <-"Los Angeles"
library(dplyr)
library(ggplot2)
#Both_Ne <- rbind(Baltimore_NEI, LosAngeles_NEI) %>% group_by(city,year)
#Both_Ne <- aggregate(Emissions~year+city, Both_N, FUN=sum)

Both_NEI <- rbind(Baltimore_NEI, LosAngeles_NEI) %>% group_by(city,year)%>% 
  summarise(Emissions=sum(Emissions))
years <-factor(Both_NEI$year)
gg_plot <- ggplot(Both_NEI, aes(factor(year), Emissions, fill=years )) +
           geom_bar(stat = "identity")+
           facet_grid(.~city)+
           xlab("Year")+
           ylab("PM2.5 Emissions")+
           theme_bw()+
           ggtitle(" Comparing Baltimore City and Los Angeles County PM2.5 Vehicle Emissions from 1999 to 2008")+
           theme(plot.title = element_text(hjust = 0.5))+
           geom_label(aes(label=round(Emissions,2)), colour="white", fontface="bold")
gg_plot
dev.copy(png, width=750, height=550, units="px", file="plot6.png")
dev.off()
