# Coursera Exploratory Data Analysis
# Project 4, Week 1
# Rich Morrison
# April 8, 2016
#
# Plot 4

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

# save plot to .png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# create 2 x 2 grid of plots
par(mfcol=c(2,2))

# create plot #1
plot(data$Time, data$Global_active_power, xaxt="n", xlab="",
     ylab="Global Active Power (kilowatts)", type="l")
dayrange=c(as.POSIXlt(min(data$Time)),as.POSIXlt(max(data$Time)))  
axis.POSIXct(1, at=seq(dayrange[1], dayrange[2]+(3600*24), by="day"), 
             labels=c("Thurs","Fri","Sat"), format="%b")

# create plot #2
plot(data$Time, data$Sub_metering_1, xaxt="n", xlab="",
     ylab="Energe sub metering", type="l")
lines(data$Time, data$Sub_metering_2, type="l", col="red")
lines(data$Time, data$Sub_metering_3, type="l", col="blue")
dayrange=c(as.POSIXlt(min(data$Time)),as.POSIXlt(max(data$Time)))  
axis.POSIXct(1, at=seq(dayrange[1], dayrange[2]+(3600*24), by="day"), 
             labels=c("Thurs","Fri","Sat"), format="%b")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","blue","red"), box.lwd = 0, box.col="white",
       inset=0.01) 


# create plot 3
plot(data$Time, data$Voltage, xaxt="n", xlab="datetime",
     ylab="Voltage", type="l")
dayrange=c(as.POSIXlt(min(data$Time)),as.POSIXlt(max(data$Time)))  
axis.POSIXct(1, at=seq(dayrange[1], dayrange[2]+(3600*24), by="day"), 
             labels=c("Thurs","Fri","Sat"), format="%b")

# create plot 4
plot(data$Time, data$Global_reactive_power, xaxt="n", xlab="datetime",
     ylab="Global_reactive_power", type="l")
dayrange=c(as.POSIXlt(min(data$Time)),as.POSIXlt(max(data$Time)))  
axis.POSIXct(1, at=seq(dayrange[1], dayrange[2]+(3600*24), by="day"), 
             labels=c("Thurs","Fri","Sat"), format="%b")

# turn off png device
dev.off()