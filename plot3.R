##################################################
#plot3.R
# read in the data file, and create plot3

#read the data
mainData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", ""))

# combine the date and time for plotting
#mainData$DateTime <- as.POSIXct(paste(mainData$Date, mainData$Time), format="%d/%m/%Y %H:%M:%S")
mainData$DateTime <- paste(mainData$Date, mainData$Time)
mainData$DateTime <- strptime(mainData$DateTime, format = "%d/%m/%Y %H:%M:%S")

#filter the date range from Feb 1st 2007 to Feb 2nd 2007
filteredData <- subset(mainData, mainData$DateTime > ("2007-02-01 00:00:00") & mainData$DateTime < ("2007-02-03 00:00:00") )

#generate the plot
plot(filteredData$DateTime, filteredData$Sub_metering_1,type="l", col = "black", bg = "white", ylab="Energy sub metering", xlab= "")
lines(filteredData$DateTime, filteredData$Sub_metering_2,type="l", col = "red", bg = "white", ylab="Energy sub metering", xlab="")
lines(filteredData$DateTime, filteredData$Sub_metering_3,type="l", col = "blue", bg = "white", ylab="Energy sub metering", xlab= "")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

#save plot
dev.copy(png, filename = "plot3.png", width = 480, height = 480, units = "px")
dev.off()

