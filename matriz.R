#install.packages(c('tidyverse','neuralnet', 'caret'))
library(neuralnet)
library(tidyverse)
library(caret)
data = iris
muestra = createDataPartition(data$Species,p=0.8, list=F)
train = data[muestra,]
test = data[-muestra,]
red.neuronal = neuralnet(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data=train, hidden = c(2,3))
red.neuronal$act.fct
plot(red.neuronal)

#Aplicar el conjunto de pruebas a la red para predecir la especie
prediccion = predict(red.neuronal, test, type='class')

#Decodificar columna que ocntiene el valor maxiom y por ende la especie
decodificar.col = apply(prediccion, 1, which.max)

codificado = data_frame(decodificar.col)
codificado = mutate(codificado, especie=recode(codificado$decodificar.col, "1"="Setosa", "2"="versicolor", "3"="virginica"))
test$Species = codificado$especie


#virtualizar pesos
red.neuronal$weights

