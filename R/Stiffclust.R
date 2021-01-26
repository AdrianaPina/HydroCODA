#' @name 
#' Stiffclust
#' @title Representative Stiff Diagram for the cluster classification of hydrochemical water samples.
#' @description This function generates the representative CoDA Stiff Diagrams \cite{(Stiff, 1951)} using the mean chemical concentration of each cluster.
#' 
#' @param Dataclust is a matrix that contains the hydrochemical composition of water samples and the assigned cluster using the \code{\link{waterclust}} function. Sample name, source, long, lat, Mg, Ca, Na,K,HCO3, Cl,SO4,NO3,NO2,Fe. All concentrations are in meq/l. 
#' @param plt is a logical value to indicate whether plot is diplayed
#' @return Draws the representative CoDa Stiff Diagram for the cluster classification of hydrochemical water samples.
#' 
#' @export
#' 
#' @import grDevices
#' 
#' @param Dataclust is a matrix that contains the hydrochemical composition of water samples and the assigned cluster using the \code{\link{waterclust}} function. ID, long, lat, source, Mg, Ca, Na,K,HCO3, Cl,SO4,NO3,NO2,Fe. All concentrations are in meq/l. 
#' @return draws the representative CoDa Stiff Diagram for the cluster classification of hydrochemical water samples.
#' 
#' @author Adriana Piña <appinaf@unal.edu.co>\cr
#' David Zamora <dazamoraa@unal.edu.co> \cr
#' @references 
#' Stiff, H. A. (1951). The Interpretation of Chemical Water Analysis by Means of Patterns. Journal of Petroleum Technology, 3(10), 15–3. <DOI: 10.2118/951376-G>
#' @examples
#' data(Dataclust)
#' Fig <- Stiffclust(Dataclust, plt = TRUE)
#' Fig

Stiffclust <- function(Dataclust, plt){
  Datachem <- Dataclust
  Datachem[,1] <- NULL
  by_cyl <- dplyr::group_by(Datachem, cluster)
  stiff <- dplyr::summarise(by_cyl,
    Cl = mean(Cl),
    HCO3 = mean(HCO3),
    SO4 = mean(SO4),
    Mg = mean(Mg),
    Ca = mean(Ca),
    Na = mean(Na),
    K = mean(K),
  )
  title <- c("cluster", "Cl", "HCO3", "SO4", "Mg", "Ca", "Na", "K")
  colnames(stiff) <- title
  M_stiff <- data.frame(stiff)
  M_stiff$NaK <- (-1) * M_stiff$Na
  M_stiff$Mg <- (-1) * M_stiff$Mg
  M_stiff$Ca <- (-1) * M_stiff$Ca
  M_stiff$cluster <- NULL
  M_stiff$Na <- NULL
  M_stiff$K <- NULL
  M_stiff <- t(M_stiff)
  
  N_clus <- ncol(M_stiff)
  colorn = topo.colors(N_clus, alpha = 1)
  y <- rbind(3, 2, 1, 1, 2, 3)
  y <- y/10
  
  D_stiff <- cbind(M_stiff, y)
  maxVal <- max(max(D_stiff[ ,1:N_clus]), abs(min(D_stiff[ ,1:N_clus])))
  
  #Figura
  if(plt == TRUE){
    par(mar = c(0.5,0.5, 0.5, 0.5))
    par(mfrow = c(N_clus, 1))
    aux <- N_clus-1
    for (i in 1:aux) {
      Fig <- plot(D_stiff[,i], y, cex = 0, xlim = c(-(maxVal), maxVal),
                yaxt = 'n', xaxt = 'n', xlab = "", ylab = i, ann = TRUE, bty = 'n')
      polygon(D_stiff[,i], y, col = colorn[i]) 
    }
  
    par(mar = c(2, 0.5, 0.5, 0.5))
    Fig <- plot(D_stiff[,N_clus], y, cex = 0, xlim = c(-(maxVal), maxVal),
                yaxt = 'n', xlab = "", ylab = N_clus, ann = TRUE, bty = 'n')
    polygon(D_stiff[,N_clus], y, col = colorn[N_clus]) 
    mtext("meq/l", side = 1, adj = 0, cex = 0.7)
    text(-maxVal, 0.3, "Na+K", cex = 0.9)
    text(-maxVal, 0.2 , "Ca++", cex = 0.9)
    text(-maxVal, 0.1, "Mg++", cex = 0.9)
    text(maxVal, 0.3, "Cl-", cex = 0.9)
    text(maxVal, 0.2 , "HCO3-", cex = 0.9)
    text(maxVal, 0.1, "SO4--", cex = 0.9)
  }
  print(Fig)
}
