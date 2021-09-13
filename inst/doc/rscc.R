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
prgs  <- sourcecode(files, basename=TRUE, minlines=3)
names(prgs)

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
simy  <- similarities(prgs)
head(simy)

## -----------------------------------------------------------------------------
cat(as.character(prgs[[1]]))                       # source code
all.vars(prgs[[1]])                                # type="v", default
all.names(prgs[[1]])                               # type="n"
setdiff(all.names(prgs[[1]]), all.vars(prgs[[1]])) # type="f"

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
simy  <- similarities(prgs, minlen=4)
head(simy)

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE, minlines=1)
simy  <- similarities(prgs)
attr(simy, "similarity")[1:3,1:3]
simy  <- similarities(prgs, same.file=FALSE)
attr(simy, "similarity")[1:3,1:3]

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
simy  <- similarities(prgs, coeff="m")
head(simy)

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
simy  <- similarities(prgs)
head(simy)

## ---- fig.height=3------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
simy  <- similarities(prgs, type="n", minlen=3)
stripchart(simy$jaccard, "jitter", pch=19, xlab="Jaccard")

## -----------------------------------------------------------------------------
library("igraph")
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
simy  <- similarities(prgs, type="n", minlen=3)
graph <- as_igraph(simy, diag=FALSE)
# color all edges wit a large similarity coefficient in red
E(graph)$color <- ifelse(E(graph)$weight>0.4, "red", "grey")
plot(graph, edge.width=1+3*E(graph)$weight)
box()

## -----------------------------------------------------------------------------
files <- list.files(system.file("examples", package="rscc"), "*.R$", full.names = TRUE)
prgs  <- sourcecode(files, basename=TRUE, silent=TRUE)
simy  <- similarities(prgs, type="n", minlen=3)
if (interactive()) browse(prgs, simy, sum(simy$jaccard>0.4))

