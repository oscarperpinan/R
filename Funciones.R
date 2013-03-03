
## #+TITLE:     Funciones
## #+AUTHOR:    Oscar Perpiñán Lamigueiro
## #+EMAIL:     oscar.perpinan@gmail.com
## #+DESCRIPTION:
## #+KEYWORDS:
## #+LANGUAGE:  es
## #+OPTIONS:   H:3 num:t toc:nil \n:nil @:t ::t |:t ^:t -:t f:t *:t <:t
## #+OPTIONS:   TeX:t LaTeX:t skip:nil d:nil todo:t pri:nil tags:not-in-toc
## #+INFOJS_OPT: view:nil toc:nil ltoc:t mouse:underline buttons:0 path:http://orgmode.org/org-info.js
## #+EXPORT_SELECT_TAGS: export
## #+EXPORT_EXCLUDE_TAGS: noexport
## #+LINK_UP:   
## #+LINK_HOME: 
## #+XSLT:
## #+startup: beamer
## #+LaTeX_CLASS: beamer
## #+BEAMER_FRAME_LEVEL: 2
## #+LATEX_CLASS_OPTIONS: [xcolor={usenames,svgnames,dvipsnames}]
## #+LATEX_HEADER: \AtBeginSection[]{\begin{frame}<beamer>\frametitle{Contenidos}\tableofcontents[currentsection]\end{frame}}
## #+LATEX_HEADER: \lstset{keywordstyle=\color{blue}, commentstyle=\color{gray!90}, basicstyle=\ttfamily\footnotesize, columns=fullflexible, breaklines=false,linewidth=\textwidth, backgroundcolor=\color{gray!23}, basewidth={0.5em,0.4em}, literate={á}{{\'a}}1 {ñ}{{\~n}}1 {é}{{\'e}}1 {ó}{{\'o}}1 {º}{{\textordmasculine}}1}
## #+LATEX_HEADER: \usepackage{mathpazo}
## #+LATEX_HEADER: \setbeamercovered{transparent}
## #+LATEX_HEADER: \usefonttheme{serif} 
## #+LATEX_HEADER: \usetheme{Goettingen}
## #+LATEX_HEADER: \hypersetup{colorlinks=true, linkcolor=Blue, urlcolor=Blue}
## #+PROPERTY:  tangle yes
## #+PROPERTY:  comments org
## #+PROPERTY: results output
## #+PROPERTY: session *R*
## #+PROPERTY: exports both
## #+LATEX_HEADER: \usepackage{fancyvrb}
## #+LATEX_HEADER: \DefineVerbatimEnvironment{verbatim}{Verbatim}{fontsize=\tiny, formatcom = {\color{black!70}}}

setwd('~/R/intro')

## Mi primera función
## - Definición

myFun <- function(x, y){
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

## - Una función identifica sus argumentos por su nombre y por su orden (sin nombre)

power <- function(x, exp){
    x^exp
    }

power(x=1:10, exp=2)

power(1:10, exp=2)

power(exp=2, x=1:10)

## Argumentos: valores por defecto
## - Se puede asignar un valor por defecto a los argumentos

power <- function(x, exp=2){
    x ^ exp
    }

power(1:10)

power(1:10, 2)

## Funciones sin argumentos

hello <- function(){
    print('Hello world!')
    }

hello()

## Argumentos sin nombre: =...=

pwrSum <- function(x, power, ...){
    sum(x ^ power, ...)
    }

x <- 1:10
pwrSum(x, 2)

x <- c(1:5, NA, 6:9, NA, 10)
pwrSum(x, 2)

pwrSum(x, 2, na.rm=TRUE)

## Argumentos ausentes: =missing=

suma10 <- function(x, y){
    if (missing(y)) y <- 10
    x + y
    }

suma10(1:10)

## Control de errores: =stopifnot=

foo <- function(x, y){
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

## Clases de variables
## - Las variables que se emplean en el cuerpo de una función pueden
##   dividirse en:
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
    interna <- function(x, y){
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
    function(x){
        m*x + n
        }
    }

myFoo <- constructor(10, 3)
myFoo

## Funciones que devuelven funciones

class(myFoo)

environment(myFoo)

ls()

ls(env=environment(myFoo))

get('m', env=environment(myFoo))

get('n', env=environment(myFoo))

## =traceback=

sumSq <- function(x, ...){
    sum(x ^ 2, ...)
    }

sumProd <- function(x, y, ...){
    xs <- sumSq(x, ...)
    ys <- sumSq(y, ...)
    xs * ys
    }

sumProd(rnorm(10), runif(10))

sumProd(rnorm(10), letters[1:10])

traceback()

## =system.time=

noise <- function(sd)rnorm(1000, mean=0, sd=sd)

sumNoise <- function(nComponents){
    vals <- sapply(seq_len(nComponents), noise)
    rowSums(vals)
    }

system.time(sumNoise(1000))

## =Rprof=
## - Usaremos un fichero temporal

tmp <- tempfile()

## - Activamos la toma de información

Rprof(tmp)

## - Ejecutamos el código a analizar

zz <- sumNoise(1000)

## =Rprof=
## - Paramos el análisis

Rprof()

## - Extraemos el resumen

summaryRprof(tmp)

## =do.call= 
## - Ejemplo: sumar los componentes de una lista

lista <- list(a=rnorm(100), b=runif(100), c=rexp(100))
with(lista, sum(a + b + c))

## - En lugar de nombrar los componentes, creamos una llamada a una
##   función con =do.call=

do.call(sum, lista)

## =do.call=

## - Se emplea frecuentemente con el resultado de =lapply=

x <- rnorm(5)
ll <- lapply(1:5, function(i)x^i)
do.call(rbind, ll)

## - Este mismo ejemplo puede resolverse con =sapply=

sapply(1:5, function(i)x^i)

## =Reduce=
## - Combina sucesivamente los elementos de un objeto aplicando una
##   función binaria

Reduce('+', 1:10)
## equivalente a 
## sum(1:10)

## =Reduce=

Reduce('/', 1:10)

Reduce(paste, LETTERS[1:5])

foo <- function(u, v)u + 1 /v
Reduce(foo, c(3, 7, 15, 1, 292), right=TRUE)
## equivalente a
## foo(3, foo(7, foo(15, foo(1, 292))))

## Funciones recursivas
## - [[http://en.wikibooks.org/wiki/R_Programming/Working_with_functions#Functions_as_Objects][Serie de Fibonnaci]]

fib <- function(n){
    if (n>2) {
        c(fib(n-1),
          sum(tail(fib(n-1),2)))
    } else if (n>=0) rep(1,n)
    }

fib(10)
