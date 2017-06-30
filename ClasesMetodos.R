## Clases
## Los objetos básicos en =R= tienen una clase implícita definida en =S3=. Es accesible con =class=.

  x <- rnorm(10)
  class(x)


## Pero no tienen atributo ni se consideran formalmente objetos:

attr(x, 'class')

is.object(x)

## Clases
## Se puede redefinir la clase de un objecto =S3= con =class=

  class(x) <- 'myNumeric'
  class(x)


## Ahora sí es un objeto y su atributo está definido:

attr(x, 'class')

is.object(x)


## Sin embargo, su modo de almacenamiento (clase intrínseca) no cambia:

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
## - =UseMethod= sirve para elegir el método correspondiente a la clase
##   del objeto empleado como argumento en la función.

## - Se debe definir un método genérico, incluyendo llamada a
##   =UseMethod=.

summary



## - Si no hay un método definido para la clase del objeto, =UseMethod= ejecuta la función por defecto:

summary.default

## Métodos genéricos: =UseMethod=


  myFun <- function(x, ...)UseMethod('myFun')
  myFun.default <- function(x, ...){
    cat('Funcion genérica\n')
    print(x)
    }

x <- rnorm(10)
myFun(x)

myFun(task1)

## =methods=
## Con =methods= podemos averiguar los métodos que hay definidos para una función particular:

methods('myFun')

methods('summary')

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

myFun(task1)

methods(myFun)

methods(class='Task')

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

setClass('task',
         slots = c(
             what = 'character',
             when = 'Date',
             priority = 'character')
         )

getClass('task')

getSlots('task')

slotNames('task')

## Creación de un objeto con la clase definida: =new=
## Una vez que la clase ha sido definida con =setClass=, se puede crear un objeto nuevo con =new=.

task1 <- new('task',
             what='Find and fix bugs',
             when=as.Date('2013-03-15'),
             priority='High')

task1

## Funciones para crear objetos
## Es habitual definir funciones que construyen y modifican objetos
## para evitar el uso de =new=:

createTask <- function(what, when, priority){
    new('task',
        what = what,
        when = when,
        priority = priority)
    }

task2 <- createTask(what = 'Write an email',
                    when = as.Date('2013-01-01'),
                    priority = 'Low')

createTask('Oops', 'Hoy', 3)

## Definición de la clase =ToDo=

setClass('ToDo',
         slots = c(tasks = 'list')
         )

myList <- new('ToDo',
              tasks = list(
                  t1 = task1,
                  t2 = task2))

## Acceso a los slots
## Para extraer información de los /slots/ hay que emplear =@= (a
## diferencia de =$= en listas y =data.frame=)

myList@tasks

## Acceso a los slots
## El /slot/ =tasks= es una lista: empleamos =$= para acceder a sus elementos

myList@tasks$t1


## Cada elemento de =tasks= es un objeto de clase =task=: empleamos
## =@= para extraer sus /slots/.

myList@tasks$t1@what

## Problema con los slots definidos como =list=
## Dado que el slot =tasks= es una =list=, podemos añadir cualquier
## cosa. 

  myListOops <- new('ToDo',
                    tasks=list(t1='Tarea1',
                      task1, task2))

## Validación
## Para obligar a que sus elementos sean de clase =task= debemos añadir
## una función de validación.

valida <- function (object) {
    if (any(sapply(object@tasks,
                   function(x) !is(x, "task")))) 
        stop("not a list of task objects")
    return(TRUE)
}

setClass('ToDo',
         slots = c(tasks = 'list'),
         validity=valida
         )

myListOops <- new('ToDo',
                  tasks=list(t1='Tarea1',
                             task1, task2))

## Funciones para crear y modificar objetos

createToDo <- function(){
    new('ToDo')
}

addTask <- function(object, task){
    ## La siguiente comprobación sólo es necesaria si la
    ## definición de la clase *no* incorpora una función 
    ## validity
    stopifnot(is(task,'task'))
    object@tasks <- c(object@tasks, task)
    object
}

## Métodos en =S4=: =setMethod=
## - Normalmente se definen con =setMethod=.
## - Hay que definir:
##   - la =signature= (clase de los argumentos para /esta/ definición del
##     método)
##   - la función a ejecutar (=definition=).
## - Es necesario que exista un método genérico ya definido. Si no
##   existe, se define con =setGeneric= y =standardGeneric=

setGeneric('myMethod',
           function(x, y, ...)
               standardGeneric('myMethod')
           )

setGeneric('print')

## Métodos en =S4=: =setGeneric= y =getGeneric=
## Si ya existe un método genérico, la función =definition= debe tener
## todos los argumentos de la función genérica y en el mismo orden.


library(lattice)  
isGeneric('xyplot')

getGeneric('xyplot')

## Definición de un método =print= para =task=

setMethod('print', signature = 'task',
          definition = function(x, ...){
              cat('What: ', x@what,
                  '- When:', as.character(x@when),
                  '- Priority:', x@priority,
                  '\n')
          })

  print(task1)

## Definición de un método =print= para =ToDo=

setMethod('print', signature='ToDo',
          definition = function(x, ...){
              cat('This is my ToDo list:\n')
              tasksList <- x@tasks
              for (i in seq_along(tasksList)) {
                  cat('No.', i, ':')
                  print(tasksList[[i]])
              }
              cat('--------------------\n')
          })

  print(myList)

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
