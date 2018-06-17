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



# plot 1 
quartz()
hist(df$Global_active_power, main = "Global Active Power", 
     xlab ="Global Active Power (kilowatts)", col = "red")
dev.copy(png, file = "./Plot1.png", width = 480, height = 480)
dev.off()