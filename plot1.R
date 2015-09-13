##This script produces a histogram which displays household global minute-averaged active power (in kilowatt)

##Load subset of full data downloaded from https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
powdata <- read.table("household_power_consumption.txt", sep = ";", skip = 66637, nrows = 2881, col.names = c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Subset data again to isolate last 7 variables
sub_powdata <- powdata[,3:9]
head(sub_powdata)

##Convert Date variable from factor to date
newDate <-as.Date(powdata$Date, format = "%d/%m/%Y")
newDate
class(newDate)

##Paste Date and Time
pastedata <- paste(newDate, powdata$Time)
pastedata

##convert to POSIX
posmake1 <- as.POSIXct(pastedata)
head(posmake1)
class(posmake1)

##Cbind
bound_data <- cbind(posmake1, sub_powdata)
head(bound_data)

##Create and save png file
png(filename = "plot1.png")
hist(bound_data$Global_Active_Power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()