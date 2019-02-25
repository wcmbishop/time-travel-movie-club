# AFI top 100 movies
# source: https://www.afi.com/100Years/movies.aspx
# (table copied to .txt file)

library(tidyverse)
library(datapasta)

movies_raw <- read_lines(file.path("data-raw", "afi-top-100.txt"))
movies_raw <- movies_raw[grepl("View Details", movies_raw) == FALSE]

matches <- stringr::str_match(movies_raw, pattern = "([0-9]+)[. ] (.+) [(]([0-9]{4})[)]")
afi_movies <- as_tibble(matches[, 2:4], .name_repair = "minimal")
names(afi_movies) <- c("rank", "movie", "year")
afi_movies <- afi_movies %>% 
  mutate(rank = as.integer(rank),
         year = as.integer(year))

# count movies by year
afi_movies %>% 
  count(year) %>% 
  filter(n > 2) %>% 
  arrange(desc(n))

# 1939 movies
afi_movies %>% filter(year == 1939)

# save data
saveRDS(afi_movies, file = file.path("data", "afi_movies.rds"))
