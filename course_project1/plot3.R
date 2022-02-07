#save file in fileName
fileName <- file("household_power_consumption.txt") 

# read the data for 2007-02-01 and 2007-02-02
data_main <- read.table(text = grep("^[1,2]/2/2007", readLines(fileName), 
                                    value = TRUE), 
                        col.names = c("Date", "Time", "Global_active_power", 
                                      "Global_reactive_power", "Voltage", 
                                      "Global_intensity", "Sub_metering_1", 
                                      "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)
close(fileName)
DateTime <-strptime(paste(data_main$Date, data_main$Time), "%d/%m/%Y %H:%M:%S")
submetering1 <- as.numeric(data_main$Sub_metering_1)
submetering2 <- as.numeric(data_main$Sub_metering_2)
submetering3 <- as.numeric(data_main$Sub_metering_3)


plot(DateTime, submetering1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(DateTime, submetering2, type = "l", col = "red")
lines(DateTime, submetering3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, 
       lwd = 2.5, col = c("black", "red", "blue"))
dev.copy(png, width=480, height=480, file="plot3.png")
dev.off()
