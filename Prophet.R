#Proyecto final
#Script Consolidacion de datos y limpieza
rm(list=ls()) ## Limpiar el entorno de trabajo
getwd()
#1. Librerias----
require(pacman)
p_load(prophet,tidyverse,readxl,openxlsx,forecast) 
       
datos  <-  read.xlsx("Base_Datos_2018_V6.xlsx",detectDates=T, sheet= "Hoja1")  
datosfuturos <-read.xlsx("Base_Datos_2018_V6.xlsx",detectDates=T, sheet= "Hoja3") 


df<- datos %>% rename("ds" = "Fecha","y"="P_bolsa") %>% select("ds","y") 
df$P_Henry_Hub <- datos$P_Henry_Hub
df$Aporte_MH <- datos$Por_Aporte_MH
df$Cat_enso <- datos$Cat_enso
#df,daily.seasonality=TRUE
m <- prophet(daily.seasonality=TRUE)
m = add_regressor(m, "P_Henry_Hub")
m = add_regressor(m, "Aporte_MH")
m = add_regressor(m, "Cat_enso")
m <- fit.prophet(m, df)

## Future Dataframe
future <- make_future_dataframe(m, periods = 365, freq="days", include_history = TRUE)
future$P_Henry_Hub  <- datosfuturos$P_Henry_Hub   
future$Aporte_MH  <- datosfuturos$Por_Aporte_MH  
future$Cat_enso  <- datosfuturos$Cat_enso  

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

# Print predictions
cat("\nPredictions:\n")
tail(future)

plot(m, forecast) 

prophet_plot_components(m, forecast)

plot_forecast_component(m, forecast, 'P_Henry_Hub')

plot_forecast_component(m, forecast, 'Cat_enso')


plot_forecast_component(m, forecast, 'Aporte_MH')
