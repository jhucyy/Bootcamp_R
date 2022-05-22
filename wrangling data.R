
# Data Wragling -----------------------------------------------------------

rm(list = ls())

# installing packages function install.packages()

# install.packages("tidyverse")

library(tidyverse)

# pacotes são importantes para implementar diversas
# funcionalidades no R, tidyverse é essencial para as fuções
# de manuseio e limpeza de base dados, para cada necessidade
# o R apresenta um catalógo de pacotes, disponíveis online

# para usar um pacote, é necessário instalar, caso não tenha,
# e carregá-lo com a função library() sempre que for utilizar
# run the package every time you'll use it.


# base de dados apple_data -------------------------------------------------

# esse data set demonstra quão longe as pessoas estão indo
# no período de pandemia

apple_data

# tibble são mais facieis de visualizar e navegar

Brazil <- apple_data %>% 
  filter(country == "Brazil")

# A função filter do pacote dplyr dentro do tidyverse
# serve para filtrar linhas dentro de variáveis


transport_types <- apple_data %>% 
  count(transportation_type)


# ordenar as variáveis conforme algum padrão, nesse
# caso, em ordem alfabética.


alpha_order <- apple_data %>% 
  arrange(region)

# a função arrange ordena as bases conforme algum padrão


# fazer perguntas aos dados, reestruturar a base inicial
# para atender as minhas necessidades

# calcular o nível de mobilidade nos países

long_apple_data <- gather(apple_data, key = day, value = mobility_data, `2020-01-13`:`2020-08-20`)

?gather
# gather aloca os dados de várias colunas em uma só, a partir dos argumentos


?pivot_longer()

pivot <- pivot_longer(apple_data, cols = `2020-01-13`:`2020-08-20`, names_to = "day" )

# o pacote pivot_longer é agora mais recomendado
# para fazer esse tipo de operação
# pois gather() já não está sendo mais atualizado


# tibbles -----------------------------------------------------------------

as.tibble(iris)
# coage data frames para tibbles


# Importing data ----------------------------------------------------------

# necessário readr package parte do tidyverse

library(tidyverse)

# function read_file diferentes tipos de files mais comum
# read_csv, read_csv2, read_delim

# csv comma separeted files 
# arquivos separados por vírgulas, geralmente,
# tabelas de excel

# como usar?
# read_csv("//path to the file")

setwd("C:/Users/labhd_juciane/OneDrive/Documentos/revisao_r")

write_csv(Brazil, "brazil.csv")
Brazil <- read_csv("brazil.csv")


Brazil <- pivot_longer(Brazil, cols = `2020-01-13`:`2020-08-20`, names_to = "day")

glimpse(Brazil)


# Data import -------------------------------------------------------------


# data importation is an importante part of working with
# big data, for this we are going to use the readr package
# wich is inside the tidyverse package in a R
# load tidyverse below:

library(tidyverse)

# function of the readr package

# most of the funcitions of the readr's package turns
# flat data into data frames like

# read_csv()
# read_table()
# read_log()

# all of this functions work with very similar sintaxe
# we'll focus on the read_csv, because most files
# are stored in this format
# the first argument to this function is the path to the
# file

# read_csv("//path")

# if the column doesn't have names, use the argument
# col_names = FALSE, so the R won't treat the first 
# columns as the names
# also, you can use the argument
# col_names = c(...) to give the columns names


# Pivot wider -------------------------------------------------------------


# pivot wider organize the table if the rows are messy 
# see an example below:

library(tidyverse)

table2
# in this tible the rows are mixed with what should be 
# the columns names

table2_tidy <- table2 %>%
  pivot_wider(names_from = type, values_from = count)


# Pivot longer ------------------------------------------------------------
# have columns names
# in this case we are gonna fix a tibble that doesn't
# have colunm name and the first row is taken as the
# columns names
table4a

