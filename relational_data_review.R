
# Relational data ---------------------------------------------------------

library(tidyverse)
library(nycflights13)

flights <- nycflights13::flights

#  muitas bases de dados, são chamadas de dados relacionais
# porque o que importa são as relações, e não as bases individuais.

# para trabalhar com relational data, são necessárias funções
# para manusear pares de tabela, ou seja, pelo menos dois datasets

# mutating joins esse verbo combina as linhas de dois data frames;

# filtering joins esse verbo filtra a linha de dois data frames
# baseado em se essas linhas combinam ou não;

# set operations ???
# which treat observations as if they were set elements


# relational data - dados relacionais, são tabelas que contêm dados
# sobre a mesma coisa, só que separadamente. A exemplo do data set
# nycflights13

# discover origin of the planes


flights %>% 
  select(origin, dest)

# key, "chave" é a variável que conecta dois data sets 
# esse é o elemento relacional

# uma chave primária deve identificar cada linha de forma única
# uma forma de checar é com a função count(n > 1), no caso de 
# n ser maior do que um, essas colunas não podem ser chaves 
# primárias

flights %>% 
 count(year, dest, tailnum) %>% 
  filter(n > 1)

flights %>% 
  count(year, month, day, flight) %>% 
  filter(n > 1)


ex_1 <- Lahman::Batting

ex_3 <- babynames::babynames

ex_2 <- nasaweather::atmos

ex_2 %>% 
  count(lat, long, year, month, surftemp, temp, pressure, ozone,
          cloudlow, cloudmid, cloudhigh) %>% 
  filter(n > 1)


ex_3 %>% 
  count(year, sex, name, n, prop) %>% 
  filter(n > 1)


# Parei aqui 
# 13.4 Mutating joins
# https://r4ds.had.co.nz/relational-data.html#mutating-joins