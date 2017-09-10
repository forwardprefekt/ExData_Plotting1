setwd("c:/users/gangsta/Downloads/")

library(lubridate)

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

png("plot1.png")
hist(power$Global_active_power, xlab="Global Active Power (kilowatts)", ylab = "Frequency", col="red", main = "Global Active Power")
dev.off()
