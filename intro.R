
## Más de 4000 paquetes disponibles
## - Algunos vienen instalados y se cargan al empezar:

sessionInfo()

## - Otros vienen instalados pero hay que cargarlos:

library(lattice)
packageVersion('lattice')
packageDescription('lattice')

## - Otros hay que instalarlos y después cargarlos:

install.packages('zoo')
library('zoo')
packageDescription('zoo')

## Primeros pasos

x <- 1
x
length(x)
class(x)

x <- c(1, 2, 3)
x
length(x)
class(x)

## Primeras funciones

class(c)
class(length)
length

## Operaciones sencillas con vectores

x + 1
y <- 1:10
x + y
x * y
x^2
x^2 + y^3
exp(x)
log(x)

## ¿Y qué hago cuando necesito ayuda?

help(exp)
help(log)

## Generar vectores con =seq=

x1 <- seq(1, 100, by=2)
x1
help(seq)

seq(1, 100, 10)
seq(1, 100, length=10)
seq(1, 1, 10)

x <- seq(1, 100, length=10)
x
length(x)

x <- seq(1, 100, length=10)
y <- seq(2, 100, length=50)

## Unir vectores con =c=

z <- c(x, y)
z
z + c(1, 2)
z + c(1, 2, 3, 4, 5, 6, 7)
z <- c(z, z, z, z)
z

## Generar vectores con =rep=

rep(1:10, 4)

length(z)

rep(c(1, 2, 3), 10)
rep(c(1, 2, 3), each=10)
help(rep)

## Indexado numérico de vectores

x <- seq(1, 100, 2)
1:5
x[c(1, 2, 3, 4, 5)]
x[1:5]
x[10:5]

## Indexado de vectores con condiciones lógicas

condicion <- (x>30)
condicion
class(condicion)

## Indexado de vectores con condiciones lógicas

x==37
x[x==37]
x[x!=9]
x[x>20]

## - Y aquí ¿qué ocurre?

x[x=10]

## Indexado de vectores con =%in%=

y <- seq(101, 200, 2)
y %in% c(101, 127, 141)
y
y[y %in% c(101, 127, 141)]

## Indexado de vectores con condiciones múltiples

z <- c(x, y)
z
z>150
z[z>150]
z[z<30 | z>150]
z[z>=30 & z<=150]
z[c(1, 10, 40, 80)]

## Indexado de vectores con condiciones múltiples

cond  <-  (x>10) & (x<50)
cond
cond  <-  (x>=10) & (x<=50)
cond
x[cond]

## Con las condiciones se pueden hacer operaciones

sum(cond)
!cond
sum(!cond)
length(x[cond])
length(x[!cond])
as.numeric(cond)

## Funciones predefinidas

summary(x)
mean(x)
sd(x)
median(x)
max(x)
min(x)
range(x)
quantile(x)

## Construir una matriz

z <- 1:12
M  <-  matrix(z, nrow=3)
M
z
help(matrix)
class(M)
dim(M)
summary(M)

## Matrices a partir de vectores: =rbind= y =cbind=

x <- 1:10
y <- 1:10
z <- 1:10
z <- y <- x <- 1:10

M <- cbind(x, y, z)
M
M <- rbind(x, y, z)
M

rbind(M, M)
cbind(M, M)

## Transponer una matriz

t(M)
class(t)
dim(t(M))

## Operaciones con matrices

M * M
M ^ 2
M %*% M
M %*% t(M)
help('%*%')

## Operaciones con matrices: funciones predefinidas

sum(M)
rowSums(M)
colSums(M)
rowMeans(M)
colMeans(M)

## La función =apply=

help(apply)
apply(M, 1, sum)
apply(M, 2, sum)
apply(M, 1, mean)
apply(M, 2, mean)
apply(M, 1, sd, na.rm=TRUE)
apply(M, 2, sd)

## =sweep=
## - Usamos el conjunto de datos =state.x77=

head(state.x77)

## - Calculamos el máximo por columna

maxes <- apply(state.x77, 2, max)

## - Dividimos cada columna por su máximo

stateNorm <- sweep(state.x77, 2, maxes, FUN="/")
head(stateNorm)

## Indexado de matrices

M
M[]
M[1, ]
M[, 1]
sum(M[, 1])
M[1:2, ]
M[1:2, 2:3]
M[1, c(1, 4)]
M[-1,]
M[-c(1, 2),]

## ¿Qué es =NA=?

class(NA)
x <- rnorm(100)
idx <- sample(length(x), 10)
idx
x[idx]
x2 <- x
x2[idx] <- NA
x2

