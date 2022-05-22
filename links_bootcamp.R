# https://sicss.io/boot_camp/
# https://sicss.io/curriculum
# https://sicss.io/2021/fgv-dapp-brazil/pre_arrival

library(tidyverse)

# R basics - basics operations --------------------------------------------

# acessar uma linha específca em uma variável
# dentro de uma coluna
covid_tweets$tweet_text[1]

ggplot(data = mpg)+
  geom_point(aes(x = displ, y = hwy))

filter(mpg, cyl == 8)

filter(diamonds, carat > 3)

?mean

random_vector <- c("R","is","great")

random_vector[3]

class(random_vector)

some_vector <- c(25555,342343,123123123,4234234,53243234,54324234,5421111,12312312,111231,
                 1231231,12312312,12312312,123123,898972,789872,2343,23423423,2343221,23423,
                 14444,44324222,2342341,124231111,22233345,1111233333,1231231,1231231)

mean(some_vector)
mean(some_vector)
max(some_vector)
min(some_vector)

?max

# max e min function, retornam o maior e o menor número em
# em uma variável numérica


library(devtools)

# congresso <- load(url('https://dssoc.github.io/datasets/congress.RData'))

glimpse(congress)
class(congress)
class(congress$birthyear)


idades <- congress$birthyear

idades_congressistas <- 2022 - idades

view(idades_congressistas)

mean(idades_congressistas)

2022 - 1952
2022 - 1933  

idades_1 <- data.frame(idades_congressistas)


count(idades_1)

idades_1 %>% 
  max()

2022 - 89

