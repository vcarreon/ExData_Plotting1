##Plot4
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
str(electricSubset) #look at the properties of each variable. 
#Global Active Power, Global Reactive Power, Voltage, Sub metering 1 & 2 are all factors instead of a numbers.
electricSubset$Global_active_power<-as.numeric(as.character(electricSubset$Global_active_power)) #Change Global Active Power to number
electricSubset$Global_reactive_power<-as.numeric(as.character(electricSubset$Global_reactive_power)) #Change Global Active Power to number
electricSubset$Voltage<-as.numeric(as.character(electricSubset$Voltage))
electricSubset$Sub_metering_1<-as.numeric(as.character(electricSubset$Sub_metering_1))
electricSubset$Sub_metering_2<-as.numeric(as.character(electricSubset$Sub_metering_2))
electricSubset$Sub_metering_3<-as.numeric(as.character(electricSubset$Sub_metering_3))
str(electricSubset) #Verify that variable types have changed
electricSubset<-transform(electricSubset,timeCombined=as.POSIXct(paste(Date,Time)),"%d/%m/%Y %H:%M:%S") #Add new Date and Time combined variable and format as POSIXct class
View(electricSubset) #verify new column created
str(electricSubset$timeCombined) #check to make sure new column is in POSIXct format

#Step 3: Create the Plots
par(mfrow=c(2,2)) #2 rows 2 columns

#Plot 1
#Create plot with timeCombined on x axis and Global Active Power on y axis, type=l for lines, 
#no label on x axes and add label for y axis
plot(electricSubset$timeCombined,electricSubset$Global_active_power,type="l",xlab="",ylab="Global Active Power")

#Plot 2
#Create plot with timeCombined on x axis, Voltage on y axis, type=l for lines. 
#Lables- datetime on x axis, Voltage y axis
plot(electricSubset$timeCombined,electricSubset$Voltage,type="l",xlab="datetime",ylab="Voltage")

#Plot 3
# Create plot with timeCombined on x axis and submetering 1,2,3 on y axis, type=l for lines, 
#no label on x axes and add label for y axis
plot(electricSubset$timeCombined,electricSubset$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(electricSubset$timeCombined,electricSubset$Sub_metering_2,col="red")
lines(electricSubset$timeCombined,electricSubset$Sub_metering_3,col="blue")
#Add legend in top right, bty removes the box, cex shrinks the text
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),bty="n",cex=.5)

#Plot 4
# Create a plot with timeCombined on x axis, Global Active Power on y axis, type=1 for lines. 
#Labels-datetime on x axis, Global_reactive_Power on y axis
plot(electricSubset$timeCombined,electricSubset$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")


#Step 4: Copy plot to a PNG File
dev.copy(png,file="plot4.png",width=480,height=480) #save copy as PNG and make file 480x480
dev.off() #close graphics device