## =NA= en las funciones

summary(x)
mean(x)
sum(x)

summary(x2)
mean(x2)
sum(x2)

## =NA= en las funciones

mean(x2, na.rm=TRUE)
sum(x2, na.rm=TRUE)
sd(x2, na.rm=TRUE)
class(TRUE)

## Para definir una función usamos la función =function=

myFun <- function(x, y) x + y
myFun(3, 4)
class(myFun)

## Definir una función a partir de funciones

foo  <-  function(x, ...){
  mx <- mean(x, ...)
  medx <- median(x, ...)
  sdx <- sd(x, ...)
  c(mx, medx, sdx)
  }

## O en forma resumida:

foo <- function(x, ...){c(mean(x, ...), median(x, ...), sd(x, ...))}

## Y ahora usamos la función con vectores

foo(1:10)

rnorm(100)
help(rnorm)
foo(rnorm(1e5))

## Y también funciona con matrices

rowMeans(M)
apply(M, 1, foo)
colMeans(M)
apply(M, 2, foo)

## La función =outer=

f <- function(x, y)x^2+y^2
f
f(1, 2)
x
y

z <- outer(x, y, f)
z
image(x, y, z)

## Para crear una lista usamos la función =list=

lista <- list(a=c(1,3,5),
              b=c('l', 'p', 'r', 's'),
              c=3)
class(list)
class(lista)

## Podemos acceder a los elementos...
## - Por su nombre

lista
lista$a
lista$b
lista$c

## - o por su índice

lista[1]
lista[[1]]

class(lista[1])
class(lista[[1]])

lista[2]
lista[[2]]

class(lista[2])
class(lista[[2]])

## Cada elemento es diferente
## - Clase

class(lista)
class(lista$a)
class(lista$b)
class(lista$c)

## - Longitud

length(lista)
length(lista$a)
length(lista$b)
length(lista$c)

## Para matrices =apply=, para listas =lapply= y =sapply=

lapply(lista, length)
sapply(lista, length)

lista <- list(x = 1:10,
              y = seq(0, 10, 2),
              z = rnorm(30))
lista

lapply(lista, sum)
lapply(lista, median)
lapply(lista, foo)

## Para crear un =data.frame=...

df <- data.frame(x = 1:10,
                 y = rnorm(10),
                 z = 0)

length(df)
dim(df)

## Podemos acceder a los elementos
## - Por su nombre

df$x
df$y
df$z

## - Por su índice

df
df[1,]
df[,1]
df[,2]

## La regla del reciclaje

year <- 2011
month <- 1:12
class <- c('A', 'B', 'C')
vals <- rnorm(12)

dats <- data.frame(year, month, class, vals)
dats

## La función =expand.grid=

x <- y <- seq(-4*pi, 4*pi, len=200)
df <- expand.grid(x = x, y = y)
head(df)
tail(df)
summary(df)
dim(df)
names(df)

## Funciones sobre =data.frame=

circles <- function(object){
  r <- with(object, sqrt(x^2 + y^2))
  res <- cos(r^2)*exp(-r/6)
  res}

df$result <- circles(df)
head(df)

## Una imagen vale más que mil palabras

library(lattice)
levelplot(result ~ x + y, data=df)

## Unir dos =data.frame=
## - Primero construimos un =data.frame= de ejemplo

USStates <- as.data.frame(state.x77)
USStates$Name <- rownames(USStates)
rownames(USStates) <- NULL

## - Lo partimos en estados "fríos" y estados "grandes"

coldStates <- USStates[USStates$Frost>150, c('Name', 'Frost')]
largeStates <- USStates[USStates$Area>1e5, c('Name', 'Area')]

## - Unimos los dos conjuntos (estados "fríos" y "grandes")

merge(coldStates, largeStates)

## =merge= usa =match=
## - Estados grandes que también son fríos

idxLarge <- match(largeStates$Name,
                  coldStates$Name,
                  nomatch=0)
idxLarge

coldStates[idxLarge,]

## - Estados frios que también son grandes

idxCold <- match(coldStates$Name,
                 largeStates$Name,
                 nomatch=0)
idxCold

largeStates[idxCold,]

## Una variable numérica que nos servirá para el ejemplo

N <- 100
edad <- sample(seq(18, 40, 1), N, replace=TRUE)
summary(edad)

## Una variable cualitativa se define con =factor=
## - Ahora es un =character=

sexo <- sample(c('H', 'M'), N, replace=TRUE)
class(sexo)
summary(sexo)

## - Ahora es un =factor=

