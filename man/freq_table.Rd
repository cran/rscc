% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/freq_table.R
\name{freq_table}
\alias{freq_table}
\title{freq_table}
\usage{
freq_table(docs, ...)
}
\arguments{
\item{docs}{documents object}

\item{...}{unused}
}
\value{
a matrix with similarities
}
\description{
Computes a frequency table of words and documents.
}
\examples{
# example files are taken from https://CRAN.R-project.org/package=SimilaR
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names=TRUE)
prgs  <- sourcecode(files, basename=TRUE)
docs  <- documents(prgs)
freq_table (docs)
}
