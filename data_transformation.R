
# Data transformation  ----------------------------------------------------

# https://r4ds.had.co.nz/transform.html

library(tidyverse)
library(nycflights13)

flights <- nycflights13::flights
flights

# verbos do dplyr 

# o dplyr é um pacote utilizado para fazer a manipulação da
# base de dados, abaixo os principais verbos/funções:

# filter() - filtra as linhas de uma variável;
# select() - seleciona uma variável/coluna;
# mutate() - cria novas variáveis fazendo operações com as 
# existentes;
# arrange() - reordena as colunas em ordem alfabética ou numérica;
# count() - conta os elementos das variáveis;
# summarize() - calcula as varáveis e resume tudo em um único número;
# group_by() - utilizado em combinação com as demais variáveis,
# agrupa as linhas (iguais) em uma única categoria.


# filter ------------------------------------------------------------------

# filtrar todos os voos de 1 de janeiro

flights %>% 
  filter(month == 1 & day == 1)

# combinações 
#  == quero esse
# != todos menos esse
# > maior que esse 
# >= maior ou igual a esse
# <= menor ou igual a esse
# < menor que esse
# is.na() todos os na
# !is.na() nenhum na
# & esse e esse, combinação de variáveis diferentes
# | esse ou esse, combinação de duas linhas da mesma variável


# filtra todos os voos de novembro ou dezembro 

flights %>% 
  filter(month == 11 | month == 12)

flights %>% 
  filter(month %in% c(11,12))

# exercise

# voo com atraso maior que 2h na chegada

delay_2h <- flights %>% 
  filter(arr_delay >= 120)

# Flew to Houston (IAH or HOU)

IAH_HOU <- flights %>% 
  filter(dest %in% c("IAH", "HOU"))

flights %>% 
  filter(dest == "IAH" | dest == "HOU")

# Were operated by United, American, or Delta - UA AA DL

flights %>% 
  filter(carrier %in% c("UA", "AA", "DL"))

flights %>% 
  filter(carrier == "UA" | carrier == "AA" | carrier == "DL")

# Departed in summer (July, August, and September)

flights %>% 
  filter(month %in% c(7, 8, 9))

flights %>% 
  filter(month == 7 | month == 8 | month == 9)

# Arrived more than two hours late, but didn’t leave late

five <- flights %>% 
  filter(arr_delay == 120 & !is.na(dep_delay <= 0))

# Were delayed by at least an hour, but made up over 30 minutes in flight

six <- flights %>% 
  filter(arr_delay <= 100 & arr_time <= 30 )

# Departed between midnight and 6am (inclusive)

seven <- flights %>% 
  filter(hour %in% c(-24:6))

?between()

# seven_btw <- flights %>% 
#   filter(hour, between(24,6))

         
# missing deep_time

eight <- flights %>% 
  filter(is.na(dep_time))


# summarise e group_by

daily <- flights %>% 
  group_by(year, month, day) %>% 
  summarise(flight = n())

# ungroup

daily %>% 
  ungroup() %>% 
  summarise(flights = n())
# https://r4ds.had.co.nz/transform.html#ungrouping


library(tidyverse)
library(nycflights13)
flights <- nycflights13::flights


flights %>% 
  filter(dep_delay > 50)

flights %>% 
  filter(dep_delay == 10)


(popular_dest <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365))


# What time of day should you fly if you want to avoid delays as much as possible?

avoid_delay <- flights %>% 
  group_by(dep_delay, arr_delay) %>% 
  filter(dep_delay <= 0 & arr_delay <= 0)
# para evitar atrasos os horários mais propícios são entre
# 5 e 8 da manhã

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay) & !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

flights %>% 
  group_by(month, day) %>% 
  arrange() %>% count()

flights %>% select(month, day) 

flights %>% 
  group_by(month) %>% 
  count()


# Atalhos -----------------------------------------------------------------


# ctrl + shift + s executa todo o script de vez
# ctrl + shift + c cria uma linha para escrever, que não é
# executável no script, isto é útil para colocar obs.
# ctrl + shift + r cria uma seção, útil para organizar as obs.
# ctrl + shift + n cria um novo script
# ctrl + s salva as modificações no script
