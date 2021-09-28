# read quotes from a url
f_read_data <- function(url){
  suppressMessages(
    quotes  <- read_csv(url)
  )
  return(quotes)
}
