###############################################################################
## Plot1.R
##
## Author: Ryan Fry
##
## For Coursera course: 'Exploritory Data Anaysis' assignemnt 1. 
## Task: Create 4 plots to examine how household energy usage varies over a 2-day period in February, 2007
##       This is Plot1. 
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
raw <- raw[raw$Date %in% c('1/2/2007','2/2/2007'),]

#The first chart, the histogram doesn't concern itself with dates or times. 
#so there is no need to convert them. 

#I need gobal active power to be a number
# no clean up needs to be done here as the dataset is already clean. 
raw$Global_active_power <- as.numeric(raw$Global_active_power)

png('Plot1.png',
    width = 480, 
    height = 480)
hist(raw$Global_active_power,
     xlab = 'Global Active Power (Kilowatts)',
     main = 'Global Active Power',
     col = 'red')
dev.off()