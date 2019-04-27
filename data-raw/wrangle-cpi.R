library(dplyr)
library(readr)

# Consumer Price Index
cpi_raw <- read_tsv(file.path("data-raw", "cpi.tsv"))
cpi_raw

cpi <- cpi_raw %>% 
  select(year = Year,
         cpi = Avg) %>% 
  mutate(year = as.integer(year))
cpi <- bind_rows(cpi, data.frame(year = 2019, cpi = 253))

# adjusted ratio to 2018
cpi <- cpi %>% 
  mutate(cpi_ratio2018 = cpi / cpi[year == 2018])


# save
saveRDS(cpi, file = file.path("data", "cpi.rds"))
# cpi <- readRDS(file.path("data", "cpi.rds"))
