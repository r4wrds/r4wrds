# import downloaded wcr data
f_wcr_import <- function(county, files_in){
  # valid counties from entire dataset, i.e.,
  # dput(sort(unique(d$COUNTY_NAME)))
  counties_valid <-
    c("Alameda", "Alpine", "Amador", "Butte", "Calaveras", "Colusa",
      "Contra Costa", "Del Norte", "El Dorado", "Fresno", "Glenn",
      "Humboldt", "Imperial", "Inyo", "Kern", "Kings", "Klamath, OR",
      "Lake", "Lassen", "Los Angeles", "Madera", "Marin", "Mariposa",
      "Mendocino", "Merced", "Modoc", "Mono", "Monterey", "Napa", "Nevada",
      "Orange", "Placer", "Plumas", "Riverside", "Sacramento", "San Benito",
      "San Bernardino", "San Diego", "San Francisco", "San Joaquin",
      "San Luis Obispo", "San Mateo", "Santa Barbara", "Santa Clara",
      "Santa Cruz", "Shasta", "Sierra", "Siskiyou", "Solano", "Sonoma",
      "Stanislaus", "Sutter", "Tehama", "Tulare", "Tuolumne", "Ventura",
      "Yolo", "Yuba", "ALL")

  # ensure input county is valid before reading in data
  if(! county %in% counties_valid) {
    stop(
      glue("County must be one of: {paste(counties_valid, collapse = ', ')}"),
      call. = FALSE
    )
  }

  cat("Valid county provided, now proceeding to read data...", "\n")

  # read and combine - use datatable for speed and memory management
  d <- map(files_in, ~data.table::fread(.x)) %>%
    reduce(left_join, by = "SITE_CODE")

  cat("Files read and combined...", "\n")

  # if a county is supplied (not requesting ALL the data), filter to it
  if(county != "ALL"){
    cat("Filtering to", county, "county...", "\n")
    d <- filter(d, COUNTY_NAME == county)
  }

  # select only relevant columns & convert to sf object
  cat("Selecting relevant columns...", "\n")
  d <- d %>%
    select(SITE_CODE, MSMT_DATE, WSE, LONGITUDE,
           LATITUDE, WELL_DEPTH, COUNTY_NAME) %>%
    filter(!is.na(LONGITUDE) & !is.na(LATITUDE)) %>%
    st_as_sf(coords = c("LONGITUDE", "LATITUDE"), crs = 4269)

  cat("Data import complete.", "\n")
  return(d)
}
