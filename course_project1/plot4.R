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
globalactivepower <-as.numeric(data_main$Global_active_power)
voltage <- as.numeric(data_main$Voltage)
submetering1 <- as.numeric(data_main$Sub_metering_1)
submetering2 <- as.numeric(data_main$Sub_metering_2)
submetering3 <- as.numeric(data_main$Sub_metering_3)
globalreactivepower <- as.numeric(data_main$Global_reactive_power)

par(mfrow=c(2,2))

plot(DateTime, globalactivepower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(DateTime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(DateTime, submetering1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(DateTime, submetering2, type = "l", col = "red")
lines(DateTime, submetering3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n", cex = 0.2)

plot(DateTime, globalreactivepower, type = "l", xlab = "date", ylab = "Global_reactive_power")
dev.copy(png, width=480, height=480, file="plot4.png")
dev.off()
