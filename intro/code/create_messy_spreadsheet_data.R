
# Create Spreadsheet Data for Mod2A ---------------------------------------

# load libraries
library(tidyverse) # includes readxl
#library(readxl) # to read excel files
library(openxlsx) # to write excel files
#library(writexl) # to write excel files: fast and smaller files

# Get Data ----------------------------------------------------------------

# read in the data
csci <- read_csv("data/cscidat.csv")

# drop the lat lon from csci to set up joins in mod2
csci <- csci %>% select(-starts_with("New_"))

# read in the latlon data
xy_dat <- read_csv("data/latlon.csv")


# SETUP AND WRITE TO XLSX -------------------------------------------------

# we want to make the first table a "messy" dataset with some issues that make reading it in tricky
# the second table or "tab" will be the clean version (csci as is)
# the third tab will be the latlong data

# using openxlsx and set styling
wb <- createWorkbook()
options("openxlsx.borderColour" = "#4F80BD")
options("openxlsx.borderStyle" = "thin")
modifyBaseFont(wb, fontSize = 10, fontName = "Roboto")
headSty <- createStyle(halign="center", border = "TopBottomLeftRight")

# setup the worksheets
addWorksheet(wb, sheetName = "messy", gridLines = TRUE)
addWorksheet(wb, sheetName = "csci_clean", gridLines = TRUE)
addWorksheet(wb, sheetName = "sites_latlon", gridLines = TRUE)

# write data to worksheets
writeDataTable(wb, sheet = 1, x = csci, colNames = FALSE, rowNames=FALSE, startRow = 3, withFilter = FALSE)
writeDataTable(wb, 2, x = csci, withFilter = FALSE, headerStyle = headSty)
writeDataTable(wb, 3, x = xy_dat, withFilter = FALSE)

# make a messed up dataframe and make up data
# add a random date:
st_d <- as.Date("1998-05-07") # start
en_d <- as.Date("1999-12-07") # end
nR <- nrow(ChickWeight) # number of rows
date <- seq(st_d, en_d, length.out = nR) # seq of dates eq to length of nrows

# add a "combined column" (not tidy)
combcol <- sample(paste0(rep(c("pink","blue","gray"), 
                     nR), "-", rep(c("Y","N"), nR)), nR)

# now stitch together
df_mess <- ChickWeight %>% 
  mutate(sky= rnorm(n = nrow(.), mean = 3, sd = 1),
         date = date ,
         combcol = combcol) %>% 
  rename(Indiv = Chick) # rename col (new name = old name)


# write data to specific sheet and location (make it messy)
writeDataTable(wb, sheet = 1, df_mess, startCol = "M", startRow = 1, withFilter = FALSE)
qplot(data=df_mess, x = weight, y= Time, colour = Diet)
insertPlot(wb, 1, xy=c("T", 16)) ## insert plot at cell R16


# now save!
saveWorkbook(wb, "data/csci_spreadsheet.xlsx", overwrite = TRUE)
