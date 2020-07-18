# paquetes: dplyr
#' Title
#' @title Representative Stiff Diagram for the cluster classification of hydrochemical water samples.
#' @description This function generates the representative Stiff Diagram (\cite{Stiff1951}) using the average concentration of each cluster.
#'  
#' @param Dataclust is a matrix that contains the hydrochemical composition of water samples and the assigned cluster using the \code{\link{waterclut}} function. Sample name, source, long, lat, Mg, Ca, Na,K,HCO3, Cl,SO4,NO3,NO2,Fe. All concentrations are in meq/l. 
#'
#' @return
#' @author Adriana Piña <appinaf@unal.edu.co>\cr
#' David Zamora <dazamoraa@unal.edu.co> \cr
#' @export
#'
#' @examples
#' Fig <- Stiffclust(Dataclust)
#' Fig
#' 
#' #' @article{Stiff1951,
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
#' 
Stiffclust <- function(Dataclust){
  Datachem <- Dataclust
  Datachem[,1:4] <- NULL
  by_cyl <- Datachem %>% group_by(cluster)
  stiff <- by_cyl %>% summarise(
    stiff$Cl <- mean(Cl),
    stiff$SO4 <- mean(SO4),
    stiff$HCO3 <- mean(HCO3),
    stiff$Na <- mean(Na),
    stiff$Mg <- mean(Mg),
    stiff$Ca <- mean(Ca),
  )
  title <- c("cluster", "Cl","SO4","HCO3","Na","Mg","Ca")
  colnames(stiff) <- title
  M_stiff <- data.frame(stiff)
  M_stiff$Na <- (-1) * M_stiff$Na
  M_stiff$Mg <- (-1) * M_stiff$Mg
  M_stiff$Ca <- (-1) * M_stiff$Ca
  M_stiff$cluster <- NULL
  M_stiff <- t(M_stiff)
  
  N_clus <- ncol(M_stiff)
  colorn = topo.colors(N_clus, alpha=1)
  y <- rbind(1,2,3,3,2,1)
  y <- y/10
  
  D_stiff <- cbind(M_stiff,y)
  maxVal <- max(max(D_stiff[,1:N_clus]),abs(min(D_stiff[,1:N_clus])))
  
  #Figura
    par(mar=c(1,1,1,1))
    par(mfrow=c(N_clus,1))
    for (i in 1:N_clus) {
      Fig <- plot(D_stiff[,i], y, cex = 0, xlim = c(-(maxVal), maxVal),
                yaxt = 'n',xlab = "", ylab = "",ann = TRUE, bty = 'n',
                main = i)
      polygon(D_stiff[,i],y,col = colorn[i]) 
    }
  return(Fig)
}