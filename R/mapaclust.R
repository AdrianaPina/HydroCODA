#' Title
#' @title Interactive map showing clusters location.
#' @description This function generates an interactive map of zone showing the samples location and cluster classification using the Compositional Data (CoDa) approach for the data treatment and a clr trasnformation (\cite{Aitchison1982a}).
#' @details This function requires the matrix with the hydrochemical composition of water samples and cluster classification obtained using the \code{\link{waterclut}} function.
#' @param Dataclust is a matrix that contains the hydrochemical composition of water samples and the assigned cluster using the \code{\link{waterclut}} function. Sample name, source, long, lat, Mg, Ca, Na,K,HCO3, Cl,SO4,NO3,NO2,Fe. All concentrations are in meq/l. 
#' @param crsprj is the coordinate reference system (CRS) of an object. Default value is EPSG 4326 for Coordenadas Geográficas WGS84.
#' @param Area is a shape with the area of interest.
#' @param Geology is a shape with the geology of the area of interest.
#' @param Faults is a shape with the faults of the area of interest. 
#' @param mapout whether to render the map in the browser (TRUE) or the RStudio viewer (FALSE).
#' @param Filename is a character varible to assign the name of the generated figure.
#' @param shp_field is a character varible indicating the shape field name that contains the geological description to show in the map.
#' @return
#' @author Adriana Piña <appinaf@unal.edu.co>\cr
#' David Zamora <dazamoraa@unal.edu.co> \cr
#' @export 
#'
#' @examples
#' Fig <- mapaclust(Dataclust, crsprj = 4326, Area, Geology, Faults, mapout = TRUE, shp_field = "SimboloUC", Filename = "clusterMap")
#' Fig
#' 
#' @article{Aitchison1982a,
# author = {Aitchison, J},
# journal = {Journal of the Royal Statistical Society. Series B (Methodological)},
# keywords = {digamma function,maximum likelihood estimation,method of moments,multivariate},
# number = {2},
# pages = {139--177},
# title = {{The Statistical Analysis of Compositional Data}},
# volume = {44},
# year = {1982}
# }


mapaclust <- function(Dataclust, crsprj = 4326, Area, Geology, Faults, mapout = FALSE, shp_field, Filename){
  
  dfb <- cbind(Dataclust[,1:4],Dataclust$cluster) 
  N_clus <- max(summary(Dataclust$cluster))
  colorn = topo.colors(N_clus, alpha=1)
  
  Titulos <- c('ID','lat','long','Tipo','cluster')
  colnames(dfb) <- Titulos
  dfb = as.data.frame(dfb)
  dfb$poph <- paste(Dataclust$ID, "Cluster", Dataclust$cluster, Data$tipo)
  dfb$lat= Dataclust$lat
  dfb$long= Dataclust$long
  dfb_project <- st_as_sf(dfb, coords = c("long", "lat"), crs=  crsprj) #dar formato espacial

  
  Mapa <- mapView(Area, map.types = c("Esri.WorldShadedRelief", "OpenStreetMap.DE"), 
                  color = "red", alpha.regions = 0, legend = FALSE,
                  viewer.suppress = mapout)+
    mapView(Fallas,color = "black",legend = FALSE)+
    mapView(Geologia, zcol = "SimboloUC",alpha.regions = 0.5,
            legend = FALSE) +
    mapview(dfb_project, zcol = "cluster",legend = TRUE,
            #cex = "cluster", 
            col.regions = colorn)
    img <- "./Logo_HYDS_2019.svg" #Como agregar la ruta de la imagen?
    leafem::addLogo(Mapa, img, src = "local",
            position = "bottomleft",
            offset.x = 5,
            offset.y = 40,
            width = 70,
            height = 70)
    mapshot(Mapa, url = paste0(getwd(), "/", Filename, ".html"))
    
  return(Mapa)
}
