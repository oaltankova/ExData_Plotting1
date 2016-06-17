## Source data https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## The goal is to examine how household energy usage varies over a 2-day period in February, 2007.
## Construct the plot 3 and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
print("Load packages")
if (!library(sqldf, logical.return = TRUE)){
        install.packages("sqldf")
        library(sqldf)
}
print("Downloading zip file")
## Download and unzip file with source data
if(file.exists("household_power_consumption.zip")) {
        file.remove("household_power_consumption.zip")
}
if(file.exists("household_power_consumption.txt")) {
        file.remove("household_power_consumption.txt")
}

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="household_power_consumption.zip")

print("Unzip file")
## Unzip file
unzip(zipfile = "household_power_consumption.zip")
file.remove("household_power_consumption.zip")

print("Read Data for plot3")
## Read Data for plot1 - columns Date, Time, Global_active_power, 
##                      Sub_metering_1, Sub_metering_2 and Sub_metering_3
## and rows with Date in ("1/2/2007","2/2/2007")
gapower<-read.csv.sql(file = "household_power_consumption.txt", 
                      sep = ";",
                      sql ='select Date, Time, Global_active_power,
                            Sub_metering_1, Sub_metering_2, Sub_metering_3       
                      from file 
                      where Date in ("1/2/2007","2/2/2007")'
)
closeAllConnections()
gapower$Global_active_power <- as.numeric(gapower$Global_active_power, na.string = "?")
gapower$Sub_metering_1 <- as.numeric(gapower$Sub_metering_1, na.string = "?")
gapower$Sub_metering_2 <- as.numeric(gapower$Sub_metering_2, na.string = "?")
gapower$Sub_metering_3 <- as.numeric(gapower$Sub_metering_3, na.string = "?")
gapower$DateTime <- strptime(paste(gapower$Date,gapower$Time),"%d/%m/%Y %H:%M:%S")


print("Create plot3")
## Create plot3
if(file.exists("plot3.png")) {
        file.remove("plot3.png")
}
png(file="plot3.png", width = 480, height = 480)
with (gapower, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=NA))
with (gapower, lines(DateTime, Sub_metering_2, col="red"))
with (gapower, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

print("Remove data file")
if(file.exists("household_power_consumption.txt")) {
        file.remove("household_power_consumption.txt")
}