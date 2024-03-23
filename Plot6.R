#Setting up new directory for assignment
dir.create("CourseProject2")
setwd("CourseProject2")
getwd()   #confirms working directory changed to "CourseProject2"

#Unzipping file for project
"C:\Users\micha\OneDrive\Desktop\exdata_data_NEI_data.zip" #copied path name of compressed zip file

uzp <- "C:/Users/micha/OneDrive/Desktop/exdata_data_NEI_data.zip" #assigned path to variable, "uzp"

unzip(uzp, exdir = "C:/Users/micha/OneDrive/Documents/CourseProject2")  #unzipped variable, "uzp" into the current working directory, aka CourseProject2

#install the proper packages to complete the assignment
install.packages("dplyr")
library("dplyr")
install.packages("ggplot2")
library("ggplot2")
install.packages("scales")
library("scales")
install.packages("data.table")
library("data.table")

#read data tables using function readRDS()
SCC <- readRDS("Source_Classification_Code.rds")
SUMdata <- readRDS("summarySCC_PM25.rds")

#Extract motor vehicle source data from SCC
SCC$vehicle_flag<-ifelse(grepl("vehicle", SCC$EI.Sector,ignore.case = TRUE) == TRUE,1,0)
SCC_MVehicle <- subset(SCC,vehicle_flag==1)
MVehicle_Merge <- merge(SUMdata, SCC_MVehicle, by="SCC")

#Subset motor vehicles in dataset for Baltimore and Los Angeles
Baltimore_LA <- subset(MVehicle_Merge, fips=="24510" | fips=="06037")
Baltimore_LA$city <- ifelse(Baltimore_LA$fips=="24510", "Baltimore", "Los Angeles")

#Getting the total of motor vehicle emissions from Baltimore and Los Angeles by the Year
Balt_LA_Emissions <- aggregate(Emissions ~ year + city, Baltimore_LA, sum)

#Create Plot6.png
png("plot6.png", width=500, height=480)

#Create the ggplot for Plot6.png
ggplot(Balt_LA_Emissions, aes(x = year,y = Emissions, color = city)) +
  geom_line() + geom_point() + xlab("Year") + ylab("Total PM2.5 Emission") +
  ggtitle("Differences in Motor Vehicle Source Emissions between Baltimore and Los Angeles from 1999 to 2008")

dev.off()


