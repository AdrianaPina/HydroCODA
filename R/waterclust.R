#' @name  
#' waterclust
#' 
#' @title Clustering of hydrochemical water samples using Compositional Data (CoDA) approach.
#' @description This function allows the user to define clusters according to the hydrochemical characteristics of water samples and to build dendograms, 
#' using the Ward agglomeration method. Compositional Data (CoDA) approach and the Centered log ratio - clr transformation \cite{(Aitchison, 1982)} are implemented for the data treatment. 
#' @param Data is dataframe that contains the hydrochemical composition of water samples. 
#' Titles must be as follows: ID, long, lat, source, Mg, Ca, Na, K, HCO3, Cl, SO4. 
#' All concentrations are in meq/l. Additional chemical compounds must be added in columns after the Fe column concentration and titles must be introduced in a vector in the \emph{chem.name} variable.
#' @param chem.name is a vector than contains the titles of the additional chemical compoundS contained in the data set. If \emph{chem.name = FALSE}, the following chemical compounds are assumed: \emph{Mg, Ca, Na, K, HCO3, Cl, SO4}.
#' @param height is an integer that defines the height of the treecut to define clusters
#' @param typ is a double between 0 and 1 which defines the analysis type. \emph{typ = 1} for the samples clustering and, \emph{typ = 2} for the chemical compounds clustering. 
#' @return Prints a matrix that contains the hydrochemical composition of water samples and the assigned cluster. A dendogram using the established \emph{height} is plotted.
#' 
#' @export
#' 
#' @return prints a matrix that contains the hydrochemical composition of water samples and the assigned cluster. A dendogram using the established \emph{height} is plotted.
#'
#' @author Adriana Piña <appinaf@unal.edu.co>\cr
#' David Zamora <dazamoraa@unal.edu.co> \cr
#' @references 
#' Aitchison, J. (1982). The Statistical Analysis of Compositional Data. Journal of the Royal Statistical Society. Series B (Methodological), 44(2), 139–177.
#' @examples
#' data(Balance)
#' Dataclust <- waterclust(Balance, height = 50, typ = 2, chem.name = FALSE)

waterclust <- function(Data, height, typ, chem.name){
  
  Datachem <- Data
  Datachem[,1:4] <- NULL
  names(Datachem) <- NULL

  Comp <- compositions::acomp(Datachem)
  if(typ == 1){
    dd <- stats::dist(t(compositions::clr(Comp)))  
  } else {
    dd <- compositions::clr(Comp)
  }  
  Tree <- stats::hclust(stats::dist(dd), method = "ward.D")
  Dendogram <- plot(Tree, labels = Data$ID,cex.axis = 1.2,cex.lab = 1,cex = 0.55, 
                    col = "gray40",main="Dendrograma",hang = -1)
  f <- stats::rect.hclust(Tree, h = height)
  N_clus <- length(f)
  cut_tree <- stats::cutree(Tree, k = N_clus)
  cluster <- as.matrix(cut_tree)
  
  if(chem.name == FALSE){
    names(Datachem) <- c("Mg", "Ca", "Na", "K", "HCO3", "Cl","SO4")
  } else {
    names(Datachem) <- chem.name
  }

  Dataclust <- cbind(Data[,1:4], Datachem, cluster)
  # print(Dataclust, Dendogram) 
  print("Results can be checked in Dataclust variable.")

  print(Dendogram)
  return(Dataclust)
}
