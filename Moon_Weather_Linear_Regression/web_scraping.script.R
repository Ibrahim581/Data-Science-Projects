# Web scraping data

# Loading libraries
library(tidyverse)
library(rvest)

# Extracting data from url
website = read_html('https://aa.usno.navy.mil/calculated/moon/phases?date=2022-01-01&nump=99&format=t&submit=Get+Data')

Moon_Phase = website %>% 
  html_nodes('tr :nth-child(1)') %>% 
  html_text()

Date = website %>% 
  html_nodes('tr :nth-child(2)') %>% 
  html_text()

Time = website %>% 
  html_nodes('tr :nth-child(3)') %>% 
  html_text()

# Setting a data frame
data <- data.frame(Moon_Phase, Date, Time)

# Deleting the first row
data <- data[-1, ]

# Saving it as csv
write.csv(data, 'moon_data.csv')
