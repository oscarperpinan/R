## Mi primera función
## - Definición

myFun <- function(x, y)
{
    x + y
}


## - Argumentos

formals(myFun)


## - Cuerpo

body(myFun)

## Mi primera función

myFun(1, 2)

myFun(1:10, 21:30)

myFun(1:10, 3)

## Argumentos: nombre y orden

## Una función identifica sus argumentos por su nombre y por su orden (sin nombre)


power <- function(x, exp)
{
    x^exp
}

power(x=1:10, exp=2)

power(1:10, exp=2)

power(exp=2, x=1:10)

## Argumentos: valores por defecto
## - Se puede asignar un valor por defecto a los argumentos

power <- function(x, exp = 2)
{
    x ^ exp
}

power(1:10)

power(1:10, 2)

## Funciones sin argumentos

hello <- function()
{
    print('Hello world!')
}

hello()

## Argumentos sin nombre: =...=

pwrSum <- function(x, power, ...)
{
    sum(x ^ power, ...)
}

x <- 1:10
pwrSum(x, 2)

x <- c(1:5, NA, 6:9, NA, 10)
pwrSum(x, 2)

pwrSum(x, 2, na.rm=TRUE)

## Argumentos ausentes: =missing=

suma10 <- function(x, y)
{
    if (missing(y)) y <- 10
    x + y
}

suma10(1:10)

## Control de errores: =stopifnot=

foo <- function(x, y)
{
    stopifnot(is.numeric(x) & is.numeric(y))
    x + y
}

foo(1:10, 21:30)

foo(1:10, 'a')

## Control de errores: =stop=

foo <- function(x, y){
    if (!(is.numeric(x) & is.numeric(y))){
        stop('arguments must be numeric.')
    } else { x + y }
}

foo(2, 3)

foo(2, 'a')

## Mensajes para el usuario
## =stop= para la ejecución y emite un mensaje de error

stop('Algo no ha ido bien.')


## =warning= no interfiere en la ejecución pero añade un mensaje a la cola de advertencias

warning('Quizás algo no es como debiera...')


## =message= emite un mensaje (*no usar =cat= o =print=*)

message('Todo en orden por estos lares.')

## Clases de variables
## Las variables que se emplean en el cuerpo de una función pueden
## dividirse en:
##   - Parámetros formales (argumentos): =x=, =y=
##   - Variables locales (definiciones internas): =z=, =w=, =m=
##   - Variables libres: =a=, =b=

myFun <- function(x, y){
    z <- x^2
    w <- y^3
    m <- a*z + b*w
    m
}

a <- 10
b <- 20
myFun(2, 3)

## Lexical scope

## - Las variables libres deben estar disponibles en el entorno
##   (=environment=) en el que la función ha sido creada.

environment(myFun)

ls()

## Lexical scope: funciones anidadas

anidada <- function(x, y){
    xn <- 2
    yn <- 3
    interna <- function(x, y)
    {
        sum(x^xn, y^yn)
    }
    print(environment(interna))
    interna(x, y)
}

anidada(1:3, 2:4)

sum((1:3)^2, (2:4)^3)

## Lexical scope: funciones anidadas

xn

yn

interna

## Funciones que devuelven funciones

constructor <- function(m, n){
    function(x)
    {
        m*x + n
    }
}

myFoo <- constructor(10, 3)
myFoo

## 10*5 + 3
myFoo(5)

## Funciones que devuelven funciones

class(myFoo)

environment(myFoo)

ls()

ls(env = environment(myFoo))

get('m', env = environment(myFoo))

get('n', env = environment(myFoo))

## =lapply=
## Supongamos que tenemos una lista de objetos, y queremos aplicar a cada elemento la misma función:

lista <- list(a = rnorm(100),
              b = runif(100),
              c = rexp(100))


## Podemos resolverlo de forma repetitiva...

sum(lista$a)

sum(lista$b)

sum(lista$c)



## O mejor con =lapply= (lista + función):

lapply(lista, sum)

## =do.call=
## Supongamos que queremos usar los elementos de la lista como argumentos de una función.

## Resolvemos de forma directa:

sum(lista$a, lista$b, lista$c)


