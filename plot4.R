#########################################
#plot4.R
# generate the combined 2x2 plot
#

#load the data
mainData <- read.table("./household_power_consumption.txt",header = TRUE, sep = ";", na.strings = c("?", ""))

#combine date and time in a single column for graphing
mainData$DateTime <- paste(mainData$Date, mainData$Time)
mainData$DateTime <- strptime(mainData$DateTime, format = "%d/%m/%Y %H:%M:%S")

#data range: Feb 1st 2007 - Feb 2nd 2007
filteredData <- subset(mainData, mainData$DateTime < ("2007-02-03 00:00:00") & mainData$DateTime > ("2007-02-01 00:00:00"))

#convert global active power to numeric for the graph
filteredData$Global_active_power <- as.numeric(filteredData$Global_active_power)

#generate the plots

#create a 2x2 area for the 4 plots with a white bakground
par(mfrow = c(2,2), bg = "white")
with(filteredData, {
  #Global_active_power
  plot(filteredData$DateTime, filteredData$Global_active_power,type="l", bg = "white", ylab="Global Active Power (kilowatts)", xlab= "")
  
  #Voltage
  plot(filteredData$DateTime, filteredData$Voltage,type="l", bg = "white", cex= 0.5, ylab="Voltage", xlab= "datetime")
  
  #Energy sub metering multivariate plot
  plot(filteredData$DateTime, filteredData$Sub_metering_1,type="l", col = "black", bg = "white", ylab="Energy sub metering", xlab= "")
  lines(filteredData$DateTime, filteredData$Sub_metering_2,type="l", col = "red", bg = "white", ylab="Energy sub metering", xlab= "")
  lines(filteredData$DateTime, filteredData$Sub_metering_3,type="l", col = "blue", bg = "white", ylab="Energy sub metering", xlab= "")
  legend("topright", lty = 1,  bg = "transparent", cex = 0.8, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))
  
  #Global reactive power
  plot(filteredData$DateTime, filteredData$Global_reactive_power,type="l", ylab="Global_reactive_power", xlab= "datetime", bg = "white")
  
  #save the graph and close the device
  dev.copy(png, filename = "plot4.png", width = 480, height = 480, units = "px")
  dev.off()
})
