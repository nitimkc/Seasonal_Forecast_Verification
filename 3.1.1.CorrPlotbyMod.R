# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

library(s2dverification)
#library(reshape2)
#library(hash)
#library(RColorBrewer)
#library(rgdal)
#library(leaflet)
#library(raster)

corrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/corrDJF.rds")
corrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/corrJJA.rds")

NovLat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLat.rds")
NovLon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")
MayLat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayLat.rds")
MayLon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayLon.rds")




# max corr compared to 4 models
corr.max <- apply(corrDJF , c(3,4,5) , function(corrDJF) ifelse(all(is.na(corrDJF)), NA, max(corrDJF, na.rm = TRUE))) 
corr.max.JJA <- apply(corrJJA , c(3,4,5) , function(corrJJA) ifelse(all(is.na(corrJJA)), NA, max(corrJJA, na.rm = TRUE))) 





# index for max corr compared to 4 models
corr.maxInd <- apply(corrDJF , c(3,4,5) , function(corrDJF) ifelse(all(is.na(corrDJF)), NA, which.max(corrDJF))) 
corr.maxInd <- corr.maxInd[2,,]

corr.maxInd.JJA <- apply(corrJJA , c(3,4,5) , function(corrJJA) ifelse(all(is.na(corrJJA)), NA, which.max(corrJJA))) 
corr.maxInd.JJA <- corr.maxInd.JJA[2,,]



# check
#print(c(corrDJF[1,1,2,32,1], corrDJF[2,1,2,32,1], 
        #corrDJF[3,1,2,32,1], corrDJF[4,1,2,32,1]))





# dot for winter
dot1 <- as.matrix(corrDJF[1,1,2,,]>corrDJF[1,1,4,,]) ; dot1[is.na(dot1)] <- FALSE
dot2 <- as.matrix(corrDJF[2,1,2,,]>corrDJF[2,1,4,,]) ; dot2[is.na(dot2)] <- FALSE
dot3 <- as.matrix(corrDJF[3,1,2,,]>corrDJF[3,1,4,,]) ; dot3[is.na(dot3)] <- FALSE
dot4 <- as.matrix(corrDJF[4,1,2,,]>corrDJF[4,1,4,,]) ; dot4[is.na(dot4)] <- FALSE


dot.max <- matrix(NA, 71, 128)
for (i in 1:71) {
  for (j in 1:128) {
    ifelse (corr.maxInd[i,j] == 1, dot.max[i,j] <- dot1[i,j],
            ifelse (corr.maxInd[i,j] == 2, dot.max[i,j] <- dot2[i,j],
                    ifelse (corr.maxInd[i,j] == 3, dot.max[i,j] <- dot3[i,j],
                            ifelse (corr.maxInd[i,j] == 4, dot.max[i,j] <- dot4[i,j],FALSE))))
  }
}
dot.max[is.na(dot.max)] <- FALSE


# dot for summer
dot5 <- as.matrix(corrJJA[1,1,2,,]>corrJJA[1,1,4,,]) ; dot5[is.na(dot5)] <- FALSE
dot6 <- as.matrix(corrJJA[2,1,2,,]>corrJJA[2,1,4,,]) ; dot6[is.na(dot6)] <- FALSE
dot7 <- as.matrix(corrJJA[3,1,2,,]>corrJJA[3,1,4,,]) ; dot7[is.na(dot7)] <- FALSE
dot8 <- as.matrix(corrJJA[4,1,2,,]>corrJJA[4,1,4,,]) ; dot8[is.na(dot8)] <- FALSE


dot.max.JJA <- matrix(NA, 71, 128)
for (i in 1:71) {
  for (j in 1:128) {
    ifelse (corr.maxInd.JJA[i,j] == 1, dot.max.JJA[i,j] <- dot5[i,j],
            ifelse (corr.maxInd.JJA[i,j] == 2, dot.max.JJA[i,j] <- dot6[i,j],
                    ifelse (corr.maxInd.JJA[i,j] == 3, dot.max.JJA[i,j] <- dot7[i,j], dot8[i,j])))
                            #ifelse (corr.maxInd.JJA[i,j] == 4, dot.max.JJA[i,j] <- dot8[i,j],FALSE))))
  }
}
dot.max.JJA[is.na(dot.max.JJA)] <- FALSE



# plot


interval <- seq(0,4,1)
col <- c("#fb8072", "#b3de69", "#80b1d3", "#fdb462")

postscript("Corr_Skill_by_Model.ps")

layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE), 
       respect = TRUE,
       widths=c(1,1), heights=c(1,.25)) 

PlotEquiMap(corr.maxInd, NovLon, NovLat,
            toptitle = "Map of Skill by Model for Winter", sizetit = 0.5,
            #brks = interval, 
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot.max))

PlotEquiMap(corr.maxInd.JJA, MayLon, MayLat,
            toptitle = "Map of Skill by Model for Summer", sizetit = 0.5,
            #brks = interval, 
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot.max.JJA))

ColorBar(interval, cols = col, vert = FALSE , subsampleg = 1, cex = 1)

dev.off()




