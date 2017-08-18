##Lesly Lopez
##Graph data in dc workshop
##llopez84@ucmerced.edu
##08/18/17

##Visualization 
#install.packages('tidyverse')
library(tidyverse)

##Read in data from common species
surveys_complete <- read.csv('data_output/surveys_complete.csv')

##General Plotting ----
##Plot data
ggplot(data = surveys_complete, aes(x = weight, y = hindfoot_length)) +
         (geom_point())
ggplot(data = surveys_complete, aes(x = weight, y = hindfoot_length)) +
  (geom_point(alpha = 0.2, aes(color = species_id)))
##alpha: transparancy changes
#Make a mapping things in this list, pick from a color palette

## Challenge
## Use what you just learned to create a scatter plot of weight over species_id
## with the plot types showing in different colors. Is this a good way to show
## this type of data?
ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  (geom_point(alpha = 0.2, aes(color = plot_type)))

##Try boxplot instead of scatterplot
ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
  (geom_boxplot(alpha = 0.2, aes(color = plot_type)))

##Divid boxplot by sex
ggplot(data = surveys_complete, aes(x = species_id, y = weight)) + 
  facet_grid(sex ~ .) +
  (geom_boxplot(alpha = 0.2, aes(color = plot_type))) 

##Time Series ----
##Get yearly counts
yearly_counts <- surveys_complete %>%
  group_by(year,species_id) %>%
  tally
##Plot time series
ggplot(data = yearly_counts, aes(x = year, y = n)) + 
  geom_line()
##Want time series for each species
##group = species_id to group 
ggplot(data = yearly_counts, aes(x = year, y = n,group = species_id, 
                                 color = species_id)) + 
  geom_line() +
  facet_wrap(~ species_id)

#Facet_grid is more ordered. 
ggplot(data = yearly_counts, aes(x = year, y = n,group = species_id, 
                                 color = species_id)) + 
  geom_line() +
  facet_grid(~ species_id)

##Yearly sex count
yearly_sex_counts <- surveys_complete %>%
  group_by(year,species_id,sex) %>%
  tally

##Plot yearly sex count
ggplot(data = yearly_sex_counts, aes(x = year, y = n, color = sex)) + 
  geom_line() +
  facet_wrap(~ species_id)

##Challenge
## Use what you just learned to create a plot that depicts how the average 
## weight of each species changes through the years.

##Find avg weight of species per year
yearly_weight_avg <- surveys_complete %>%
  group_by(species_id, year) %>%
  summarize(species_weight_avg = mean(weight))
##Plot time series of avg weight of species
ggplot(data=yearly_weight_avg, aes(x = year, y = species_weight_avg, 
                                   color = species_id)) +
  geom_line() +
  facet_wrap(~ species_id) + 
  labs(x = "Year", y = "Mean Weight (g)")
##Themes: format base plot ----
##Plot time series of avg weight of species
yrly_avg_weight_plot <- ggplot(data=yearly_weight_avg, aes(x = year, y = species_weight_avg, 
                                   color = species_id)) +
  geom_line() +
  facet_wrap(~ species_id) + 
  labs(x = "Year", y = "Mean Weight (g)") +
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90), legend.position = "none")
##theme(): adjust axis text color, change spacing, etc

#Save plot
ggsave("yearly_average_weight_plot.png", yrly_avg_weight_plot)
