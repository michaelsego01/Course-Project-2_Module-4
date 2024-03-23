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

#Subset dataset to only include data from Baltimore City (fip = 24510)
Baltimore <- subset(SUMdata, fips==24510)

#summing up the Emissions by year in Baltimore
BaltimoreEmissions <- tapply(Baltimore$Emissions, Baltimore$year, sum)

#make Plot3.png
png("plot3.png")

#make a ggplot for plot3.png
ggplot(Baltimore, aes(factor(year), Emissions, fill=type))+
  geom_bar(stat="identity") +
  facet_grid(. ~type)+
  labs(x="year", y=expression("Total PM2.5 Emission (Tons)")) + 
  labs(title="PM2.5 Emissions, Baltimore City 1999-2008 by Source Type")

dev.off()

