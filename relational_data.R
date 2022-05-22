rm(list = ls())


# Relational data ---------------------------------------------------------
# https://r4ds.had.co.nz/relational-data.html

# é muito comum em uma análise em uma base de dados
# dispor de vários data tables, esses casos são classificados
# como dados relacionais, ou relational data, porque é a 
# relação coletiva dos diferentes data sets que importa
# e não um data set em particular.

# funções comuns para se usar nesses casos
# Mutating joins, which add new variables to one data frame from matching observations in another.

# Filtering joins, which filter observations from one data frame based on whether or not they match an observation in the other table.

# Set operations, which treat observations as if they were set elements


# Prática -----------------------------------------------------------------

library(tidyverse)
library(nycflights13)

airlines
airports
planes
weather

# keys, as chaves conectam as varáveis que estabelecem 
# relações, as chaves devem ser combinadas para 
# corroborar com a informação que se quer obter
# por exemplo, no caso de querer encontrar o clima
# é necessário combinar as variáveis, year, hour, origin,
# dest, day...


weather %>% 
  count(year, day, month, hour, day, origin) %>% 
  filter(n > 1)

flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)


flights2 %>% 
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")


flights2 %>% 
  left_join(weather)


airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()



flights %>%
  mutate(tot_delay = arr_delay + dep_delay) %>%
  group_by(tailnum) %>%
  summarize(avg_delay = mean(tot_delay, na.rm = TRUE)) %>%
  left_join(select(planes, tailnum, year), by = "tailnum") %>%
  mutate(year = 2013 - year) %>%
  ggplot(aes(avg_delay, year)) +
  geom_point() +
  geom_smooth()
