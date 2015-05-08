require(dplyr)
require(lubridate)

if(!file.exists("./data")) {dir.create("./data")}

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

sourceFile <- "exdata-data-household_power_consumption.zip"
dataFile  <- "./data/household_power_consumption.txt"
outputFile <- "./data/raw_data.RData"

# Download file and extract it.
if(!file.exists(sourceFile)) {
    if (Sys.info()['sysname'] == "windows") {
        # needed for my Windows PC
        download.file(fileURL, destfile=sourceFile)
    } else {
        # needed for my Mac
        download.file(fileURL, destfile=sourceFile, method = "curl")
    }
    unzip(sourceFile, exdir="./data", junkpaths=TRUE)
}

# read the file and get just the days we need
tmp <- read.table(dataFile, header=TRUE, sep=";", na.strings="?")
dn <- names(tmp)
d1 <- filter(tmp, Date == "1/2/2007")
d2 <- filter(tmp, Date == "2/2/2007")
df <- rbind(d1, d2)
names(df) <- dn

# Convert the Date and Time Columns
dts_txt <- paste(df$Date, df$Time)
date_time <- strptime(dts_txt, format="%d/%m/%Y %H:%M:%S")
df <- cbind(df, date_time)


# Start the plotting
sm1 <- df$Sub_metering_1
sm2 <- df$Sub_metering_2
sm3 <- df$Sub_metering_3
tod <- df$date_time

png("plot3.png", width=480, height=480)

plot(tod, sm1, type="l", col= "black")
lines(tod, sm2, col="red")
lines(tod, sm3, col="blue")
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1),
       lwd=c(2.5,2.5),col=c("black", "red", "blue")) 
dev.off()