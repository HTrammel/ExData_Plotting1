# Generic get_data script
# 1. creates data directory
# 2. with given variables, download and extract needed data files in to the data directory.

require(dplyr)
require(lubridate)

if(!file.exists("./data")) {dir.create("./data")}

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

sourceFile <- "exdata-data-household_power_consumption.zip"
dataFile  <- "./data/household_power_consumption.txt"
outputFile <- "./data/raw_data.RData"

# Download file and extract it.
if(!file.exists(sourceFile)) {
    download.file(fileURL, destfile=sourceFile, method = "curl")
    unzip(sourceFile, exdir="./data", junkpaths=TRUE)
}

# read the file and get just the days we need
tmp <- read.csv2(dataFile, header=TRUE)
dn <- names(tmp)
d1 <- filter(tmp, Date == "1/2/2007")
d2 <- filter(tmp, Date == "2/2/2007")
df <- rbind(d1, d2)
names(df) <- dn

# Convert the Date and Time Columns
dts_txt <- paste(df$Date, df$Time)
date_time <- strptime(dts_txt, format="%d/%m/%Y %H:%M:%S")
df <- cbind(df, date_time)


# Clean up debris from above
rm(tmp,d1,d2,dn)

# write data out to file for reuse
save(df, file=outputFile)