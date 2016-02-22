## =lattice=

##   - Implementación de los gráficos /trellis/, /The Elements of Graphing Data/ de Cleveland)

##   - Estructura matricial de paneles definida a través de una fórmula.


xyplot(wt ~ mpg | am, data = mtcars, groups = cyl)

## =ggplot2=

##   - Implementación de /The Grammar of Graphics/ de Wilkinson.

##   - Combinación de funciones que proporcionan los componentes (capas) del gráfico.


ggplot(mtcars, aes(mpg, wt)) +
    geom_point(aes(colour=factor(cyl))) +
    facet_grid(. ~ am)

## Leemos desde el archivo local 

  aranjuez <- read.csv('data/aranjuez.csv')

  summary(aranjuez)

## Añadimos algunas columnas

aranjuez$date <- as.Date(aranjuez$X)

  aranjuez$month <- as.numeric(
                    format(aranjuez$date, '%m'))

  aranjuez$year <- as.numeric(
                   format(aranjuez$date, '%Y'))

  aranjuez$day <- as.numeric(
                  format(aranjuez$date, '%j'))

  aranjuez$quarter <- quarters(aranjuez$date)
      

## lattice
## - Documentación: [[http://lmdvr.r-forge.r-project.org/figures/figures.html][Código y Figuras del libro]]


  library(lattice)

## =xyplot=


  xyplot(Radiation ~ TempAvg, data=aranjuez)

## Añadimos rejilla


  xyplot(Radiation ~ TempAvg, data=aranjuez,
         grid = TRUE)

## Añadimos regresión lineal


  xyplot(Radiation ~ TempAvg, data=aranjuez,
         type=c('p', 'r'), grid = TRUE,
         lwd=2, col.line='black')
  

## Añadimos ajuste local


  xyplot(Radiation ~ TempAvg, data=aranjuez,
         type=c('p', 'smooth'), grid = TRUE,
         lwd=2, col.line='black')

## Paneles


  xyplot(Radiation ~ TempAvg|factor(year),
         data=aranjuez)

## Grupos


  xyplot(Radiation ~ TempAvg, groups=quarter,
         data=aranjuez, auto.key=list(space='right'))

## Paneles y grupos


  xyplot(Radiation ~ TempAvg|factor(year),
         groups=quarter,
         data=aranjuez,
         layout=c(4, 2),
         auto.key=list(space='right'))

## Paneles y grupos

  xyplot(Radiation ~ TempAvg|factor(year),
         groups=quarter,
         data=aranjuez,
         layout=c(4, 2),
         type=c('p', 'r'),
         auto.key=list(space='right'))

## Colores y tamaños

  xyplot(Radiation ~ TempAvg,
         type=c('p', 'r'),
         cex=2, col='blue',
         alpha=.5, pch=19,
         lwd=3, col.line='black',
         data=aranjuez)

## Colores con grupos


  xyplot(Radiation ~ TempAvg,
         group=quarter,
         col=c('red', 'blue', 'green', 'yellow'),
         pch=19,
         auto.key=list(space='right'),
         data=aranjuez)

## Colores con grupos: =par.settings= y =simpleTheme=
## - Primero definimos el tema con =simpleTheme=

  myTheme <- simpleTheme(col=c('red', 'blue',
                          'green', 'yellow'),
                          pch=19, alpha=.6)

## Colores con grupos: =par.settings= y =simpleTheme=
## - Aplicamos el resultado en =par.settings=

  xyplot(Radiation ~ TempAvg,
         groups=quarter,
         par.settings=myTheme,
         auto.key=list(space='right'),
         data=aranjuez)

## Colores: brewer.pal


library(RColorBrewer)

myPal <- brewer.pal(n = 4, 'Dark2')

myTheme <- simpleTheme(col = myPal,
                       pch=19, alpha=.6)

## Asignamos paleta con =par.settings=

xyplot(Radiation ~ TempAvg,
       groups=quarter,
       par.settings=myTheme,
       auto.key=list(space='right'),
       data=aranjuez)

## Paneles a medida


  xyplot(Radiation ~ TempAvg, data=aranjuez,
         panel=function(x, y, ...){
             panel.xyplot(x, y, ...)
             minIdx <- which.min(x)
             maxIdx <- which.max(x)
             panel.points(x[c(minIdx, maxIdx)],
                          y[c(minIdx, maxIdx)],
                          cex=2, col='red')
             panel.text(x[minIdx], y[minIdx],
                        'MIN', pos=1)
             })

## Matriz de gráficos de dispersión


  splom(aranjuez[,c("TempAvg", "HumidAvg", "WindAvg",
                    "Rain", "Radiation", "ET")],
        pscale=0, alpha=0.6, cex=0.3, pch=19)

## Matriz de gráficos de dispersión


  splom(aranjuez[,c("TempAvg", "HumidAvg", "WindAvg",
                    "Rain", "Radiation", "ET")],
        groups=aranjuez$quarter,
        auto.key=list(space='right'),
        pscale=0, alpha=0.6, cex=0.3, pch=19)

## =levelplot=


  levelplot(TempAvg ~ year * day, data = aranjuez)

## =levelplot= con una paleta mejor
## - Usamos =colorRampPalette= para generar una función que interpola colores a partir de una paleta

levelPal <- colorRampPalette(
    brewer.pal(n = 9, 'Oranges'))


## - Comprobamos que es una función generadora de colores


levelPal(14)



## #+RESULTS:
## :  [1] "#FFF5EB" "#FEEBD9" "#FDE0C3" "#FDD3A8" "#FDC088" "#FDAB67" "#FD974A"
## :  [8] "#F9812F" "#F16B16" "#E45709" "#D14501" "#B13A02" "#973003" "#7F2704"

## - Usamos esta función con =col.regions=

  levelplot(TempAvg ~ year * day,
            col.regions = levelPal,
            data = aranjuez)

## =contourplot=

  contourplot(TempAvg ~ year * day,
              data = aranjuez,
              lwd = .5,
              labels = list(cex = 0.6),
              label.style = 'align',
              cuts = 5)
              

## Box-and-Whiskers


  bwplot(Radiation ~ month, data=aranjuez,
         horizontal=FALSE, pch='|')

## Box-and-Whiskers


  bwplot(Radiation ~ month, data=aranjuez,
         horizontal=FALSE,
         panel=panel.violin)

## Histogramas


  histogram(~ Radiation|factor(year), data=aranjuez)

## Gráficos de densidad


densityplot(~ Radiation, groups=quarter,
            data=aranjuez,
            auto.key=list(space='right'))

## =dotplot=

  avRad <- aggregate(Radiation ~ month * year,
                     data=aranjuez, FUN=mean)

  dotplot(month ~ Radiation|factor(year), data=avRad)

## Quantile-Quantile


  firstHalf <- aranjuez$quarter %in% c('Q1', 'Q2')
  
  qq(firstHalf ~ Radiation, data=aranjuez)

## Quantile-quantile


  winter <- aranjuez$quarter %in% c('Q1', 'Q4')
  
  qq(winter ~ Radiation, data=aranjuez)

## Quantile-Quantile


  qqmath(~TempAvg, data=aranjuez,
         groups=year, distribution=qnorm)
