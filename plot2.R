##Plot2
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
electricSubset<-transform(electricSubset,timeCombined=as.POSIXct(paste(Date,Time)),"%d/%m/%Y %H:%M:%S") #Add new Date and Time combined variable and format as POSIXct class
View(electricSubset) #verify new column created
str(electricSubset$timeCombined) #check to make sure new column is in POSIXct format

#Step 3: Create the Plot
par(mfrow=c(1,1)) #single plot
#Create plot with timeCombined on x axis and Global Active Power on y axis, type=l for lines, no label on x axes and add label for y axis
plot(electricSubset$timeCombined,electricSubset$Global_active_power,type="l",xlab="",ylab="Global Active Power (killowats)")

#Step 4: Copy plot to a PNG File
dev.copy(png,file="plot2.png",width=480,height=480) #save copy as PNG and make file 480x480
dev.off() #close graphics device
