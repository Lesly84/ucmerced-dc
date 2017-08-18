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

##Pipes =>    %>%
##Idea f(g o x)
surveys1995 <- surveys %>% 
  filter(year == 1995) %>% #filter is for rows
  select(year, plot_id, species_id, weight) #select is for columns



