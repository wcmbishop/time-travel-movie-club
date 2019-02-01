# generate road-trip bingo cards

library(bingo)
# https://github.com/jennybc/bingo

bingo_squares <- c(
  "lose a party member",
  "gain a party member",
  "reveal mysterious past",
  "montage scene",
  "confrontation with locals",
  "breakdown",
  "roadblock",
  "pit-stop",
  "local cuisine",
  "detour",
  "dead-end",
  "change vehicles",
  "meet a hitch-hiker",
  "get lost",
  "stranger danger",
  "are we there yet?",
  "low on fuel",
  "cop turns up",
  "fight over music",
  "car chase",
  "makeout in the vehicle",
  "travel by foot",
  "cross a border",
  "reach final destination!"
  )
length(bingo_squares)

bc <- bingo(words = bingo_squares, n_cards = 5, n = 5)
# generate PDF cards
plot(bc, dir = "data", pdf_base = "road-trip-bingo-")
# convert 1 card to png
library(pdftools)
bitmap <- pdftools::pdf_render_page("data/road-trip-bingo-01.pdf", dpi = 300)
png::writePNG(bitmap, file.path("data", "road-trip-bingo.png"))