## Mejoramos /un poco/ con =with=:

with(lista, sum(a, b, c))


## La forma recomendable es mediante =do.call= (función + lista)

do.call(sum, lista)

## =do.call=

## Se emplea frecuentemente para adecuar el resultado de =lapply= (entrega una lista):

  x <- rnorm(5)
  ll <- lapply(1:5, function(i)x^i)
  do.call(rbind, ll)

## =Reduce=
## Combina sucesivamente los elementos de un objeto aplicando una función binaria

## (((1+2)+3)+4)+5
Reduce('+', 1:5)

## =Reduce=

## (((1/2)/3)/4)/5
Reduce('/', 1:5)

foo <- function(u, v)u + 1 /v
Reduce(foo, c(3, 7, 15, 1, 292))
## equivalente a
## foo(foo(foo(foo(3, 7), 15), 1), 292)

Reduce(foo, c(3, 7, 15, 1, 292), right=TRUE)
## equivalente a
## foo(3, foo(7, foo(15, foo(1, 292))))

## Funciones recursivas
## Ejemplo: [[http://en.wikibooks.org/wiki/R_Programming/Working_with_functions#Functions_as_Objects][Serie de Fibonnaci]]

fib <- function(n){
    if (n>2) {
        c(fib(n-1),
          sum(tail(fib(n-1),2)))
    } else if (n>=0) rep(1,n)
}

fib(10)

## Post-mortem: =traceback=

sumSq <- function(x, ...)
    sum(x ^ 2, ...)

sumProd <- function(x, y, ...){
    xs <- sumSq(x, ...)
    ys <- sumSq(y, ...)
    xs * ys
}

sumProd(rnorm(10), runif(10))

sumProd(rnorm(10), letters[1:10])

traceback()

## Analizar antes de que ocurra: =debug=
## =debug= activa la ejecución paso a paso de una función:

debug(sumProd)


## - Cada vez que se llame a la función, su cuerpo se ejecuta línea a línea y los resultados de cada paso pueden ser inspeccionados.
## - Los comandos disponibles son:
##   - =n= o intro: avanzar un paso.
##   - =c=: continua hasta el final del contexto actual (por ejemplo,
##     terminar un bucle).
##   - =where=: entrega la lista de todas las llamadas activas.
##   - =Q=: termina la inspección y vuelve al nivel superior.
## - Para desactivar el análisis:

undebug(sumProd)

## Analizar antes de que ocurra: =trace=
## - =trace= permite mayor control que =debug=

trace(sumProd, tracer=browser, exit=browser)


## - La función queda modificada

sumProd

body(sumProd)

## Analizar antes de que ocurra: =trace=
## - Los comandos =n= y =c= cambian respecto a =debug=:
##   - =c= o intro: avanzar un paso.
##   - =n=: continua hasta el final del contexto actual (por ejemplo,
##     terminar un bucle).
## - Para desactivar

untrace(sumProd)

## ¿Cuánto tarda mi función? =system.time=
## Defino una función que rellena una matriz de 10^6 filas y =n= columnas con una distribución normal:

makeNoise <- function(n){
    sapply(seq_len(n), function(i) rnorm(1e6))
}

M <- makeNoise(100)
summary(M)

## Diferentes formas de sumar
## =system.time= mide el tiempo de CPU que consume un código[fn:1].


system.time({
    suma1 <- numeric(1e6)
    for(i in 1:1e6) suma1[i] <- sum(M[i,])
})

system.time(suma2 <- apply(M, 1, sum))

system.time(suma3 <- rowSums(M))

## ¿Cuánto tarda cada parte de mi función?: =Rprof=
## - Usaremos un fichero temporal

tmp <- tempfile()


## - Activamos la toma de información

Rprof(tmp)


## - Ejecutamos el código a analizar

suma1 <- numeric(1e6)
for(i in 1:1e6) suma1[i] <- sum(M[i,])

suma2 <- apply(M, 1, FUN = sum)

suma3 <- rowSums(M)

## ¿Cuánto tarda cada parte de mi función?: =Rprof=
## - Paramos el análisis

Rprof()


## - Extraemos el resumen

summaryRprof(tmp)
