#############################
##CaseStudy1 Project 
#############################

### Loads required library to complete data cleaning and data analysis
library(readr)
library(dplyr)
library(ggplot2)
library(stringr)
library(data.table)
library(Hmisc)

#Read files into dataframe  
# Using the "read_csv" from readr package helps eliminate the need to use stringasFactors= F
GDP.data <- read_csv("GDP.csv",skip =3)  
Educ.data <- read_csv("Edu.csv") 

#GDP data has some irrelevant columns: we pick the relevant ones
GDP.data <- GDP.data[, c(1, 2, 4, 5)]
GDP.data <- GDP.data[-c(1:2),]

#Rename column
colnames(GDP.data) <- c("Country_Code", "Rank", "Country_Name", "GDP_Value")

#Examining  our dataset
head(GDP.data)
head(Educ.data)

#Replace all empty spaces within Educ_data columns with an underscore
colnames(Educ.data) <- str_replace_all(colnames(Educ.data)," ","_")

#Since we are not going to use all columns in  Education dataset, we'll select the most relavant for our analysis  
Educ.data <- Educ.data %>% 
  select(CountryCode,Long_Name,Short_Name, Income_Group,Region,Currency_Unit)  

# Now check for number of NA's in all columns within GDP and Educ dataset
for (i in GDP.data){
  length1 <- is.na(i)
  print (sum(length1))
}

for (i in Educ.data){
  length1 <- is.na(i)
  print (sum(length1))
}

#Convert the Character GDP column in the GDP_data to Numeric  and remove the commas
GDP.data$GDP_Value <- as.numeric(str_replace_all(GDP.data$GDP_Value,",",""))
#Convert rank column to numbers 
GDP.data$Rank <- as.numeric(GDP.data$Rank)

write.csv(GDP.data, file = "GDP_Clean.csv")
write.csv(Educ.data, file = "Edu_Clean.csv")