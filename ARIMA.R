#Proyecto final

rm(list=ls()) ## Limpiar el entorno de trabajo
setwd("D:/Documents/Andres/ANDES/2.5/ProyectoFinalG2")

#1.  Librerias----
#install.packages("lubridate")
require(pacman)
p_load(tidyverse, # manipular/limpiar conjuntos de datos
       readxl,    # carga datos de excel
       lubridate,  # para fechas
       tseries,
       astsa,
       forecast,
       foreign,
       quantmod
       )

#2.  Descargar datos de mi pc ----
## Informacion desde 1-ene-2018 hasta 30--jun-2022
#Precios bolsa energía eléctrica
Pbol_2018 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2018.xlsx")
Pbol_2019 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2019.xlsx")
Pbol_2020 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2020.xlsx")
Pbol_2021 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2021.xlsx")
Pbol_2022 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2022.xlsx")
#3.  Unir bases de datos ----
#Precios bolsa energía eléctrica
Pbol <- rbind(Pbol_2018,Pbol_2019,Pbol_2020,Pbol_2021,Pbol_2022)
#4.  Limpieza variables ----
#Precios bolsa energía eléctrica
Pbol$Pbol_prom <- rowMeans(Pbol[,2:25])
Pbol <- Pbol[-2:-26]
#5.  Exporta base de datos con variables ----
write.csv(Pbol,file = "Pbol.csv",row.names = F)
#6.  Importa bases de datos consolidados ----
Pbol <- read_csv("Pbol.csv")
#7.  Modelo ARIMA ----

dates <- Pbol$Fecha
Pbol_2 <- Pbol
Pbol_2 <- Pbol_2[-1]

## Create a time series object

Arimar.ts <- ts(Pbol_2,     
           start = c(2018,1,1), 
           frequency = 365)
Arimar.ts

print(Arimar.ts)
class(Arimar.ts)
start(Arimar.ts)
end(Arimar.ts)
plot(Arimar.ts,  main="Serie de tiempo", ylab="Precio", col="navy")

#Requiere comprobar estacionalidad

#Prueba de estacionalidad con una diferencia
seriedif=diff(Arimar.ts)
plot(seriedif)
#Prueba de D.F.
adf.test(seriedif,alternative = "stationary")
# con p-value de 0.01, se comprueba que hay estacionalidad
#comprobar autocorrelacion

acf(ts(seriedif, frequency=1))
pacf(ts(seriedif, frequency=1))

#7.1 Modelo Arima 1 ----
## 1 autoregresivo, 1 diferencia, 1 media movil
modelo1 <- arima(Arimar.ts,order=c(1,1,1))
summary(modelo1)
#tsdiag(modelo1)
Box.test(residuals(modelo1),type="Ljung-Box")
# con p-vale de 0.7893 mayor a .05 ,se puede afirmar que hay ruido blanco, por consiguiente
# nuestro modelo se ajusta bien.
# Ruido blanco significa que el error
# media igual a cero
# Varianza constante
# No estar serialmente correlacionada

#Mirar errores
error=residuals(modelo1)
plot(error, main="Error modelo 1", col="navy")

#Pronosticos Arima
pronostico1_1=forecast::forecast(modelo1,h=30)
pronostico1_1
plot(pronostico1_1, main="Pronóstico modelo 1 a 30 días", ylab="Precio ($/kWh)", col="navy")

pronostico1_2=forecast::forecast(modelo1,h=60)
pronostico1_2
plot(pronostico1_2, main="Pronóstico modelo 1 a 60 días", ylab="Precio ($/kWh)", col="navy")

pronostico1_3=forecast::forecast(modelo1,h=90)
pronostico1_3
plot(pronostico1_3,  main="Pronóstico modelo 1 a 90 días", ylab="Precio ($/kWh)", col="navy")


#7.2 Modelo Arima 2 ----
## 1 autoregresivo, 1 diferencia, 7 media movil
modelo2 <- arima(Arimar.ts,order=c(1,1,7))
summary(modelo2)
#tsdiag(modelo2)
Box.test(residuals(modelo2),type="Ljung-Box")
# con p-vale de 0.7893 mayor a .05 ,se puede afirmar que hay ruido blanco, por consiguiente

#Mirar errores
error=residuals(modelo2)
plot(error, main="Error modelo 2", col="navy")

#Pronosticos Arima
pronostico2_1=forecast::forecast(modelo2,h=30)
pronostico2_1
plot(pronostico2_1, main="Pronóstico modelo 2 a 30 días", ylab="Precio ($/kWh)", col="navy")

pronostico2_2=forecast::forecast(modelo2,h=60)
pronostico2_2
plot(pronostico2_2, main="Pronóstico modelo 2 a 60 días", ylab="Precio ($/kWh)", col="navy")

pronostico2_3=forecast::forecast(modelo2,h=90)
pronostico2_3
plot(pronostico2_3,  main="Pronóstico modelo 2 a 90 días", ylab="Precio ($/kWh)", col="navy")