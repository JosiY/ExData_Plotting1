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

par(mfcol = c(2,2))

op <- par(cex=0.7)

plotactive <- with(cleandf, plot(Date_Time, Global_active_power, type="l", xlab ="", ylab ="Global Active Power" )) 

plot3 <- plot (cleandf$Date_Time,cleandf$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
plot3 <-lines (cleandf$Date_Time,cleandf$Sub_metering_2, type = "l", col = "red")
plot3<- points (cleandf$Date_Time,cleandf$Sub_metering_3, type = "l", col = "blue")
plot3 <-legend("topright", lty = 1, cex=0.82, bty='n',col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

plotvoltage <- with(cleandf, plot(Date_Time, Voltage, type="l", xlab ="datetime", ylab ="Voltage" )) 

plotreactive <- with(cleandf, plot(Date_Time, Global_reactive_power, type="l", xlab ="datetime", ylab ="Global_reactive_power" )) 

dev.copy(png, file = "plot4.png")

dev.off()


