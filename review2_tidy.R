
# Wrangling data - revisão ------------------------------------------------

# o processo de wrangling, é justamente o processo de manipulação
# da base de dados, envolve várias etapas, 

# Importar > Limpar > transformar(modelagens e visualização) >
# comunicar

# mas esse é um processo cíclico de idas e vindas.


# tibbles -----------------------------------------------------------------

library(tidyverse)

# tibble é o data frame próprio para trabalhar com o tidyverse

as_tibble(iris)

# essa função transforma qualquer data frame em tibble

# para criar o vetor como tibble basta usar a função 
# tibble()

tibble(x = 1:5, y = 7 - 2)

# diferente do data.frame o tibble, não altera a classe dos objetos
# não altera o nome das linhas ou das variáveis.

# diferenças com data.frame

# print, diferente do data.frame o tibble apenas mostra as 10 
# primeiras linhas de uma tabela,e  aparecem apenas as colunas
# que encaixam na tela, junto com a classe das variáveis.

# com tibble é possível controlar o padrão da visualização

nycflights13::flights %>% 
  print(n = 10, width = Inf)


nycflights13::airports %>% 
  print(n = 20, width = Inf)

# n = número de linhas, width = Inf, quer dizer printar todas
# as colunas


nycflights13::flights %>% 
  View()

# subsseting

df <- tibble(x = 1:5, y = 2 * 3)

df$x
df[[2]]

mtcars

as_tibble(mtcars)

var <- tibble("mpg")

var$`"mpg"`
var[[1]]



# Data import -------------------------------------------------------------

# neste capítulo trabalharemos com o readr package parte do 
# tidyverse para importação de dados

read_csv()

# função útil para ler tabelas separadas por vírgulas, o tipo 
# mais comum de base

# o primeiro argumento mais importante para read_csv é o caminho

dados <- read_csv("./apple_mobility_data.csv")


# Tidy data ---------------------------------------------------------------

rm(list = ls())

table2

# compute the rate of table2
# primeiro vou precisar transformar as linhas da coluna type 
# em duas colunas, para separar os valores
# para isso uso pivot_wider

table2_tidy <- table2 %>% 
  pivot_wider(names_from = type, values_from = count)

rate_table2 <- table2_tidy %>% 
  mutate(rate = cases / population * 10000)


# rate table4a + table4b

table4a

# pivot_longer para consertar as colunas

table4_tidy <- table4a %>% 
  pivot_longer(cols = `1999`:`2000`, names_to = "year", 
               values_to = "population")




table4b_tidy <- table4b %>% 
  pivot_longer(cols = `1999`:`2000`, names_to = "year", 
               values_to = "population") 
  

tidy <- table2 %>% 
  pivot_wider(names_from = type, values_from = count)

plot <- tidy %>% 
  mutate(rate = cases / population * 10000) %>% 
  ggplot(aes(year, cases))+
  geom_line(aes(group = country), color = "grey50")+
  geom_point(aes(color = country))+
  theme_classic()


# pivot_longer

tidy_4a <- table4a %>% 
  pivot_longer(cols = `1999`:`2000`, names_to = "year",
               values_to = "cases")

tidy_4b <- table4b %>% 
  pivot_longer(cols = `1999`:`2000`, names_to = "year",
               values_to = "population")

new <- left_join(tidy_4a, tidy_4b)

# left_join junta os dois datasets

table2 %>% 
  pivot_wider(names_from = type, values_from = count)

people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

people_tidy <- people %>% 
  pivot_wider(names_from = names, values_from = values)


preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

preg %>% 
  pivot_longer(cols = "male":"female", names_to = "gender",
               values_to = "age")

# separate

table3 %>% 
  separate(rate, into = c("cases", "population"))

table3 %>% 
  separate(rate, into = c("cases", "population"),
           convert = T)

table_sep <- table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

table_sep %>% 
  unite(new, century, year, sep = "")

treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)


treatment %>% 
  fill(person)


who <- tidyr::who
glimpse(who)


who_1 <- who %>% 
  pivot_longer(cols = new_sp_m014:newrel_f65, names_to = "key",
               values_to = "cases", values_drop_na = TRUE)


who_tidy <- who_1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>% 
  separate(key, into = c("new", "type", "sexage"), sep = "_") %>% 
  separate(sexage, into = c("sex", "ages"), sep = 1) %>% 
  select(-new, -iso2, -iso3)



by_year <- who_tidy %>% 
  group_by(year) %>% 
  count() %>% arrange(-n)


by_sex <- who_tidy %>% 
  group_by(sex) %>% 
  count() %>% arrange(-n)



# parei em relational data