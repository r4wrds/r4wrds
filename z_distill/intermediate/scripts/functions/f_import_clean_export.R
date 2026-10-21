# imports dataframe, filters to observation wells,
# converts well depth feet to meters, projects to epgs 3310
# and exports the data
f_import_clean_export <- function(file_in, file_out){
  read_csv(file_in) %>%
    filter(WELL_USE == "Observation") %>%
    mutate(well_depth_m = WELL_DEPTH * 0.3048) %>%
    sf::st_as_sf(coords = c("LONGITUDE", "LATITUDE"), crs = 4269) %>%
    sf::st_transform(3310) %>%
    sf::st_write(file_out)
}
