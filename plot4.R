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
gap <- df$Global_active_power
grp <- df$Global_reactive_power
volt <- df$Voltage
sm1 <- df$Sub_metering_1
sm2 <- df$Sub_metering_2
sm3 <- df$Sub_metering_3
tod <- df$date_time

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

#1 top left
plot(tod, gap, type="l", ylab = "Global Active Power", xlab = "" )

#2 top right
plot(tod, volt, type="l", ylab = "Voltage", xlab = "datetime" )

#3 bottom left
plot(tod, sm1, type="l", col= "black")
lines(tod, sm2, col="red")
lines(tod, sm3, col="blue")
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1),
       lwd=c(2.5,2.5),col=c("black", "red", "blue")) 

#4 bottom right
plot(tod, grp, type="l", ylab = "Global_reactive_power", xlab = "datetime" )

dev.off()