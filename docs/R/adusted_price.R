

cpi <- readRDS(file.path("data", "cpi.rds"))

adjusted_price <- function(price, from_year, to_year = 2018) {
  year_range <- range(cpi$year)
  if ((from_year %in% cpi$year) == FALSE)
    stop("'from_year' is outside of allowed year range")
  if ((to_year %in% cpi$year) == FALSE)
    stop("'to_year' is outside of allowed year range")
  
  # adjust price
  cpi_from <- cpi$cpi[cpi$year == from_year]
  cpi_to <- cpi$cpi[cpi$year == to_year]
  message(paste("adjusted price from", from_year, "to", to_year))
  price * cpi_to/cpi_from
}
