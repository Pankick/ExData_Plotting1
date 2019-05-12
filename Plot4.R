data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
#str(data)
data <- subset(data,as.Date(Date, "%d/%m/%Y") >= as.Date("2007-2-1") & as.Date(Date, "%d/%m/%Y") <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]
data$Date <- as.character(data$Date)
data$Time <- as.character(data$Time)
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png,"plot4.png")
dev.off()
