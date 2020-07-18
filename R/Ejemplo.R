
library(dplyr)
library(ggplot2)
library(compositions) 
library(plotly)
library(mapview)
library(sf)
library(utils)
library(stats)
library(rgdal)

 

setwd("D:/MEGIA/Hidroquimica")
Data = read.csv("Balance_borra.csv", header = TRUE,sep = ";")
Area <- readOGR("Area contractual.shp")
Geologia <- readOGR("D:/MEGIA/Hidroquimica/shp/Unidades_Geo.shp")
Fallas <- readOGR("D:/MEGIA/Hidroquimica/shp/Fallas.shp")


Dataclust <- waterclust(Data, 35, typ = 2)
mapaclust(Dataclust, crsprj = 4326, Area, Geology, Faults, mapout = FALSE, Filename = "clusterMap")
Stiffclust(Dataclust)
Results <- PCAcoda(Dataclust, comp1 = 1, comp2 = 2)
  