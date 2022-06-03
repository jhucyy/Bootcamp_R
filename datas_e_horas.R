
# datas e hora ------------------------------------------------------------


# pacotes -----------------------------------------------------------------

library(lubridate)
library(nycflights13)

# vetores de data e tempo são identificados assim no tibble <date>, <time>
# ou <dttm> quando são os dois 


# ()today or now() apresenta a data atual

today()
now()


# 3 tipos de objetos podem ser transformados em data e hora
# 1 string; 2 data e hora separados e 3 um vetor de data e hora preexistente


# criando date times a parte de dados preexistentes separadas em diferentes
# colunas

flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))


# Exercícios --------------------------------------------------------------

# parsing dates:

d1 <- "January 1, 2010"

mdy(d1)


d2 <- "2015-Mar-07"
ymd(d2)


d3 <- "06-Jun-2017"
dmy(d3)


d4 <- c("August 19 (2015)", "July 1 (2015)")
mdy(d4)

d5 <- "12/30/14"

mdy(d5)



# Pegando os componentes --------------------------------------------------

# 
# You can pull out individual parts of the date with the accessor 
# functions year(), month(), mday() (day of the month), yday() 
# (day of the year),
# wday() (day of the week), hour(), minute(), and second().

datetime <- ymd_hms("2016-07-08 12:34:56")

year(datetime)

# pegando o dia da semana, com o argumento label pega a abreviação do 
# dia, e com o argumento abbr= F anula a abreviação e mostra o nome todo
wday(datetime, label = T, abbr = F)


hour(datetime)

month(datetime, label = T, abbr = F)



# Utilizando  o wday para pegar os dias da semana em que houve mai --------

flights %>% 
  mutate(wday = wday(dep_time, label = T, abbr = F)) %>% 
  mutate(wday = wday %>% fct_infreq()) %>% 
  filter(!is.na(wday)) %>% 
  ggplot() +
  geom_bar(aes(x = wday))+
  coord_flip()+
  theme_classic()+
  xlab("dias_da_semana")
