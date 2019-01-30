# data prep for IMDB data
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# data files: https://datasets.imdbws.com
# data docs: https://www.imdb.com/interfaces/

library(RSQLite)
library(R.utils)
library(readr)
library(dplyr)

# download data files --------
base_url <- "https://datasets.imdbws.com"
gz_files <- c("title.basics.tsv.gz", "title.ratings.tsv.gz")
for (file_name in gz_files) {
  dest_file <- paste("data-raw", file_name, sep = "/")
  download.file(
    url = paste(base_url, file_name, sep = "/"),
    destfile = dest_file)
  gunzip(dest_file, remove = TRUE, overwrite = TRUE)
}

# read data --------
titles <- read_tsv("data-raw/title.basics.tsv", quote = "",
                   na = c("", "NA", "\\N"), col_types = "ccccliidc")
ratings <- read_tsv("data-raw/title.ratings.tsv", quote = "",
                   na = c("", "NA", "\\N"), col_types = "cdi")

# wrangle movie data --------
imdb_movies <- titles %>% 
  filter(titleType == "movie", isAdult == FALSE) %>% 
  left_join(ratings, by = "tconst") %>% 
  select(imdb_id = tconst,
         primary_title = primaryTitle,
         original_title = originalTitle,
         year = startYear,
         runtime = runtimeMinutes,
         genres = genres,
         rating_avg = averageRating,
         rating_votes = numVotes)
imdb_movies
object.size(imdb_movies) %>% format(standard = "SI", units = "MB")

# save data and remove files --------
saveRDS(imdb_movies, file = file.path("data", "imdb_movies.rds"))
rm(ratings, titles)
unlink(list.files("data-raw", pattern = "*.tsv", full.names = TRUE))
# imdb_movies <- readRDS(file = file.path("data", "imdb_movies.rds"))

