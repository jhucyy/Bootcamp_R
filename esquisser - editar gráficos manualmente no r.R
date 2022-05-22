install.packages("esquisse")
library(esquisse)
library(dados)

dados <- dados::pinguins

dados |> esquisser()  


library(ggplot2)

ggplot(dados) +
 aes(x = especie, y = ilha) +
 geom_tile(size = 1.2) +
 theme_minimal() +
 facet_wrap(vars(sexo))
library(ggplot2)



