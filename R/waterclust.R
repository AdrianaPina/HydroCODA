#Paquetes: stats, compositions, utils, rgdal

#' Title
#' @description This function allows the user to define clusters according to the hydrochemical characteristics of water samples and to build dendograms, using the Compositional Data (CoDa) approach for the data treatment and a clr transformation (\cite{Aitchison1982a}). 
#' @param Data is dataframe that contains the hydrochemical composition of water samples. Sample name, source, long, lat, Mg, Ca, Na,K,HCO3, Cl,SO4,NO3,NO2,Fe. All concentrations are in meq/l.
#' @param height is an integer that defines the height of the treecut to define clusters
#' @param typ is a double between 0 and 1 which defines the analysis type. 1 for the samples clustering and 2 for the chemical compounds clustering 
#'
#' @author Adriana Piña <appinaf@unal.edu.co>\cr
#' David Zamora <dazamoraa@unal.edu.co> \cr
#' @export
#'
#' @examples
#'Dataclust <- waterclust(Data, height = 35, typ = 2)

waterclust <- function(Data, height, typ = 2){
  Datachem <- Data
  Datachem[,1:4] <- NULL

  #Eliminar variables con más del 15% de datos faltantes

  Comp = acomp(Datachem)
  if(typ == 1){
  dd <- dist(t(clr(Comp)))  
  }
  else {
  dd <- clr(Comp )
  }  
  Tree <- hclust(dist(dd),method = "ward.D")
  Dendogram <- plot(Tree,labels = Tree$X,cex.axis = 1.2,cex.lab=1,cex = 0.55, col = "gray40",main="Dendrograma",hang = -1)
  f <- rect.hclust(Tree, h = height)
  N_clus <- length(f)
  cut_tree <- cutree(Tree, k = N_clus)
  cluster <- as.matrix(cut_tree)
  Dataclust <- cbind(Data[,1:4],Datachem, cluster)
  #Dataclust <- as.data.frame(Dataclust)
  #dimnames(Dataclust)[[1]] <- Data$ID  
    
  #write.table(Dataclust, file = "Dataclust.csv", row.names=F)
  print(Dataclust, Dendogram)
}