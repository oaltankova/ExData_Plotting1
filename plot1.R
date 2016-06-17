## Source data https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## The goal is to examine how household energy usage varies over a 2-day period in February, 2007.
## Construct the plot 1 and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
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

print("Read Data for plot1")
## Read Data for plot1 - columns Date, Time and Global_active_power 
## and rows with Date in ("1/2/2007","2/2/2007")
gapower<-read.csv.sql(file = "household_power_consumption.txt", 
                       sep = ";",
                       sql ='select Date, Time, Global_active_power 
                               from file 
                              where Date in ("1/2/2007","2/2/2007")'
                      )
closeAllConnections()
gapower$Global_active_power <- as.numeric(gapower$Global_active_power, na.string = "?")

print("Create plot1")
## Create plot1
if(file.exists("plot1.png")) {
        file.remove("plot1.png")
}
png(file="plot1.png", width = 480, height = 480)
hist(gapower$Global_active_power, 
     ylim = c(0, 1200), 
     col="red",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power"
     )
dev.off()

print("Remove data file")
if(file.exists("household_power_consumption.txt")) {
        file.remove("household_power_consumption.txt")
}