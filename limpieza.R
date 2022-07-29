#Proyecto final
rm(list=ls()) ## Limpiar el entorno de trabajo

#1. Librerias----
require(pacman)
p_load(tidyverse, # manipular/limpiar conjuntos de datos.
       readxl      #carga datos de excel
      )
#2. Descargar datos de mi pc ----
## Informacion desde 1-ene-2018 hasta 30--jun-2022
#Precio Henry Hub, gas internacional
Henry_Hub <- read_excel("Precio_Henry_Hub.xls")
#Aportes diarios hidricos
Aportes_Diario_2018 <- read_excel("Aportes_Diario_2018.xlsx")
Aportes_Diario_2019 <- read_excel("Aportes_Diario_2019.xlsx")
Aportes_Diario_2020 <- read_excel("Aportes_Diario_2020.xlsx")
Aportes_Diario_2021 <- read_excel("Aportes_Diario_2021.xlsx")
Aportes_Diario_2022 <- read_excel("Aportes_Diario_2022.xlsx")
#Aportes mensuales hidricos (aportes historicos)
Aportes_Mensual_2018 <- read_excel("Aportes_Mensual_2018.xlsx")
Aportes_Mensual_2019 <- read_excel("Aportes_Mensual_2019.xlsx")
Aportes_Mensual_2020 <- read_excel("Aportes_Mensual_2020.xlsx")
Aportes_Mensual_2021 <- read_excel("Aportes_Mensual_2021.xlsx")
Aportes_Mensual_2022 <- read_excel("Aportes_Mensual_2022.xlsx")
#Capacidad Efectiva Neta - CEN de generadores (calcular % indisponibilidad generadores)
CEN_2018 <- read_excel("Capacidad_Efectiva_Neta_(kW)_2018.xlsx")
CEN_2019 <- read_excel("Capacidad_Efectiva_Neta_(kW)_2019.xlsx")
CEN_2020 <- read_excel("Capacidad_Efectiva_Neta_(kW)_2020.xlsx")
CEN_2021 <- read_excel("Capacidad_Efectiva_Neta_(kW)_2021.xlsx")
CEN_2022 <- read_excel("Capacidad_Efectiva_Neta_(kW)_2022.xlsx")
#Disponibilidad (calcular % indisponibilidad generadores)
Disponibilidad_2018 <- read_excel("Disponibilidad_Comercial_(kW)_2018.xlsx")
Disponibilidad_2019 <- read_excel("Disponibilidad_Comercial_(kW)_2019.xlsx")
Disponibilidad_2020 <- read_excel("Disponibilidad_Comercial_(kW)_2020.xlsx")
Disponibilidad_2021 <- read_excel("Disponibilidad_Comercial_(kW)_2021.xlsx")
Disponibilidad_2022 <- read_excel("Disponibilidad_Comercial_(kW)_2022.xlsx")
#Generación
Generacion_2018 <- read_excel("Generacion_(kWh)_2018.xlsx")
Generacion_2019 <- read_excel("Generacion_(kWh)_2019.xlsx")
Generacion_2020 <- read_excel("Generacion_(kWh)_2020.xlsx")
Generacion_2021 <- read_excel("Generacion_(kWh)_2021.xlsx")
Generacion_2022 <- read_excel("Generacion_(kWh)_2022.xlsx")
#Precios bolsa energía eléctrica
Pbol_2018 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2018.xlsx")
Pbol_2019 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2019.xlsx")
Pbol_2020 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2020.xlsx")
Pbol_2021 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2021.xlsx")
Pbol_2022 <- read_excel("Precio_Bolsa_Nacional_($kwh)_2022.xlsx")
#Reservas hidricas (calcular % de los embalses)
Reservas_2018 <- read_excel("Reservas_Diario_2018.xlsx")
Reservas_2019 <- read_excel("Reservas_Diario_2019.xlsx")
Reservas_2020 <- read_excel("Reservas_Diario_2020.xlsx")
Reservas_2021 <- read_excel("Reservas_Diario_2021.xlsx")
Reservas_2022 <- read_excel("Reservas_Diario_2022.xlsx")
#3. Unir bases de datos ----
#Aportes diarios hidricos
Aportes <- rbind(Aportes_Diario_2018,Aportes_Diario_2019,Aportes_Diario_2020,
                 Aportes_Diario_2021,Aportes_Diario_2022)
#Aportes mensuales hidricos (aportes historicos)
Aportes_Mensual <- rbind(Aportes_Mensual_2018,Aportes_Mensual_2019,Aportes_Mensual_2020,
                         Aportes_Mensual_2021,Aportes_Mensual_2022)
#Capacidad Efectiva Neta - CEN de generadores (calcular % indisponibilidad generadores)
CEN <- rbind(CEN_2018,CEN_2019,CEN_2020,CEN_2021,CEN_2022)
#Disponibilidad (calcular % indisponibilidad generadores)
Disp <- rbind(Disponibilidad_2018,Disponibilidad_2019,Disponibilidad_2020,
              Disponibilidad_2021,Disponibilidad_2022)
#Generación
Gen <- rbind(Generacion_2018,Generacion_2019,Generacion_2020,
             Generacion_2021,Generacion_2022)
#Precios bolsa energía eléctrica
Pbol <- rbind(Pbol_2018,Pbol_2018,Pbol_2019,Pbol_2020,Pbol_2021,Pbol_2022)
#Reservas hidricas (calcular % de los embalses)
Reservas <- rbind(Reservas_2018,Reservas_2019,Reservas_2020,Reservas_2021,Reservas_2022)
#4. Limpieza variables pendiente@@@@@@@@@@@@@@@@@@@@@@ ----
#5. Exporta base de datos con variables ----
saveRDS(Aportes,file = "Aportes.rds")
saveRDS(Aportes_Mensual,file = "Aportes_Mensual.rds")
saveRDS(CEN,file = "CEN.rds")
saveRDS(Disp,file = "Disp.rds")
saveRDS(Gen,file = "Gen.rds")
saveRDS(Pbol,file = "Pbol.rds")
saveRDS(Henry_Hub,file = "Henry_Hub.rds")

