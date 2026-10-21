# visualize results
f_wcr_visualize_map <- function(df, yr_min){

  # slice the first observation per SITE_ID (for location) and
  # re-convert to sf which is lost during nest and unnest
  d_map <- df %>%
    group_by(SITE_CODE) %>%
    slice(1) %>%
    ungroup() %>%
    st_as_sf() %>%
    filter(length_yr >= yr_min) %>%
    # create a bin for trend magnitude that matches DWR bins (Fig 2)
    mutate(
      bin = cut(
        b1,
        breaks = c(-1000, -2.5, 0, 2.5, 1000),
        labels = c("Increase > 2.5 ft/yr", "Increase 0 - 2.5 ft/yr",
                   "Decrease 0 - 2.5f ft/yr", "Decrease > 2.5 ft/yr")
      )
    )

  # sacramento county polygon
  sac <- st_read(here("data", "shp", "sac", "sac_county.shp")) %>%
    st_transform(st_crs(d_map))

  # plot magnitude bins
  p <- ggplot() +
    geom_sf(data = sac) +
    geom_sf(data = d_map, aes(fill = bin), pch = 21, size = 3, alpha = 0.9) +
    rcartocolor::scale_fill_carto_d("", palette = "TealRose") +
    theme_void()

  return(p)
}
