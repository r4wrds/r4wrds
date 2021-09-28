# paste the quote to the author
f_preprocess_data <- function(d){
  d$full_quote  <- paste0(d$Quote, " -", d$Author)
  return(d)
}
