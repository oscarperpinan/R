library("raster")
library("rasterVis")
library("sp")
library("latticeExtra")

proj <- CRS("+proj=longlat +ellps=WGS84")
##setwd('~/Docencia/eoi/R')

##################################################################
## CM-SAF
##################################################################

unzip("data/SISmm2008_CMSAF.zip", exdir="data/CMSAF")
old <- setwd("data/CMSAF")
listFich <- dir(pattern="2008")
stackSIS <- stack(listFich)
stackSIS <- stackSIS*24 ##irradiancia (W/m2) a irradiacion Wh/m2
setwd(old)

idx <- seq(as.Date("2008-01-15"), as.Date("2008-12-15"), "month")

SISmm <- setZ(stackSIS, idx)
projection(SISmm) <- proj
names(SISmm) <- month.abb

levelplot(SISmm)

##################################################################
## SIAR
##################################################################

## http://solar.r-forge.r-project.org/data/SIAR.csv
SIAR <- read.csv("data/SIAR.csv")
spSIAR <- SpatialPointsDataFrame(SIAR[, c(6, 7)], SIAR[, -c(6, 7)],
                                 proj4str=proj)


levelplot(SISmm, layers='Jun') + layer(sp.points(spSIAR, pch=19, col='black', cex=0.6))

CMSAF.SIAR <- extract(SISmm, spSIAR)
CMSAF.SIAR <- zoo(t(CMSAF.SIAR), as.yearmon(idx))
names(CMSAF.SIAR) <- spSIAR$Estacion

summary(CMSAF.SIAR)

madridSIAR <- subset(SIAR, Provincia == "Madrid")
spMadrid <- SpatialPoints(madridSIAR[, c('lon', 'lat')], proj4str=proj)
CMSAFMadrid <- extract(SISmm, spMadrid)
CMSAFMadrid <- zoo(t(CMSAFMadrid), as.yearmon(idx))
names(CMSAFMadrid) <- madridSIAR$Estacion
xyplot(CMSAFMadrid, superpose=TRUE, auto.key=list(space='right'))
