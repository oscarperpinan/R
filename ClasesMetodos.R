## Clases
## Los objetos básicos en =R= tienen una clase implícita definida en =S3=. Es accesible con =class=.

  x <- rnorm(10)
  class(x)


## Pero no tienen atributo...

attr(x, 'class')


## ...ni se consideran formalmente objetos

is.object(x)

## Clases
## Se puede redefinir la clase de un objecto =S3= con =class=

  class(x) <- 'myNumeric'
  class(x)


## Ahora sí es un objeto... 

is.object(x)


## y su atributo está definido

attr(x, 'class')


## Sin embargo, su modo de almacenamiento (/clase intrínseca/) no cambia:

  mode(x)

## Definición de Clases 

  task1 <- list(what='Write an email',
                when=as.Date('2013-01-01'),
                priority='Low')
  class(task1) <- 'Task'
  task1

  task2 <- list(what='Find and fix bugs',
                when=as.Date('2013-03-15'),
                priority='High')
  class(task2) <- 'Task'

## Definición de Clases

  myToDo <- list(task1, task2)
  class(myToDo) <- c('ToDo3')
  myToDo

## Métodos genéricos: =UseMethod=
## El primer paso para que usar métodos en =S3= es definir un método genérico con =UseMethod=. Esta función selecciona el método correspondiente a la clase del argumento.

summary



## Si no hay un método definido para la clase del objeto, =UseMethod= ejecuta la función por defecto:

summary.default

## Métodos específicos: =methods=
## Con =methods= podemos averiguar los métodos que hay definidos para una función particular:

methods('summary')

## Ejemplo de definición de método genérico
## En primer lugar, definimos la función con =UseMethod=:

  myFun <- function(x, ...)UseMethod('myFun')


## ... y la función por defecto.

  myFun.default <- function(x, ...){
    cat('Funcion genérica\n')
    print(x)
    }

## Ejemplo de definición de método genérico
## Dado que no hay métodos definidos, esta función siempre ejecuta la función por defecto.

methods('myFun')

x <- rnorm(10)
myFun(x)

myFun(task1)

## Definición del método para =Task=

myFun.Task <- function(x, number,...)
{
    if (!missing(number))
        cat('Task no.', number,':\n')
    cat('What: ', x$what,
        '- When:', as.character(x$when),
        '- Priority:', x$priority,
        '\n')
}

methods(myFun)

methods(class='Task')

## Método de =Task=


myFun(task1)

myFun(task2)

myFun(ToDo3)

## =NextMethod=
## Incluyendo =NextMethod= en un método específico llamamos al método genérico (=default=).

  print.Task <- function(x, ...){
    cat('Task:\n')
    NextMethod(x, ...) ## Ejecuta print.default
  }

  print(task1)

## =NextMethod=

  print.ToDo3 <- function(x, ...){
    cat('This is my ToDo list:\n')
    NextMethod(x, ...)
    cat('--------------------\n')
  }

print(myToDo)

## Definición de un método =S3= para =Task=

print.Task <- function(x, number,...){
    if (!missing(number))
        cat('Task no.', number,':\n')
    cat('What: ', x$what,
        '- When:', as.character(x$when),
        '- Priority:', x$priority,
        '\n')
}

print(task1)

print(myToDo[[2]])

## Definición de un método =S3= para =ToDo3=
## - Definimos un método más sofisticado para la clase =ToDo3= *sin*
##   tener en cuenta el método definido para la clase =Task=.

  print.ToDo3 <- function(x, ...){
    cat('This is my ToDo list:\n')
    for (i in seq_along(x)){
      cat('Task no.', i,':\n')
      cat('What: ', x[[i]]$what,
          '- When:', as.character(x[[i]]$when),
          '- Priority:', x[[i]]$priority,
          '\n')
      }
    cat('--------------------\n')
  }

  print(myToDo)

## Redefinición del método para =ToDo3=

## - Podemos aligerar el código teniendo en cuenta el método definido para la clase =Task=.

  print.ToDo3 <- function(x, ...){
      cat('This is my ToDo list:\n')
      ## Cada uno de los elementos de un
      ## objeto ToDo3 son Task.  Por tanto,
      ## x[[i]] es de clase Task y
      ## print(x[[i]]) ejecuta el metodo
      ## print.Task
    for (i in seq_along(x)) print(x[[i]], i)
      cat('--------------------\n')
  }

print(myToDo)

## Definición de una nueva clase


setClass('bird',
         slots = c(
             name = 'character',
             lat = 'numeric',
             lon = 'numeric',
             alt = 'numeric',
             speed = 'numeric',
             time = 'POSIXct')
         )

## Funciones para obtener información de una clase

getClass('bird')

getSlots('bird')

slotNames('bird')

## Creación de un objeto con la clase definida
## Una vez que la clase ha sido definida con =setClass=, se puede crear un objeto nuevo con =new=. Es habitual definir funciones que construyen y modifican objetos para evitar el uso directo de =new=:

readBird <- function(name, path)
{
    csvFile <- file.path(path, paste0(name, ".csv"))

    vals <- read.csv(csvFile)
    
    new('bird',
        name = name,
        lat = vals$latitude,
        lon = vals$longitude,
        alt = vals$altitude,
        speed = vals$speed_2d,
        time = as.POSIXct(vals$date_time)
        )
}

## Creación de objetos con la clase definida

eric <- readBird("eric", "data")
nico <- readBird("nico", "data")
sanne <- readBird("sanne", "data")

