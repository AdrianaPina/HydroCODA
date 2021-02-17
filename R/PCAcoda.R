#' @name 
#' PCAcoda
#' @title Principal Analysis Components using the Compositional Data (CoDA) approach.
#' @description Principal Analysis Components using the Compositional Data (CoDA) approach for the data treatment and the Centered log ratio - clr transformation \cite{(Aitchison, 1982)}.
#' @param Dataclust is a matrix that contains the hydrochemical composition of water samples and the assigned cluster using the \code{\link{waterclust}} function.
#' Titles must be as follows: ID, long, lat, source, Mg, Ca, Na, K, HCO3, Cl,SO4, NO3, NO2, Fe. All concentrations are in meq/l.
#' Aditional chemical compounds must be added in columns after the Fe column concentration. 
#' @param comp1 is a numeric value indicating the number of the component to be plotted on the x-axys.
#' @param comp2 is a numeric value indicating the number of the component to be plotted on the y-axys.
#'
#' @return returns an interactive compositional biplot with the selected compositions, the samples description and the assigned cluster from the \code{\link{waterclust}} function; 
#' a summary of the PCA analysis with the Standard deviation, the Proportion of Variance and the Cumulative Proportion for each composition;
#' a list with class "princomp" (see \code{\link{compositions}} documentation)
#' 
#' @export 
#' 
#' @import grDevices graphics
#' 
#' @return a list that comprises a figure and two dataframes. The figure is an interactive compositional biplot with the selected compositions, the samples description and the assigned cluster from the \code{\link{waterclust}} function;
#' The first list, is the summary of the PCA analysis with the Standard deviation, the Proportion of Variance and the Cumulative Proportionfor each composition. 
#' The second one is a list with class "princomp" (see \code{\link{compositions}} documentation).
#' 
#' @author Adriana Piña <appinaf@unal.edu.co>\cr
#' David Zamora <dazamoraa@unal.edu.co> \cr
#' @references 
#' Aitchison, J. (1982). The Statistical Analysis of Compositional Data. 
#' Journal of the Royal Statistical Society. Series B (Methodological), 44(2), 139–177.
#' 
#' @examples
#' data("Balance")
#' Dataclust <- waterclust(Balance, height = 35, typ = 2)
#' PCAcoda(Dataclust, comp1 = 1, comp2 = 2)

PCAcoda <- function(Dataclust, comp1, comp2){
  Data <- Dataclust
  Data[,1:4] <- NULL
  Data$cluster <- NULL
  MyComp <- compositions::acomp(Data)
  Transf <- compositions::clr(MyComp)
  pca <- compositions::princomp.rmult(Transf, cor=FALSE, robust = TRUE) # compute principal component analysis
  PoV <- pca$sdev^2/sum(pca$sdev^2)*100
  PoV <- formatC( signif(PoV, digits=3))
  
  print(summary(pca, loadings = TRUE, cutoff = 0.1), digits = 2)
  
  
  par(mar = c(2,2,1,1))
  par(mfrow = c(1,1))
  screefig <- stats::screeplot(pca, type = "lines") # 
  
  loads <- pca$loadings
  scor <- pca$scores
  scores1<-cbind(scor,Dataclust$cluster)#clusters
  scores1 <- as.data.frame(scores1)
  N_clus <- max(summary(Dataclust$cluster))
  colorn <- hcl.colors(N_clus, palette = "viridis")
  
  #Figure
  name <- as.character(Dataclust$tipo)
  fig <- plotly::plot_ly(scores1, x= scores1[,comp1], y = scores1[,comp2], 
                         name = scores1[,ncol(scores1)], 
                         type = 'scatter', mode = 'markers',
                         text = ~paste(Dataclust$ID, "<br />", 
                                       "Cluster", scores1[,ncol(scores1)],"<br />", name), 
                         hoverinfo = "text", colors = colorn, color = ~scores1[, dim(scores1)[2]])
  fig <- plotly::hide_colorbar(fig)
  fig <- plotly::add_annotations(fig, ax = loads[,1]*10, ay = loads[,comp2]*10, axref='x', ayref='y', 
                            x = 0, y = 0, xref='x', yref='y',arrowcolor='gray',
                            text = row.names(loads),arrowhead = 0,arrowsize = 0.00001,
                            font = list(color = '#264E86',
                                        family = 'sans serif',
                                        size = 16))
  
  fig <- plotly::layout(fig, title = "CoDA+PCA", 
                        xaxis = list(title = paste("Comp ", comp1, "(", PoV[comp1],"%)")),
                        yaxis = list(title = paste("Comp ", comp2, "(", PoV[comp2],"%)")),
                        font = list(color = 'black',
                               family = 'sans serif', size = 14))
  
  fig


  output <- list(fig = fig, pca = pca)
  return(output)
}
