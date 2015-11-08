#read, plot and save plot1
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
png(file = "./coursera/plot1.png", height = 480, width = 480)

#plot histogram
hist(dtsub$Global_active_power, main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")

#close png
dev.off()