## Acceso a los slots
## A diferencia de =$= en listas y =data.frame=, para extraer información de los /slots/ hay que emplear =@= (pero no es recomendable):

eric@name

summary(eric@speed)

## Clases =S4= con slots tipo lista

setClass("flock",
         slots = c(
             name = "character",
             members = "list")
         )

notAFlock <- new("flock",
                 name = "flock0",
                 members = list(eric,
                                3,
                                "hello"))
sapply(notAFlock@members, class)

## Función de validación

valida <- function (object) {
    if (any(sapply(object@members,
                   function(x) !is(x, "bird")))) 
        stop("only bird objects are accepted.")
    return(TRUE)
}

setClass("flock",
         slots = c(
             name = "character",
             members = "list"),
         validity = valida
         )

## Ejemplo de objeto =S4= con slot tipo =list=

newFlock <- function(name, ...){
    birds <- list(...)
    new("flock",
        name = name,
        members = birds)
}

notAFlock <- newFlock("flock0",
                    eric, 2, "hello")

myFlock <- newFlock("flock1",
                    eric, nico, sanne)

## Métodos en =S4=: =setMethod=
## - Normalmente se definen con =setMethod= suministrando:
##   - la clase de los objetos para /esta/ definición del
##     método (=signature=)
##   - la función a ejecutar (=definition=).

setMethod('show',
          signature = "bird",
          definition = function(object)
          {
              cat("Name: ", object@name, "\n")
              cat("Latitude: ", summary(object@lat), "\n")
              cat("Longitude: ", summary(object@lon), "\n")
              cat("Speed: ", summary(object@speed), "\n")
          })

eric

## Métodos en =S4=: =setMethod=

setMethod('show',
          signature = "flock",
          definition = function(object)
          {
              cat("Flock Name: ", object@name, "\n")
              N <- length(object@members)
              lapply(seq_len(N), function(i)
              {
                  cat("Bird #", i, "\n")
                  print(object@members[[i]])
              })
          })

myFlock

## Métodos en =S4=: =setGeneric=
## - Es necesario que exista un método genérico ya definido.

isGeneric("as.data.frame")


## - Si no existe, se define con =setGeneric= (y quizás =standardGeneric=).

setGeneric("as.data.frame")


## - La función =definition= debe respetar los argumentos de la función genérica y en el mismo orden.

getGeneric("as.data.frame")

## Métodos en =S4=: ejemplo con =as.data.frame=

setMethod("as.data.frame",
          signature = "bird",
          definition = function(x, ...)
          {
              data.frame(
                  name = x@name,
                  lat = x@lat,
                  lon = x@lon,
                  alt = x@alt,
                  speed = x@speed,
                  time = x@time)
          })

ericDF <- as.data.frame(eric)

## Métodos en =S4=: ejemplo con =as.data.frame=

setMethod("as.data.frame",
          signature = "flock",
          definition = function(x, ...)
          {
              dfs <- lapply(x@members, as.data.frame)
              dfs <- do.call(rbind, dfs)
              dfs$flock_name <- x@name
              dfs
          })

flockDF <- as.data.frame(myFlock)

## Métodos en =S4=: ejemplo con =xyplot=

library(lattice)

setGeneric("xyplot")

setMethod('xyplot',
          signature = "bird",
          definition = function(x, data = NULL, ...)
          {
              df <- as.data.frame(x)
              xyplot(lat ~ lon, data = df, ...)
          })

xyplot(eric)

## Métodos en =S4=: ejemplo con =xyplot=


setMethod('xyplot',
          signature = "bird",
          definition = function(x, data = NULL,
                                mode = "latlon", ...)
          {
              df <- as.data.frame(x)
              switch(mode,
                     lontime = xyplot(lon ~ time, data = df, ...),
                     lattime = xyplot(lat ~ time, data = df, ...),
                     latlon = xyplot(lat ~ lon, data = df, ...),
                     speed = xyplot(speed ~ time, data = df, ...)
                     )
          })

xyplot(eric, mode = "lontime")

## Métodos en =S4=: ejemplo con =xyplot=


setMethod('xyplot',
          signature = "flock",
          definition = function(x, data = NULL, ...)
          {
              df <- as.data.frame(x)
              xyplot(lon ~ lat,
                     group = name,
                     data = df,
                     auto.key = list(space = "right"))
              })

xyplot(myFlock)

## Clases =S3= con clases y métodos =S4=
## Para usar objetos de clase =S3= en =signatures= de métodos =S4= o
## como contenido de =slots= de una clase =S4= hay que registrarlos con
## =setOldClass=:

setOldClass('lm')

getClass('lm')

## Ejemplo con =lm= y =xyplot=
## Definimos un método genérico para =xyplot=

library(lattice)
setGeneric('xyplot')


## Definimos un método para la clase =lm= usando =xyplot=.

setMethod('xyplot',
          signature = c(x = 'lm',
                        data = 'missing'),
          definition = function(x, data,
                                ...)
          {
              fitted <- fitted(x)
              residuals <- residuals(x)
              xyplot(residuals ~ fitted,...)
          })

## Ejemplo con =lm= y =xyplot=
## Recuperamos la regresión que empleamos en el apartado de Estadística:

lmFertEdu <- lm(Fertility ~ Education, data = swiss)
summary(lmFertEdu)

## Ejemplo con =lm= y =xyplot=


xyplot(lmFertEdu, col='red', pch = 19,
       type = c('p', 'g'))
