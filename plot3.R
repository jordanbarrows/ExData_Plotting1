## sets the name of the directory to be downloaded
dirname <- "electricpowerconsumption.zip"

## if the file is not there, download it
if (!file.exists(dirname)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, dirname, method = "curl")
}

## if the directory from the unzipped directory is not there, 
## unzip electricpowerconsumption.zip
if (!file.exists("household_power_consumption.txt")) {
    unzip(dirname)
}

## initializes the data.table package
library(data.table)

## read in the data between 01/02/2007 and 02/02/2007
power <- fread("household_power_consumption.txt")
powershort <- rbind(power[power$Date == "1/2/2007", ], 
                    power[power$Date == "2/2/2007",])

## add a column with Date/Time in POSIXct format
datetime <- paste(powershort$Date, powershort$Time)
CombinedDateTime <- as.POSIXct(strptime(datetime, "%d/%m/%Y %H:%M:%S"))
powershortnew <- cbind(CombinedDateTime, powershort)

## plot Sub_metering data as line graphs over the two days and save to a png
if (!file.exists("plot3.png")) {
    png("plot3.png", width = 480, height = 480)
    x <- powershortnew$CombinedDateTime
    a <- powershortnew$Sub_metering_1
    b <- powershortnew$Sub_metering_2
    c <- powershortnew$Sub_metering_3
    plot(x, a, type = "n", xlab = "", ylab = "Energy Sub Metering")
    lines(x, a)
    lines(x, b, col = "red")
    lines(x, c, col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"), lty = 1, lwd = 2)
    dev.off()
}