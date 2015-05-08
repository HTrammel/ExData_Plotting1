# plot1.R

outputFile <- "./data/raw_data.RData"

if(!file.exists(outputFile)) {
    source("get_data.R")
} else {
    load(outputFile)
}

gap <- as.numeric(df$Global_active_power)
hist(gap/1000,
    breaks = seq(0, 6, by=0.25),
    col="red",
    main="Global Active Power",
    xlab="Global Active Power (kilowatts)")

# axis are not correct


