## Source data https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## The goal is to examine how household energy usage varies over a 2-day period in February, 2007.
## Construct the plot 2 and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
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

print("Read Data for plot2")
## Read Data for plot2 - columns Date, Time and Global_active_power 
## and rows with Date in ("1/2/2007","2/2/2007")
gapower<-read.csv.sql(file = "household_power_consumption.txt", 
                      sep = ";",
                      sql ='select Date, Time, Global_active_power 
                      from file 
                      where Date in ("1/2/2007","2/2/2007")'
)
closeAllConnections()
gapower$Global_active_power <- as.numeric(gapower$Global_active_power, na.string = "?")
gapower$DateTime <- strptime(paste(gapower$Date,gapower$Time),"%d/%m/%Y %H:%M:%S")

print("Create plot2")
## Create plot2
if(file.exists("plot2.png")) {
        file.remove("plot2.png")
}
png(file="plot2.png", width = 480, height = 480)
with (gapower, plot(DateTime, Global_active_power, type="l",
                    ylab="Global Active Power (kilowatts)",
                    xlab=NA)
)
dev.off()

print("Remove data file")
if(file.exists("household_power_consumption.txt")) {
        file.remove("household_power_consumption.txt")
}