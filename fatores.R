# Fatores -----------------------------------------------------------------

# os fatores são utilizados em variáveis categóricas, ou seja, que possuem um
# conjunto de valores predeterminado.

# para trabalhar com fatores no R utilizamos o pacote forcats, presente no meta
# pacote tidyverse

library(forcats)


# Problemas que são solucionados com fatores ------------------------------

# quando se precisar encontrar um padrão de hierarquização entre variáveis 
# categóricas, como por exemplo, meses do ano.


# criando fatores ---------------------------------------------------------

# primeiro, para criar os fatores é preciso estabelecer os níveis.
# assim, cria-se um objeto com os níveis:

meses <- c("Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Agos", "Set",
           "Out", "Nov", "Dez")

# proximo passo criar os farores e nomear os níveis.


x1 <- c("Jan", "Fev", "Mar")


meses_níveis <- c("Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Agos", "Set",
                  "Out", "Nov", "Dez")

fator_meses <- factor(x1, levels = meses_níveis)

factor(x1, levels = x1)



# https://r4ds.had.co.nz/factors.html
# 15.3 General Social Survey - parei aqui
