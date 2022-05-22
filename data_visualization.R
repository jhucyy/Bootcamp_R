
# Data visualization ------------------------------------------------------

library(tidyverse)

apple_mobility <- read_csv("./apple_mobility_data.csv")

apple_tidy <- apple_mobility %>% 
  pivot_longer(cols =`2020-01-13`:`2020-08-20`, 
                           names_to = "dates", values_to = "mobility_data")

country_averages <- apple_tidy %>% 
  filter(transportation_type == "walking") %>% 
  group_by(country) %>% 
  summarise(walking_average = mean(mobility_data, na.rm = TRUE)) %>% 
  filter(!is.na(country))

# visualization
country_averages %>% 
  mutate(country = fct_reorder(country, walking_average)) %>% 
ggplot(aes(country, weight = walking_average))+
  geom_bar(fill = "purple")+
  coord_flip()+
  ylab("Relative Rate of Walking Direction Requests")+
  xlab("Country")+
  theme_minimal()



ggplot(country_averages, aes(y = reorder(country, walking_average), weight = walking_average)+
  geom_bar(fill = "blue")+
  ylab("Country")+  
  xlab("Relative Rate of Walking Direction Requests")+
  theme_minimal()

  

# Outros tipos de grÃ¡ficos ------------------------------------------------

#converte texto em data

library(lubridate)

apple_tidy$dates <- as_date(apple_tidy$dates)  


italy_spain_data <- apple_tidy %>% 
  filter(country == c("Italy", "Spain") & transportation_type == "walking") %>% 
  group_by(country, dates) %>% 
  summarise(walking_average = mean(mobility_data, na.rm = T))


italy_spain_data %>% 
  ggplot(aes(x = dates, y = walking_average, group = country, color = country))+
  geom_line()+
  facet_wrap(~country)+
  theme_classic()+
  ylab("Relative Volume of Walking Direction")

#facet quebra uma camada em vÃ¡rias
# camadas


# chapter 3-28 R for data science -----------------------------------------
rm(list = ls())
mpg
  

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy))
  

# abaixo esquema para plot
# no ggplot2

# ggplot(data = <DATA>) + 
  # <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
  
 
ggplot(data = mpg)+
  geom_point(mapping = aes(x = class, y = drv))
  
  
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point(aes(color = class)) + geom_line()+
  facet_wrap(~class)+
  theme_bw()

# argument size 

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, size = class),
             show.legend = F)


# alpha aes, controls the transparecy of the points

ggplot(mpg)+
  geom_point(aes(displ, hwy), alpha = 1/3)

ggplot(mpg)+
  geom_point(aes(displ, hwy, alpha = class))


# shape aes, controls the shape of the points

ggplot(mpg)+
  geom_point(aes(displ, hwy, shape = class))
# obs:What happened to the SUVs? ggplot2 will only use six shapes at a time. By default, additional groups will
# go unplotted when you use the shape aesthetic.

# aplicando shape manualmente, selecionando uma das 6
# formas disponÃ­veis;
# para aplicar um argumento manualmente, lembrar que Ã© 
# sempre fora da caixa aes:
ggplot(mpg)+
  geom_point(aes(displ, hwy), shape = 23, fill = "blue")


?mpg



ggplot(mpg)+
  geom_point(aes(displ, hwy), stroke = 1/3)
?geom_point


ggplot(mpg)+
  geom_point(aes(displ, hwy, colour = displ < 5))


# FACETS ------------------------------------------------------------------

# Facets Ã© um argumento estÃ©tico que fragmenta o datset
# em pequenos plots

ggplot(mpg)+
  geom_point(aes(displ, hwy))+
  facet_wrap(~class, nrow = 2)

# facet grid combina duas variÃ¡veis

ggplot(mpg)+
  geom_point(aes(displ, hwy))+
  facet_grid(drv ~ cyl)



ggplot(mpg)+
  geom_point(aes(displ, hwy))+
  facet_wrap(~year)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
# aparentemente alonga o plot e tira a divisÃ£o em linhas