sexo <- factor(sexo)
class(sexo)
summary(sexo)
levels(sexo)
nlevels(sexo)

## Los =factor= sirven para agrupar

## - Con la función =table=

table(edad, sexo)
table(edad > 30, sexo)
table(edad %in% 20:30, sexo)

## - Con =tapply= o =aggregate=

tapply(edad,sexo, mean)
aggregate(edad ~ sexo, FUN=median)

## Los factores sirven para separar

edadSexo <- split(edad, sexo)
class(edadSexo)

sapply(edadSexo, mean)

## Los =factor= se pueden generar a partir de variables numéricas
## - Por ejemplo, con =cut=

gEdad <- cut(edad, breaks=4)
class(gEdad)
levels(gEdad)
nlevels(gEdad)

## - Nuevamente =table=

table(gEdad)
table(gEdad, sexo)

## =Date=

as.Date('2013-02-06')
as.Date('2013/02/06')

as.Date('06.02.2013')
as.Date('06.02.2013', format='%d.%m.%Y')

as.Date(37, origin='2013-01-01')

## Secuencias temporales con =Date=

seq(as.Date('2004-01-01'), by='day', length=10)
seq(as.Date('2004-01-01'), by='month', length=10)
seq(as.Date('2004-01-01'), by='10 day', length=10)

## POSIXct

as.POSIXct('2013-02-06')
ISOdate(2013, 2, 7)

hoy <- as.POSIXct('2013-02-06')

help(format.POSIXct)
format(hoy, '%Y')
format(hoy, '%d')
format(hoy, '%m')
format(hoy, '%b')
format(hoy, '%d de %B de %Y')

hora <- Sys.time()
hora

format(hora, '%H:%M:%S')
format(hora, '%H horas, %M minutos y %S segundos')

## Secuencias temporales con =POSIXct=

seq(as.POSIXct('2004-01-01'), by='month', length=10)
seq(as.POSIXct('2004-01-01 10:00:00'), by='15 min', length=10)

## Zonas horarias

as.POSIXct('2013-02-06 15:30:00', tz='GMT')
as.POSIXct('2013-02-06 15:30:00', tz='Europe/Madrid')

hawaii <- as.POSIXct('2013-02-06 15:30:00', tz='HST')
## Character
format(hawaii, tz='GMT')
## POSIXct
as.POSIXct(format(hawaii, tz='GMT'), tz='GMT')

## Bastan unas simples comillas

cadena <- "Hola mundo"
class(cadena)
nchar(cadena)

## - Y aquí, ¿qué pasa?

length(cadena)
cadena[1]
cadena[2]

## Un vector de =character=

cadenaVec <- c("Hola mundo", "Hello world")
nchar(cadenaVec)
length(cadenaVec)

## Para mostrarlos usamos =cat= o =print=

a = 2
b = 3

cat('La suma de', a, 'y', b, 'es', a + b)

cat('La suma de', a, 'y', b, 'es', a + b, fill=TRUE)

cat('La suma de', a, 'y', b, 'es', a + b, '\n',
    'La multiplicación de', a, 'por', b, 'es', a*b, '\n')

cat('La suma de', a, 'y', b, 'es', a + b, '\n',
    'La multiplicación de', a, 'por', b, 'es', a*b, fill=15)

## Los =character= se pueden unir...
## - Primero sencillo

paste('Hello', 'World', sep='_')

paste(cadenaVec)
paste(cadenaVec, collapse='=')

## - Y algo más complicado

paste('X', 1:5, sep='.')
paste(c('A', 'B'), 1:5, sep='.')

paste(c('A', 'B'), 1:5, sep='.', collapse='|')

## ... y también se pueden separar...

strsplit(cadenaVec, split=' ')
strsplit(cadenaVec, split='')

chSep <- strsplit(cadenaVec, split=' ')
class(chSep)
length(chSep)
sapply(chSep, length)
sapply(chSep, nchar)

## ... y, por supuesto, manipular

sub('o', '0', 'Hola Mundo')
gsub('o', '0', 'Hola Mundo')

substring(cadena, 1) <- 'HOLA'
cadena

tolower(cadena)
toupper(cadena)

## =for=

for(n in c(2,5,10,20,50)) {
    x <- rnorm(n)
    cat(n,":", sum(x^2),"\n")
}

## =if=

x <- rnorm(10)
x2 <- numeric(length(x))
for (i in seq_along(x2)){
    if (x[i]<0) x2[i] <- 0 else x2[i] <- 1
    }
cbind(x, x2)

## =ifelse=

x <- rnorm(10)
ifelse(x>0, 1, 0)
