dats <- read.table('data/aranjuez.csv')
head(dats)

dats <- read.table('data/aranjuez.csv', sep=',')
head(dats)

dats <- read.table('data/aranjuez.csv', sep=',', header=TRUE)
head(dats)

aranjuez <- read.csv('data/aranjuez.csv')
head(aranjuez)

class(aranjuez)
names(aranjuez)

library(lattice)

xyplot(Radiation ~ TempAvg, data=aranjuez)

xyplot(Radiation ~ TempAvg, data=aranjuez,
       type=c('p', 'r'))

xyplot(Radiation ~ TempAvg + TempMax + TempMin,
       data = aranjuez, xlab='Temperature',
       type=c('p', 'r'), auto.key=TRUE,
       pch=16, alpha=0.5)

library(RColorBrewer)

humidClass <- cut(aranjuez$HumidAvg, 4)
myPal <- brewer.pal(n=4, 'GnBu')

xyplot(Radiation ~ TempAvg + TempMax + TempMin,
       groups=humidClass, outer=TRUE,
       data = aranjuez, xlab='Temperature',
       layout=c(3, 1),
       scales=list(relation='free'),
       auto.key=list(space='right'),
       par.settings=custom.theme(pch=16,
         alpha=0.8, col=myPal))

library(zoo)

fecha <- as.POSIXct(aranjuez[,1],
                    format='%Y-%m-%d')
head(fecha)

aranjuez <- zoo(aranjuez[, -1], fecha)
class(aranjuez)
head(aranjuez)

aranjuez <- read.zoo('data/aranjuez.csv',
                     sep=',', header=TRUE)

header(aranjuez)
names(aranjuez)
summary(index(aranjuez))

unzip('data/InformeDatos.zip', exdir='data')

aranjuez <- read.table("data/M03_Aranjuez_01_01_2004_31_12_2011.csv",
                     fileEncoding = 'UTF-16LE',
                     header = TRUE, fill = TRUE,
                     sep = ';', dec = ",")

head(aranjuez)
summary(aranjuez)
names(aranjuez)

tt <- as.Date(aranjuez$Fecha, format='%d/%m/%Y')
aranjuez <- zoo(aranjuez[, c(6, 7, 9, 11, 12, 16,
                             17, 19, 20, 22)],
                order.by=tt)

names(aranjuez) <- c('TempAvg', 'TempMax',
                     'TempMin', 'HumidAvg',
                     'HumidMax','WindAvg',
                     'WindMax', 'Radiation',
                     'Rain', 'ET')

xyplot(aranjuez)

xyplot(aranjuez[,c("TempAvg", "TempMax", "TempMin")],
       superpose=TRUE)

xyplot(TempAvg ~ Radiation,
       data=as.data.frame(aranjuez))

aranjuez$G0 <- aranjuez$Radiation/3.6*1000
xyplot(aranjuez$G0)

aranjuezClean <- within(as.data.frame(aranjuez),{
  TempMin[TempMin>40] <- NA
  HumidMax[HumidMax>100] <- NA
  WindAvg[WindAvg>10] <- NA
  WindMax[WindMax>10] <- NA
})

aranjuez <- zoo(aranjuezClean, index(aranjuez))

Year <- function(x)as.numeric(format(x, "%Y"))

Year(index(aranjuez))

aranjuezY <- aggregate(aranjuez$G0, by=Year,
                       FUN=mean, na.rm=TRUE)
aranjuezY
class(aranjuezY)

G0y <- aggregate(aranjuez$G0, by=Year,
                 FUN=mean, na.rm=TRUE)
G0y

aggregate(aranjuez$G0, by=function(tt)cut(tt, 'year'),
          FUN=mean, na.rm=TRUE)

Month <- function(x)as.numeric(format(x, "%m"))

Month(index(aranjuez))

G0m <- aggregate(aranjuez$G0, by=Month,
                 FUN=mean, na.rm=TRUE)
G0m

months(index(aranjuez))

G0m <- aggregate(aranjuez$G0, by=months,
                 FUN=mean, na.rm=TRUE)
G0m

as.yearmon(index(aranjuez))

G0ym <- aggregate(aranjuez$G0, by=as.yearmon,
                  FUN=mean, na.rm=TRUE)
G0ym

URL <- "http://www.nrel.gov/midc/apps/plot.pl?site=LANAI&start=20090722&edy=19&emo=11&eyr=2010&zenloc=19&year=2010&month=11&day=1&endyear=2010&endmonth=11&endday=19&time=1&inst=3&inst=4&inst=5&inst=10&type=data&first=3&math=0&second=-1&value=0.0&global=-1&direct=-1&diffuse=-1&user=0&axis=1"
## URL <- "data/NREL-Hawaii.csv"

lat <- 20.77
lon <- -156.9339
hawaii <- read.zoo(URL,
                col.names = c("date", "hour",
                  "G0", "B", "D0", "Ta"),
                ## Dia en columna 1, Hora en columna 2
                index = list(1, 2),
                ## Obtiene escala temporal de estas dos columnas
                FUN = function(d, h) as.POSIXct(
                  paste(d, h),
                  format = "%m/%d/%Y %H:%M",
                  tz = "HST"), 
                header=TRUE, sep=",")

hawaii$B0 <- with(hawaii, G0-D0)

xyplot(hawaii)
xyplot(hawaii[,c('G0', 'D0', 'B0')],
       superpose=TRUE)

xyplot(Ta ~ G0 + D0 + B0,
       data=as.data.frame(hawaii),
       type=c('p', 'smooth'),
       par.settings=custom.theme(
         alpha=.5, pch=16,
         lwd=3, col.line='black'),
       outer=TRUE, layout=c(3, 1),
       scales=list(x=list(relation='free')))

hour <- function(x)as.numeric(format(x, '%H'))

G0h <- aggregate(hawaii$G0, by=hour,
                 FUN=sum, na.rm=1)/1000
G0h

hour <- function(x)as.POSIXct(format(x,
                                     '%Y-%m-%d %H:00:00'))

G0h <- aggregate(hawaii$G0, by=hour,
                 FUN=sum, na.rm=1)/60
G0h

G0d <- aggregate(G0h,
                 by=function(x)format(x, '%Y-%m-%d'),
                 sum)/1000

day <- function(x)format(x, '%Y-%m-%d')
G0d <- aggregate(hawaii$G0, by=day,
                 sum)/60/1000
G0d

truncDay <- function(x)as.POSIXct(trunc(x, units='day'))
G0d <- aggregate(hawaii$G0, by=truncDay,
                 sum)/60/1000
G0d

halfHour <- function(tt, delta=30){
  tt <- as.POSIXlt(tt)
  gg <- tt$min %/% delta
  tt <- modifyList(tt, list(min=gg*delta))
  as.POSIXct(tt)
}

hawaii30 <- aggregate(hawaii, by=halfHour,
                      FUN=sum)/60

head(hawaii30)
