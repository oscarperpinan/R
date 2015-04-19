
## =setwd=, =getwd=, =dir=

  getwd()
  old <- setwd("~/github/r-intro-eoi")
  dir()

  dir(pattern='.R')

  dir('data')

## Lectura de datos con =read.table=

  
  dats <- read.table('data/aranjuez.csv', sep=',', header=TRUE)
  head(dats)

## Lectura de datos con =read.csv=

aranjuez <- read.csv('data/aranjuez.csv')
names(aranjuez)[1] <- 'Date'
head(aranjuez)

  class(aranjuez)

  names(aranjuez)

## Indexado con =[]=
## - Filas

aranjuez[1:5,]

## - Filas y Columnas

aranjuez[10:14, 1:5]

## Indexado con =[]=
## - Condición basada en los datos

idx <- with(aranjuez, Radiation > 20 & TempAvg < 10) 

head(aranjuez[idx, ])

## =subset=

subset(aranjuez,
       subset = (Radiation > 20 & TempAvg < 10),
       select = c(Radiation, TempAvg,
           TempMax, TempMin))

## Forma simple con =stack=

aranjuezWide <- aranjuez[, c('Radiation',
                             'TempAvg', 'TempMax',
                             'WindAvg', 'WindMax')]

## - Pasamos de formato =wide= a =long=

aranjuezLong <- stack(aranjuezWide)

head(aranjuezLong)

summary(aranjuezLong)

## Más flexible con =reshape2=
## - =reshape2= es un paquete que puede facilitar la transformación de =data.frame= y matrices.

library(reshape2)

## =melt= para cambiar de /wide/ a /long/

aranjuezLong2 <- melt(aranjuez, id.vars = 'Date',
                      variable.name = 'Variable',
                      value.name = 'Value')

head(aranjuezLong2)

## =dcast= para cambiar de /long/ a /wide/

aranjuezWide2 <- dcast(aranjuezLong2,
                       Variable ~ Date)
head(aranjuezWide2[, 1:10])

## =aggregate=

aranjuez$rainy <- aranjuez$Rain > 0

aggregate(Radiation ~ rainy, data = aranjuez,
          FUN = mean)

## Variable categórica con =cut=

aranjuez$tempClass <- cut(aranjuez$TempAvg, 5)

aggregate(Radiation ~ tempClass, data = aranjuez,
          FUN = mean)

aggregate(Radiation ~ tempClass + rainy,
          data = aranjuez, FUN = mean)

## Agregamos varias variables

aggregate(cbind(Radiation, TempAvg) ~ tempClass,
          data = aranjuez, FUN = mean)

aggregate(cbind(Radiation, TempAvg) ~ tempClass + rainy,
          data = aranjuez, FUN = mean)

## Agregamos a partir de un formato =long=

head(aranjuezLong2)

aggregate(Value ~ Variable, data = aranjuezLong2,
          FUN = mean)

## Con =merge=
## - Primero construimos un =data.frame= de ejemplo

  USStates <- as.data.frame(state.x77)
  USStates$Name <- rownames(USStates)
  rownames(USStates) <- NULL

## - Lo partimos en estados "fríos" y estados "grandes"

  coldStates <- USStates[USStates$Frost>150,
                         c('Name', 'Frost')]
  largeStates <- USStates[USStates$Area>1e5,
                          c('Name', 'Area')]

## Con =merge=
## - Unimos los dos conjuntos (estados "fríos" y "grandes")

  merge(coldStates, largeStates)

## =merge= usa =match=
## - Estados grandes que también son fríos

  idxLarge <- match(largeStates$Name,
                    coldStates$Name,
                    nomatch=0)
  idxLarge

  coldStates[idxLarge,]

## =merge= usa =match=
## - Estados frios que también son grandes

  idxCold <- match(coldStates$Name,
                   largeStates$Name,
                   nomatch=0)
  idxCold

  largeStates[idxCold,]
