# print a random animal and a random quote
f_inspire_me <- function(d){
  animals <- names(animals)
  say(sample(d$full_quote, 1), by = sample(animals, 1))
}
