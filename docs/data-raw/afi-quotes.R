# AFI top 100 movie quotes
# source: https://www.afi.com/100Years/quotes.aspx
# (table copied to Numbers and exported to .csv)

library(tidyverse)
library(datapasta)

# prep quotes
afi_quotes <- read_csv(file.path("data-raw", "afi-top-100-quotes.csv"))
afi_quotes <- afi_quotes %>% 
  rename(rank = `#`, quote = QUOTE, movie = MOVIE, year = YEAR) %>%
  mutate(movie = ifelse(grepl("WIZARD OF OZ", movie), "THE WIZARD OF OZ", movie))

# top quoted movies
afi_quotes %>% 
  count(movie, year) %>% 
  filter(n > 1) %>%
  arrange(desc(n))

# top quoted years
afi_quotes %>% 
  count(year, movie) %>% 
  group_by(year) %>% 
  summarise(movies = paste(movie, " (", n, ")", sep = "", collapse = ", "),
            n = sum(n)) %>% 
  filter(n > 3) %>%
  select(year, n, movies) %>% 
  arrange(desc(n))

# Oz quotes
2 %>% 
  filter(movie == "THE WIZARD OF OZ")

# save to ./data
saveRDS(afi_quotes, file = file.path("data", "afi_quotes.rds"))
# afi_quotes <- readRDS(file.path("data", "afi_quotes.rds"))
