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
par(mar=c(4,4,4,1),cex.lab=0.75, cex.axis=0.75, cex.main=0.9, cex.sub=0.75 )
hist(data$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)", main="Global Active Power")

# save plot to .png file
dev.copy(png, filename = "plot1.png", width = 480, height = 480, units = "px")
dev.off()