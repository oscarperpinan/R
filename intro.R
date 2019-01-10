## Lectura de datos
## Importamos datos en formato tabular de un fichero disponible en un [[https://raw.githubusercontent.com/oscarperpinan/R/master/data/aranjuez.csv][enlace externo]]. 

myURL <- "https://raw.githubusercontent.com/oscarperpinan/R/master/data/aranjuez.csv"

## Las columnas están separadas por comas
## La primera fila es la cabecera
datos <- read.table(myURL,
                    sep=',',
                    header=TRUE)

## Accedemos al contenido


summary(datos)

## Modificamos los datos

## Convertimos unidades (MJ -> kWh)
datos$Radiation2 <- datos$Radiation / 3.6

## 10 primeras filas de las dos variables
datos[1:10,
      c("Radiation", "Radiation2")]

## Representamos gráficamente los datos

library(lattice)

xyplot(Radiation ~ TempAvg, data = datos,
       type = c("p", "r"),
       pch = 21, col = 'black', fill = 'gray')

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

## A partir de ficheros

dats <- read.table('data/aranjuez.csv',
                   sep=',',
                   header=TRUE)

head(dats)

## A partir de ficheros remotos

remoto <- read.table('https://raw.githubusercontent.com/oscarperpinan/R/master/data/aranjuez.csv',
                     sep=',',
                     header=TRUE)

head(remoto)

identical(dats, remoto)

## Condiciones simples

x <- seq(-1, 1, .1)
x

x < 0

x >= 0

x == 0

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


  x[x != 9]

  x[x > 20]

x[x %in% seq(0, 10, .5)]

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

## Indexado lógico
## - Hay que explicitar dos veces el =data.frame=:

df[df$y > 0,]


## - La función =subset= simplifica el código:

subset(df, y > 0)

## Uso de =with= 
## - Problema: el código con varias variables puede ser ilegible

df$x^2 + df$y^2


## - La función =with= permite acceder a varias variables con una única llamada:

with(df, x^2 + y^2)

with(df, x[y > 0])

## Argumentos: nombre y orden

## Una función identifica sus argumentos por su nombre y por su orden (sin nombre)


eleva <- function(x, p)
{
    x ^ p
}

eleva(x = 1:10, p = 2)

eleva(1:10, p = 2)

eleva(p = 2, x = 1:10)

## Argumentos: valores por defecto
## - Se puede asignar un valor por defecto a los argumentos

eleva <- function(x, p = 2)
{
    x ^ p
}

eleva(1:10)

eleva(1:10, 2)

## Argumentos sin nombre: =...=

pwrSum <- function(x, p, ...)
{
    sum(x ^ p, ...)
}

x <- 1:10
pwrSum(x, 2)

x <- c(1:5, NA, 6:9, NA, 10)
pwrSum(x, 2)

pwrSum(x, 2, na.rm=TRUE)

## Podemos construir a partir de funciones

foo  <-  function(x, ...){
  mx <- mean(x, ...)
  medx <- median(x, ...)
  sdx <- sd(x, ...)
  c(mx, medx, sdx)
  }

foo(1:10)

foo(rnorm(1e5))

## Funciones en paquetes

## - =R= proporciona un amplio conjunto de funciones predefinidas agrupadas en paquetes

##   - Algunos paquetes vienen instalados y se cargan al empezar (/base/):

  sessionInfo()


## - Otros vienen instalados pero hay que cargarlos (/recommended/):

  library(lattice)

  packageDescription('lattice')


## - Otros hay que instalarlos y después cargarlos (/contributed/):

  install.packages('data.table')

  library('data.table')
  packageDescription('data.table')

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

remoto <- read.csv('https://raw.githubusercontent.com/oscarperpinan/R/master/data/aranjuez.csv')

## =for=
## - En =R= suele usarse más la familia de funciones =*apply= con funciones vectorizadas.
## - No obstante, =for= puede tener su utilidad:

for(n in c(2,5,10,20,50)) {
    x <- rnorm(n)
    cat(n,":", sum(x^2),"\n")
}

## =if=
## - En =R= suele usarse más el indexado lógico (vectorizado).
## - ¿Cuál es el equivalente a este bucle for-if?

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
