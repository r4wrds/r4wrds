library(tidyverse)
library(sf)
library(here)
library(patchwork)

# load functions
list.files(here("functions"), full.names = TRUE, pattern = "f_wcr") %>%
  walk(~source(.x))

# urls for data
base_url <-
  "https://data.cnra.ca.gov/dataset/dd9b15f5-6d08-4d8c-bace-37dc761a9c08/resource/"
urls <- paste0(
  base_url,
  c("af157380-fb42-4abf-b72a-6f9f98868077/download/stations.csv",
    "bfa9f262-24a1-45bd-8dc8-138bc8107266/download/measurements.csv",
    "f1deaa6d-2cb5-4052-a73f-08a69f26b750/download/perforations.csv")
)

# data path to download files and read them
data_path <- here("data", "pgwl")

# ------------------------------------------------------------------------
# download data
f_wcr_download(data_path, urls = urls)

# ------------------------------------------------------------------------
# import, clean, and model
d <-
  # import downloaded data
  f_wcr_import(
    county   = "Sacramento",
    files_in = list.files(data_path, full.names = TRUE)
  ) %>%
  # minor cleaning of one unreasonable value
  filter(WSE >-200) %>%
  # clean data
  f_wcr_clean(start_date = lubridate::ymd("2000-01-01")) %>%
  # fit a linear model for each SITE_CODE group, extract beta_1
  f_wcr_model()

# ------------------------------------------------------------------------
# visualize big picture map
# create output directory if it doesn't already exist
path_plot <- here("results", "plot")
dir.create(path_plot)

p <- f_wcr_visualize_map(d, yr_min = 5)
ggsave(file.path(path_plot, "00_ALL.png"), p, height = 6, width = 6)

# write all timeseries plots. use map instead of walk because we want
# to capture output to inspect
safely_viz <- safely(f_wcr_visualize_timeseries)
errs <- group_split(d, SITE_CODE) %>% map(~safely_viz(.x, path_plot))

# ------------------------------------------------------------------------
# write
# create output directory if it doesn't already exist
path_csv <- here("results", "csv")
dir.create(path_csv)

# write all results as one big csv and use default ordering to sort
write_csv(d, file.path(path_csv, "00_ALL.csv"))

# silently write a separate csv for each group
d %>%
  split(.$SITE_CODE) %>%
  walk(~write_csv(.x, file.path(path_csv, glue::glue("{.x$SITE_CODE[1]}.csv"))))
