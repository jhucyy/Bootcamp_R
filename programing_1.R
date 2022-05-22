

load("./Senators_Data.Rdata")


install.packages("rtweet")
library(rtweet)

senators_data$twitter_url[1]
test <- get_timeline("https://twitter.com/SenDanSullivan")


gsub("https://twitter.com/", "", senators_data$twitter_url[1])

twitter_url_remover <- function(x)(
  
)

# criando uma função
twitter_url_remover <- function(x){
  handle <- gsub("https://twitter.com/", "", x)
  return(handle)
}


twitter_url_remover("https://twitter.com/SenDanSullivan")
tweet_holder <- as.data.frame(NULL)


for (i in 1:5) {
  handle <- twitter_url_remover(senators_data$twitter_url[i])
  tweets <- get_timeline(handle)
  tweet_holder <- rbind(tweet_holder, tweets)
  
  print(i)
  
}

senators_data$twitter_url[4]

tweet_holder$screen_name

# data merging
library(tidyverse)

tweet_holder$screen_name

senators_data$screen_name <- gsub("https://twitter.com/", "", senators_data$twitter_url)

merged_data <- left_join(tweet_holder, senators_data)





