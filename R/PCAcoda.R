# paquetes: compositions, ggplot, plotly, stats

#' @name 
#' PCAcoda
#'
#' @title Principal Analysis Components using the Compositional Data (CoDa).
#' @description Principal Analysis COmponents using the Compositional Data (CoDa) approach for the data treatment and a clr transformation (\cite{Aitchison1982a})
#'
#' @param Dataclust is a matrix that contains the hydrochemical composition of water samples and the assigned cluster using the \code{\link{waterclut}} function. Sample name, source, long, lat, Mg, Ca, Na,K,HCO3, Cl,SO4,NO3,NO2,Fe. All concentrations are in meq/l. 
#' @param comp1 is a numeric value indicating the number of the component to be plotted on the x-axys.
#' @param comp2 is a numeric value indicating the number of the component to be plotted on the y-axys.
#'
#' @return
#' @author Adriana Piña <appinaf@unal.edu.co>\cr
#' David Zamora <dazamoraa@unal.edu.co> \cr
#' 
#' @import stats
#' 
#' @export
#'
#' @examples
#' PCAcoda(Dataclust, comp1 = 1, comp2 = 2)
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
PCAcoda <- function(Dataclust, comp1 = 1, comp2 = 2){
  Data <- Dataclust
  Data[,1:4] <- NULL
  Data$cluster <- NULL
  MyComp <- compositions::acomp(Data)
  Transf <- compositions::clr(MyComp)
  pca <- stats::princomp(Transf) # compute principal component analysis
  
  par(mar=c(2,2,1,1))
  par(mfrow=c(1,1))
  screefig <- stats::screeplot(pca, type = "lines") # 

  loads <- pca$loadings
  scor <- pca$scores
  scores1<-cbind(scor,Dataclust$cluster)#clusters
  scores1 <- as.data.frame(scores1)
  N_clus <- max(summary(Dataclust$cluster))
  colorn = topo.colors(N_clus, alpha=1)
  
  #Figure
  name <- as.character(Dataclust$tipo)
  fig <- plot_ly(scores1, x= scores1[,comp1], y = scores1[,comp2], 
                 name = scores1[,ncol(scores1)], 
                 type = 'scatter', mode = 'markers',
                 text = ~paste(Dataclust$ID, "<br />", 
                               "Cluster", scores1[,ncol(scores1)],"<br />", name), 
                 hoverinfo = "text") 
  fig <- fig %>%    add_annotations(ax = loads[,1]*10, ay = loads[,comp2]*10, axref='x', ayref='y', 
                                    x = 0, y = 0, xref='x', yref='y',arrowcolor='gray',
                                    text = row.names(loads),arrowhead = 0,arrowsize = 0.00001,
                                    font = list(color = '#264E86',
                                                family = 'sans serif',
                                                size = 16))
  fig <- fig %>% layout(title = "CoDa+PCA", xaxis = list(title = paste("Comp ", comp1)),
                        yaxis = list(title = paste("Comp ", comp2)),
                        font = list(color = 'black',
                                    family = 'sans serif', size = 14))
  
  fig
  
  ResultsPCA <- summary(pca)
  output <- list(fig = fig, ResultsPCA = ResultsPCA, pca = pca)
  return(output)
}
