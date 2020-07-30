#' Area_data
#' 
#' @format A shape file with the polygon of the study area:
#' \describe{
#'   \item{x}{The min and max latitud}
#'   \item{y}{The min and max longitud}
#'   \item{CRS arguments} {The projection of the shape file}
#' }
"Area_data"

#' faults
#' 
#' @format A shape file with the faults of the study area (Magdalena Middle Valley, Colombia):
#' \describe{
#'   \item{x}{The min and max latitud}
#'   \item{y}{The min and max longitud}
#'   \item{SimboloUC}{The name of the fault}
#'   \item{CRS arguments} {The projection of the shape file}
#' }
#' @source \url{https://www.datos.gov.co/dataset/Fallas/8gux-3y6i}
#' 
"faults"

#' Geological Units
#' 
#' @format  A shape file with the geology of the study area (Magdalena Middle Valley, Colombia):
#' \describe{
#'   \item{x}{The min and max latitud}
#'   \item{y}{The min and max longitud}
#'   \item{SimboloUC}{The geological descrition of each unit}
#'   \item{CRS arguments} {The projection of the shape file}
#'   ...
#' }
#' @source \url{https://www.datos.gov.co/Minas-y-Energ-a/Mapa-Geol-gico-de-Colombia-cronoestratigraf-a/5fee-j9jk}
#' 
"geological_units"

#' Balance
#' 
#' @format  A csv file that contains identification, logtitud, latitud, type of source and the hydrochemical composition of the water samples colected in the Magdalena Middle Valley, Colombia:
#' \describe{
#'   \item{ID}{Identification of each water sample}
#'   \item{long}{Longitud of the point}
#'   \item{lat}{Latitud of the point}
#'   \item{source} {Type of source: well, piezometer, creek, etc.}
#'   \item{Mg} {Mg^{+2} concentration in meq/l.}
#'   \item{Ca} {Ca^{+2} concentration in meq/l.}
#'   \item{Na} {Na^{+} concentration in meq/l.}
#'   \item{K} {K^{+} concentration in meq/l.}
#'   \item{HCO3} {HCO_3^{-} concentration in meq/l.}
#'   \item{Cl} {Cl^{-} concentration in meq/l.}
#'   \item{SO4} {SO_4^{2-} concentration in meq/l.}
#'   \item{NO3} {NO_3^{-} concentration in meq/l.}
#'   \item{NO2} {NO_3^{-} concentration in meq/l.}
#'   \item{Fe} {Fe concentration in meq/l.}
#'   ...
#' }
"Balance"
