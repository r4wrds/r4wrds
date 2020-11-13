# get exercise data in raw format, from ASCIfigs proj
# https://github.com/fawda123/ASCIfigs
library(tidyverse)

ascidat <- read.csv('https://raw.githubusercontent.com/fawda123/ASCIfigs/master/raw/asci.scores.csv', stringsAsFactors = F) %>% 
  select(X, Type.hybrid.1, MMI.hybrid) %>% 
  rename(
    id = X, 
    site_type = Type.hybrid.1,
    ASCI = MMI.hybrid
  )
cscidat <- read.csv('https://raw.githubusercontent.com/fawda123/ASCIfigs/master/raw/csci.scores.csv', stringsAsFactors = F) %>% 
  mutate(
    Replicate = gsub('.*_([0-9]+)$', '\\1', SampleID_old), 
    SampleID_old = gsub('_[0-9]+$', '', SampleID_old),
    SampleDate = gsub('.*_(.*)$', '\\1', SampleID_old),
    StationID = gsub('(^.*)_.*$', '\\1', SampleID_old)
  ) %>% 
  select(StationID, SampleDate, Replicate, CSCI, COMID)

write.csv(ascidat, file = 'data/ascidat.csv', row.names = F, quote = F)
write.csv(cscidat, file = 'data/cscidat.csv', row.names = F, quote = F)
write.csv(locs, file = 'data/latlon.csv', row.names = F, quote = F)

  
