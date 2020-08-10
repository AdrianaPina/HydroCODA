Adriana Piña
27/7/2020





# HydroCODA

The R package aims to analyse underlying hydrogeological processes
governing the hydrochemistry using the Compositional Data approach
proposed by Aitchison (1982) prior a Multistatistical Analysis. It is a
tool to perform water samples clasification by a Hierarchical Cluster
Analysis - HCA and Principal Component Analysis - PCA. Finally, it
creates the classical Stiff Diagram Stiff (1951) for each cluster and
draws an interactive map with the location, description and cluster
clasification. CoDA techniques have been well developed in the R-package
“compositions” Van Den Boogaart and Tolosana (2015), then HydroCODA
R-package is an implementation to enhance the hydrogeochemical analysis.

## Installation

Currently, you can install the version under development from
[Github](https://github.com/AdrianaPina/HydroCODA), using these
commands:

``` r
install.packages("devtools")
devtools::install_github("AdrianaPina/HydroCODA")
```

## Compositional Data Analysis CoDA for the treatment of hydrogeochemical water samples

Water sampling provides information about the state of a system. In
hydrogeology, water composition allows to study the provenance of
grundwater according to the mineral interaction with the host rock, to
define recharge, flowpaths and discharge zones, to identify aquifer
pollution due to natural or antrophic conditions, among others. As
result, large databases are built based on the number of samples and,
the measured chemical compounds, wich are at least the major ions
(Ca^{+2}, Mg^{+2}, K^{+}, Na^{+}, Cl^{-}, HCO\_3^{-}, NO\_3^{-},
NO\_2^{-} and SO\_4^{2-}). To overcome the integration, interpretation
and representation of the results, a very common practice is the use of
multivariate statistical techniques Cloutier et al. (2008) that require
data standarization and transformation.

However, hydrogeochemical data from a single sample consist of a series
of measurements of analytes, commonly expressed in proportions such as
mg/L, ppm or ppb Blake et al. (2016), which charactertize the
compositional data (the fact that the determinations on each specimen
sum to a constant) (Aitchison (1982)). As consequence, there is a
misinterpretation of closed data when treated with “normal” statistical
methods and the usual multivariate statistical techniques are not
applicable to constrained data (Aitchison (2003)).

Then, the incorporation of CoDA techniques greatly improved traditional
statistical techniques in particular the PCA and the HCA, allows for the
identification of underlying hydrogeological processes governing the
hydrochemistry (Blake et al. (2016), Piña et al. (2018)). With this
approach data are fully taken into account, enhancing their relative
multivariate behaviour in the correct sample space (Buccianti et al.
(2015)).

Based on the R-package “compositions” Van Den Boogaart and Tolosana
(2015), raw hydrochemical data is treated as compositional data, then a
CLR transformation (Aitchison (2003)) is implemented to perform the HCA;
it allows the classification of water samples (cluster). Then, water
samples and the assigned cluster are located on a map to visualize the
results acording to the geology and faults distribution. There is an
option to built a representative Stiff diagram (Stiff (1951)) for each
cluster, providing information about the hydrogeological units. Finally,
a compositional PCA could be performed, obtaining the loads for each
component and building the compositional covariance biplot. This kind of
plots are useful as exploratory and expository tool, nevertheless, the
fundamental elements of a compositional biplot are the links (the join
of two or more rays), not the rays as in the case of variation
(Aitchison (2003)). There are some properties for the interpretation of
the compositional variability for the analysis (Blake et al. (2016)):

1)  If two vertices are coincident or situated close to each other, they
    are proportional;
2)  The length of a link between two vertices is proportional to the log
    ratio of those two variables;
3)  If three or more vertices lie on the same link, they may represent a
    sub-composition with one single degree of freedom;
4)  If two links between four separate clr-variables are orthogonal,
    then the corresponding pairs of variables may vary independently of
    each other (this also applies for two orthogonal links describing
    sub-compositions).

## Disclaimer

HydroCODA is a public R library that is made freely available by the
voluntary work of the researchers/authors at the Universidad Nacional de
Colombia (UNAL), hereafter call as creators, so as to promote the study
of hydrogeological units by using statistics and hydrogeochemistry
tools.

