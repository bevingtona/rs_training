
# DATA MANUPULATION LIBRARIES
library(reshape2); 
library(plyr);          # Split-apply-combine
library(stringr);
library(purrr); 
library(broom); 
library(tidyr); 
library(dplyr);         # Grammar of data manipulation 
library(lubridate)
library(lme4)
library(Hmisc)
library(doBy)

# LOAD SPATIAL TOOLS 
library(rgdal); 
library(rasterVis); 
library(raster); 
library(sf); 
library(rgeos); 
library(spdep)
library(maptools);      
library(bcmaps); 
library(autothresholdr)
library(oceanmap)
library(RStoolbox)
library(ggspatial)
library(igraph)

# LOAD GGPLOT TOOLS
library(ggplot2);       # Main plotting package
library(ggExtra)
library(ggpubr)
library(GGally)
library(ggmap);         # Ggplot mapping tools
library(ggpmisc);       # Miscelaneous tools for ggplot
library(RColorBrewer)   # Color brewer for ggplot
library(ggthemes);      # Additional ggplot themes and scales
library(forcats);       # Package for reordering factors e.g. fct_reorder() -- "for categories" 
library(scales);        # General plot scales 
library(hexbin);
library(gridExtra);     # Grid arrange for multi plot

rm(list=ls(all=TRUE))

# setwd("C:/Users/bevington/Dropbox/FLNRO_p1/spyder27project/20181124_Somenos_20170101_20181124_c001_PSScene4Band_analytic_sr_02x02/tif")
setwd("G:/Dropbox/FLNRO_p1/Research_Water/Project_Somenos_Lake/20181124_Somenos_20170101_20181124_c001_PSScene4Band_analytic_sr_02x02/tif")

# List of Rasters in WD
sr = list.files(recursive = T, pattern = "SR_clip.tif$")

# Import Shapefile
sh = shapefile("../shp/CLIP_AREA_UTM.shp")

# Clip Raster to Shapefile Function
clipzilla<-function(raster,shape) {
  a1_crop<-crop(raster,shape)
  step1<-rasterize(shape,a1_crop)
  a1_crop*step1}
  
# Set Counter
count = 1

# Set stack
all_img = brick()
all_ndwi = brick()
all_blue = brick()
all_ndvi = brick()

# Read images, clip and calculate indices
for(s in sr){
  
  # Count Function
  print(paste(count,"of",length(sr)))
  count = count + 1
  
  # Image Date and Time
  date = str_split_fixed(s, "_", 7)[1]
  time = str_split_fixed(s, "_", 7)[2]
  
  # Read 4 Band Raster (Bands: 1 = Blue, 2 = Green, 3 = Red, 4 = NIR)
  ras = stack(s)
  
  # Clip Raster to Shapefile
  rasClip = clipzilla(ras, sh)
  
  # Calculate NDWI
  ndwi = ((rasClip[[2]] - rasClip[[4]])/(rasClip[[2]] + rasClip[[4]]))
  names(ndwi) = paste(date,time, sep="_")
  writeRaster(x = ndwi, filename = paste(date,time,"ndwi.tif", sep="_"))
  
  # Calculate blue
  # blue = rasClip[[1]]
  # names(blue) = as.character(date)
  # writeRaster(x = blue, filename = paste(date,time,"blue.tif", sep="_"))
  
  # Calculate ndvi
  # ndvi = ((rasClip[[4]] - rasClip[[3]])/(rasClip[[4]] + rasClip[[3]]))
  # names(ndvi) = as.character(date)
  # writeRaster(x = ndvi, filename = paste(date,time,"ndvi.tif", sep="_"))
  
  # Export to brick  
  # all_img = brick(x = c(all_img,rasClip))
  
  # Export to brick  
  all_ndwi = brick(x = c(all_ndwi,ndwi))
  
  # Export to brick  
  # all_blue = brick(x = c(all_blue,blue))

  # Export to brick  
  # all_ndvi = brick(x = c(all_ndvi,ndvi))
  
  }
  
  # Remove
  remove(blue, ndvi, ndwi, ras, rasClip, date, time, s, sr, clipzilla, sh)

# Set thresholding methods
methods = c("IJDefault","Huang","Intermodes","IsoData","Minimum","Moments","Otsu","Shanbhag") #"Li","Mean","Percentile","RenyiEntropy","MinErrorI","Triangle",,"Huang2"

# Empty Dump DF
df = data.frame(NA,NA,NA,NA,NA)
names(df) = c("meth","indx","date","time","area","th")
df = df[complete.cases(df),]
  
