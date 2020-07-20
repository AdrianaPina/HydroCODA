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
#' @article{Stiff1951,
#' author = {Stiff, Henry A.},
#' doi = {10.2118/951376-G},
#' file = {:C$\backslash$:/Users/USER/AppData/Local/Mendeley Ltd./Mendeley Desktop/Downloaded/Stiff - 1951 - The Interpretation of Chemical Water Analysis by Means of Patterns.pdf:pdf},
#' issn = {0149-2136},
#' journal = {Journal of Petroleum Technology},
#' mendeley-groups = {Propuesta/hidrogeoquimica},
#' month = {oct},
#' number = {10},
#' pages = {15--3},
#' publisher = {Society of Petroleum Engineers},
#' title = {{The Interpretation of Chemical Water Analysis by Means of Patterns}},
#' volume = {3},
#' year = {1951}
#' }
PCAcoda <- function(Dataclust, comp1 = 1, comp2 = 2){
  Data <- Dataclust
  Data[,1:4] <- NULL
  Data$cluster <- NULL
  MyComp <- compositions::acomp(Data)
  Transf <- clr(MyComp)
  pca <- princomp(Transf) # compute principal component analysis
  
  par(mar=c(2,1,1,1))
  par(mfrow=c(1,1))
  screefig <- screeplot(pca, type = "lines") # 

  loads <- pca$loadings
  scor <- pca$scores
  scores1<-cbind(scor,Dataclust$cluster)#clusters
  scores1 <- as.data.frame(scores1)
  N_clus <- max(summary(Dataclust$cluster))
  colorn = topo.colors(N_clus, alpha=1)
  
  #Figure
  
  fig <- plot_ly(scores1, x= scores1[,comp1], y = scores1[,comp2], name = scores1[,ncol(scores1)], 
                 type = 'scatter', mode = 'markers',text = ~paste(Dataclust$ID, 
                                                                  "<br />", "Cluster",scores1[,ncol(scores1)]), hoverinfo = "text") 
  fig <- fig %>%    add_annotations(ax = loads[,1]*10, ay = loads[,2]*10, axref='x', ayref='y', 
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
  
  ResultPCA <- summary(pca)
  list = c(pca,ResultPCA)
  
  return(fig)
  return(list)
}
