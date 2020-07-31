#' Area_data
#' 
#' @format A shape file with the polygon of the study area:
#' \describe{
#'   \item{x}{The min and max latitud}
#'   \item{y}{The min and max longitud}
#' }
"Area_data"

#' faults
#' 
#' @format A shape file with the faults of the study area (Magdalena Middle Valley, Colombia):
#' \describe{
#'   \item{x}{The min and max latitud}
#'   \item{y}{The min and max longitud}
#'   \item{SimboloUC}{The name of the fault}
#' }
#' @source \url{https://www.datos.gov.co/dataset/Fallas/8gux-3y6i}
"faults"

#' Geological Units
#' 
#' @format  A shape file with the geology of the study area (Magdalena Middle Valley, Colombia):
#' \describe{
#'   \item{x}{The min and max latitud}
#'   \item{y}{The min and max longitud}
#'   \item{SimboloUC}{The geological descrition of each unit}
#' }
#' @source \url{https://www.datos.gov.co/Minas-y-Energ-a/Mapa-Geol-gico-de-Colombia-cronoestratigraf-a/5fee-j9jk}
"geological_units"

#' Balance
#' 
#' @format  A csv file that contains identification, logtitud, latitud, type of source and the hydrochemical composition of the water samples colected in the Magdalena Middle Valley, Colombia:
#' \describe{
#'   \item{ID}{Identification of each water sample}
#'   \item{long}{Longitud of the point}
#'   \item{lat}{Latitud of the point}
#' }
"Balance"

#' Dataclust
#' 
#' @format  A csv file that contains identification, logtitud, latitud, type of source, cluster clasification using \code{\link{waterclust}} function and, the hydrochemical composition of the water samples colected in the Magdalena Middle Valley, Colombia:
#' \describe{
#'   \item{ID}{Identification of each water sample}
#'   \item{long}{Longitud of the point}
#'   \item{lat}{Latitud of the point}
#' }
"Dataclust"
