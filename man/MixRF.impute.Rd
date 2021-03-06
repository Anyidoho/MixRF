% Please edit documentation in R/MixRF.impute.r
\name{MixRF.impute}
\alias{MixRF.impute}
\title{Impute a large number of genes using the MixRF algorithm with parallel computing}
\usage{
MixRF.impute(Ydat, eqtl.lis, snp.dat, cov = NULL, iPC = TRUE, 
    idx.selected.gene.iPC = NULL, parallel.size = 1, correlation = FALSE, 
    nCV = 3)
}
\arguments{
\item{Ydat}{An array of expression data of dimension sample-by-gene-by-tissue, nxpxT, where n is sample size.
p is the number of genes, and T is the number of tissues.  Ydat[,1,] is a matrix of the first gene expression
in T tissues for n individuals, nxT. Ydat[,,1] is a nxp matrix of the expression data of p genes in the first tissue.}

\item{eqtl.lis}{A list of eQTL names of length p. Each element in the list contains the name of the eQTLs for
the corresponding gene. The order of the list should correspond to the order of genes in Ydat. The code and example to calculate eQTLs can be found at https://github.com/randel/MixRF/blob/master/R/eqtl.r.}

\item{snp.dat}{A matrix of genotype. Each row is a sample and each column corresponds to one SNP. The column names should match eqtl.lis.}

\item{cov}{A matrix of covariates. Each row is a sample and each column corresponds to one covariate. For example, age, gender.}

\item{iPC}{An option. When it is TRUE, the imputed PCs (iPCs) for each tissue type will be constructed
based on the combined observed and imputed data on the selected genes. The iPCs will be adjusted as covariates
in the imputation.}

\item{idx.selected.gene.iPC}{The option is used only when iPC=TRUE. When it is, one may select a subset of genes and impute
those first to construct iPCs.}

\item{parallel.size}{A numerical value specifying the number of CPUs/cores/processors available for parallel computing.}

\item{correlation}{The option to calculate the imputation correlation using cross-validation or not. The default is FALSE.}

\item{nCV}{The option is used only when correlation=TRUE. The number of folds for cross-validation. The default is 3 folds.}
}
\value{
An nxpxT array of imputed and observed expression data. The observed values in Ydat are still kept and the missing values in Ydat are imputed.
When the user chooses to calculate the imputation correlation using cross-validation (correlation=TRUE), the estimated imputation correlation (cor)
will also be returned in a list together with the imputed data (Yimp).
}
\description{
This function impute the expression of a large number of genes using the MixRF algorithm with parallel computing.
}
\examples{
\dontrun{
data(sim)

idx.selected.gene.iPC = which(sapply(sim$eqtl.lis, length) >= 1)

Yimp = MixRF.impute(sim$Ydat, sim$eqtl.lis, sim$snp.dat, sim$cov, iPC = TRUE, 
    idx.selected.gene.iPC, parallel.size = 4)
}

}
