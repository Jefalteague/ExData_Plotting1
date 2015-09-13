##This script produces a histogram which displays household global minute-averaged active power (in kilowatt)

##Load subset of full data downloaded from https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
powdata2 <- read.table("household_power_consumption.txt", sep = ";", skip = 66637, nrows = 2881, col.names = c("Date", "Time", "Global_Active_Power", "Global_Reactive_Power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
head(powdata2)
tail(powdata2)

##Subset data again to isolate last 7 variables
powdata3 <- powdata2[,3:9]
head(powdata3)
class(powdata3)

##Convert Date variable from factor to date
new_date1 <- as.Date(powdata2$Date, format = "%d/%m/%Y")
head(new_date1)
class(new_date1)

##Paste Date and Time
paste_cols <- paste(new_date1, powdata2$Time)
head(paste_cols)

##convert to POSIX
posmake <- as.POSIXct(paste_cols)
head(posmake)
class(posmake)

##Cbind
bound <- cbind(posmake, powdata3)
head(bound)

at <- format(bound$posmake, "%S") == "00" & format(bound$posmake, "%M") == "00" & format(bound$posmake, "%H") == "00"
at

sub_bound <- bound$posmake[at]
sub_bound

wk_cnvrt <- weekdays(sub_bound, abbreviate = TRUE)
wk_cnvrt

##Create and save png file
png(filename = "plot3.png")
plot(bound$Sub_metering_1 ~ bound$posmake, pch = 20, cex = .1, xlab = "", xaxt = "n", ylab = "Energy Submetering")
lines(bound$Sub_metering_1 ~ bound$posmake, col = "black")
lines(bound$Sub_metering_2 ~ bound$posmake, col = "red")
lines(bound$Sub_metering_3 ~ bound$posmake, col = "blue")
legend("topright", inset=0, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1, 1), lwd = c(1.0, 1.0), col = c("black","red","blue"), horiz=FALSE)
axis(1, at = sub_bound, labels = wk_cnvrt)
dev.off()
