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
##Help -> Cheat sheets -> Data manipulation
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
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

## Challenge

## 1. How many individuals were caught in each plot_type surveyed?
surveys %>%
  group_by(plot_type) %>%
  tally

## 2. Use group_by() and summarize() to find the mean, min, and 
## max hindfoot length for each species (using species_id).
surveys %>%
  group_by(species_id) %>%
  filter(!is.na(hindfoot_length)) %>%
  summarize(mean_hindfoot = mean(hindfoot_length), 
            min_hindfoot = min(hindfoot_length), max_hindfoot = max(hindfoot_length))

## 3. What was the heaviest animal measured in each year? Return
## the columns year, genus, species_id, and weight.
#Method 1
surveys_max_weight <- surveys %>%
  group_by(year) %>%
  filter(!is.na(weight)) %>%
  filter(weight==max(weight)) %>%
  select(year,genus,species_id,weight) %>% 
  arrange(year) #arrange by year
tally(surveys_max_weight)

##Method 2
surveys %>%
  select(year,genus,species_id,weight) %>%
  group_by(year) %>%
  top_n(1,weight)
##top_n get the top number
#Alternative Method 1
surveys %>%
  group_by(year) %>%
  filter(weight==max(weight), na.rm=TRUE) %>%
  select(year,genus,species_id,weight) %>% 
  arrange(year) #arrange by year
tally(surveys_max_weight)

## 4. You saw above how to count the number of individuals of each sex using a
## combination of group_by() and tally(). How could you get the same result using
## group_by() and summarize()? Hint: see ?n.
surveys %>%
  group_by(sex) %>%
  summarise(n())


##Exporting data and Cleaning up data ----
surveys_complete <- surveys %>%
  filter(species_id != "") %>% #remove missing species_id
  filter(!is.na(weight)) %>% #remove N/As for weight
  filter(!is.na(hindfoot_length)) %>% #remove N/As for hindfoot length
  filter(sex != "")

surveys_complete <- surveys %>%
  filter(species_id != "", 
         !is.na(weight),
         !is.na(hindfoot_length),
         sex != "")
#Remove species that only exist a few times
species_counts <- surveys_complete %>%
  group_by(species_id) %>%
  tally %>%
  filter(n>=50)

#Keep most common species
surveys_common_species <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id) #logical operator: %in%

#Write data output to csv
write.csv(surveys_common_species,file = "data_output/surveys_complete.csv")