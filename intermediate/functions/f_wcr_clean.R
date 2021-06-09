# clean wcr data
f_wcr_clean <- function(df, start_date = NULL, end_date = NULL){

  # valid date classes
  valid_class <- c("Date", "POSIXct", "POSIXt")

  # verify correct date class
  if(! is.null(start_date) & ! class(start_date)[1] %in% valid_class ){
    stop(
      glue(
        "Invalid `start_date` class, use: {paste(valid_class, collapse=', ')}",
      ),
      call. = FALSE
    )
  }
  if(! is.null(end_date) & ! class(end_date)[1] %in% valid_class ){
    stop(
      glue(
        "Invalid `end_date` class, use: {paste(valid_class, collapse=', ')}",
      ),
      call. = FALSE
    )
  }

  cat("Cleaning data", "\n")

  # if start and end date are NULL, use the min and max date
  if(is.null(start_date)){
    start_date <- min(df$MSMT_DATE, na.rm = TRUE)
    cat("Start date NULL, using min date:", as.character(start_date), "\n")
  }
  if(is.null(end_date)){
    end_date <- max(df$MSMT_DATE, na.rm = TRUE)
    cat("End date NULL, using max date:", as.character(end_date), "\n")
  }

  # filter to date range and clean
  df <- filter(df, MSMT_DATE >= start_date & MSMT_DATE <= end_date)

  cat(
    "Data filtered between",
    as.character(start_date), "and",
    as.character(end_date),   "\n "
  )

  return(df)
}
