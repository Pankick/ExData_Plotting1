data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
#str(data)
data <- subset(data,as.Date(Date, "%d/%m/%Y") >= as.Date("2007-2-1") & as.Date(Date, "%d/%m/%Y") <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]
data$Date <- as.character(data$Date)
data$Time <- as.character(data$Time)
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)

with(data, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,"plot3.png")
dev.off()
