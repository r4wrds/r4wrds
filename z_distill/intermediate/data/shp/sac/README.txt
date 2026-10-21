Service URL: https://gis.water.ca.gov/arcgis/rest/services/Boundaries/i03_CaliforniaCounties/MapServer/0

Layer Name: i03_CaliforniaCounties

Description: ***** BACKGROUND *****In late 1996, the Dept of Conservation (DOC) surveyed state and federal
agencies about the county boundary coverage they used. As a result, DOC adopted the 1:24,000 (24K) scale U.S.
Bureau of Reclamation (USBR) dataset (USGS source) for their Farmland Mapping and Monitoring Program (FMMP)
but with several modifications. Detailed documentation of these changes is provided by FMMP and included in
the lineage section of the metadata. A dataset named cnty24k97_1 was made available (approximately 2004)
through the California Department of Forestry and Fire Protection - Fire and Resource Assessment Program (CDF
- FRAP) and the California Spatial Information Library (CaSIL). In late 2006, the Department of Fish and Game
(DFG) reviewed cnty24k97_1. Comparisons were made to a high-quality 100K dataset (co100a/county100k from the
former Teale Data Center GIS Solutions Group) and legal boundary descriptions from (
http://www.leginfo.ca.gov ). The cnty24k97_1 dataset was missing Anacapa and Santa Barbara islands. DFG added
the missing islands using previously-digitized coastline data (coastn27 of State Lands Commission origin),
corrected a few county boundaries, built region topology, added additional attributes, and renamed the
dataset to county24k. In 2007, the California Mapping Coordinating Committee (CMCC) requested that the
California Department of Forestry and Fire Protection (CAL FIRE) resume stewardship of the statewide county
boundaries data. CAL FIRE adopted the changes made by DFG and collected additional suggestions for the county
data from DFG, DOC, and local government agencies. CAL FIRE incorporated these suggestions into the latest
revision, which has was renamed cnty24k09_1. ***** THIS VERSION*****This version of the county dataset was
created as a result of an effort to improve the coastal linework. It uses the previous interior linework from
the cnty24k13_1 data, but replaces the coastal linework (including islands and inlets) based on NOAA's ERMA
coastal dataset (which used NAIP 2010). In addition to the improved linework, additional coding was added to
differentiate inlets and bays, islands, and manmade structures such as piers and breakers. This dataset is
one of several available datasets that were created as a group designed to work in topological sync with each
other. These "paired" datasets include a basic county dataset (cnty15_1_basic), a basic state dataset
(state15_1), an ocean dataset (ocean15_1), and country/state datasets (both full and neighbor-only -
cntrystate15_1_full and cntrystate15_1_neighbor, respectively). Further details about these paired datasets
can be found in their respective metadata. This specific datasetrepresents the full detailed county dataset
with all coding (islands, inlets, constructed features, etc). The user has the freedom to use this coding to
create definition queries, symbolize, or dissolve to create a more generalized dataset as needed.In November
2015, the dataset was adjusted to include a change in the Yuba-Placer county boundary from 2010 that was not
yet included in the 14_1 version of the dataset (ord No 5546-B). This change constitutes the diffrence
between the 15_1 and 14_1 versions of this dataset.

Fields
       Field        Field Name                    Alias                                   Data Type
       =====        ==========                    ===========                             =========
         1          OBJECTID                      OBJECTID                                OID            
         2          COUNTY_NAME                   COUNTY_NAME                             String         
         3          COUNTY_ABBREV                 COUNTY_ABBREV                           String         
         4          COUNTY_NUM                    COUNTY_NUM                              SmallInteger   
         5          COUNTY_CODE                   COUNTY_CODE                             String         
         6          COUNTY_FIPS                   COUNTY_FIPS                             String         
         7          Shape                         Shape                                   Geometry       
         8          Shape.STArea()                Shape.STArea()                          Double         
         9          Shape.STLength()              Shape.STLength()                        Double         

Export date: 09/25/2020 13:26
