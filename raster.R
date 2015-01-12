
## Primeros pasos en R
## - Configuramos el directorio de trabajo

  ## Entre las comillas hay que indicar el directorio en el que está el
  ## repositorio (será visible la carpeta data/)
  setwd('~/github/intro/')

## - Cargo los paquetes que usaremos

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

## Leo los ficheros CMSAF

old <- setwd('data')
unzip("SISmm2008_CMSAF.zip")
listFich <- dir(pattern="\\.nc")
stackSIS <- stack(listFich)
## irradiancia (W/m2) a irradiacion Wh/m2
stackSIS <- stackSIS*24
setwd(old)

## Añado información temporal

  idx <- seq(as.Date("2008-01-15"),
             as.Date("2008-12-15"),
             "month")
  
  SISmm <- setZ(stackSIS, idx)

## Fijo la proyección de trabajo y nombres de capas

  proj <- CRS("+proj=longlat +ellps=WGS84")
  projection(SISmm) <- proj
  names(SISmm) <- month.abb

## Veamos la información  
## - Mapa clásico

  levelplot(SISmm)

## - Densidad de probabilidad por capa (mes)

  densityplot(SISmm)

## Más sobre visualización
## - Gráfico Hovmoller (tiempo-latitud)

  hovmoller(SISmm, dirXY=y,
            panel=panel.2dsmoother, n=1000)

## - Gráfico Hovmoller (tiempo-longitud)

  hovmoller(SISmm, dirXY=x,
            panel=panel.2dsmoother, n=1000)

## Calculamos el valor anual por celda
## - No del todo correcto (cada mes tiene un número diferente de días)

SISy <- mean(SISmm) * 365/1000

## - Mejorado

  SISy <-  sum(SISmm *
               c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31))/1000
  names(SISy) <- 'G0'

## Veamos la radiación anual
## - Relación con la longitud y la latitud

  xyplot(G0 ~ y, data=SISy)
  xyplot(G0 ~ x, data=SISy)

## - Distribución de valores

  histogram(SISy)

## Extraemos información de un punto

  myPoint <- cbind(-3.6, 40.1)
  extract(SISmm, myPoint)

## Extraemos información de varios puntos

  myLocs <- cbind(-8, 38:43)
  SISlocs <- extract(SISmm, myLocs)

## - Superponemos mapa global con la localización de los puntos

  levelplot(SISy) +
    layer(sp.points(myLocs,
                    pch=16, col='black')) 

## Extraemos información de una rejilla

  extent(SISmm)
  myGrid <- expand.grid(long=-10:4, lat=36:44)
  SISgrid <- extract(SISmm, myGrid)

## - Nuevamente superponemos mapa y rejilla

  levelplot(SISy) +
    layer(sp.points(myGrid,
                    pch=16, col='black')) 

## Estaciones MAGRAMA-SIAR
## - Localización de las [[https://raw.github.com/oscarperpinan/intro/master/data/SIAR.csv][estaciones SIAR]]

  SIAR <- read.csv("data/SIAR.csv")

## - Construimos un objeto espacial con la información y las coordenadas

  spSIAR <- SpatialPointsDataFrame(SIAR[, c(6, 7)],
                                   SIAR[, -c(6, 7)],
                                   proj4str=proj)
  head(spSIAR)

## - Mostramos el mapa de radiación anual con las estaciones SIAR

  levelplot(SISy, layers='Jun') +
    layer(sp.points(spSIAR,
                    pch=19, col='black', cex=0.6))

## Extraemos información de CMSAF

  CMSAF.SIAR <- extract(SISmm, spSIAR)
  CMSAF.SIAR <- zoo(t(CMSAF.SIAR), as.yearmon(idx))
  names(CMSAF.SIAR) <- spSIAR$Estacion
  summary(CMSAF.SIAR)

## Particularizamos para una estación
## - Primero extraemos información para la estación de Madrid

  madridSIAR <- subset(SIAR, Provincia == "Madrid")
  spMadrid <- SpatialPoints(
                madridSIAR[, c('lon', 'lat')],
                proj4str=proj)
  CMSAFMadrid <- extract(SISmm, spMadrid)
  CMSAFMadrid <- zoo(t(CMSAFMadrid), as.yearmon(idx))
  names(CMSAFMadrid) <- madridSIAR$Estacion

## - Mostramos la serie temporal correspondiente

  xyplot(CMSAFMadrid,
         superpose=TRUE,
         auto.key=list(space='right'))
