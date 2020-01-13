# 
library(dplyr)
library(readr)

us_pop_raw <- read_tsv(file.path("data-raw", "us-population.tsv"))

us_pop <- us_pop_raw %>% 
  mutate(year = as.integer(stringr::str_sub(Date, -4L, -1L)),
         population = parse_number(Value) * 1e6) %>% 
  select(year, population) %>% 
  # remove duplicate year entries
  group_by(year) %>% 
  summarise(population = min(population))

saveRDS(us_pop, file = file.path("data", "us_pop.rds"))
# us_pop <- readRDS(file.path("data", "us_pop.rds"))
