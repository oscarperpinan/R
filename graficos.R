library(lattice)

xyplot(wt ~ mpg | am, data = mtcars, groups = cyl)

library(ggplot2)

ggplot(mtcars, aes(mpg, wt)) +
    geom_point(aes(colour=factor(cyl))) +
    facet_grid(. ~ am)

  aranjuez <- read.csv('data/aranjuez.csv')

  summary(aranjuez)

aranjuez$date <- as.Date(aranjuez$X)

aranjuez$month <- as.numeric(
    format(aranjuez$date, '%m'))

aranjuez$year <- as.numeric(
    format(aranjuez$date, '%Y'))

aranjuez$day <- as.numeric(
    format(aranjuez$date, '%j'))

aranjuez$quarter <- quarters(aranjuez$date)

xyplot(Radiation ~ TempAvg, data=aranjuez)

ggplot(aranjuez, aes(TempAvg, Radiation)) + 
    geom_point()

xyplot(Radiation ~ TempAvg, data=aranjuez,
       grid = TRUE)

xyplot(Radiation ~ TempAvg, data=aranjuez,
       type=c('p', 'r'), grid = TRUE,
       lwd=2, col.line='black')

ggplot(aranjuez, aes(TempAvg, Radiation)) + 
    geom_point() +
    geom_smooth(method = "lm")

xyplot(Radiation ~ TempAvg, data=aranjuez,
       type=c('p', 'smooth'), grid = TRUE,
       lwd=2, col.line='black')

ggplot(aranjuez, aes(TempAvg, Radiation)) + 
    geom_point() +
    geom_smooth()

xyplot(Radiation ~ TempAvg|factor(year),
       data=aranjuez)

ggplot(aranjuez, aes(TempAvg, Radiation)) + 
    geom_point() +
    facet_wrap(~factor(year))

xyplot(Radiation ~ TempAvg, groups=quarter,
       data=aranjuez, auto.key=list(space='right'))

ggplot(aranjuez, aes(TempAvg, Radiation,
                     color = quarter)) + 
    geom_point()

xyplot(Radiation ~ TempAvg|factor(year),
       groups=quarter,
       data=aranjuez,
       layout=c(4, 2),
       auto.key=list(space='right'))

ggplot(aranjuez, aes(TempAvg, Radiation,
                     color = quarter)) + 
    geom_point() +
    facet_wrap(~factor(year))

xyplot(Radiation ~ TempAvg|factor(year),
       groups=quarter,
       data=aranjuez,
       layout=c(4, 2),
       type=c('p', 'r'),
       auto.key=list(space='right'))

xyplot(Radiation ~ TempAvg,
       type=c('p', 'r'),
       cex=2, col='blue',
       alpha=.5, pch=19,
       lwd=3, col.line='black',
       data=aranjuez)

xyplot(Radiation ~ TempAvg,
       group=quarter,
       col=c('red', 'blue', 'green', 'yellow'),
       pch=19,
       auto.key=list(space='right'),
       data=aranjuez)

myTheme <- simpleTheme(col=c('red', 'blue',
                             'green', 'yellow'),
                       pch=19, alpha=.6)

xyplot(Radiation ~ TempAvg,
       groups=quarter,
       par.settings=myTheme,
       auto.key=list(space='right'),
       data=aranjuez)

library(RColorBrewer)

myPal <- brewer.pal(n = 4, 'Dark2')

myTheme <- simpleTheme(col = myPal,
                       pch=19, alpha=.6)

xyplot(Radiation ~ TempAvg,
       groups=quarter,
       par.settings=myTheme,
       auto.key=list(space='right'),
       data=aranjuez)

splom(aranjuez[,c("TempAvg", "HumidAvg", "WindAvg",
                  "Rain", "Radiation", "ET")],
      pscale=0, alpha=0.6, cex=0.3, pch=19)

library(GGally)
ggpairs(aranjuez)

splom(aranjuez[,c("TempAvg", "HumidAvg", "WindAvg",
                  "Rain", "Radiation", "ET")],
      groups=aranjuez$quarter,
      auto.key=list(space='right'),
      pscale=0, alpha=0.6, cex=0.3, pch=19)

levelplot(TempAvg ~ year * day, data = aranjuez)

ggplot(aranjuez, aes(year, day)) + 
    geom_raster(aes(fill = TempAvg))

levelPal <- colorRampPalette(
    brewer.pal(n = 9, 'Oranges'))

levelPal(14)

  levelplot(TempAvg ~ year * day,
            col.regions = levelPal,
            data = aranjuez)

contourplot(TempAvg ~ year * day,
            data = aranjuez,
            lwd = .5,
            labels = list(cex = 0.6),
            label.style = 'align',
            cuts = 5)

bwplot(Radiation ~ month, data=aranjuez,
       horizontal = FALSE, pch='|')

ggplot(aranjuez, aes(factor(month), Radiation)) + 
    geom_boxplot()

bwplot(Radiation ~ month, data=aranjuez,
       horizontal=FALSE,
       panel=panel.violin)

ggplot(aranjuez, aes(factor(month), Radiation)) + 
    geom_violin()

histogram(~ Radiation|factor(year), data=aranjuez)

ggplot(aranjuez, aes(Radiation)) + 
    geom_histogram() +
    facet_wrap(~factor(year))

densityplot(~ Radiation, groups=quarter,
            data=aranjuez,
            auto.key=list(space='right'))

ggplot(aranjuez, aes(Radiation, color = quarter)) + 
    geom_density()

  firstHalf <- aranjuez$quarter %in% c('Q1', 'Q2')
  
  qq(firstHalf ~ Radiation, data=aranjuez)

  winter <- aranjuez$quarter %in% c('Q1', 'Q4')
  
  qq(winter ~ Radiation, data=aranjuez)

  qqmath(~TempAvg, data=aranjuez,
         groups=year, distribution=qnorm)
