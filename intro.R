
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

## Y aquí, ¿qué ocurre?					    :B_block:
##      :PROPERTIES:
##      :BEAMER_env: block
##      :END:

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

## Aritmética sencilla

x + y
x - y
x * y
x^2 + y^3
exp(x)
log(x)

## Funciones predefinidas

summary(x)
mean(x)
sd(x)
median(x)
max(x)
min(x)
range(x)
quantile(x)

## Funciones y condiciones

sum(x)
sum(x[cond])
sum(x[(x>=10) & (x<=50)])
x[1] + x[2] + x[3] + x[4] + x[5]
sum(x[1:5])

## ¿Y qué hago cuando necesito ayuda?

help(exp)
help(sum)
help(quantile)

## ¿Qué es =NA=?

class(NA)
seq_along(x)
idx <- sample(seq_along(x), 10)
idx
x[idx]
x2 <- x
x2[idx] <- NA
x2

## =NA= en las funciones

summary(x2)
mean(x2)
sum(x2)

## =NA= en las funciones

mean(x2, na.rm=TRUE)
sum(x2, na.rm=TRUE)
sd(x2, na.rm=TRUE)
class(TRUE)

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

## Podemos acceder a los elementos por su nombre

lista
lista$a
lista$b
lista$c

## o por su índice

lista[1]
lista[[1]]

class(lista[1])
class(lista[[1]])

lista[2]
lista[[2]]

class(lista[2])
class(lista[[2]])

## Cada elemento es de una clase diferente

class(lista)
class(lista$a)
class(lista$b)
class(lista$c)

## y de una longitud diferente

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

## Podemos acceder a los elementos por su nombre

df$x
df$y
df$z

## o por su índice

df
df[1,]
df[,1]
df[,2]

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

## Base

plot(df$x, df$y)

## Lattice: =xyplot=

library(lattice)

xyplot(y ~ x, data=df)
xyplot(y ~ x, data=df, type='l')
xyplot(y ~ x, data=df, type='b')
xyplot(y ~ x, data=df, type=c('b', 'g'))
xyplot(y ~ x, data=df, type=c('b', 'r', 'g'))

help(xyplot)

## Lattice: =levelplot=

levelplot(result ~ x * y, data=df)
xyplot(result ~ x, data=df)
