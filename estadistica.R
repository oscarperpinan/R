
## #+TITLE:     Estadística básica con R
## #+AUTHOR:    Oscar Perpiñán Lamigueiro
## #+EMAIL:     oscar.perpinan@gmail.com
## #+DATE: Febrero de 2013
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
## #+LATEX_HEADER: \AtBeginSection[]{\begin{frame}<beamer>\frametitle{Contenidos}\tableofcontents[currentsection]\end{frame}}
## #+LATEX_HEADER: \lstset{keywordstyle=\color{blue}, commentstyle=\color{gray!90}, basicstyle=\ttfamily\footnotesize, columns=fullflexible, breaklines=false,linewidth=\textwidth, backgroundcolor=\color{gray!23}, basewidth={0.5em,0.4em}, literate={á}{{\'a}}1 {ñ}{{\~n}}1 {é}{{\'e}}1 {ó}{{\'o}}1 {º}{{\textordmasculine}}1}
## #+LATEX_HEADER: \usepackage{mathpazo}
## #+LATEX_HEADER: \setbeamercovered{transparent}
## #+LATEX_HEADER: \usefonttheme{serif} 
## #+LATEX_HEADER: \usetheme{Goettingen}
## #+PROPERTY:  tangle yes
## #+PROPERTY:  comments org
## #+PROPERTY: results output
## #+PROPERTY: session *R*
## #+PROPERTY: exports both
## #+LATEX_HEADER: \usepackage{fancyvrb}
## #+LATEX_HEADER: \DefineVerbatimEnvironment{verbatim}{Verbatim}{fontsize=\tiny, formatcom = {\color{black!70}}}

setwd('~/R/intro')

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
