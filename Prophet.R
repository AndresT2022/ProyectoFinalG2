#Proyecto final
#Script Consolidacion de datos y limpieza
rm(list=ls()) ## Limpiar el entorno de trabajo
#1. Librerias----
require(pacman)
p_load(prophet,tidyverse,readxl,openxlsx) 
       
datos  <-  read.xlsx("Base_Datos_2018_Alejandro.xlsx",detectDates=T)  
df<- datos %>% rename("ds" = "Fecha","y"="P_bolsa") %>% select("ds","y") 
df$P_Henry_Hub <- datos$P_Henry_Hub
df$Aporte_MH <- datos$"Aporte/MH"
#df,daily.seasonality=TRUE
m <- prophet(yearly.seasonality=TRUE)
m = add_regressor(m, "P_Henry_Hub")
m = add_regressor(m, "Aporte_MH")
m <- fit.prophet(m, df)

## Future Dataframe
future <- make_future_dataframe(m, periods = 365, freq="days")
future$P_Henry_Hub  <- df$P_Henry_Hub  
future$Aporte_MH  <- df$Aporte_MH  


forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

# Print predictions
cat("\nPredictions:\n")
tail(future)

plot(m, forecast)
