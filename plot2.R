setwd("d:/ExpData")
if (!file.exists("./prj1")) {
  dir.create("./prj1")
}
setwd("./prj1")

file1 <- "../household_power_consumption.txt"

require(data.table)

dateData <- fread(file1, 
                  sep=";",
                  header=TRUE,
                  na.strings="?",
                  select=1)


rows <- c(which(dateData$Date == "2/2/2007"),which(dateData$Date == "1/2/2007"))

dateData <- NULL

allData1 <- fread(file1, 
                  sep=";",
                  header=TRUE,
                  na.strings="?",
                  nrows=length(rows), 
                  skip=(if (length(rows) > 0) {
                    rows[1]-1
                  } else {
                    -1
                  }))
