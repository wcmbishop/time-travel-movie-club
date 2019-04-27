
library(dplyr)
library(readr)

box_office_raw <- read_csv(file.path("data-raw", "box-office-mojo.csv"))

box_office <- box_office_raw %>% 
  rename(domestic_gross = lifetime_gross) %>% 
  mutate(rank = as.integer(rank),
         year = as.integer(year))
box_office

# adjusted gross for inflation
cpi <- readRDS(file.path("data", "cpi.rds"))
box_office <- box_office %>% 
  left_join(cpi, by = "year") %>% 
  mutate(domestic_gross_adj = domestic_gross / cpi_ratio2018)


# save
saveRDS(box_office, file = file.path("data", "box_office.rds"))
# box_office <- readRDS(file.path("data", "box_office.rds"))
