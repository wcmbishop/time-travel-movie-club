library(dplyr)
library(readr)

# top movies ======
top_domestic_raw <- read_tsv(file.path("data-raw", "top-domestic-gross-ticket-adjusted.tsv"))
names(top_domestic_raw) <- c("rank", "title", "studio", "domestic_gross_adj", "domestic_gross", "year")

top_domestic <- top_domestic_raw %>% 
  mutate(multiple_releases = stringr::str_sub(year, -1L, -1L) == "^",
         year = parse_integer(stringr::str_sub(year, 1L, 4L)),
         domestic_gross_adj = parse_number(domestic_gross_adj),
         domestic_gross = parse_number(domestic_gross)) %>% 
  select(rank, year, title, everything())

saveRDS(top_domestic, file = file.path("data", "top_domestic.rds"))
# top_domestic <- readRDS(file.path("data", "top_domestic.rds"))


# yearly ticket prices ====
ticket_price_raw <- read_tsv(file.path("data-raw", "year-ticket-price.tsv"))
names(ticket_price_raw) <- c("year", "price")

ticket_price <- ticket_price_raw %>% 
  mutate(year = as.integer(year),
         price = parse_number(stringr::str_sub(price, -4L, -1L)))

saveRDS(ticket_price, file = file.path("data", "ticket_price.rds"))
# ticket_price <- readRDS(file.path("data", "ticket_price.rds"))

