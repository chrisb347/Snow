# Snow Shiny Application

The rnoaa package for the National Oceanic and Atmospheric Association (NOAA) is a great portal to download free weather data from many of the weather data collection services by NOAA.
I am a big snowboarder, so when my professor told us we could make a shiny application on anything we wanted as long as we only spend 2-3 weeks on it, I knew that writing an application to see where the most
snowfall occurs and when would be what I wanted to do. I know all of the top ski resorts and I obtained the geospatial coordinates for each of them, and rnoaa functions are able to use these coordinates to do the rest.

## Downloading the data through rnoaa package

The packages used to work with the data and connect to the API for this project are: [rnoaa](https://docs.ropensci.org/rnoaa/articles/rnoaa.html), [rgdal](https://www.rdocumentation.org/packages/rgdal/versions/1.5-16), [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html), 
[tidyverse](https://www.tidyverse.org), [reshape2](https://cran.r-project.org/web/packages/reshape2/index.html)

rnoaa has a terrific setup that allows the user to take a list of geospatial coordinates and pass them through a a function called **meteo_nearby_stations()**. Once I had a list of coordinates of my favorite ski resorts it was no trouble to pass coordinates into this function. This function uses these coordinates and draws a circle with a user specified radius in kilometers. Then the fucntion searches for x number of weather stations within that radius and will yield their daily data in a data frame. What fun! 

|rowID|stationID|x|Date|mflag_snwd|qflag_snwd|sflag_snwd|snwd|mflag_snow|qflag_snow|sflag_snow|snow|name_dist|Mountain|name|latitude|longitude|distance|km|dist|Fall|Depth|
|-----|--|---------|----|----------|---------|-----------|----|----------|----------|----------|----|---------|--------|----|--------|---------|--------|--|----|----|-----|
|1|US1COEG0009|146885|2003-11-01| | | |0| | | |0|Beaver Creek, Colorado 7.61 (km)|Beaver Creek, Colorado|VAIL 4.1 WSW|39.618|-106.4295|7.60905163327255|(km)|7.61|2.5|0|
|2|US1COEG0009|146885|2003-11-01| | | |0| | | |0|Vail, Colorado 5.35 (km)|Vail, Colorado|VAIL 4.1 WSW|39.618|-106.4295|5.34582940993183|(km)|5.35|0|0|
|3|US1COEG0009|146886|2003-11-02| | | |0| | | |0|Beaver Creek, Colorado 7.61 (km)|Beaver Creek, Colorado|VAIL 4.1 WSW|39.618|-106.4295|7.60905163327255|(km)|7.61|0|10|
|799282|USC00426648|300626|1928-11-18|NA|NA|0|0| | |6|0|Park City, Utah 2.14 (km)|Park City, Utah|PARK CITY G.C.|40.66|-111.5156|2.14321110201938|(km)|2.14|0|0|
|799283|USC00426648|300627|1928-11-19|NA|NA|0|0| | |6|0|Deer Valley, Utah 4.03 (km)|Deer Valley, Utah|PARK CITY G.C.|40.66|-111.5156|4.02712962300516|(km)|4.03|0|0|
|1428957|USS0021A32S|512392|2008-08-10| | |T|0|NA|NA|0|0|Mount Baker, Washington 11.92 (km)|Mount Baker, Washington|Elbow Lake|48.69|-121.91|11.9205608676175|(km)|11.92|0|5|
|1468847|USW00093230|326166|2019-11-29| | | |0| | | |0|Heavenly, Lake Tahoe, California  6.25 (km)|Heavenly, Lake Tahoe, California |SOUTH LAKE TAHOE AP|38.8983|-119.9947|6.24895331637875|(km)|6.25|0|0|
|1468848|USW00093230|326167|2019-11-30| | | |0| | | |0|Heavenly, Lake Tahoe, California  6.25 (km)|Heavenly, Lake Tahoe, California |SOUTH LAKE TAHOE AP|38.8983|-119.9947|6.24895331637875|(km)|6.25|0|0|





