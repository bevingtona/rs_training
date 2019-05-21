
rm(list=ls(all=T))

# install.packages("remotes")
# remotes::install_github("bevingtona/planetR", force = T)
library(planetR)
# install.packages(c("raster","sf","mapview","mapedit"))
library(httr)
library(raster)
library(sf)
library(mapview)
library(mapedit)

#### VARIABLES: Set variables for Get_Planet function ####

# Set API
setwd("C:/Users/bevington/Dropbox/FLNRO_p1/Programming/bevirepo/rs_training/20190519_CCA_Prince_George/PM_Advanced_RS/Code")
getwd()
api_key = as.character(read.csv("C:/Users/bevington/Dropbox/FLNRO_p1/Programming/bevirepo/api.csv")$api)

# Date range of interest

  ### Programmatic
  # start_year = 2019
  # end_year   = 2019
  # start_doy  = 250
  # end_doy    = 300
  # date_start = paste0(start_year,"-01-01"))+start_doy
  # date_end   = paste0(end_year,"-01-01"))+end_doy

  ### Specify Date  
  date_start = as.Date('2019-05-12') #paste0(start_year,"-01-01"))+start_doy
  date_end   = as.Date('2019-05-20') #paste0(end_year,"-01-01"))+end_doy

# Metadata filters
cloud_lim    = 1 # less than (from 0-1)
item_name    = "PSScene4Band" #"PSOrthoTile" #PSScene4Band")#,"PSScene3Band") #c(#c("Sentinel2L1C") #"PSOrthoTile"
product      = "analytic" #c("analytic_b1","analytic_b2")

# Set AOI
my_aoi       = read_sf("outline.kml") # Import from KML or other
# my_aoi       = mapedit::editMap() # Set in GUI
bbox         = extent(my_aoi)
mapview(my_aoi)

#### PLANET_SEARCH: Search API ####

response <- planet_search(bbox, date_end, date_start, cloud_lim, item_name)
print(paste("Images available:", length(response$features), item_name, product))

#### OUT DIRECTORY ####

setwd("C:/Users/bevington/")
getwd()

#### PLANET_ACTIVATE: Batch Activate ####

for(i in 1:length(response$features)) {
  planet_activate(i, item_name = item_name)
  print(paste("Activating", i, "of", length(response$features)))}

#### PLANET_DOWNLOAD: Batch Download ####

for(i in 1:length(response$features)) {
  planet_download(i)
  print(paste("Downloading", i, "of", length(response$features)))}


