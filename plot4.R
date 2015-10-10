#R
namePNG = 'plot4.png'
sizePNGx = 480
sizePNGy = 480
strStartDate <- '01/02/2007'
strEndDate <- '02/02/2007'
nRows = -1

cClasses <- c("character", "character")
for (i in seq(7))
	cClasses <- c(cClasses, "numeric")

hpc <- read.csv2("household_power_consumption.txt", na.strings = '?', colClasses=cClasses, dec='.')
hpc$posixDate <- as.Date(strptime(hpc$Date, "%d/%m/%Y"))
posixStartDate <- as.Date(strptime(strStartDate, "%d/%m/%Y"))
posixEndDate <- as.Date(strptime(strEndDate, "%d/%m/%Y"))
hpcFiltred <- subset(hpc, posixDate >= posixStartDate & posixDate <= posixEndDate)
rm(hpc)
tHpc <- hpcFiltred[,3:9]
tHpc$datetime <- strptime(paste(hpcFiltred$Date, hpcFiltred$Time), "%d/%m/%Y %H:%M:%S")
rm(hpcFiltred)
png(namePNG, width=sizePNGx, height=sizePNGy)
par(mfrow=c(2,2))
with(tHpc, {
	plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

	plot(datetime, Global_reactive_power, type="l")

	plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
	points(datetime, Sub_metering_2, type="l", col="red")
	points(datetime, Sub_metering_3, type="l", col="blue")
	legend("topright", lty=1, col=c("black", "red", "blue"), legend=paste0("Sub_metring_", c("1", "2", "3")), lwd=2)

	plot(datetime, Global_reactive_power, type="l")
})
dev.off()
