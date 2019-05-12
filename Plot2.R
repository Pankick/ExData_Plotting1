data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
#str(data)
data <- subset(data,as.Date(Date, "%d/%m/%Y") >= as.Date("2007-2-1") & as.Date(Date, "%d/%m/%Y") <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]
data$Date <- as.character(data$Date)
data$Time <- as.character(data$Time)
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)

plot(data$Global_active_power~data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot2.png")
dev.off()
