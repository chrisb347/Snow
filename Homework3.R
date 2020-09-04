#install.packages('rnoaa')
#install.packages('jsonlite')
#install.packages('httr')
#install.packages('rgdal')
library(rnoaa)
library(jsonlite)
library(httr)
library(rgdal)
library(dplyr)
library(tidyverse)
library(reshape2)
library(ggplot2)

#install.packages("https://cran.r-project.org/src/contrib/rgdal_0.9-1.tar.gz", repos = NULL, type="source", configure.args = "--with-gdal-config=/Library/Frameworks/GDAL.framework/Versions/1.10/unix/bin/gdal-config --with-proj-include=/Library/Frameworks/PROJ.framework/unix/include --with-proj-lib=/Library/Frameworks/PROJ.framework/unix/lib")
#install.packages('rgdal')


#####input key to interact with the noaa database

options(noaakey = 'cXBFucDzRYbUampcvGHBBGxDRLEzDrFn')

setwd('C:\\Users\\Cbarry\\Desktop\\fordham\\Data vis\\homework3\\')


##downloading from the database takes a while so save the files locally if you can

resort<-read.csv('Resort_coordinates.csv')
f<- read.csv('stations.csv')
Stations_pull<-read.csv('stations_pull.csv')

##this function puts all the weather stations in a data frame. make sure you save this locally
# f <-ghcnd_stations()
# write.csv(f,'stations.csv')

###find stations near a list of geo locations. headers are very important in the resort object, also do not import this as a tibble.
##if you import the resort file as a tibble the below function will fail
###rnoaa documentation has a link to the list of acceptable weather types to search for, for the var argument

stations<- meteo_nearby_stations(lat_lon_df=resort, station_data = f, var=c('SNOW','SNWD','DASF','MDSF','WESD','WESF','WT**','WV**'),year_min = 1850,year_max = 2019,limit=5,radius = 25)

#var=c('SNOW','SNWD','DASF','MDSF','WESD','WESF','WT**','WV**')

##collapse stations list into one data frame
stations1<-stations%>%
  bind_rows(.id='Mountain')

###pull all the actual weather data down by day for each station

# Stations_pull<-meteo_pull_monitors(stations1$id,keep_flags=TRUE,var=c('SNOW','SNWD'))

# write.csv(Stations_pull,'stations_pull.csv')

##merge with identiers other cleaning
station_labeled<-merge(Stations_pull,stations1,by='id',all=TRUE)

km<-'(km)'
station_labeled<-cbind(station_labeled,km)

station_data<-station_labeled%>%
  replace(.,is.na(.),0) %>%
  mutate(dist=round(distance,digits=2), Fall=round(snow*0.0393701,digits=2),Depth = round(snwd*0.0393701,digits=2))%>%
  unite(name_dist,Mountain,dist,km,remove=FALSE, sep=' ')

##write out final dataframe for App
write.csv(station_data,'sd1.csv')

# ggplot(filter(station_data,name_dist=='Vail, Colorado 5.35 (km)'| name_dist== 'Brighton, Utah 4.85 (km)')) +
#   geom_line(aes(x=date,y=snow,col=name_dist))



# x_sum<-station_data%>%
#   select(id,Mountain,snow,snwd)%>%
#   group_by(id,Mountain)%>%
#   summarize_all(sum)
# 
# write.csv(x_sum,"merge_test.csv")
# 
# y_sum<-Stations_pull%>%
#   replace(.,is.na(.),0)%>%
#   select(id,snwd,snow)%>%
#   group_by(id)%>%
#   summarize_all(sum)
# 
# write.csv(y_sum,'un_merge_test.csv')



# date_min_max<-station_labeled%>%
#   group_by(id,Mountain)%>%
#   arrange(date)%>%
#   filter(date %in% range(date))




###create map dataframe 

map_station3<-station_data%>%
  select(id,Mountain,snow,snwd,longitude,latitude)%>%
  group_by(id,Mountain,longitude,latitude)%>%
  summarise_all(sum)%>% 
  unite(descript,Mountain,snow, sep='=',remove=FALSE)

map_station1<-station_data%>%
  select(id,date)%>%
  group_by(id)%>%
  summarise_all(min)%>%
  rename(min=date)

map_station2<-station_data%>%
  select(id,date)%>%
  group_by(id)%>%
  summarise_all(max)%>%
  rename(max=date)

date_merge<-merge(map_station1,map_station2,by='id')
map_station<-merge(map_station3,date_merge,by='id')

mp_s<-map_station%>%unite(dates,min,max,sep='-',remove=FALSE)%>%
  unite(descript1,descript,dates,sep=', ',remove=FALSE)


