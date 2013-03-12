
## Conjunto de datos: swiss

data(swiss)

summary(swiss)

## **
## #+ATTR_LATEX: width=0.6\textwidth

pdf(file="splomSwiss.pdf")
splom(swiss, pscale=0, type=c('p', 'smooth'),
      groups=swiss$Catholic > 50, xlab='')
dev.off()

## Resumir información

summary(swiss)

mean(swiss$Fertility)

colMeans(swiss)

## Resumir información

sd(swiss$Fertility)

sapply(swiss, sd)

## Generar datos aleatorios

rnorm(10, mean=1, sd=.4)

runif(10, min=-3, max=3)

rweibull(n=10, shape=3, scale=2)

## Generar datos aleatorios

x <- seq(1, 100, length=10)
x

sample(x)

sample(x, 5)

sample(x, 5, replace=TRUE)

## Tests

t.test(swiss$Fertility, mu=70)

wilcox.test(swiss$Fertility, mu=70)

## Tests

A <- rnorm(1000)
B <- rnorm(1000)
C <- rnorm(1000, sd=3)

t.test(A, B)

wilcox.test(A, B)

## Tests

t.test(A, C)

wilcox.test(A, C)

## Tests

Religion <- ifelse(swiss$Catholic > 50,
                   'Catholic', 'Protestant')

t.test(Fertility ~ Religion, data=swiss)

wilcox.test(Fertility ~ Religion, data=swiss)

## Fertilidad y educación

lmFertEdu <- lm(Fertility ~ Education, data = swiss)
summary(lmFertEdu)

## Fertilidad y educación

coef(lmFertEdu)

residuals(lmFertEdu)

fitted.values(lmFertEdu)

## Fertilidad, educación y religión

lmFertEduCat <- lm(Fertility ~ Education + Catholic,
                   data = swiss)
summary(lmFertEduCat)

## Lo mismo con =update=

lmFertEduCat <- update(lmFertEdu, . ~ . + Catholic,
                       data = swiss)
summary(lmFertEduCat)

## Fertilidad, educación, religión y agricultura

lmFertEduCatAgr <- lm(Fertility ~ Education + Catholic + Agriculture,
                      data = swiss)
summary(lmFertEduCatAgr)

## Lo mismo con =update=

lmFertEduCatAgr <- update(lmFertEduCat, . ~ . + Agriculture,
                          data = swiss)
summary(lmFertEduCatAgr)

## Lo mismo con =update=

lmFertEduCatAgr <- update(lmFertEdu, . ~ . + Catholic + Agriculture,
                          data = swiss)
summary(lmFertEduCatAgr)

## anova

anova(lmFertEdu, lmFertEduCat, lmFertEduCatAgr)

## Fertilidad contra todo

lmFert <- lm(Fertility ~ ., data=swiss)

summary(lmFert)

## Elegir un modelo

anova(lmFert)

## Elegir un modelo

stepFert <- step(lmFert)

## Elegir un modelo

summary(stepFert)

## Elegir un modelo

stepFert$anova