# Objetos geomÃ©tricos (geoms) diferentes ----------------------------------

ggplot(mpg)+
  geom_smooth(aes(displ, hwy, linetype = drv, group= drv))



# combinaÃ§Ã£o de mais de um geom

ggplot(mpg, aes(displ, hwy, group = drv))+
  geom_smooth()+geom_point()



ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color = class))+
  geom_smooth(data = filter(mpg, class == "subcompact"), se = F)


# 1

ggplot(mpg, aes(displ, hwy))+
  geom_point()+geom_smooth(se = F)


# 2
ggplot(mpg, aes(displ, hwy, group = drv))+
  geom_point()+ geom_smooth(se = F)


# 3

ggplot(mpg, aes(displ, hwy, group = drv))+
  geom_point(aes(color = drv))+geom_smooth(aes(linetype = drv), se = F)

# 4

ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color = drv))+geom_smooth(se = F)


# 5

ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color = drv), stroke = 1)


# Transformação estatística -----------------------------------------------

library(tidyverse)


ggplot(data = diamonds)+
  geom_bar(aes(x = cut))

ggplot(data = diamonds)+
  stat_count(aes(x = cut))


demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
demo %>% 
  mutate(cut = fct_reorder(cut, freq)) %>% 
  ggplot()+
  geom_bar(aes(x = cut, y = freq), stat = "identity")

?geom_col
?stat_smooth


ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color))


ggplot(data = diamonds)+
  geom_bar(aes(x = cut, color = cut), show.legend = F)


ggplot(data = diamonds)+
  geom_bar(aes(x = cut, fill = cut))



ggplot(data = diamonds)+
  geom_bar(aes(x = cut, fill = clarity))+
  facet_wrap(~cut)


ggplot(data = diamonds)+
  geom_bar(aes(x = cut, color = clarity),
           position = "identity", fill = NA)


ggplot(data = diamonds)+
  geom_bar(aes(x = cut, fill = clarity),
           alpha = 1/5, position = "identity")


# position = "fill" works like stacking, but makes each set of stacked bars the same height. This makes it easier to compare proportions across groups.

# ggplot(data = diamonds) + 
  # geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
 # position fill ajuda a analisar proporções dos valores entre as 
# barras.


ggplot(data = diamonds)+
  geom_bar(aes(x = cut, fill = clarity), position = "dodge")

# position dodge isola os valores individuais dentro de cada 
# variável, assim é útil para observar valores individuais.



# position jitter, é útil especificamente para scaterplots
# nesse tipo de gráfico é comum um ponto sobrepopor o outro
# usando o argumento position = "jitter" adiciona um valor
# aleatório para a distância de cada ponto, apresentando 
# uma representação mais fiel dos dados;

# You can avoid this gridding by setting the position adjustment to "jitter". position = "jitter" adds a small amount of random noise to each point. This spreads the points out because no 
# two points are likely to receive the same amount of random noise.


ggplot(data = mpg)+
  geom_point(aes(x = displ, y = hwy), position = "jitter")

ggplot(data = mpg)+
  geom_point(aes(x = displ, y= hwy))

# ?position_dodge, ?position_fill, ?position_identity, 
# ?position_jitter, and ?position_stack.

?geom_boxplot


ggplot(data = mpg)+
  geom_boxplot(aes(x = displ, y = hwy), position = "dodge2")



# Sistemas coordenados ----------------------------------------------------


# coord_flip, inverte a ordem do x e do y:

ggplot(data = mpg)+
  geom_boxplot(aes(x = class, y = hwy))+
  coord_flip()
  


# coord_quickmap, serve para plotar a figura de um mapa
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")+
  coord_map()

# coord_polar

ggplot(data = diamonds)+
  geom_bar(aes(x = cut, fill = cut), show.legend = F)+
  labs(x= NULL, y = NULL)+
  coord_polar()+
  theme_gray()


# workflowbasics ----------------------------------------------------------


# padrão de escrita no r mais recomendado
# snake_case, letras minúsculs com a separação de palavras
# com _
