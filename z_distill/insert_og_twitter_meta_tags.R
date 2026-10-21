library(here)
library(tidyverse)

f <- list.files(here::here(), pattern = ".html$", full.names = TRUE, recursive = TRUE)

# insert this text for open graph (og)
insert_og <- c(
  '  <meta property="og:image" content="https://r4wrds.com/./img/cover.png">',
  '  <meta property="og:image:width" content="1406">',
  '  <meta property="og:image:height" content="1146">'
)

# insert this text for twitter 
insert_tw <- c(
  '  <meta property="twitter:image" content="https://r4wrds.com/./img/cover.png">',
  '  <meta property="twitter:image:width" content="1406">',
  '  <meta property="twitter:image:height" content="1146">'
)


insert_og_twitter_meta_tags <- function(f){
  l <- read_lines(f) 
  i_og <- str_which(l, '<meta property="og:title')
  i_tw <- str_which(l, '<meta property="twitter:title')
  
  if(!is_empty(i_og)){
    l2 <- c(
      l[c(1:i_og)], 
      insert_og,
      l[(i_og+1):i_tw],
      insert_tw,
      l[(i_tw+1):length(l)]
    )
    write_lines(l2, f)
  }
}

walk(f, ~insert_og_twitter_meta_tags(.x))
