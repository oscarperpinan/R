x=1
x
x=c(1, 2, 3)
x
length(x)
class(x)
class(c)
class(length)
length
x *2
x1=seq(1, 100, by=2)
x1
args(seq)
help(seq)
seq(1, 100, 10)
seq(1, 100, length=10)
x=seq(1, 1, 
10)
x
x=seq(1, 100, length=10)
x
length(x)
x=seq(1, 100, length=10)
y=seq(2, 100, length=50)
2.3
2,3
x
y
z=c(x, y)
z
z=c(z, z, z, z)
z
z*2
z+10
length(z)
z + c(1, 2)
x=seq(0, 5, 10)
x
x=seq(0, 5, length=10)
x
x + c(1, 2)
x + c(1, 2, 3)
x^2 + y^3
x
x=seq(1, 10, 1)
seq(1, 10, 1)
x=rep(1, 10)
x
rep(c(1, 2,3), 10)
rep(c(1, 2,3), each=10)
x=seq(1, 100, 2)
y=seq(101, 200, 2)
z=c(x, y)
length(z)
z
z>150
z[z>150]
z[z<30 | z>150]
z[50]
z[c(1, 10, 40, 80)]
x
length(x)
condicion=x>30
condicion = (x>30)
condicion
z[condicion]
length(z)
z
x>30
class(x>30)
length(x>30)
z= (x>30)
x[z]
x=1:100
x
cond = (x < 30)
cond
x
x[cond]
z
x
cond = (x>10) & (x<50)
cond
cond = (x>=10) & (x<=50)
cond
x[cond]
sum(cond)
class(sum)
length(x[cond])
sum(x)
sum(x[cond])
sum(x[(x>=10) & (x<=50)])
x[1] + x[2] + x[3] + x[4] + x[5]
x[c(1, 2, 3, 4, 5)]
x
x[c(1, 2, 3, 4, 5)]
x[1:5]
1:5
sum(x[1:5]
)
cond
as.numeric(cond)
as.character
as.character(1)
as.character(1:10)
sum(as.character(1:10))
help(sum)
cond
!cond
sum(!cond)
x
x==10
x[x==10]
x[x!=10]
x[x=10]
z
y
y[x=10]
y[y==10]
x==10
x=10
x
y %in% c(101, 127, 141)
y
y[y %in% c(101, 127, 141)]
z=1:200
M = matrix(z, nrow=20)
M
z
t(M)
class(t)
M * M
M ^2
M %*% M
M %*% t(M)
M %*% t(M)
help('%*%')
help('%*%')
class(M)
dim(M)
sum(M)
summary(M)
z
summary(z)
summary(M)
sum(z)
sum(M)
rowSum(M)
rowSums(M)
colSums(M)
M[1, ]
M[, 1]
sum(M[, 1])
M[1:3, ]
M[1:3, 1:3]
M[1, c(2, 5)]
M[-1,]
M[-c(1, 2, 4),]
P=M[1:3, 1:3]
P
sd(M)
sd(z)
apply(M, 1, sd)
apply(M, 2, sd)
apply(M, 2, sd)
M[1,]
sd(M[1,])
apply(M[1:3,], 2, sd)
M
M[,1]
sd(M[,1])
sd(M[,2])
apply(M, 2, sd)
apply(M, 2, median)
summary(M)
mean(M)
apply(M, 2, mean)
apply(M, 2, median)
apply(M, 2, sd)
foo = function(x, ...){c(mean(x), median(x), sd(x))}
foo = function(x, ...){c(mean(x), median(x), sd(x))}
class(foo(
class(foo)
foo
foo(1:10)
1:10
foo(1:10)
foo(rnorm(100))
rnorm(100)
foo(rnorm(100))
r=rnorm(100)
r
r
r
r
foo(r)
foo(r)
apply(M, 2, foo)
apply(M, 1, foo)
foo(rnorm(100))
x=1:10
y=1:10
z=1:10
M=cbind(x, y, z)
M
M=rbind(x, y, z)
M
f=function(x, y)x^2+y^2
f
f(1, 2)
z=outer(x, y, f)
z
x
y
z
image(x, y, z)
??
?sum
?reset
reset
help(resetClass)
lista=list(a=c(1,3,5), b=c('l', 'p', 'r', 's'), c=3)
class(list)
lista
lista$a
class(lista)
class(lista$a)
class(lista$b)
class(lista$c)
lista$b
length(lista)
length(lista$a)
length(lista$b)
length(lista$c)
lapply(lista, length)
lista=list(x=1:10, y=seq(0, 10, 2), z=1)
lista
lapply(lista, sum)
lapply(lista, median)
lapply(lista, foo)
NA
data.frame
data.frame
lista$a
lista$x
df=data.frame(x=1:10, y=rnorm(10), z=0)
df
df[1,]
df[,1]
df[,2]
df$x
df$y
plot(df$x, df$y)
utils:::menuInstallPkgs()
library(lattice)
xyplot(y ~ x, data=df)
xyplot(y ~ x, data=df, type='l')
xyplot(y ~ x, data=df, type='b')
xyplot(y ~ x, data=df, type=c('b', 'g'))
xyplot(y ~ x, data=df, type=c('b', 'r', 'g'))
x=1:10
y=1:10
df=expand.grid(a=x, b=y)
df=expand.grid(a=1:10, b=1:10)
df
dim(df)
df
df
foo=function(object)object$a^2 + object$b^2
names(df)
foo(df)
head(df)
df
head(df, 10)
df$result=foo(df)
head(df)
levelplot(result ~ a*b, data=df)
data(WorldPhones)
ls()
WorldPhones
class(WorldPhones)
WP=as.data.frame(WorldPhones)
WP
class(WP)
WP$Oceania
colnames(WorldPhones)
mean(WP$Oceania)
lapply(WP, mean)
lapply(WP, foo)
lapply(WP, mean)
sapply(WP, mean)
apply(WP, 1, mean)
apply(WP, 2, mean)
xyplot(N.Amer + Europe +Asia ~rownames(WP), data=WP)
rownames(WP)
WP$Year = as.numeric(rownames(WP))
WP
xyplot(N.Amer + Europe +Asia ~ Year, data=WP)
URL = 'http://www.marm.es/siar/exportador.asp?T=DD&P=28&E=3&I=01/01/2004&F=31/12/2009'
class(URL)
aranjuez=read.table(URL, header=TRUE, skip=1, fill=TRUE, dec=',')
head(aranjuez)
head(aranjuez)
tail(aranjuez)
summary(aranjuez)
tail(aranjuez)
x11()
xyplot(Radiacion~TempMedia, data=aranjuez)
xyplot(Radiacion~TempMedia, data=aranjuez, type=c('p', 'r'))
xyplot(Radiacion~TempMedia + TempMax + TempMin, data=aranjuez, type=c('p', 'r'))
xyplot(Radiacion~TempMedia + TempMax + TempMin, data=aranjuez, type=c('p', 'r'), auto.key=TRUE)
aranjuez$G0=aranjuez$Radiacion/3.6*1000
head(aranjuez)
head(aranjuez)
class(aranjuez$Fecha2)
summary(aranjuez$Fecha2)
levels(aranjuez$Fecha2)
levels(aranjuez$Fecha2)
fecha=as.POSIXct(aranjuez$Fecha2, format='%d/%m/%Y')
head(fecha)
utils:::menuInstallPkgs()
library(zoo)
aranjuez2=zoo(aranjuez[,-1], fecha)
head(aranjuez2)
xyplot(aranjuez2)
xyplot(aranjuez2$G0)
Year=function(x)as.numeric(format(x, "%Y"))
Year(fecha)
aggregate(aranjuez2, by=Year, FUN=mean)
aggregate(aranjuez2$G0, by=Year, FUN=mean)
Month=function(x)as.numeric(format(x, "%m"))
Month(head(fecha))
Month(tail(fecha))
aggregate(aranjuez2$G0, by=Month, FUN=mean)
mean(c(1, 2))
mean(c(1, 2, NA))
mean(c(1, 2, NA), na.rm=1)
mean(c(1, 2, NA), na.rm=TRUE)
aggregate(aranjuez2$G0, by=Month, FUN=mean, na.rm=TRUE)
fecha=as.POSIXct(aranjuez$Fecha2, format='%d/%m/%Y')
class(fecha)
summary(fecha)
library(zoo)
aranjuez2=zoo(aranjuez[,-1], fecha)
summary(aranjuez2)
xyplot(aranjuez2)
aggregate(aranjuez2$G0, by=Year, FUN=mean)
aggregate(aranjuez2$G0, by=Year, FUN=mean, na.rm=TRUE)
aggregate(aranjuez2$G0, by=Month, FUN=mean, na.rm=TRUE)
Month=function(x)as.numeric(format(x, '%m'))
aranjuezMM=aggregate(aranjuez2, by=Month, FUN=mean, na.rm=TRUE)
class(aranjuezMM)
xyplot(aranjuezMM)
seq(as.Date('2004-01-01'), by='day', length=10)
seq(as.Date('2004-01-01'), by='month', length=10)
seq(as.POSIXct('2004-01-01'), by='month', length=10)
source('c:/temp/sesion.R')
source('c:\temp\sesion.R')
source('c:/temp/sesion.R')
source('C:/temp/sesion.R')
source('C:\temp\sesion.R')
source('C:\temp\sesion.R')
getwd()
setwd('C:\temp')
setwd('C:/temp')
setwd('C:/temp')
dir()
source('sesion.R')
source('sesion.R')
foo=function(x, y){
    tmp=x+ y
    tmp2=tmp^2
    result=c(tmp, tmp2)
    result
}
foo
foo=function(x, y){
    tmp=x+ y
    tmp2=tmp^2
    result=c(tmp, tmp2)
    result
}
foo
foo(1, 2)