The representations of the physical world within the software are widely
known. The codification and use of them are offered through this R
library as a public service and are no cause of action against the
creators. The user of this software/information is responsible for
verifying the suitability, accuracy, completeness and quality for the
particular use of it and hence the user asumes all liability and waives
any claims or actions against the creators. Creators do not make any
claim, guarantee or warranty the, expressed or implied, suitability,
accuracy, completeness and quality for the particular use of the
library. The creators disclaim any and all liability for any claims or
damages that may result from the application of the information/software
contained in the library. The information/software is provided as a
guide.

Regarding other information contained in the library. The links or
information that are accessed through external sites, which are not
maintained by the creators, do not make the creators responsible for
that content or the any claims or damages that may result from the use
of these external sites. Information within this library is considered
to be accurate with the considerations of uncertainties associated with
hydrological modelling.

## References

<div id="refs" class="references">

<div id="ref-Aitchison1982">

Aitchison, J. 1982. “The Statistical Analysis of Compositional Data.”
*Journal of the Royal Statistical Society. Series B (Methodological)* 44
(2): 139–77.

</div>

<div id="ref-Aitchison2003">

Aitchison, John. 2003. “A Concise Guide to Compositional Data Analysis.”
Laboratório de Estatística e Geoinformação.
[http://www.leg.ufpr.br/lib/exe/fetch.php/pessoais:abtmartins:a{\\\_}concise{\\\_}guide{\\\_}to{\\\_}compositional{\\\_}data{\\\_}analysis.pdf](http://www.leg.ufpr.br/lib/exe/fetch.php/pessoais:abtmartins:a%7B\\_%7Dconcise%7B\\_%7Dguide%7B\\_%7Dto%7B\\_%7Dcompositional%7B\\_%7Ddata%7B\\_%7Danalysis.pdf).

</div>

<div id="ref-Blake2016">

Blake, Sarah, Tiernan Henry, John Murray, Rory Flood, Mark R. Muller,
Alan G. Jones, and Volker Rath. 2016. “Compositional multivariate
statistical analysis of thermal groundwater provenance: A
hydrogeochemical case study from Ireland.” *Applied Geochemistry* 75:
171–88. <https://doi.org/10.1016/j.apgeochem.2016.05.008>.

</div>

<div id="ref-Buccianti2015">

Buccianti, A., A. Lima, S. Albanese, C. Cannatelli, R. Esposito, and B.
De Vivo. 2015. “Exploring topsoil geochemistry from the CoDA
(Compositional Data Analysis) perspective: The multi-element data
archive of the Campania Region (Southern Italy).” *Journal of
Geochemical Exploration* 159: 302–16.
<https://doi.org/10.1016/j.gexplo.2015.10.006>.

</div>

<div id="ref-Cloutier2008">

Cloutier, Vincent, René Lefebvre, René Therrien, and Martine M. Savard.
2008. “Multivariate statistical analysis of geochemical data as
indicative of the hydrogeochemical evolution of groundwater in a
sedimentary rock aquifer system.” *Journal of Hydrology* 353 (3-4):
294–313. <https://doi.org/10.1016/j.jhydrol.2008.02.015>.

</div>

<div id="ref-Pina2018">

Piña, Adriana, Leonardo David Donado, Sarah Blake, and Thomas Cramer.
2018. “Compositional multivariate statistical analysis of
hydrogeochemical processes in a fractured massif: La Línea Tunnel
project, Colombia.” *Applied Geochemistry* 95C: 1–18.
<https://doi.org/10.1016/j.apgeochem.2018.05.012>.

</div>

<div id="ref-Stiff1951">

Stiff, Henry A. 1951. “The Interpretation of Chemical Water Analysis by
Means of Patterns.” *Journal of Petroleum Technology* 3 (10): 15–13.
<https://doi.org/10.2118/951376-G>.

</div>

<div id="ref-VanDenBoogaart2015">

Van Den Boogaart, Gerald, and Raimon Tolosana. 2015. *Package
’compositions’ Title Compositional Data Analysis*.
<http://www.stat.boogaart.de/compositions>.

</div>

</div>
