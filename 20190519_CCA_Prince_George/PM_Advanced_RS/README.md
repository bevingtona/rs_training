# Advanced Satellite Remote Sensing 
# *Wednesday May 22, 2019*

## Part 1: 1300 1415 PM

1. **Presentation:**
   1. Introductions
   1. Advanced Satellite Remote Sensing
1. **GitHub:** https://github.com/bevingtona/rs_training
   1. Clone or download repository
   1. Optional: https://gitforwindows.org
1. **Google Earth Engine:** https://code.earthengine.google.com
   1. **Exercise 1:** Load a timeseries of Landsat Images
      1. Export scenes 
      1. Export timelapse video
   1. **Exervise 2:** Large area mosaics
      1. Create a function to apply the Sentinel 2 Cloud mask 
      1. Experiment with different mosaics (seasons, years, cloud cover filters)
   1. **Exercise 3:** Export time series data 
      1. Export a csv of NDVI values over time from the Landsat Archive
1. **LandTrendR:** https://emapr.github.io/LT-GEE/
   1. **UI LandTrendr Pixel Time Series Plotter:** source and LandTrendr-fitted data for a pixel https://emaprlab.users.earthengine.app/view/lt-gee-pixel-time-series
   1. **UI LandTrendr Change Mapper:** map disturbances and view attributes https://emaprlab.users.earthengine.app/view/lt-gee-change-mapper
   1. **UI LandTrendr Fitted Index Delta RGB Mapper:** visualize change and relative band/index information https://emaprlab.users.earthengine.app/view/lt-gee-fitted-index-delta-rgb-mapper
   1. **UI LandTrendr Time Series Animator:** make an animated GIF from a LandTrendr FTV annual time series https://emaprlab.users.earthengine.app/view/lt-gee-time-series-animator

## Part 2: 1445 1600 PM

1. **Best new papers:**
   1. 
1. **LandTrendR:**
   1. Add Labels to GIF https://gist.github.com/jdbcode/2af647876e03c76de5424e15b30b74ec
1. **Add LandTrendR in GEE** 
   1. Add Mosaic
   1. Classify image
1. **Planet Explorer and PlanetR**
   1. Planet API https://developers.planet.com/docs/api/  
   1. planetR https://github.com/bevingtona/planetR
   1. Bulk download https://github.com/bevingtona/planetR/blob/master/example/planet_example.R
1. **Planet Image Classification**
   1. Detect NDVI over time 
   2. Plot 