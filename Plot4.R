# Install the package
install.packages("lubridate")
# Load the package
library(lubridate)
library(sqldf)
library(datasets)



# download files 
if(!file.exists("data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/test.zip", method ="curl")
dateDownloaded<-date()


#upzip
zipF<- "./data/test.zip"
outDir<-"./data/"
unzip(zipF,exdir=outDir)


con <-file("./data/household_power_consumption.txt")
df <- sqldf("select * from con where Date in ('1/2/2007', '2/2/2007')", 
            file.format = list(header = TRUE, sep = ";"))
close(con)

#plot 4 
quartz()
par(mfrow = c(2, 2))
par(mar = c(4, 4, 1, 2))
with(df, {
  plot(DateTime, Global_active_power, ylab = "Global Active Power", "n")
  lines(DateTime, Global_active_power)
  plot(DateTime, Voltage, ylab = "Voltage", xlab = "datetime", "n")
  lines(DateTime, Voltage)
  
  plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", "n")
  lines(DateTime, Sub_metering_1, col="black")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col=c("black", "red", "blue"), lty=c(1,1,1), cex = 0.75, bty = "n")
  
  plot(DateTime, Global_reactive_power, "n", xlab = "datetime")
  lines(DateTime, Global_reactive_power)
})
dev.copy(png, file = "./Plot4.png", width = 480, height = 480)
dev.off()


