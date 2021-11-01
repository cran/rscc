## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=FALSE-----------------------------------------------------
library(rscc)

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE)
names(prgs)

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, minlines=3, silent=TRUE)
names(prgs)

## -----------------------------------------------------------------------------
docs <- documents(prgs)
# create term document frequency table
freq_table(docs)[1:8,1:8]

## -----------------------------------------------------------------------------
cat(as.character(prgs[[1]]))                       # source code
all.vars(prgs[[1]])                                # type="v", default
all.names(prgs[[1]])                               # type="n"
setdiff(all.names(prgs[[1]]), all.vars(prgs[[1]])) # type="f"

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
docs  <- documents(prgs)
similarities(docs)[1:8,1:8]

## ---- eval=FALSE--------------------------------------------------------------
#  inset1 <- setfull %in% unique(set1)
#  inset2 <- setfull %in% unique(set2)
#  p      <- length(setfull)
#  n11    <- sum(inset1 & inset2)
#  n10    <- sum(inset1 & !inset2)
#  n01    <- sum(!inset1 & inset2)
#  n00    <- sum(!inset1 & !inset2)

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
docs  <- documents(prgs)
similarities(docs, coeff="m")[1:8,1:8]

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
docs  <- documents(prgs)
tfidf(docs)[1:8,1:8]

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
docs  <- documents(prgs)
simm  <- similarities(docs, coeff="m")
simdf <- matrix2dataframe(simm)
head(simdf, 10)

## ---- fig.height=3------------------------------------------------------------
stripchart(simdf[,3], "jitter", pch=19, xlab=names(simdf)[3])

## -----------------------------------------------------------------------------
library("igraph")
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
docs  <- documents(prgs, type="n", minlen=3)
simm  <- similarities(docs)
graph <- as_igraph(simm, diag=FALSE)
# color all edges wit a large similarity coefficients in red
E(graph)$color <- ifelse(E(graph)$weight>0.4, "red", "grey")
plot(graph, edge.width=1+3*E(graph)$weight)
box()

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE, minlines=1)
docs  <- documents(prgs)
simm  <- similarities(docs)
simm[1:3,1:3]
simm  <- same_file(simm)
simm[1:3,1:3]

## ---- eval=FALSE--------------------------------------------------------------
#  files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
#  prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
#  docs  <- documents(prgs, type="n", minlen=3)
#  simdf <- matrix2dataframe(similarities(docs))
#  if (interactive()) browse(prgs, simdf, simdf[,3]>0.4)

