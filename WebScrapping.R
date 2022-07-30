rm(list=ls())
getwd()
install.packages('openxlsx')
library(openxlsx)
library(stringr)
library(plyr)
library(ggvis)
library(knitr)
library(rvest)
library(tidyverse)
library(glue)
library(dplyr)
library(jsonlite)
#library("writexl")

x= "https://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/ONI_v5.php"
#tabla <- read_html(x)%>% html_table() %>% .[[1]]
tabla <- x %>%  read_html() %>%html_nodes(xpath='/html/body/table[4]/tbody/tr/td[2]/table[2]') %>% html_table()
tabla <- tabla[[1]]
colnames(tabla)=tabla[c(1),]
tabla=tabla[-c(1),]
tabla<- subset(tabla, Year != "Year")
tabla<- subset(tabla, Year >= 2010)

write.xlsx(tabla,"ENSO.xlsx", overwrite=TRUE)
