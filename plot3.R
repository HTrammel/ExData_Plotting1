# plot3.R

outputFile <- "./data/raw_data.RData"

if(!file.exists(outputFile)) {
    source("get_data.R")
} else {
    load(outputFile)
}

sm1 <- as.numeric(df$Sub_metering_1)
sm2 <- as.numeric(df$Sub_metering_2)
sm3 <- as.numeric(df$Sub_metering_3)
tod <- df$date_time
plot(tod, sm1, type="l", col= "black")
lines(tod, sm2/5, col="red")
lines(tod, sm3, col="blue")
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1),
       lwd=c(2.5,2.5),col=c("black", "red", "blue")) 
