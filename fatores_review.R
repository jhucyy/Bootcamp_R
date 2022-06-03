
# Factors -----------------------------------------------------------------

# fatores são utilizados com variáveis categóricas, ou seja, variáveis que 
# tem o conjunto de possibilidades/categorias pré-determinado, como as 
# variáveis em string (character)

# obs: as variáveis númericas são por definição, variáveis contínuas, pois o 
# conjunto de possibilidades é virtualmente infinito.


# pacote ------------------------------------------------------------------

# para trabalhar com factors utilizares o pacote forcats presente no 
# metapacote tidyverse

library(forcats)


# criando um fator --------------------------------------------------------

# primeiro, para criar um fator é necessário definir um vetor com todos os 
# valores possíveis dentro desta variável:

# para criar um fator que represente os meses do ano

todos_os_meses <- c("Jan", "Fev", "Mar", "Abr", "Mai", "Jun",
                    "Agost", "Set", "Out", "Nov", "Dez")


meses <- c("Jan", "Mai", "Mar", "Dez")


factor(meses, levels = todos_os_meses)

# para que a ordem em que os valores são apresentados respeite a hierárquia 
# do fator, utiliza-se a função unique()

(fator <- factor(meses, levels = unique(meses)))


# colocando a mão na massa ------------------------------------------------
gss_cat <- forcats::gss_cat

gss_cat %>% 
  count(race)


# obs: quando estamos trabalhando com fatores/factors as duas operações 
# mais comuns são: mudar os níveis dos fatores e alterar os valores
# dos fatores


# Exercise ----------------------------------------------------------------

# 1- apresentar o valor total da var rincome

gss_cat %>% 
  count(rincome)


# visualização com bar chart



gss_cat %>%
  filter(!rincome %in% c("Not applicable")) %>%
  mutate(rincome = fct_recode(rincome,
                              "Less than $1000" = "Lt $1000"
  )) %>% 
  mutate(rincome_na = rincome %in% c("Refused", "Don't know", "No answer")) %>% 
  ggplot(aes(x = rincome, fill = rincome_na))+
  geom_bar(show.legend = F)+
  coord_flip()+
  scale_fill_manual(values = c("FALSE" = "black", "TRUE" = "gray"))+
  theme_classic()

# religião maior

gss_cat %>% 
  mutate(relig = relig %>% fct_infreq()) %>% 
  ggplot(aes(x = relig))+
  geom_bar(fill = "blue", alpha = 2/7)+
  coord_flip()+
  theme_classic()+
  xlab("religião")



# reordenando os fatores --------------------------------------------------

# fct_reorder() é uma função que reordena os fatores a parte de dois
# argumentos, premeiro = o fator que você quer reordenar, segundo = a 
# variável númerica conforme a qual você quer reordenar esse fator.


gss_cat %>% 
  group_by(relig) %>% 
  summarise(age = mean(age, na.rm = T),
                       tvhours = mean(tvhours, na.rm = T)) %>% 
  mutate(relig = fct_reorder(relig, tvhours)) %>% 
  ggplot()+
  geom_point(aes(x = relig, y = tvhours))+
  coord_flip()

# What if we create a similar plot looking 
# at how average age varies across reported income level?


gss_cat %>% 
  group_by(rincome) %>% 
  summarise(age = mean(age, na.rm = T)) %>% 
  mutate(rincome = fct_reorder(rincome, age)) %>% 
  ggplot(aes(x = age, y = rincome))+
  geom_point()

# para bar chats, pode ser utilizado apenas o fct_infreq()
# não precisa de nenhum argumento

gss_cat %>% 
  mutate(marital = marital %>% fct_infreq()) %>% 
  ggplot(aes(x = marital))+
  geom_bar()+
  coord_flip()



# modificando os valores dos fatores com fct_recode -----------------------
gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"    = "Strong republican",
                              "Republican, weak"      = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"        = "Not str democrat",
                              "Democrat, strong"      = "Strong democrat"
  )) %>%
  count(partyid)



# If you want to collapse a lot of levels, fct_collapse() 
# is a useful variant of fct_recode(). 
# For each new variable, you can provide a vector of old levels:

gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
  count(partyid)
s