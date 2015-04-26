
## Más de 6000 paquetes disponibles
## - Algunos vienen instalados y se cargan al empezar:

  sessionInfo()

## Más de 6000 paquetes disponibles
## - Otros vienen instalados pero hay que cargarlos:

  library(lattice)
  packageVersion('lattice')

  packageDescription('lattice')

## Más de 6000 paquetes disponibles
## - Otros hay que instalarlos y después cargarlos:

  install.packages('data.table')
  library('data.table')
  packageDescription('data.table')

## Material
## - Todo el código del curso asume que la ruta de trabajo coincide con la carpeta local: definimos la ruta de trabajo con =setwd=

setwd('/ruta/de/copia/local/del/repositorio/')

## - Comprobamos que todo ha ido bien. El resultado de la siguiente instrucción debe ser la estructura de carpetas y ficheros del repositorio:

dir()

## Material
## - Finalmente hay que instalar los paquetes que se emplean a lo largo del curso. Algunos ya vendrán instalados con tu distribución de R por ser paquetes recomendados. En la siguiente instrucción usamos el /CRAN mirror/ de la Oficina de Software Libre (CIXUG).

install.packages(c('lattice', 'latticeExtra',
                   'RColorBrewer',
                   'zoo',
                   'reshape2', 'ggplot2'),
                 repos = 'http://ftp.cixug.es/CRAN')

## Primeros pasos

x <- 1:5
x

length(x)

class(x)

## Generar vectores con =seq=

x1 <- seq(1, 100, by=2)
x1

seq(1, 100, length=10)

## Unir vectores con =c=

x <- c(1, 2, 3)
x

x <- seq(1, 100, length=10)
y <- seq(2, 100, length=50)
z <- c(x, y)
z

## Operaciones sencillas con vectores

  x <- 1:5
  x + 1

  x^2

  y <- 1:10
  x + y

  x * y

  x^2 + y^3

## Construir una matriz

  z <- 1:12
  M  <-  matrix(z, nrow=3)
  M

  class(M)

  dim(M)

  summary(M)

## Matrices a partir de vectores: =rbind= y =cbind=

z <- y <- x <- 1:10

M <- cbind(x, y, z)
M

M <- rbind(x, y, z)
M

## Para crear una lista usamos la función =list=

lista <- list(a=c(1,3,5),
              b=c('l', 'p', 'r', 's'),
              c=3)
lista

class(lista)

length(lista)

## Para crear un =data.frame=...

  df <- data.frame(x = 1:5,
                   y = rnorm(10),
                   z = 0)
  df

  length(df)

  dim(df)

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

## Para definir una función usamos la función =function=

myFun <- function(x, y) x + y
myFun

  class(myFun)

  myFun(3, 4)

## Podemos construir a partir de funciones

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

foo(rnorm(1e5))

## Condiciones simples

x <- seq(-1, 1, .1)
x

x < 0

x >= 0

x != 0

## Condiciones múltiples

cond  <-  (x > 0) & (x < .5)
cond

cond  <-  (x >= .5) | (x <= -.5)
cond

## Con las condiciones se pueden hacer operaciones

sum(cond)

sum(!cond)

as.numeric(cond)

## Indexado numérico

  x <- seq(1, 100, 2)
  x

  x[1:5]

  x[10:5]

## Indexado con condiciones lógicas

  x == 37

  x[x == 37]

  x[x != 9]

  x[x > 20]

## Indexado con condiciones múltiples

z <- seq(-10, 10, by = .5)
z

z[z < -5 | z > 5]

cond <- (z >= 0 & z <= 5)
cond

z[cond]

## Indexado de matrices

M[1:2, ]

M[1:2, 2:3]

M[1, c(1, 4)]

## Indexado de matrices

M[-1,]

M[-c(1, 2),]

## Podemos acceder a los elementos...
## - Por su nombre

lista$a

## - o por su índice

  lista[1]

  lista[[1]]

## Podemos acceder a los elementos

  df <- data.frame(x = 1:5,
                   y = rnorm(10),
                   z = 0)

## - Por su nombre (como una lista)

df$x

## - Por su índice (como una matriz)

df[1,]

df[,1]

## La función =apply=

apply(M, 1, sum)

rowSums(M)

apply(M, 2, mean)

colMeans(M)

## =lapply= y =sapply=

lista <- list(x = 1:10,
              y = seq(0, 10, 2),
              z = rnorm(30))
lapply(lista, sum)

sapply(lista, sum)

## =for=
## - En =R= suele usarse más la familia de funciones =*apply= con funciones vectorizadas.

for(n in c(2,5,10,20,50)) {
    x <- rnorm(n)
    cat(n,":", sum(x^2),"\n")
}

## =if=
## - En =R= suele usarse más el indexado lógico (vectorizado).

  x <- rnorm(10)
  x2 <- numeric(length(x))
  for (i in seq_along(x2)){
      if (x[i]<0) x2[i] <- 0 else x2[i] <- 1
      }
  cbind(x, x2)

## =ifelse=

x <- rnorm(10)
x

ifelse(x>0, 1, 0)
