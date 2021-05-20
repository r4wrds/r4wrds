# visualize results and save
f_wcr_visualize <- function(df, type){
  if(type == "timeseries"){
    p <-
  }

  return(p)
}

d_recent %>%
  filter(SITE_CODE %in% unique(d$SITE_CODE)[1:7]) %>%
  ggplot() +
  geom_line(aes(MSMT_DATE, WSE)) +
  geom_smooth(aes(MSMT_DATE, WSE, color = direction), method = "lm", se = FALSE) +
  facet_wrap(~SITE_CODE) +
  labs(color = "Trend")

# slice the first observation per SITE_ID (for location) and
# re-convert to sf which is lost during nest and unnest
d_map <- d_recent %>%
  group_by(SITE_CODE) %>%
  slice(1) %>%
  ungroup() %>%
  st_as_sf() %>%
  filter(length_yr >= 5)

# create a bin for trend magnitude that matches DWR bins (Fig 2)
d_map$bin <- cut(
  d_map$b1,
  breaks = c(-1000, -2.5, 0, 2.5, 1000),
  labels = c("Increase > 2.5 ft/yr", "Increase 0 - 2.5 ft/yr",
             "Decrease 0 - 2.5f ft/yr", "Decrease > 2.5 ft/yr")
)

# sacramento county polygon
sac <- st_read(here("data", "shp", "sac", "sac_county.shp")) %>%
  st_transform(st_crs(d_map))

# plot direction
ggplot() +
  geom_sf(data = sac) +
  geom_sf(data = d_map, aes(fill = direction), pch = 21, size = 2) +
  guides(fill = FALSE) +
  theme_void()

# plot magnitude bins
ggplot() +
  geom_sf(data = sac) +
  geom_sf(data = d_map, aes(color = bin), size = 2, alpha = 0.8) +
  rcartocolor::scale_color_carto_d("",palette = "TealRose") +
  theme_void()
