
rm(list=ls(all=TRUE))

library(sf)
library(raster)
library(stringr)
library(raster)
library(ggplot2)
library(ggspatial)
library(RStoolbox)

# setwd("C:/Users/bevington/Dropbox/FLNRO_p1/spyder27project/20181124_Somenos_20170101_20181124_c001_PSScene4Band_analytic_sr_02x02/tif")
setwd("")
dir.create("out", )

# List of Rasters in working directory
sr = list.files(recursive = F, pattern = ".tif$")

# Import Shapefile
sh = read_sf("outline.kml")
sh = sf::st_transform( sh, crs = 32610)
bbox = extent(sh)

# Clip Raster to Shapefile Function
clipzilla<-function(raster,shape) {
  a1_crop<-crop(raster,shape)
  step1<-rasterize(shape,a1_crop)
  a1_crop*step1}

# Read images, clip and calculate indices
for(s in sr){
  # s = sr[1]
  print(s)
  
  # Image Date and Time
  date = str_split_fixed(s, "_", 3)[1]
  time = str_split_fixed(s, "_", 3)[2]
  
  # Read 4 Band Raster (Bands: 1 = Blue, 2 = Green, 3 = Red, 4 = NIR)
  ras = stack(s)
  
  # Clip Raster to Shapefile
  rasClip = clipzilla(ras, bbox)

  # # Calculate NDVI 
  # ndvi = spectralIndices(img = rasClip, blue = 1, green = 2, red = 3, nir = 4, index = "NDVI")
  # 
  # # Extract NDVI > 1 
  # ndvi_m = ndvi
  # ndvi_m[ndvi_m<0] <- NA
  # ndvi_m[ndvi_m>0] <- 1
  
  # Plot
  ggRGB(rasClip, r = 4, g = 3, b = 2, maxpixels=500000, stretch = 'log') + 
    labs(title = date, x = "", y = "") + 
    layer_spatial(sh, fill = NA, color = "black", size = 1)
  
  # Save Plot
  ggsave(filename = paste0("out/",s,".jpg"), device = "jpeg")
  
  }
