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

#Subset motor vehicles in dataset for Baltimore
Baltimore <- subset(MVehicle_Merge, fips=="24510")

#Get total # of Motor Vehicle emissions in Baltimore by the year
BaltimoreMVehicle <- tapply(Baltimore$Emissions, Baltimore$year, sum)

#Save the total emissions data as a data frame in order to plot it with the ggplot() function
BaltimoreMVehicle <- as.data.frame(BaltimoreMVehicle)
names(BaltimoreMVehicle)[1] <- "Emissions"
rownames(BaltimoreMVehicle) <- c(1:4)
BaltimoreMVehicle$Year <- c(1999, 2002, 2005, 2008)

##Create Plot5.png
png("plot5.png")

#Create the gpplot for Plot5.png
ggplot(BaltimoreMVehicle, aes(x = Year,y = Emissions)) +
  geom_line() + geom_point() +
  labs(x="year", y=expression("Total PM2.5 Emission")) +
  labs(title="PM2.5 Motor Vehicle Source Emissions in Baltimore from 1999 to 2008")

dev.off()


