library(dplyr)
library(tibble)
library(magrittr)
library(ggplot2)

imdb_movies <- readRDS(file = file.path("data", "imdb_movies.rds"))

decade_years <- seq(1929, 2019, by = 10)

decade_movies <- imdb_movies %>% 
  filter(year %in% decade_years) %>% 
  mutate(rating_int = round(rating_avg))
decade_movies


ggplot(decade_movies, aes(as.factor(year))) +
  geom_bar(aes(fill = as.factor(rating_int))) +
  labs(x = "year", fill = "rating")


decade_movies %>% 
  filter(year == 1999, rating_avg > 7) %>% 
  arrange(desc(rating_avg)) %>% 
  View
