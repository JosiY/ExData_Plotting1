setwd("C:/Users/Josephine/Desktop/Exploratory Data Analysis/Course Project 01")

library(sqldf)

myFile <- "C:/Users/Josephine/Desktop/Exploratory Data Analysis/Course Project 01/household_power_consumption/household_power_consumption.txt"

mySql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"

dfData <-read.csv2.sql(myFile,mySql)

datetime <- with(dfData, paste(Date, Time, sep=" "))

newdfData <- cbind(datetime,dfData)

newformat <-strptime(newdfData$datetime, "%d/%m/%Y %H:%M:%S")

bind <-cbind(newformat,newdfData)

names(bind)[1] <-c("Date_Time")

cols <- c(2,3,4)

cleandf <- bind[,-cols]

Sys.setlocale("LC_TIME", "English") 

plot2 <- with(cleandf, plot(Date_Time, Global_active_power, type="l", xlab ="", ylab ="Global Active Power (kilowatts)" )) 

dev.copy(png, file = "plot2.png")

dev.off()
