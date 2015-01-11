##################################################
#plot1.R
# read in the data file, and create plot1

#read the data
mainData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#convert to date for filtering
mainData$Date <- as.Date(mainData$Date, "%d/%m/%Y")

#filter the data
filteredData <- mainData[mainData$Date == as.Date("1/2/2007", "%d/%m/%Y") | mainData$Date == as.Date("2/2/2007", "%d/%m/%Y"),]

#convert the column to numeric for plotting purposes
filteredData$Global_active_power <- as.numeric(filteredData$Global_active_power)
 
#create the plot as a png
hist(filteredData$Global_active_power, col = "red", bg = "white", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, filename = "plot1.png", units = "px", width = 480, height = 480)
dev.off()

