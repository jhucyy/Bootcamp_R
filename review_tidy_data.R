rm(list = ls())

install.packages("tidyverse")
library(tidyverse)


apple <- load("./Apple_Mobility_Data.Rdata")

brazil <- apple_data %>% 
  filter(region == "Brazil")


regions <- apple_data %>% 
  select(region)


transport_types <- apple_data %>% 
  count(transportation_type)


alpha_order <- apple_data %>% 
  arrange(region)

glimpse(apple_data)





apple_data_tidy <- apple_data %>% 
  pivot_longer(cols = `2020-01-13`:`2020-08-20`, 
               names_to = "dates", values_to = "mobility_data")