for(meth in methods){

  for(l in names(all_ndwi)){
    
    # Get Date
    date = as.Date(data.frame(strsplit(sub(pattern = "raw.", replacement = "", x = names(all_ndwi[[l]])), "_"))[1,], format = "%Y%m%d")
    time = data.frame(strsplit(sub(pattern = "raw.", replacement = "", x = names(all_ndwi[[l]])), "_"))[2,]
    
    # Get image from stack
    img = all_ndwi[[l]]

    # Conversions
    array = as.array(as.integer(img*-100))
    array = array[array > 0]
    
    # Threshold image
    th = auto_thresh(array, meth, ignore_na = T, ignore_black = T)
    th = (th[1]*-1)/100
    img = img > th
    writeRaster(x = img, filename = paste(date,time,meth,"ndwiTh.tif", sep="_"))
    
    rc = clump(img)
    zn = data.frame(zonal(rc, img, fun = sum))
    zn = subset(zn, value == max(zn$value))
    zn = rc==zn$zone
    area = cellStats(zn, sum)
    indx = 'ndwi'
    df = rbind(df, data.frame(meth, indx, date, time, area, th))
    print(meth)
    print(l)
    print(dim(df))
    
    remove(l, img, date, area, th, indx)
  }

  hist(all_ndwi$raw.20170819_182701)
  # for(l in names(all_ndvi)){
  # 
  #   date = as.Date(sub(pattern = "X", replacement = "", x = names(all_ndvi[[l]])), format = "%Y%m%d")
  #   img = all_ndvi[[l]]
  # 
  #   array = as.array(as.integer(img*100))
  #   array = array[array > 0]
  # 
  #   th = auto_thresh(array, meth, ignore_na = T, ignore_black = T)
  #   th = th[1]/100
  #   img = img < th
  #   writeRaster(x = img, filename = paste(l,meth,th,"ndvi.tif", sep="_"), overwrite =T)
  #   
  #   area = cellStats(img, sum)
  #   indx = 'ndvi'
  #   df = rbind(df, data.frame(meth, indx, date, area, th))
  #   print(meth)
  #   print(l)
  #   print(dim(df))
  #   
  #   remove(l, img, date, area, th)
  # }
  
}  


df2 = subset(df, area > 50000 & area < 125000)

df2$areaKm2 = df2$area *(3*3)/(1000*1000)

head(df2)

ggplot(df2, aes(factor(date), areaKm2)) + geom_boxplot() #+ facet_wrap(~meth) + theme_bw()

df2_sum = summaryBy(areaKm2 ~ factor(date) +time, df2, FUN = function(x){c(mean = mean(x), var = var(x), min = min(x), max = max(x))})


ggplot(df2_sum, aes(date, areaKm2.mean)) + geom_point(aes(size = areaKm2.var)) #+ facet_wrap(~meth) + theme_bw()

error = (4300 * 6) / (1000*1000)

df2 = subset(df2_sum, areaKm2.var < 0.002 & areaKm2.mean > 0.8) 

ggplot(df2, aes(date, areaKm2.mean)) + 

  geom_line(linetype =2) +
  geom_errorbar(aes(ymin = areaKm2.mean - error, ymax = areaKm2.mean + error), color = "red") + 
  geom_point() + 
  scale_x_date(date_breaks = "1 month", date_labels = "%b '%y") + 
  
  theme_bw() + 
  theme(aspect.ratio = 0.8) + 
  
  labs(x = "date", y = "Area (km2)")

ggsave(filename = paste(getwd(),"/Area_", format(x = now(), format = "%Y%m%d%H%M%S.pdf"), sep = ""),  width = 12, height = 12, device = "pdf")
write.csv(x = df2, file = paste(getwd(),"/Area_", format(x = now(), format = "%Y%m%d%H%M%S.csv"), sep = ""))
# & area > 75000 & 
#   date != as.Date("20170525", format = "%Y%m%d")
# 20170525
# 20170622
# 20170626




df2 = read.csv("G:/Dropbox/FLNRO_p1/Research_Water/Project_Somenos_Lake/20181124_Somenos_20170101_20181124_c001_PSScene4Band_analytic_sr_02x02/report/Area_20181129152244.csv")

head(df2)
df2 %>% 
  mutate(date = as.Date(date)) %>% 
  ggplot(aes(x = date)) + 
    geom_errorbar(aes(ymin = areaKm2.min, ymax = areaKm2.max), color = "grey", width = 10) + 
    # geom_line(aes(y = areaKm2.mean), linetype = 2) + 
    geom_point(aes(y = areaKm2.mean), shape = 21, size = 3, fill = "yellow") + 
    geom_smooth(aes(y = areaKm2.mean), se = F, color = "blue", linetype = 2) +
    geom_smooth(aes(y = areaKm2.mean), se = F, span = 0.3, color = "red", linetype = 2) +
    theme_classic(base_size = 20) +
    scale_y_continuous(limits = c(0.8,1)) + 
    scale_x_date(date_breaks = "4 months", date_labels = "%b '%y") +
    labs(x = "", y = expression(paste("Lake Area (",km^2,")",sep = "")))
