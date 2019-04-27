# 
library(dplyr)
library(readr)

annual_stats_raw <- read_tsv(file.path("data-raw", "annual-stats.tsv"))

annual_stats <- annual_stats_raw %>% 
  select(year = Year,
         n_movies = TotalMovies,
         avg_budget = AverageProductionBudget,
         world_box_office = `CombinedWorldwideBox Office`,
         top_movie = `No. 1 Movie`) %>% 
  mutate(year = as.integer(year),
         n_movies = as.integer(n_movies),
         avg_budget = parse_number(avg_budget),
         world_box_office = parse_number(world_box_office))

annual_stats

# adjusted values
cpi <- readRDS(file.path("data", "cpi.rds"))
annual_stats <- annual_stats %>% 
  left_join(cpi, by = "year") %>% 
  mutate(avg_budget_adj2018 = avg_budget / cpi_ratio2018,
         world_box_office_adj2018 = world_box_office / cpi_ratio2018)

# add US population
us_pop <- readRDS(file.path("data", "us_pop.rds"))
annual_stats <- annual_stats %>% 
  left_join(us_pop, by = "year") %>% 
  mutate(world_box_adj_percapita = world_box_office_adj2018 / population)
  

# save
saveRDS(annual_stats, file = file.path("data", "annual_stats.rds"))
# annual_stats <- readRDS(file.path("data", "annual_stats.rds"))

