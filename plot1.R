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

## plot Global Active Power as a histogram and save to a png
if (!file.exists("plot1.png")) {
    png("plot1.png", width = 480, height = 480)
    hist(as.numeric(powershort$Global_active_power), col = "red", 
        xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
    dev.off()
}





