# Coursera/JHU: Exploratory Data Analysis
# Course Project 1 - Ryan B. Harvey
# Plot 4 (plot4.R)

# Get data file from internet if not already downloaded
localfile <- "../household_power_consumption.zip"
if (!file.exists(localfile)) {
      url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(url, localfile, method="curl")
      downloadDate <- date()
}

# Set data path and unzip data file if not already unzipped
datafile <- '../household_power_consumption.txt'
if(!file.exists(datafile)) {
      unzip(localfile)
}

# Read in data and convert data types
df <- read.delim(datafile, as.is=TRUE, header=TRUE, sep=";", na.strings="?")
dts <- paste(df$Date, df$Time)
df$Date <- as.Date(strptime(df$Date, format="%d/%m/%Y"))
df$Time <- strptime(dts, format="%d/%m/%Y %H:%M:%S")

# Subset data
startdate <- as.Date(strptime("2007-02-01", format="%Y-%m-%d"))
enddate <- as.Date(strptime("2007-02-02", format="%Y-%m-%d"))
data <- subset(df, df$Date >= startdate & df$Date <= enddate)

# Create and save the plots
png(file="plot4.png",width=480,height=480)

par(mfrow=c(2, 2), mar=c(5, 4, 2, 1))

# Global Active Power plot
plot(data$Time, data$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")

# Voltage plot
plot(data$Time, data$Voltage, type="l", 
     ylab="Voltage", xlab="datetime")

# Sub metering plot
columns <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(data$Time, data$Sub_metering_1, col="black", 
     type="l", xlab="", ylab="Energy sub metering")
lines(data$Time, data$Sub_metering_2, type='l', col="red")
lines(data$Time, data$Sub_metering_3, type='l', col="blue")
legend("topright", legend=columns, col=c("black","red","blue"), 
       lty=c(1, 1, 1), lwd=c(2, 2, 2))

# Global Reactive Power plot
plot(data$Time, data$Global_reactive_power, type="l", 
     ylab="Global_reactive_power", xlab="datetime")

dev.off()
