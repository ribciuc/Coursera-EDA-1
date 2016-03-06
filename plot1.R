# It is assumed the zip / text file is already downloaded in the working directory
library(dplyr)
library(data.table)

hpc<-fread("household_power_consumption.txt", sep=";", na.strings="?")
hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")
hpc1 <- subset(hpc, Date == '2007-02-01' | Date == '2007-02-02')
nums <- as.numeric(hpc1$Global_active_power)
hpc1$Global_active_power <- nums

png(filename = "plot1.png", width=480, height=480, units="px")
hist(hpc1$Global_active_power, col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

dev.off()