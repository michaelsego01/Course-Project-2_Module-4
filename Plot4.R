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

#Extract data related to coal combustion sources ONLY

SCC$coal_flag<-ifelse(grepl("coal", SCC$EI.Sector,ignore.case = TRUE) == TRUE,1,0)
SCC_Coal <- subset(SCC,coal_flag==1)
Coal_Merge <- merge(SUMdata, SCC_Coal, by="SCC")


#get the total emissions by year then save it as a data frame in order to plot it with the ggplot() function
SUM_Coal <- tapply(Coal_Merge$Emissions, Coal_Merge$year, sum)
SUM_Coal <- as.data.frame(SUM_Coal)
names(SUM_Coal)[1] <- "Emissions"
rownames(SUM_Coal) <- c(1:4)
SUM_Coal$Year <- c(1999, 2002, 2005, 2008)

#Create Plot4.png
png("plot4.png")


#Create plot for Plot4.png
ggplot(SUM_Coal, aes(x = Year,y = Emissions)) +
  geom_line() + geom_point() +
  labs(x="year", y=expression("Total PM2.5 Emission")) +
  labs(title="PM2.5 Coal-Combustion Source Emissions Across the US from 1999 to 2008")

dev.off()
