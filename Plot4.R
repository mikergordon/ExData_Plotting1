#read, plot and save plot4
library(data.table)

#load data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
fileList <- unzip(temp, "household_power_consumption.txt", list = TRUE)
dt <- fread(input = fileList$Name, na.strings = "?")
unlink(temp)

#narrow down to Feb 1 2007 and Feb 2 2007
dtsub <- dt[Date == "1/2/2007" | Date == "2/2/2007", ]

#format date/time
dtsub <- dtsub[, Date:=as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#create png
png(file = "./coursera/plot4.png", height = 480, width = 480)

#plot graphs
par(mfrow = c(1,2), mfcol = c(2, 2))
par(cex = 0.85)
{
plot(dtsub$Date, dtsub$Global_active_power, xlab = ""
     , ylab = "Global Active Power", type = "l")
plot(dtsub$Date, dtsub$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(dtsub$Date, dtsub$Sub_metering_2, col = "Red")
lines(dtsub$Date, dtsub$Sub_metering_3, col = "Blue")
legend(x = "topright", col = c("Black", "Red", "Blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), bty = "n")
plot(dtsub$Date, dtsub$Voltage, xlab = "datetime"
     , ylab = "Voltage", type = "l")
plot(dtsub$Date, dtsub$Global_reactive_power, xlab = "datetime"
     , ylab = "Global_reactive_power", type = "l")
}
#close png
dev.off()