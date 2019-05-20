# Advanced Satellite Remote Sensing 
# *Wednesday May 22, 2019*

## Part 1: 1300 1415 PM

1. **Presentation:**
   1. Introductions
   1. Advanced Satellite Remote Sensing
   1. A review of free optical satellite remote sensing https://www.researchgate.net/publication/326190414_A_Review_of_Free_Optical_Satellite_Imagery_for_Watershed-Scale_Landscape_Analysis 

1. **GitHub:** https://github.com/bevingtona/rs_training
   1. Clone or download repository
   1. Optional: https://gitforwindows.org
1. **Google Earth Engine:** https://code.earthengine.google.com
   1. **Exercise 1:** Timelapse of Landsat imagery
      1. https://code.earthengine.google.com/0ecca4de6a7d9485ac168394007224e5
      1. ee.Image(); ee.ImageCollection()
      1. Export.image.toDrive(); Export.video.toDrive() 
   1. **Exervise 2:** Large area mosaics
      1. https://code.earthengine.google.com/f0b6c7b0b9442bc6afa64c6c900ff5b4
      1. Create a function to apply the Sentinel 2 Cloud mask 
      1. Experiment with different mosaics (seasons, years, cloud cover filters)
   1. **Exercise 3:** Export time series data 
      1. https://code.earthengine.google.com/3bd1f2c1e83c84d9e1e8d2ff74676b3a
      1. Export a csv of NDVI values for a point from the entire Landsat Archive

## Part 2: 1445 1600 PM

1. **LandTrendR:** https://emapr.github.io/LT-GEE/
   1. **UI LandTrendr Pixel Time Series Plotter:** source and LandTrendr-fitted data for a pixel https://emaprlab.users.earthengine.app/view/lt-gee-pixel-time-series
   1. **UI LandTrendr Change Mapper:** map disturbances and view attributes https://emaprlab.users.earthengine.app/view/lt-gee-change-mapper
   1. **UI LandTrendr Fitted Index Delta RGB Mapper:** visualize change and relative band/index information https://emaprlab.users.earthengine.app/view/lt-gee-fitted-index-delta-rgb-mapper
   1. **UI LandTrendr Time Series Animator:** make an animated GIF from a LandTrendr FTV annual time series https://emaprlab.users.earthengine.app/view/lt-gee-time-series-animator
   1. **Gif Labels:**
   1. Add Labels to GIF https://gist.github.com/jdbcode/2af647876e03c76de5424e15b30b74ec
1. **Add LandTrendR in GEE** 
   1. Add Mosaic
   1. Classify image
1. **Planet Explorer and PlanetR**
   1. Planet Explorer https://planet.com/explorer/
   1. Planet API https://developers.planet.com/docs/api/  
   1. planetR https://github.com/bevingtona/planetR
   1. Bulk download https://github.com/bevingtona/planetR/blob/master/example/planet_example.R
1. **Planet Image Classification**
   1. Calculate NDVI per image in R
   1. Plot NDVI change over time in R
   1. Export Gif animation
   1. Plot NDVI change over time