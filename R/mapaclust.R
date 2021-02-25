#' @name 
#' mapaclust
#' @title Interactive map showing clusters location.
#' @description This function generates an interactive map of zone showing the samples location and cluster classification using the Compositional Data (CoDA) approach for the data treatment and a clr trasnformation \cite{(Aitchison, 1982)}.
#' @details This function requires the matrix with the hydrochemical composition of water samples and cluster classification obtained using the \code{\link{waterclust}} function.
#' @param Dataclust is a matrix that contains the hydrochemical composition of water samples and the assigned cluster using the \code{\link{waterclust}} function. 
#' ID, long, lat, source, Mg, Ca, Na,K,HCO3, Cl,SO4,NO3,NO2,Fe. All concentrations are in meq/l. 
#' Aditional chemical compounds must be added in columns after the Fe column concentration.
#' @param crsprj is the coordinate reference system (CRS) of an object. Default value is EPSG 4326 for Coordenadas Geográficas WGS84.
#' @param Area is a shape with the area of interest.
#' @param Geology is a shape with the geology of the area of interest.
#' @param Faults is a shape with the faults of the area of interest. 
#' @param mapout whether to render the map in the browser (TRUE) or the RStudio viewer (FALSE).
#' @param Filename is a character varible to assign the file name to save the interactive map in HTML format.
#' @param shp_field is a character varible indicating the shape field name that contains the geological description to show in the map.
#'
#' @return Create a dynamic map showing the geographical distribution of water sample clusters.
#' 
#' @export
#' 
#' @return create a dynamic map showing the geographical distribution of water sample clusters.
#'
#' @author Adriana Piña <appinaf@unal.edu.co>\cr
#' David Zamora <dazamoraa@unal.edu.co> \cr
#' @references 
#' Aitchison, J. (1982). The Statistical Analysis of Compositional Data. Journal of the Royal Statistical Society. Series B (Methodological), 44(2), 139–177.
#' @examples
#' data(geological_units, faults, Area_data, Dataclust)
#' Fig <- mapaclust(Dataclust, crsprj = 4326, Area = Area_data, 
#'                  Geology = geological_units, Faults =faults, mapout = TRUE, 
#'                  shp_field = "SimboloUC", Filename = NULL)
#' Fig

mapaclust <- function(Dataclust, crsprj = 4326, Area, Geology, Faults, mapout = FALSE, shp_field, Filename){
  
  dfb <- cbind(Dataclust[,1:4],Dataclust$cluster) 
  N_clus <- max(summary(Dataclust$cluster))
  colorn <- hcl.colors(N_clus, palette = "viridis")
  
  TRANS <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
  
  
  Titulos <- c('ID','lat','long','Tipo','cluster')
  colnames(dfb) <- Titulos
  dfb = as.data.frame(dfb)
  dfb$poph <- paste(Dataclust$ID, "Cluster", Dataclust$cluster, Dataclust$tipo)
  dfb$lat= Dataclust$lat
  dfb$long= Dataclust$long
  dfb_project <- sf::st_as_sf(dfb, coords = c("long", "lat"), crs=  TRANS) #dar formato espacial

  Mapa <-  mapview::mapview(dfb_project, zcol = "cluster",legend = TRUE,
                   viewer.suppress = mapout,
                   map.regions = colorn)
  if(!is.null(Area)){
    Area <- sp::spTransform(Area, TRANS)
    Mapa <- Mapa + mapview::mapView(Area, color = "red",alpha.regions = 0,legend = FALSE)
  }
  if(!is.null(Faults)){
    Faults <- sp::spTransform(Faults, TRANS)
    Mapa <- Mapa + mapview::mapView(Faults,color = "black",legend = FALSE)
  }
  if(!is.null(Geology)){
    Geology <- sp::spTransform(Geology, TRANS)
    Mapa <- Mapa + mapview::mapView(Geology, zcol = shp_field, alpha.regions = 0.4,
                           legend = FALSE) 
    }
  if(!is.null(Filename)){
    mapview::mapshot(Mapa, url = paste0(getwd(), "/", Filename, ".html"))
  }
  return(Mapa)
}
