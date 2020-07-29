# Created using R version 4.0.0 on Windows 10 64-bit edition.
# See README.md for more details.


#--------------------------------------------------------------------------------
#Getting the data
#--------------------------------------------------------------------------------


# download file containing data:

if (!file.exists("exdata_data_household_power_consumption.zip")) {
  message("Data download - starting. This may take a while...")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,"exdata_data_household_power_consumption.zip", mode = "wb")
  message("Data download - done")
} else {
  message(paste("Data  download - already downloaded.", sep=""))
}

# unzip the zip file containing the data

filename <- "exdata_data_household_power_consumption.zip"


if (!file.exists("household_power_consumption.txt")) {
  unzip(filename)
  message("Data unzip - done")
} 

print("Reading the Data...")

powerConsumption <- read.csv("household_power_consumption.txt", colClasses = "character", sep = ";")

#--------------------------------------------------------------------------------
# Convert Date data to Date format and subset Power data 
# from the dates 2007-02-01 and 2007-02-02
#--------------------------------------------------------------------------------

powerConsumption$Date <- as.Date(powerConsumption$Date, format='%d/%m/%Y')

powerDate <- powerConsumption[powerConsumption$Date %in% as.Date(c('2007-02-01','2007-02-02')), ]
DT <- strptime(paste(powerDate$Date,powerDate$Time),format="%Y-%m-%d %H:%M:%S")
powerDate <- cbind(powerDate,DT)

#--------------------------------------------------------------------------------
# Creating Plot 2: Timeseries of Global Active Power
#--------------------------------------------------------------------------------

print("Creating Timeseries of Global Active Power...")

# Open PNG device and create 'plot2.png' in working directory
png(filename="plot2.png",
    width = 480, height = 480, units = "px")

# Create plot and send to a file. The plot doesn't appear on screen
plot(powerDate$DT,powerDate$Global_active_power, 
     type="l",ylab="Global Active Power (kilowatts)",xlab="")

# Close the PNG file device
dev.off()

wd <- getwd()
message(paste("Plot save successfully as 'plot2' at",wd, sep = " "))