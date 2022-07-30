#Proyecto final
#Script Consolidacion de datos y limpieza
rm(list=ls()) ## Limpiar el entorno de trabajo
#1. Librerias----
require(pacman)
p_load(prophet,tidyverse,readxl) 
       
df  <-     
m <- prophet(df)

modelo_final <- add_regressor(m, name, prior.scale = NULL, standardize = "auto", mode = NULL)

g <- cross_validation(
                modelo_final,
                30,
                "months",
                period = 15,
                initial = 40,
                cutoffs = NULL
              )


cvresultados <- performance_metrics(g, metrics = NULL, rolling_window = 0.1) 

plot_cross_validation_metric(cvresultados, metric, rolling_window = 0.1)

       
future <- make_future_dataframe(m, periods = 12, freq="month")
tail(future)

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

plot(m, forecast)


prophet_plot_components(m, forecast)
