# plot2.R

outputFile <- "./data/raw_data.RData"

if(!file.exists(outputFile)) {
    source("get_data.R")
} else {
    load(outputFile)
}

gap <- as.numeric(df$Global_active_power)
tod <- df$date_time
plot(tod, gap/500, type="l", ylab = "Global Active Power", xlab = "" )

