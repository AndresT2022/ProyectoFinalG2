#Proyecto final

rm(list=ls()) ## Limpiar el entorno de trabajo
setwd("D:/Documents/Andres/ANDES/2.5/ProyectoFinalG2")

#1.  Librerias----
#install.packages("lubridate")
#install.packages("forecast")
require(pacman)
p_load(tidyverse, # manipular/limpiar conjuntos de datos
       readxl,    # carga datos de excel
       lubridate,  # para fechas
       tseries,
       astsa,
       forecast,
       foreign,
       quantmod,LSTS
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

##

## Create a time series object

Arimar.ts <- ts(Pbol_2,     
           start = c(2018,1,1), 
           frequency = 365)

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


#P_Bolsa
train = subset(Arimar.ts,start = 1,end = 1185) 
test = subset(Arimar.ts,start =  1186) 
#validar mejor modelo
modelo_1 <- auto.arima(train, xreg=train, trace=T, D=1,lambda=0)
forecast <- forecast(modelo_1, xreg= test) ; forecast
summary(modelo_1)
autoplot(train,main = 'Forecast precio de bolsa 01-01-2018 a 31-03-2021',xlab = 'Fecha',
         ylab = 'Precio bolsa ($/kWh)')+
  autolayer(forecast,series = 'Precio bolsa predicho')+
  autolayer(test,series = 'Set de prueba abril 2021 en adelante')


Box.test(residuals(modelo_1),type="Ljung-Box")

Box.Ljung.Test(residuals(modelo_1),lag=NULL,main=NULL)

# con p-vale de 0.7131 mayor a .05 ,se puede afirmar que hay ruido blanco, por consiguiente
# nuestro modelo se ajusta bien.
# Ruido blanco significa que el error
# media igual a cero
# Varianza constante
# No estar serialmente correlacionada

#7.1 Modelo Arima 1 ----


#Mirar errores
error=residuals(modelo_1)
plot(error, main="Error modelo 1", col="navy")

#Pronostico 
pronostico1_1 <- forecast::forecast(Arimar.ts,xreg=Arimar.ts,h=30)
pronostico1_1
plot(pronostico1_1, main="Pronóstico modelo 1 a 30 días", ylab="Precio ($/kWh)", col="navy")

autoplot(train,main = 'Forecast precio de bolsa a 30 dias',xlab = 'Fecha',
         ylab = 'Precio bolsa ($/kWh)')+
  autolayer(pronostico1_1,series = 'Precio bolsa predicho')+
  autolayer(test,series = 'Set de prueba abril 2021 en adelante')
