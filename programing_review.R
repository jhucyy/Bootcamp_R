
# Programing --------------------------------------------------------------

# Pipes -------------------------------------------------------------------

# pipes fazem parte do pacote magrittr, que está dentro do tidyverse

# carregando o pacote

library(magrittr)

# o objetivo do pipe é ajudar na escrita do código, de uma forma que simples
# e sucinta, de modo que simplifique a leitura e compreensão do código


# Exemplo: ----------------------------------------------------------------
# pipe ajuda na simplificação para a combinação de funções

library(tidyverse)

flights <- nycflights13::flights

flights %>% 
  select(distance, origin) %>% 
  mutate(origin = fct_reorder(origin, distance)) %>% 
  ggplot(aes(x = origin, y = distance))+
  geom_col()+
  coord_flip()


# funções -----------------------------------------------------------------

# https://r4ds.had.co.nz/functions.html

