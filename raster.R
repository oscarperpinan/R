## Entre las comillas hay que indicar el directorio en el que está el
## repositorio (será visible la carpeta data/)
setwd('~/R/intro/')

## Si no están instalados hay que usar install.packages('Nombre_del_Paquete')
## Clases y métodos para datos espaciales
library("sp")
library("ncdf")
library("raster")
## Series temporales
library("zoo")
## Gráficos
library("lattice")
library("latticeExtra")
library("rasterVis")

unzip("SISmm2008_CMSAF.zip")
listFich <- dir(pattern=".nc")
stackSIS <- stack(listFich)
## irradiancia (W/m2) a irradiacion Wh/m2
stackSIS <- stackSIS*24

idx <- seq(as.Date("2008-01-15"),
           as.Date("2008-12-15"),
           "month")

SISmm <- setZ(stackSIS, idx)

proj <- CRS("+proj=longlat +ellps=WGS84")
projection(SISmm) <- proj
names(SISmm) <- month.abb

levelplot(SISmm)

densityplot(SISmm)

hovmoller(SISmm, dirXY=y,
          panel=panel.2dsmoother, n=1000)

hovmoller(SISmm, dirXY=x,
          panel=panel.2dsmoother, n=1000)

SISy <- mean(SISmm) * 365/1000

SISy <-  sum(SISmm *
             c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31))/1000
names(SISy) <- 'G0'

xyplot(G0 ~ y, data=SISy)
xyplot(G0 ~ x, data=SISy)

histogram(SISy)

myPoint <- cbind(-3.6, 40.1)
extract(SISmm, myPoint)

myLocs <- cbind(-8, 38:43)
SISlocs <- extract(SISmm, myLocs)

levelplot(SISy) +
  layer(sp.points(myLocs,
                  pch=16, col='black'))

extent(SISmm)
myGrid <- expand.grid(long=-10:4, lat=36:44)
SISgrid <- extract(SISmm, myGrid)

levelplot(SISy) +
  layer(sp.points(myGrid,
                  pch=16, col='black'))

SIAR <- read.csv("data/SIAR.csv")

spSIAR <- SpatialPointsDataFrame(SIAR[, c(6, 7)],
                                 SIAR[, -c(6, 7)],
                                 proj4str=proj)
head(spSIAR)

levelplot(SISy, layers='Jun') +
  layer(sp.points(spSIAR,
                  pch=19, col='black', cex=0.6))

CMSAF.SIAR <- extract(SISmm, spSIAR)
CMSAF.SIAR <- zoo(t(CMSAF.SIAR), as.yearmon(idx))
names(CMSAF.SIAR) <- spSIAR$Estacion
summary(CMSAF.SIAR)

madridSIAR <- subset(SIAR, Provincia == "Madrid")
spMadrid <- SpatialPoints(
              madridSIAR[, c('lon', 'lat')],
              proj4str=proj)
CMSAFMadrid <- extract(SISmm, spMadrid)
CMSAFMadrid <- zoo(t(CMSAFMadrid), as.yearmon(idx))
names(CMSAFMadrid) <- madridSIAR$Estacion

xyplot(CMSAFMadrid,
       superpose=TRUE,
       auto.key=list(space='right'))
