#' transdata
#'
#' @param MyData 
#' @description 
#' @return
#' @export
#'
#' @examples
transdata <- function(MyData){
  MyComp <- compositions::acomp(MyData)
  return(MyComp)
}
 
