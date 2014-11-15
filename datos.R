
## =setwd=, =getwd=, =dir=

  getwd()
  old <- setwd("~/github/intro")
  dir()
  dir(pattern='.R')
  dir('data')

## read.table
## # - Con un fichero local

  CO2 <- read.table('data/CO2_GNI_BM.csv', header=TRUE, sep=',')
  head(CO2)
  

## read.csv, read.csv2
## - =read.csv= y =read.csv2= son como =read.table= con valores
##   por defecto para encabezado y separadores

  CO2 <- read.csv('data/CO2_GNI_BM.csv')

  names(CO2)
  head(CO2)
  tail(CO2)

  summary(CO2)

## tapply

  tapply(CO2$X2000, CO2$Indicator.Name,
         FUN=mean)

## tapply

  tapply(CO2$X2000,
         CO2[,c("Indicator.Name", "Country.Name")],
         FUN=mean)

## aggregate

  aggregate(X2000 ~ Indicator.Name,
            data=CO2, FUN=mean)  

  aggregate(cbind(X2000, X2001) ~ Indicator.Name,
            data=CO2, FUN=mean)
  

  aggregate(X2000 ~ Indicator.Name + Country.Name,
            data=CO2, FUN=mean)

## aggregate

  aggregate(cbind(X2000, X2001) ~
            Indicator.Name + Country.Name,
            data=CO2, FUN=mean)

  aggregate(cbind(X2000, X2001) ~
            Indicator.Name + Country.Name,
            data=CO2, FUN=mean)

  aggregate(cbind(X2000, X2001) ~
            Indicator.Name + Country.Name,
            subset=(Country.Name %in% c('United States', 'China')),
                    data=CO2, FUN=mean)

## =stack=
## - Primero escogemos un subconjunto

  CO2China <- subset(CO2,
                     subset=(Country.Name=='China' &
                             Indicator.Name=='CO2 emissions (kg per PPP $ of GDP)'),
                     select=-c(Country.Name, Country.Code,
                               Indicator.Name, Indicator.Code))
  head(CO2China)

## =stack=
## - Pasamos de formato =wide= a =long=

  stack(CO2China)

## =reshape=: =wide= a =long=
## - Primer intento

  CO2long <- reshape(CO2,
                     varying=list(names(CO2)[5:16]),
                     direction='long')
  head(CO2long)

## =reshape=: =wide= a =long=
## - Añadimos argumentos

  CO2long <- reshape(CO2,
                     varying=list(names(CO2)[5:16]),
                     timevar='Year', v.names='Value',
                     times=2000:2011,
                     direction='long')
  head(CO2long)

## =reshape=: =long= a =wide=
## - Primero escogemos las columnas de interés

  CO2subset <- CO2long[c("Country.Name",
                         "Indicator.Name",
                         "Year", "Value")]
  head(CO2subset)

## =reshape=: =long= a =wide=
## - Ahora cambiamos formato

  CO2wide <- reshape(CO2subset,
                     idvar=c('Country.Name','Year'),
                     timevar='Indicator.Name',
                     direction='wide')
  head(CO2wide)

## =reshape=: =long= a =wide=
## - Y ponemos nombres al gusto

  names(CO2wide)[3:6] <- c('CO2.PPP', 'CO2.capita',
                           'GNI.PPP', 'GNI.capita')
  
  head(CO2wide)

## Alternativa: =reshape2=
## - =reshape2= es un paquete que puede facilitar la transformación de =data.frame= y matrices.

library(reshape2)

## Alternativa: =reshape2=
## - Para cambiar de /wide/ a /long/ usamos =melt=:

CO2long2 <- melt(CO2, id.vars = 1:4,
                 variable.name = 'Year',
                 value.name = 'Value')

head(CO2long2)

## Alternativa: =reshape2=
## - Para cambiar de /long/ a /wide/ usamos =dcast=:

CO2wide2 <- dcast(CO2subset,
                  Country.Name + Year ~ Indicator.Name)
head(CO2wide2)
