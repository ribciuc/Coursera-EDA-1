# It is assumed the zip / text file is already downloaded in the working directory
library(dplyr)
library(data.table)

# Read and subset file to relevant dates
hpc<-fread("household_power_consumption.txt", sep=";", na.strings="?",stringsAsFactors = FALSE)
hpc1 <- subset(hpc, Date == "1/2/2007" | Date == "2/2/2007")

# Create timestamps from date and time
hpc1$datetime <- paste(hpc1$Date,hpc1$Time)

# Convert variables to numeric from character format
hpc1$Global_active_power <- as.numeric(as.character(hpc1$Global_active_power))
hpc1$Global_reactive_power <- as.numeric(as.character(hpc1$Global_reactive_power))
hpc1$Voltage <- as.numeric(as.character(hpc1$Voltage))
hpc1$Sub_metering_1 <- as.numeric(as.character(hpc1$Sub_metering_1))
hpc1$Sub_metering_2 <- as.numeric(as.character(hpc1$Sub_metering_2))
hpc1$Sub_metering_3 <- as.numeric(as.character(hpc1$Sub_metering_3))

# Create plot and export to .png file
png(filename = "plot3.png", width = 480, height = 480, units ="px")

#Creates plot of date/time v Sub metering 1 data
plot(strptime(hpc1$datetime, "%d/%m/%Y %H:%M:%S"), hpc1$Sub_metering_1, 
     type = "l", xlab = "", ylab = "Energy sub metering")

#Adds line graph for date/time v Sub metering 2 data in red
lines(strptime(hpc1$datetime, "%d/%m/%Y %H:%M:%S"), 
      hpc1$Sub_metering_2, type = "l", col = "red" )

#Adds line graph for date/time v Sub metering 3 data in blue
lines(strptime(hpc1$datetime, "%d/%m/%Y %H:%M:%S"), 
      hpc1$Sub_metering_3, type = "l", col = "blue" )

#Adds legend to graph
legend("topright", lty= 1, col = c("Black", "red", "blue"), 
       legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()