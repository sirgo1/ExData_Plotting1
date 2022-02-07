#save file in fileName
fileName <- file("household_power_consumption.txt") 

# read the data for 2007-02-01 and 2007-02-02
data_main <- read.table(text = grep("^[1,2]/2/2007", readLines(fileName), 
                                    value = TRUE), 
            col.names = c("Date", "Time", "Global_active_power", 
                          "Global_reactive_power", "Voltage", 
                          "Global_intensity", "Sub_metering_1", 
                          "Sub_metering_2", "Sub_metering_3"), sep = ";",header = TRUE)
close(fileName)

DateTime <- strptime(paste(data_main$Date, data_main$Time), 
                     "%d/%m/%Y %H:%M:%S")
globalactivepower <-as.numeric(data_main$Global_active_power)

 

plot(DateTime, globalactivepower, type="l", xlab="",
     ylab="Global Active Power (kilowatts)")


dev.copy(device = png, width = 480, height = 480, file = "Plot2.png")
dev.off()
