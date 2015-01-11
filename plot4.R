##################################################
#plot4.R
# read in the data file, and create plot4

#read the data
mainData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", ""))

# combine the date and time for plotting
#mainData$DateTime <- as.POSIXct(paste(mainData$Date, mainData$Time), format="%d/%m/%Y %H:%M:%S")
mainData$DateTime <- paste(mainData$Date, mainData$Time)
mainData$DateTime <- strptime(mainData$DateTime, format = "%d/%m/%Y %H:%M:%S")


#convert the date for filtering
mainData$Date <- as.Date(mainData$Date, "%d/%m/%Y")

#filter the data
filteredData <- mainData[mainData$Date == as.Date("1/2/2007", "%d/%m/%Y") | mainData$Date == as.Date("2/2/2007", "%d/%m/%Y"),]

#convert the column to numeric for plotting purposes
filteredData$Global_active_power <- as.numeric(filteredData$Global_active_power)
 
#set up the plotting grid
par(mfrow = c(2,2))

#plot the data
with(filteredData, {
  #first plot, global active power
  plot(DateTime, Global_active_power, type = "l", bg="white", ylab="Global Active Power (kilowats)", xlab = "")
  
  #second plot, voltage
  plot(DateTime, Voltage, type = "l", bg="white", ylab="Voltage", xlab = "datetime")
  
  #third plot, sub metering
  plot(DateTime, Sub_metering_1,type="l", col = "black", ylab="Energy sub metering", xlab= "", bg = "white")
  lines(DateTime, Sub_metering_2, col="red", ylab="Energy sub metering", xlab = "")
  lines(DateTime, Sub_metering_3, col="blue", ylab="Energy sub metering", xlab = "")
  legend("topright", lty = 1, cex = 0.5, bg = "transparent", box.col = "transparent", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  #forth plot global reactive power
  plot(DateTime, Global_reactive_power, type = "l", bg="white", ylab="Global_reactive_power", xlab = "datetime")
  
  dev.copy(png, filename = "plot4.png", units = "px", width = 480, height = 480, pointsize = 12)
  dev.off()
  
})

