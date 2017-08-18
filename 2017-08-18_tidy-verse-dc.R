##Lesly Lopez
##Tidy data in dc workshop
##llopez84@ucmerced.edu
##08/18/17


##Read in Portal data into R ----
surveys <- read.csv("data/portal_data_joined.csv")

##Install tidy verse package
#install.packages('tidyverse')
##Load package
library(tidyverse)

##Select the columns plot_id, species_id and weight
select(surveys, plot_id, species_id, weight)

#Filter rows where year is 1995
filter(surveys, year == 1995)

##Pipes =>    %>% ----
##Idea f(g o x)
surveys1995 <- surveys %>% 
  filter(year == 1995) %>% #filter is for rows
  select(year, plot_id, species_id, weight) #select is for columns

##Adding a column for weight (kg) with mutate
surveys %>%
  filter(!is.na(weight)) %>% ##Remove N/A by adding filter
  mutate(weight_kg = weight/1000, #mutate adds a column
         weight_kg2 = weight_kg * 2) %>% #add two columns at once
  tail


##Challenge
##Create a new data frame from the surveys data that meets the following criteria: 
##contains only the species_id column and a new column called hindfoot_half 
##containing values that are half the hindfoot_length. 
##In this hindfoot_half column, there are no NAs and all values are less than 30.

##Note: names(surveys) colnames(surveys) returns names of types of data
#Method 1
surveys_challenge <- surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  mutate(hindfoot_half = hindfoot_length/2) %>%
  filter(hindfoot_half<30) %>%
  select(species_id, hindfoot_half)

#Method 2
surveys_challenge2 <- surveys %>%
  mutate(hindfoot_half = hindfoot_length/2) %>%
  filter(hindfoot_half<30 & !is.na(hindfoot_half)) %>% #or replace & w/ ,
  select(species_id, hindfoot_half)
 
##Check info is correct
head(surveys_challenge)
dim(surveys_challenge)

##group_by and summarize functions ----
##When you want to summarize, you use group_by
##Do data maninupalation to get something out of the raw data
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = T))
##Add species name
surveys %>%
  filter(!is.na(weight), sex =="F" | sex == "M") %>%
  group_by(species_id, sex) %>%
  summarize(mean_weight = mean(weight), min_weight = min(weight))

##Tally ----
##Tally: get total count
surveys %>%
  group_by(sex) %>%
  tally

