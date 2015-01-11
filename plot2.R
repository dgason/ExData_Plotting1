##################################################
#plot2.R
# read in the data file, and create plot2

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
 


with(filteredData,
     plot(DateTime, Global_active_power, type = "l", bg="white", ylab="Global Active Power (kilowats)", xlab = "")
     )
dev.copy(png, filename = "plot2.png", units = "px", width = 480, height = 480)
dev.off()

