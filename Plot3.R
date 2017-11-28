###############################################################################
## Plot3.R
##
## Author: Ryan Fry
##
## For Coursera course: 'Exploritory Data Anaysis' assignemnt 1. 
## Task: Create 4 plots to examine how household energy usage varies over a 2-day period in February, 2007
##       This is Plot3. 
##
## Assumptions: Presumes that the data file outlined in the assignment has been downloaded 
##              to the working directory. 
###############################################################################

##Read the data 

##First, unzip the file. 
unzip('exdata%2Fdata%2Fhousehold_power_consumption.zip')

#The file is delimited with semi-colons. 
raw <- read.csv('household_power_consumption.txt',
                sep = ';',
                stringsAsFactors = F)

#remove the unzipped file
unlink('household_power_consumption.txt')

#drop what we don't need
## > and < string comparison won't work for these values, because they are not DD/MM/YYYY
## They use single digit months and days in addition to two digit. 
## since we're dealing with a small number of dates, it's easier to list them explicitly
# note also that the dataset has already been cleaned, so additional steps are not required.
raw <- raw[raw$Date %in% c('1/2/2007','2/2/2007'),]

raw$dateTime <- paste(raw$Date, raw$Time,
                      sep = '|')

raw$dateTime = strptime(raw$dateTime, 
                        format = '%d/%m/%Y|%H:%M:%S')

#convert the submetering fields to numeric
fieldsToConvert <- c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
raw[fieldsToConvert] <- sapply(raw[fieldsToConvert], as.numeric)

png('Plot3.png')
#plotting multiple lines, but they have a common value range. So, plot the first one
#the first one being the one with the largest Y value. 
plot(y = raw$Sub_metering_1, 
     x = raw$dateTime,
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering')
#then add additional lines
lines(y = raw$Sub_metering_2,
      x = raw$dateTime,
      type = 'l',
      col = 'Red')
lines(y = raw$Sub_metering_3,
      x = raw$dateTime,
      type = 'l',
      col = 'Blue')
legend('topright', 
       legend = fieldsToConvert,
       col = c('Black', 'Red', 'Blue'),
       lty = c(1,1))
dev.off()