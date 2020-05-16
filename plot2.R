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

## plot Global Active Power as a line graph over the two days and save to a png
if (!file.exists("plot2.png")) {
    png("plot2.png", width = 480, height = 480)
    x <- powershortnew$CombinedDateTime
    a <- powershortnew$Global_active_power
    plot(x, a, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
    lines(x, a)
    dev.off()
}
