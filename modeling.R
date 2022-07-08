# Modelagem de dados observacionais


# Como faze"./Wapo_Opioid_Data.Rdata")
r análises observacionais no R ---------------------------------

library(tidyverse)

remedios <- opioid_data


ggplot(remedios, aes(y = num_pills,
                     x = republican_vote))+
  geom_point()+
  geom_smooth(method = "lm", formula = y = x)+
  theme_classic()

