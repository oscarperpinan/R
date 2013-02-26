
## Conjunto de datos de ejemplo
## - Leemos desde el archivo local

aranjuez <- read.csv('data/aranjuez.csv')

summary(aranjuez)

## Conjunto de datos de ejemplo
## - Añadimos algunas columnas

aranjuez$month <- as.numeric(format(as.Date(aranjuez$X), '%m'))
aranjuez$year <- as.numeric(format(as.Date(aranjuez$X), '%Y'))
aranjuez$day <- as.numeric(format(as.Date(aranjuez$X), '%j'))
aranjuez$jday <- julian(as.Date(aranjuez$X))
aranjuez$quarter <- quarters(as.Date(aranjuez$X))

## Lattice

## - Documentación: [[http://lmdvr.r-forge.r-project.org/figures/figures.html][Código y Figuras del libro]]

library(lattice)

## =xyplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplot.pdf")
xyplot(Radiation ~ TempAvg,
       data=aranjuez)
dev.off()

## =xyplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotPG.pdf")
xyplot(Radiation ~ TempAvg,
       data=aranjuez, type=c('p', 'g'))
dev.off()

## =xyplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotPRG.pdf")
xyplot(Radiation ~ TempAvg,
       data=aranjuez, type=c('p', 'r', 'g'))
dev.off()

## =xyplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotSmooth.pdf")
xyplot(Radiation ~ TempAvg,
       data=aranjuez, type=c('p', 'smooth', 'g'))
dev.off()

## Paneles
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotYear.pdf")
xyplot(Radiation ~ TempAvg|year, data=aranjuez)
dev.off()

## Grupos
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="xyplotQuarter.pdf")
xyplot(Radiation ~ TempAvg, groups=quarter,
       data=aranjuez, auto.key=list(space='right'))
dev.off()

## Paneles y grupos
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="xyplotQuarterYear.pdf")
xyplot(Radiation ~ TempAvg|year,
       groups=quarter,
       data=aranjuez,
       layout=c(4, 2),
       auto.key=list(space='right'))
dev.off()

## Paneles y grupos
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="xyplotQuarterYearSmooth.pdf")
xyplot(Radiation ~ TempAvg|year,
       groups=quarter,
       data=aranjuez,
       layout=c(4, 2),
       type=c('p', 'r'),
       auto.key=list(space='right'))
dev.off()

## Colores y tamaños
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="xyplotColors.pdf")
xyplot(Radiation ~ TempAvg,
       type=c('p', 'r'),
       cex=2, col='blue',
       alpha=.5,
       lwd=3, col.line='black',
       data=aranjuez)
dev.off()

## Colores con grupos
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="xyplotColorGroups.pdf")
xyplot(Radiation ~ TempAvg,
       group=quarter,
       col=c('red', 'blue', 'green', 'yellow'),
       auto.key=list(space='right'),
       data=aranjuez)
dev.off()

## Colores con grupos: par.settings
## #+ATTR_LaTeX: width=0.45\textwidth

pdf(file="myTheme.pdf")
myTheme <- custom.theme(symbol=c('red', 'blue',
                        'green', 'yellow'),
                        pch=19, alpha=.6)
xyplot(Radiation ~ TempAvg,
       groups=quarter,
       par.settings=myTheme,
       auto.key=list(space='right'),
       data=aranjuez)
dev.off()

## Colores: brewer.pal
## #+ATTR_LaTeX: width=0.45\textwidth

pdf(file="brewer.pdf")
library(RColorBrewer)
myTheme <- custom.theme(symbol=brewer.pal(n=4,
                        'Dark2'),
                        pch=19, alpha=.6)
xyplot(Radiation ~ TempAvg,
       groups=quarter,
       par.settings=myTheme,
       auto.key=list(space='right'),
       data=aranjuez)
dev.off()

## =levelplot=
## #+ATTR_LaTeX: width=0.6\textwidth

pdf(file="levelplot.pdf")
levelplot(TempAvg ~ year * day,
          data=aranjuez)
dev.off()

## =contourplot=
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="contourplot.pdf")
contourplot(Radiation ~ year * day,
            lwd=.5, labels=FALSE,
            region=TRUE, 
            data=aranjuez)
dev.off()

## Box-and-Whiskers
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="bwplot.pdf")
bwplot(Radiation ~ month, data=aranjuez,
       horizontal=FALSE, pch='|')
dev.off()

## Box-and-Whiskers
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="violin.pdf")
bwplot(Radiation ~ month, data=aranjuez,
       horizontal=FALSE,
       panel=panel.violin)
dev.off()

## Histogramas
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="histogram.pdf")
histogram(~Radiation|year, data=aranjuez,
          strip=strip.custom(strip.levels=TRUE))
dev.off()

## Gráficos de densidad
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="density.pdf")
densityplot(~Radiation, groups=quarter,
            data=aranjuez,
            auto.key=list(space='right'))
dev.off()

## =dotplot=

avRad <- aggregate(Radiation ~ month * year,
                   data=aranjuez, FUN=mean)

## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="dotplot.pdf")
dotplot(month ~ Radiation|year, data=avRad)
dev.off()

## Quantile-Quantile
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="qqHalf.pdf")
firstHalf <- aranjuez$quarter %in% c('Q1', 'Q2')

qq(firstHalf ~ Radiation, data=aranjuez)
dev.off()

## Quantile-quantile
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="qqWinter.pdf")
winter <- aranjuez$quarter %in% c('Q1', 'Q4')

qq(winter ~ Radiation, data=aranjuez)
dev.off()

## Quantile-Quantile
## #+ATTR_LaTeX: width=0.7\textwidth

pdf(file="qqNorm.pdf")
qqmath(~TempAvg, data=aranjuez,
       groups=year, distribution=qnorm)
dev.off()