table4a_tidy <- table4a %>% 
  pivot_longer(cols = `1999`:`2000`, names_to = "year",
               values_to = "population")



# Left_join ---------------------------------------------------------------

# now to unite the two tibles we use the function
# left_join

new <- left_join(table2_tidy, table4a_tidy)



table2_tidy <- table2_tidy %>% 
  select("country", "year", "population")


glimpse(table2_tidy)
glimpse(table4a_tidy)


table4a_tidy$year <- table4a_tidy$year %>% 
  as.integer(table4a_tidy$year)



# -------------------------------------------------------------------------

table4a %>% 
  pivot_longer(cols = `1999`:`2000`, names_to = "year",
               values_to = "cases")



# Separate ------------------------------------------------------------------

# separate is used to spread one column into multiple
# columns, see the case of table3

table3

# separate work with two main arguments
# separate to indicate wich column shall be separated
# and into, to express how they shoud be separeted

table3 %>% 
  separate(rate, into = c("cases", "population"))


table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")


table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")




# using the argument convert = TRUE helps the function 
# to try in find a better format for the columns

table3 %>% 
  separate(rate, into = c("cases", "population"),
           convert = TRUE)

# tests

table5 <- table3 %>% 
  separate(year, into = c("century", "year"),
           sep = 2)


table3 %>% 
  separate(year, into = c("century", "year"),
           sep = 2)

table3 %>% 
  separate(year, into = c("century", "year"),
           sep = 2)


table5 %>% 
  unite(new, century, year, sep = "") %>% 
  separate(rate, into = c("cases", "population")) %>% 
  rename(year = new)


table5 <- table5 %>% 
  separate(rate, into = c("cases", "population"))


# Unite -------------------------------------------------------------------

# it does the opposite of separate, it unify different 
# columns

# In this case we also need to use the sep argument. 
# The default will place an underscore (_) 
# between the values from different columns. 
# Here we don't want any separator so we use ""

table5 %>% 
  unite(new, century, year, sep = "")
# revisao
table4a %>% 
  pivot_longer(cols = `1999` : `2000`,
               names_to = "year", values_to = "population")

table2 %>% 
  pivot_wider(names_from = type, values_from = count)

table_sep <- table2_tidy %>% 
  separate(population, into = c("centenas", "dezenas"),
           sep = 2)

table_sep %>% 
  unite(population, centenas, dezenas, sep = "")

# Final Exercise ----------------------------------------------------------
# data base:

tidyr::who

glimpse(who)


who1 <- who %>% 
  pivot_longer(cols = new_sp_m014:newrel_f65 , 
               names_to = "key", values_to = "cases",
               values_drop_na = TRUE)


who1 %>% 
  count(key)


who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))


who3 <- who2 %>% 
  separate(key, into = c("new", "type", "sexage"),
           sep = "_")



who4 <- who3 %>% 
  select(-iso2, -iso3, -new)


who5 <- who4 %>% 
  separate(sexage, into = c("sex", "age"), sep = 1)




# -------------------------------------------------------------------------


rm(list = ls())

who <- who %>% 
  pivot_longer(cols = new_sp_m014:newrel_f65,
               names_to = "key", values_to = "cases",
               values_drop_na = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>% 
  separate(key, into = c("new", "var", "sexage")) %>% 
  select(-iso2, -iso3, -new) %>% 
  separate(sexage, into = c("sex", "age"), sep = 1)
  
  
who %>% 
  group_by(country, year, sex) %>% 
  count() %>% arrange(n) %>% 
  top_n(n = 5) %>% 
  ggplot(aes(x = year, y = country))+
  geom_line()

?top_n

who %>%   group_by(country, year, sex) %>%
  filter(year > 1995) %>%
  summarise(cases = sum(cases)) %>%
  unite(country_sex, country, sex, remove = FALSE) %>%
  ggplot(aes(x = year, y = cases, group = country_sex, colour = sex)) +
  geom_line()+
  facet_wrap(~sex)




