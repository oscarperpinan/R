
## Construimos un ejemplo

  N <- 100
  edad <- sample(seq(18, 40, 1), N, replace=TRUE)
  summary(edad)

  sexo <- sample(c('H', 'M'), N, replace=TRUE)
  class(sexo)
  summary(sexo)

## Una variable cualitativa se define con =factor=

  sexo <- factor(sexo)

  class(sexo)

  summary(sexo)

  levels(sexo)

  nlevels(sexo)

## Los =factor= sirven para agrupar
## - Con la función =table=

  table(edad > 30, sexo)

  table(edad %in% 20:30, sexo)

## Los =factor= sirven para agrupar
## - Con =tapply= o =aggregate=

tapply(edad, sexo, mean)

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
## - =help(format.POSIXct)=

  as.POSIXct('2013-02-06')

  ISOdate(2013, 2, 7)

hoy <- as.POSIXct('2013-02-06')

format(hoy, '%Y')

format(hoy, '%d')

format(hoy, '%m')

format(hoy, '%b')

format(hoy, '%d de %B de %Y')

## =POSIxct=

  hora <- Sys.time()
  hora

  format(hora, '%H:%M:%S')

  format(hora, '%H horas, %M minutos y %S segundos')

## Secuencias temporales con =POSIXct=

seq(as.POSIXct('2004-01-01'), by='month', length=10)

seq(as.POSIXct('2004-01-01 10:00:00'), by='15 min', length=10)

## Zonas horarias

  as.POSIXct('2013-02-06 15:30:00',
             tz='GMT')

  as.POSIXct('2013-02-06 15:30:00',
             tz='Europe/Madrid')

hawaii <- as.POSIXct('2013-02-06 15:30:00', tz='HST')
## Character
format(hawaii, tz='GMT')

## POSIXct
as.POSIXct(format(hawaii, tz='GMT'), tz='GMT')

## Bastan unas simples comillas

  cadena <- "Hola mundo"
  class(cadena)

  nchar(cadena)

## Un vector de =character=

  cadenaVec <- c("Hola mundo", "Hello world")
  nchar(cadenaVec)

  length(cadenaVec)

cadenaVec[1]

## Para mostrarlos usamos =cat= o =print=

  a <- 2
  b <- 3

  cat('La suma de', a, 'y', b, 'es', a + b, fill=TRUE)

  cat('La suma de', a, 'y', b, 'es', a + b, '\n',
      'La multiplicación de', a, 'por', b, 'es', a*b, '\n')

## Los =character= se pueden unir...

  paste('Hello', 'World', sep='_')

  paste('X', 1:5, sep='.')

  paste(c('A', 'B'), 1:5, sep='.')

  paste(c('A', 'B'), 1:5, sep='.', collapse='|')

## ... y también se pueden separar...

  strsplit(cadenaVec, split=' ')

  strsplit(cadenaVec, split='')

  chSep <- strsplit(cadenaVec, split=' ')
  class(chSep)

  length(chSep)

  sapply(chSep, nchar)

## ... y, por supuesto, manipular

  sub('o', '0', 'Hola Mundo')

  gsub('o', '0', 'Hola Mundo')

  substring(cadena, 1) <- 'HOLA'
  cadena

  tolower(cadena)

  toupper(cadena)
