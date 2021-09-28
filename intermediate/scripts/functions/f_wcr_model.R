# build linear model for each unique SITE ID and
# add important columns (direction), beta_1 coefficient
sec_to_yr <- function(sec){
  yr <- sec * 31557600
  return(yr)
}

f_wcr_model <- function(df){
  result <- df %>%
    group_by(SITE_CODE) %>%
    # nest the data per SITE_CODE grouping variable
    nest() %>%
    mutate(
      # map a linear model across data, extract slope magnitude & direction
      model     = map(data, ~lm(WSE ~ MSMT_DATE, data = .x)),
      b1        = map(model, ~coefficients(.x)[["MSMT_DATE"]]),
      b1        = map(b1, ~sec_to_yr(.x)),
      direction = map(b1, ~ifelse(.x >= 0, "increase", "decline")),
      # duration of the data in units of years so we know how the period
      # over which the linear model is estimated
      length_yr = map(data, ~as.numeric(diff(range(.x$MSMT_DATE))) / 365)
    ) %>%
    # unnest all columns so we can access values
    unnest(c(data, b1:length_yr)) %>%
    select(-model)

  return(result)
}
