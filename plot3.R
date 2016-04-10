# Coursera Exploratory Data Analysis
# Project 4, Week 1
# Rich Morrison
# April 8, 2016
#
# Plot 3

# read data
temp <- tempfile()
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, temp)
raw_data <- read.csv(unz(temp, "household_power_consumption.txt"), 
                     header=TRUE, sep=";", na.strings="?")
unlink(temp)

# format the Date and Time variable values
raw_data$Time <- strptime(paste(raw_data$Date, raw_data$Time), 
                          "%d/%m/%Y %H:%M:%S")
raw_data$Date <- as.Date(raw_data$Time)

# subset the data to dates of interest
data <- subset(raw_data, raw_data$Date == "2007-02-01" | 
                       raw_data$Date == "2007-02-02")



# create plot
# save plot to .png file
png(filename = "plot3.png", width = 480, height = 480, units = "px")

plot(data$Time, data$Sub_metering_1, xaxt="n", xlab="",
     ylab="Energe sub metering", type="l")

lines(data$Time, data$Sub_metering_2, type="l", col="red")

lines(data$Time, data$Sub_metering_3, type="l", col="blue")

# figure out the lowest and highest days in the range of data
# label x axis with days of week in the range of date values
# add 3600 seconds * 24 hours to get the latest day
dayrange=c(as.POSIXlt(min(data$Time)),as.POSIXlt(max(data$Time)))  
axis.POSIXct(1, at=seq(dayrange[1], dayrange[2]+(3600*24), by="day"), 
             labels=c("Thurs","Fri","Sat"), format="%b")

# add the legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","blue","red")) 

dev.off()