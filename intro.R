##################################################################
## Conceptos básicos
##################################################################

## Vectores
x <- 1
x
length(x)
class(x)

x <- c(1, 2, 3)
x
length(x)
class(x)

class(c)
class(length)
length

x * 2
x + 1

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

z <- c(x, y)
z
z + c(1, 2)
z + c(1, 2, 3, 4, 5, 6, 7)
z <- c(z, z, z, z)
z
rep(1:10, 4)

length(z)

rep(c(1, 2, 3), 10)
rep(c(1, 2, 3), each=10)
help(rep)

## Indexado

x <- seq(1, 100, 2)
1:5
x[c(1, 2, 3, 4, 5)]
x[1:5]
x[10:5]

x==37
x[x==37]
x[x!=9]
x[x=10]

y <- seq(101, 200, 2)
y %in% c(101, 127, 141)
y
y[y %in% c(101, 127, 141)]
y[y>130]
z <- c(x, y)
z
z>150
z[z>150]
z[z<30 | z>150]
z[z>=30 & z<=150]
z[50]
z[c(1, 10, 40, 80)]

condicion <- (x>30)
condicion

z[condicion]
length(z)
length(condicion)

class(x>30)

cond  <-  (x>10) & (x<50)
cond
cond  <-  (x>=10) & (x<=50)
cond
x[cond]
sum(cond)
!cond
sum(!cond)
length(x[cond])
length(x[!cond])

as.numeric(cond)

## Operaciones
x + y
x - y
x * y
x^2 + y^3
exp(x)
log(x)
help(exp)

class(sum)
help(sum)
sum(x)
sum(x[cond])
sum(x[(x>=10) & (x<=50)])
x[1] + x[2] + x[3] + x[4] + x[5]
sum(x[1:5])

summary(x)
mean(x)
sd(x)
median(x)
max(x)
min(x)
range(x)
quantile(x)

## missing values con NA
class(NA)
class(TRUE)

seq_along(x)
idx <- sample(seq_along(x), 10)
idx
x[idx]
x2 <- x
x2[idx] <- NA
x2

summary(x2)
mean(x2)
sum(x2)

mean(x2, na.rm=TRUE)
sum(x2, na.rm=TRUE)
sd(x2, na.rm=TRUE)

## Matrices
z <- 1:12
M  <-  matrix(z, nrow=3)
M
z
help(matrix)
class(M)
dim(M)

t(M)
class(t)
dim(t(M))

M * M
M ^ 2
M %*% M
M %*% t(M)
help('%*%')


summary(M)

sum(M)
rowSums(M)
apply(M, 1, sum)
colSums(M)
apply(M, 2, sum)
rowMeans(M)
apply(M, 1, mean)
colMeans(M)
apply(M, 2, mean)

apply(M, 1, sd, na.rm=TRUE)
apply(M, 2, sd)
help(apply)
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

## Funciones
foo  <-  function(x, ...){
  mx <- mean(x, ...)
  medx <- median(x, ...)
  sdx <- sd(x, ...)
  c(mx, medx, sdx)
  }

## foo <- function(x, ...){c(mean(x, ...), median(x, ...), sd(x, ...))}

class(foo)
foo

foo(1:10)

rnorm(100)
help(rnorm)
foo(rnorm(1e5))

rowMeans(M)
apply(M, 1, foo)
colMeans(M)
apply(M, 2, foo)

f <- function(x, y)x^2+y^2
f
f(1, 2)
x
y

z <- outer(x, y, f)
z
image(x, y, z)


## Listas y data.frame
lista <- list(a=c(1,3,5),
              b=c('l', 'p', 'r', 's'),
              c=3)
class(list)

lista
lista$a
lista$b
lista$c

class(lista)
class(lista$a)
class(lista$b)
class(lista$c)

length(lista)
length(lista$a)
length(lista$b)
length(lista$c)

lapply(lista, length)
sapply(lista, length)

lista <- list(x = 1:10,
              y = seq(0, 10, 2),
              z = rnorm(30))
lista
lapply(lista, sum)
lapply(lista, median)
lapply(lista, foo)


df <- data.frame(x = 1:10,
                 y = rnorm(10),
                 z = 0)
df
df[1,]
df[,1]
df[,2]

length(df)
dim(df)

df$x
df$y
df$z

plot(df$x, df$y)

library(lattice)

xyplot(y ~ x, data=df)
xyplot(y ~ x, data=df, type='l')
xyplot(y ~ x, data=df, type='b')
xyplot(y ~ x, data=df, type=c('b', 'g'))
xyplot(y ~ x, data=df, type=c('b', 'r', 'g'))
help(xyplot)

x <- y <- seq(-4*pi, 4*pi, len=200)
df <- expand.grid(x = x, y = y)
head(df)
tail(df)
summary(df)
dim(df)
names(df)

circles <- function(object){
  r <- with(object, sqrt(x^2 + y^2))
  res <- cos(r^2)*exp(-r/6)
  res}

head(circles(df))

df$result <- circles(df)
head(df)

levelplot(result ~ x * y, data=df)
xyplot(result ~ x, data=df)