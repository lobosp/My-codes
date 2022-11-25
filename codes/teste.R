# Date: 09-nov-2022
# Author: Thiago
# Objective: generate matrix of neighboors
# Disclaimer: partially done here and in python

# pacotes
library(rgeos)
library(rgdal)
library(dplyr)
library(sf)

# função para validar vizinhos
plot.vizinhos= function(data, neighbors.list)
{
  lista= c(data$CD_MUN %in% neighbors.list)
  neighborhood= data[lista, ]
  plot(neighborhood["CD_MUN"])
}

# importar mapa
# brazil= readOGR("/Users/thiagopereiralobo/Documents/Data/IBGE/Mapas/br_municipios_2019/BR_Municipios_2019.shp")
# brazil= brazil["CD_MUN"]
brazil= readOGR("/Users/thiagopereiralobo/Desktop/temp/farm-neighbor/AREA_IMOVEL/AREA_IMOVEL.shp")
brazil= brazil["COD_IMOVEL"]

# matriz de vizinhos (atenção: indice inicia no zero)
matriz= gTouches(brazil, byid= TRUE)
matriz= as.data.frame(matriz)

# inlcuir número do município
# matriz$munic7= c(as.numeric(as.character(brazil$CD_MUN)))
matriz$car= brazil$COD_IMOVEL

# definir pasta destino
folder = "/Users/thiagopereiralobo/Documents/PhD/project/current/TechDeforest/analysis/pasture_migration/output/"

# salvar arquivo
write.csv(matriz, paste0(folder, "neighbor-matrix-farm.csv"))
