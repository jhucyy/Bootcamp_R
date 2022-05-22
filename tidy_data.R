
# Tidy data ---------------------------------------------------------------

# para compactuar com os principios dos dados tidy
# é preciso seguir três fundamentos básicos
# 1 cada variavel deve ter sua coluna
# 2 cada obs sua linha
# 3 cada valor sua celula
# dados tidy, ou organizados, facilitam o processo 
# de manipulação das bases
# em sua maioria, inf baixadas da internet
# não compreendem os principios acima, desta forma, 
# é necessário organiza-los para que se adequem
# duas funções do tidyverse ajudam 
# pivot longer - reorganiza colunas bagunçadas
# pivot wider - reorganiza linhas bagunçadas

library(tidyverse)
rm(list = ls())
table4a
table4a %>% 
  pivot_longer(cols = `1999`:`2000`, names_to = "year", values_to = "population")


table2 %>% 
  pivot_wider(names_from = type, values_from = count)




q()
