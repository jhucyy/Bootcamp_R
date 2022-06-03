
# Strings -----------------------------------------------------------------


library(tidyverse)
# é possível fazer strings com "" or '', como critério de boas práticas é 
# recomendado fazer strings com "" a não ser que vá se utilizar strings dentro
# de stings "''", ex:

string_1 <- "this is a string"
string_2 <- "this also a string"
string_3 <- "'this is a string inside a string"


# várias strings são armazenadas em um vetor de caracteres com c() -combine

string_4 <- c("this", "is", "a", "string", "vector")

# str_length conta o número de caracteres em cada objeto do vetor de strings
stringr::str_length(string_4)

# para combinar várias strings use str_c
str_c("a", "b", "c")

# o argumento padrão sep, funciona para definir como as strings devem ser
# separadas

str_c("a", "b", "c", sep = "/")

