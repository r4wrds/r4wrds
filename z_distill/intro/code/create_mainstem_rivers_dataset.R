# create rivers dataset for SAC county

library(sf)
library(nhdplusTools)
library(tidyverse)
library(mapview)
mapviewOptions(fgb=FALSE)
library(dataRetrieval)


# Load Data ---------------------------------------------------------------

# this is dissolved all major rivers
load("data/major_rivers_dissolved.rda")

# this has braided segs
rivs_name <- read_rds("data/major_rivers_ca.rds")
# mapview(rivs_name, zcol = "HYDNAME")

# get county
sac_co <- read_sf("data/shp/sac/sac_county.shp") %>% st_transform(3310)

#get NWIS sites
nwis_amer <- read_rds("data/nwis_sites_amer_ds_nimbus_sf.rds")


# Spatial Wrangle ---------------------------------------------------

# buffer county
sac_buffer <- st_buffer(sac_co, dist = 1000)
plot(sac_buffer$geometry)
plot(sac_co$geometry, border="red", add=T)

# convert rivs_dissove and crop to sac
rivs_sac <- rivs %>% st_transform(3310) %>%
  st_intersection(., sac_buffer)

mapview(sac_buffer, alpha.regions=0, color="orange", lwd=3) +
  mapview(rivs_sac) + mapview(nwis_amer, color="seagreen")

# Use Data Retrieval to Get NHD Flowlines ---------------------------------

# use point from lower down in county
sac_flowlines <- findNLDI(location = c(-121.65796, 38.17559), nav = c("UM","DD","UT"), distance_km = 120)

# do same for mokel/cosumnes
cos_flowlines <- findNLDI(location = c(-121.68079, 38.08863), nav = c("UM","DD","UT"), distance_km = 120)

# merge datasets
sac_UM <- bind_rows(sac_flowlines$UM_flowlines, cos_flowlines$UM_flowlines) %>%
  distinct(nhdplus_comid, .keep_all = TRUE) %>%
  mutate(type="UM") %>%
  st_transform(3310)

sac_DD <- bind_rows(sac_flowlines$DD_flowlines, cos_flowlines$DD_flowlines) %>%
  distinct(nhdplus_comid, .keep_all = TRUE) %>%
  mutate(type="DD") %>%
  st_transform(3310)

sac_UT <- bind_rows(sac_flowlines$UT_flowlines, cos_flowlines$UT_flowlines) %>%
  distinct(nhdplus_comid, .keep_all = TRUE) %>%
  mutate(type="UT") %>%
  st_transform(3310)

# mapview
mapview(sac_UM, lwd=2, color="cyan4", legend=FALSE) +
  mapview(sac_UT, lwd=0.8, legend=FALSE, color="skyblue") +
  mapview(sac_DD, lwd=2, color="blue3", legend=FALSE) +
  mapview(sac_buffer, alpha.regions=0, color="orange", lwd=3)


# crop to sac only
sac_UM <- st_intersection(sac_UM, sac_buffer)
sac_UT <- st_intersection(sac_UT, sac_buffer)
sac_DD <- st_intersection(sac_DD, sac_buffer)

# view
mapview(sac_UT, legend=FALSE, lwd=0.8, color="skyblue") +
  mapview(sac_UM, legend=FALSE, lwd=3, color="dodgerblue") +
  mapview(sac_DD, legend=FALSE, lwd=3, color="darkblue") +
  mapview(sac_buffer, alpha.regions=0, color="orange", lwd=3) +
  mapview(rivs_sac, legend=FALSE, lwd=2, color="cyan4")



# Export ------------------------------------------------------------------


write_rds(sac_UT, file = "data/sac_co_us_tributaries.rds")
write_rds(rivs_sac, file = "data/sac_co_main_rivers_dissolved.rds")
