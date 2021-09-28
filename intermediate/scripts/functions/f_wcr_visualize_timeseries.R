# visualize timeseries of groundwater level with a map
f_wcr_visualize_timeseries <- function(df, dir_out){
  dir.create(dir_out)

  # color of trend - up or down
  col_trend <- ifelse(df$direction[1] == "decline", "red", "blue")

  # create the hydrograph
  p_hydrograph <- df %>%
    ggplot(aes(MSMT_DATE, WSE)) +
    geom_line() +
    geom_smooth(
      color = col_trend, method = "lm", se = FALSE,
      lwd = 2, linetype = "dashed"
      ) +
    guides(color = FALSE) +
    labs(title = glue::glue("{df$SITE_CODE[1]}, {round(df$b1[1], 2)} ft/yr")) +
    theme_minimal()

  # create the map
  # make measurements data spatial if not already
  df_sf <- st_as_sf(df)

  # sacramento county polygon
  sac <- st_read(here("data", "shp", "sac", "sac_county.shp")) %>%
    st_transform(st_crs(df_sf))

  # map
  p_map <- ggplot() +
    geom_sf(data = sac) +
    theme_void() +
    geom_sf(data = df_sf[1, ], color = col_trend, size = 4, alpha = 0.9)

  # combine plots: requires {pathwork}
  p_combined <- p_map + p_hydrograph

  # save
  ggsave(
    file.path(dir_out, glue::glue("{df$SITE_CODE[1]}.png")),
    p_combined,
    height = 4, width = 12
  )

}
