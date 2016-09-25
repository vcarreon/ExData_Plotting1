##Plot1
setwd("~/Datasciencecoursera/ExData_Plotting1")
library(data.table)

##Step 1: Load and Read file
electric<-read.table("./household_power_consumption.txt",header=T,sep=";")
View(electric)

##Step 2: Clean Data
electric$Date<-as.Date(electric$Date,format="%d/%m/%Y") #change the date format
View(electric) #view to make sure date is in correct format
electricSubset<-electric[(electric$Date=="2007-02-01")|(electric$Date=="2007-02-02"),] #create subset of date
View(electricSubset) #view to make sure correct- now have 2880 observations
str(electricSubset$Global_active_power) #look at the properties of Global Active Power. It is a factor instead of a number.
electricSubset$Global_active_power<-as.numeric(as.character(electricSubset$Global_active_power)) #Change Global Active Power to number
str(electricSubset$Global_active_power) #Verify that Global Active Power is now a number
table(electricSubset$Global_active_power) #verify there are no NAs

#Step 3: Create the Plot
par(mfrow=c(1,1))
hist(electricSubset$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power (killowats)")

#Step 4: Copy plot to a PNG File
dev.copy(png,file="plot1.png",width=480,height=480) #save copy as PNG and make file 480x480
dev.off() #close graphics device
