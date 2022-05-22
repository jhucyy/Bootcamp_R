rm(list = ls())

library(tidyverse)
library(nycflights13)

flights <- nycflights13::flights


# Data transformation -----------------------------------------------------

# análise de dados exploratória 

# técnicas de manipulação e visualização do resultados preliminares;
# esta etapa de análise de dados exploratória ajuda a:
# 1- gerar perguntas sobre os dados;
# 2- testar as hipóteses a partir de visualizações, transformação e
# modelagem dos dados;
# 3- usar o que você aprendeu a partir destes testes para refinar
# suas perguntas e gerar novas perguntas.

# all the steps os EDA = exploratory data analisys
# visualisation, transformation and modelling


# Pré-requisitos ----------------------------------------------------------

library(tidyverse)

# princípios do eda
# identificar a variação da variável;
# identificar relações de covariação entre as variáveis.

# categorical variables / variáveis categóricas
# cada valor corresponde a representação de um aspecto 
# são salvas como factors ou characters
# gráfico mais propício para este tipo de variável é o bar chart:

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut))


# countinouns variable / variável contínua

# uma variável é contínua se contém um número infinito de dados
# ordenados para cada varíavel, datas e horas são representativos
# deste tipo de dados.
# para variáveis contínuas gráficos histograms

ggplot(data = diamonds)+
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

ggplot(diamonds)+
  geom_freqpoly(aes(x = carat, color = cut), binwidth = 0.1)


ggplot(diamonds)+
  geom_freqpoly(aes(x = price, color = cut))+
  facet_wrap(~cut)

# relação, quanto melhor o corte, maior o preço do diamante
# identifica covariação entre duas variáveis no date set diamantes


diamonds %>% 
  filter(carat == 0.99 | carat == 1) %>% 
  ggplot()+
  geom_freqpoly(aes(x = carat))

diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y)) %>% 
  ggplot()+
  geom_point(aes(x = x, y = y), position = "jitter",
             na.rm = T)



flights %>% 
  filter(is.na(dep_time)) %>% 
  ggplot()+
  geom_histogram(aes(x = dep_time))


flights %>% 
  filter(is.na(dep_time)) %>% 
  ggplot()+
  geom_bar(aes(x = dep_time))

# 7.5 Covariation
# https://r4ds.had.co.nz/exploratory-data-analysis.html
# parei aqui