setwd("c:/users/gangsta/Downloads/")

library(lubridate)
library(reshape2)

power <- read.table(sep = ";", "./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE)

#subset
power <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

# fixup dates
power$Date <- dmy(power$Date)
power$Time <- hms(power$Time)
power$dts <- power$Date + power$Time

#make numeric
power$Global_active_power <- as.numeric(power$Global_active_power)

# assign day names
power$wday <- wday(power$Date, label=TRUE)

png("plot4.png")

#2x2 square
par(mfrow=c(2,2))

#plot1
plot(power$dts,power$Global_active_power, type="l", pch=NULL, ylab = "Global Active Power (Kilowatts)", xlab="")

#plot 2
plot(power$dts,power$Voltage, type="l", xlab="datetime",ylab="Voltage")

#plot3
plot(power$dts, power$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
points(power$dts, power$Sub_metering_1,type="l", col="gray", lwd=2)
points(power$dts, power$Sub_metering_2,type="l", col="red", lwd=2)
points(power$dts, power$Sub_metering_3,type="l", col="blue", lwd=2)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("grey","red","blue"),lwd=2)

#plot 4
plot(power$dts,power$Global_reactive_power, type="l", xlab="datetime",ylab="Global_reactive_power")

dev.off()