getwd()
## setwd(~/eoi/R)

#######
## SIAR
#######
## eportal.magrama.gob.es/websiar
aranjuez <- read.csv('data/aranjuez.csv')
head(aranjuez)

xyplot(Radiation ~ TempAvg, data=aranjuez)

xyplot(Radiation ~ TempAvg, data=aranjuez,
       type=c('p', 'r'))

xyplot(Radiation ~ TempAvg + TempMax + TempMin,
       data = aranjuez,
       type=c('p', 'r'), auto.key=TRUE, alpha=0.7)

####################
## Series temporales
####################
library(zoo)

seq(as.Date('2004-01-01'), by='day', length=10)
seq(as.Date('2004-01-01'), by='month', length=10)
seq(as.POSIXct('2004-01-01'), by='month', length=10)
seq(as.POSIXct('2004-01-01 10:00:00'), by='15 min', length=10)

fecha <- as.POSIXct(aranjuez[,1], format='%Y-%m-%d')
head(fecha)

aranjuez <- zoo(aranjuez[, -1], fecha)
class(aranjuez)
head(aranjuez)

# Conversión de unidades MJ -> Wh
aranjuez$G0 <- aranjuez$Radiation/3.6*1000
xyplot(aranjuez)
xyplot(aranjuez$G0)

############
## Aggregate
############

Year <- function(x)as.numeric(format(x, "%Y"))
Year(head(fecha))
Year(tail(fecha))

aranjuezY <- aggregate(aranjuez, by=Year, FUN=mean, na.rm=TRUE)
aranjuezY
class(aranjuezY)
G0y <- aggregate(aranjuez$G0, by=Year, FUN=mean, na.rm=TRUE)
G0y

Month <- function(x)as.numeric(format(x, "%m"))
Month(head(fecha))
Month(tail(fecha))
G0m <- aggregate(aranjuez$G0, by=months, FUN=mean, na.rm=TRUE)

as.yearmon(head(fecha))
as.yearmon(tail(fecha))
G0ym <- aggregate(aranjuez$G0, by=as.yearmon, FUN=mean, na.rm=TRUE)

##################################################################
## Datos desde una URL
##################################################################

########
## AEMET
## http://www.tiempodiario.com/rayos/20101205/radiacion_datas.csv
#######

URL1 <- "http://www.tiempodiario.com/rayos"
URL2 <- "radiacion_datas.csv"

Y <- 2010
m <- 12
d <- 5
ymd <- as.POSIXct(paste(Y, m, d, sep='-'))

URL <- paste(URL1, format(ymd, '%Y%m%d'), URL2, sep='/')
## URL <- 'data/radiacion_datas.csv'

aemetRad <- read.table(URL,
                 header=FALSE, fill=TRUE, skip=1,
                 sep=';')
nc <- ncol(aemetRad)
nms <- aemetRad[1, 2:nc]

aemetRad <- aemetRad[-1,]
Gcols <- 4:19
Dcols <- 22:37
Bcols <- 40:55


##estaciones <- aemetRad[,1] ## ¿Encoding?
estID <- aemetRad[,2]
tt <- seq(ymd + 5*3600, by='hour', length=16)
G0 <- zoo(t(aemetRad[,Gcols]), tt) * 3.6 ## kiloJulios -> Wh
D0 <- zoo(t(aemetRad[,Dcols]), tt) * 3.6
B <- zoo(t(aemetRad[,Bcols]), tt) * 3.6
names(G0) <- names(D0) <- names(B) <- estID

xyplot(G0, superpose=TRUE, auto.key=FALSE)

G0d <- colSums(G0, na.rm=TRUE)

########################################
## Una estación completa
## http://procomun.wordpress.com/2012/10/31/aemet-web-scraping-con-r/
########################################
arenosillo <- read.csv2('data/El.Arenosillo.txt')
tt <- as.POSIXct(arenosillo$Index)
arenosillo <- zoo(arenosillo[, -1], tt) * 3.6
names(arenosillo) <- c('D0', 'B', 'G0')
xyplot(arenosillo, superpose=TRUE)

truncDay <- function(x){as.POSIXct(trunc(x, units='days'))}
radD <- aggregate(arenosillo, by=truncDay, sum, na.rm=TRUE)/1000 ## kWh
xyplot(radD, superpose=TRUE)

####################
## NREL-MIDC y solaR
####################


library(solaR)

URL <- "http://www.nrel.gov/midc/apps/plot.pl?site=LANAI&start=20090722&edy=19&emo=11&eyr=2010&zenloc=19&year=2010&month=11&day=1&endyear=2010&endmonth=11&endday=19&time=1&inst=3&inst=4&inst=5&inst=10&type=data&first=3&math=0&second=-1&value=0.0&global=-1&direct=-1&diffuse=-1&user=0&axis=1"
## URL <- "data/NREL-Hawaii.csv"

lat <- 20.77
lon <- -156.9339
dat <- read.zoo(URL,
                col.names = c("date", "hour", "G0", "B", "D0", "Ta"),
                index = list(1, 2),
                FUN = function(d, h) as.POSIXct(paste(d, h), format = "%m/%d/%Y %H:%M", tz = "HST"),
                FUN2 = function(x) local2Solar(x, lon),
                header=TRUE, sep=",")

dat$B0 <- dat$G0-dat$D0

NRELMeteo <- zoo2Meteo(dat, lat=lat, source="NREL-La Ola-Lanai")

## Figure 9
xyplot(NRELMeteo)

g0NREL <- calcG0(lat=lat, modeRad="bdI", dataRad=NRELMeteo, corr="none")

xyplot(fd~kt, data=g0NREL, pch=19, cex=0.5, alpha=0.5)

xyplot(g0NREL)
xyplot(as.zooI(g0NREL), superpose=TRUE)
xyplot(D0 ~ G0, data=g0NREL)

g0BRL <- calcG0(lat=lat, modeRad='bdI', dataRad=NRELMeteo, corr='BRL')
xyplot(g0BRL)
xyplot(as.zooI(g0BRL), superpose=TRUE)
xyplot(D0 ~ G0, data=g0BRL)
xyplot(fd~kt, data=g0BRL, pch=19, cex=0.5, alpha=0.5)

g0Climed <- calcG0(lat=lat, modeRad='bdI', dataRad=NRELMeteo, corr='CLIMEDh')
xyplot(g0Climed)
xyplot(as.zooI(g0Climed), superpose=TRUE)
xyplot(D0 ~ G0, data=g0Climed)
xyplot(fd~kt, data=g0Climed, pch=19, cex=0.5, alpha=0.5)
