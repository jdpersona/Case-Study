### Loads required library to complete data cleaning and data analysis
library(readr)
library(dplyr)
library(ggplot2)
library(stringr)
library(data.table)
library(Hmisc)

#Read in Clean Data for use in Analysis
GDP.data <- read_csv("GDP_Clean.csv")[ ,2:5]
Educ.data <- read_csv("Edu_Clean.csv")[ ,2:5]

#Question1 
#Merge our dataset and remove NA's

merge_GDP_EDU <- 
  merge.data.frame(GDP.data,Educ.data, by.x = "Country_Code", by.y = "CountryCode") %>% 
  na.omit()

#Question 2
#Sort the data frame in ascending order by GDP (so United States is last). What is the 13th country in the resulting data frame?
merge_GDP_EDU <- merge_GDP_EDU %>% 
  select(everything()) %>% 
  arrange(GDP_Value) 

merge_GDP_EDU[13,3]

# Question3
Avg_GDP <- merge_GDP_EDU %>% 
  select(everything()) %>% 
  group_by(Income_Group) %>%
  summarise(Average_GDP = mean(Rank))%>%
  filter(Income_Group %in%  c("High income: OECD","High income: nonOECD"))

Avg_GDP

#Question4
ggplot(merge_GDP_EDU, aes(y = GDP_Value, x=Income_Group,fill=Income_Group)) + 
  scale_y_log10()+ 
  geom_point(pch = 21, size = 8, stat = "identity", position=position_jitter())+
  scale_fill_manual(values = c("red", "orange", "green", "blue","brown"),
                    na.value = "grey50" ) + theme(axis.text.x = element_text(angle = 45, hjust = 1))


#Question 5
merge_GDP_EDU$Quantiles <- cut2(merge_GDP_EDU$Rank, g=5)
table(merge_GDP_EDU$Quantiles, merge_GDP_EDU$Income_Group)
#How many countries are Lower middle income but among the 38 nations with highest GDP
merge_GDP_EDU[151:189,c(1,2,3,4,7)] %>% 
  filter(Income_Group=="Lower middle income") 