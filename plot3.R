setwd("d:/ExpData")
if (!file.exists("./prj1")) {
  dir.create("./prj1")
}
setwd("./prj1")

file1 <- "../household_power_consumption.txt"

require(data.table)

## read only the date column
## and filter out the row indexes that we need
dateData <- fread(file1, 
                  sep=";",
                  header=TRUE,
                  na.strings="?",
                  select=1)

## identify the row indexes to be loaded
rows <- c(which(dateData$Date == "1/2/2007"),which(dateData$Date == "2/2/2007"))

## clean up temp data to clear memory
dateData <- NULL

## load the data in to data.table
## by taking only those rows that are relevant
## since the days are continuous, we do not have to
## worry too much. Not considering header rows
allData1 <- fread(file1, 
                  sep=";",
                  header=FALSE,
                  na.strings="?",
                  nrows=length(rows), 
                  skip=(if (length(rows) > 0) {
                    rows[1]
                  } else {
                    -1
                  }))

## set the colnames correctly and efficiently
setnames (allData1, 
          colnames(allData1),
          colnames(fread(file1,
                         sep=";",
                         header=TRUE,
                         na.strings="?",nrows=0)))


if (!file.exists("./figure")) {
  dir.create("./figure")
}

timeFrame <- strptime(paste(allData1$Time,
                            allData1$Date),
                      "%H:%M:%S %d/%m/%Y")

#allData1[,xyz:=timeFrame]


par(mar=c(4,4,0,0))

png(filename = "./figure/plot3.png",
    width = 480, height = 480, units = "px", 
    pointsize = 12, bg = "grey95")

#with (allData1, 
#      plot(strptime(paste(allData1$Time, 
#                          allData1$Date), 
#                    "%H:%M:%S %d/%m/%Y"),
#           Sub_metering_1, 
#           main = "",
#           xlab="",
#           ylab="Energy sub metering",
#           type="n"))

plot(timeFrame,
     allData1$Sub_metering_1, 
     main = "",
     xlab="",
     ylab="Energy sub metering",
     type="n")

points(timeFrame,
       allData1$Sub_metering_1, 
       type="s", 
       col="maroon4")

points(timeFrame,
       allData1$Sub_metering_2, 
       type="s", 
       col="red")

points(timeFrame,
       allData1$Sub_metering_3, 
       type="s", 
       col="blue")

legend("topright",
       legend=c("Sub_metering_1", 
                "Sub_metering_2",
                "Sub_metering_3"),
       lty=1,
       col=c("maroon4",
             "red",
             "blue"))

dev.off()
