# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# Avg over 4 models plot
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

library(s2dverification)
#library(reshape2)
#library(hash)
#library(RColorBrewer)
#library(rgdal)
#library(leaflet)
#library(raster)


# load data
AvgcorrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/AvgcorrDJF.rds")
AvgcorrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/AvgcorrJJA.rds")

PrAvgcorrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgcorrDJF.rds")
PrAvgcorrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgcorrJJA.rds")

NovLat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLat.rds")
NovLon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")
MayLat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayLat.rds")
MayLon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")



# map interval
interval <- seq(-1, 1, 0.1)

# color
color=c("blue4","blue3","blue","dodgerblue3","dodgerblue2",
        "dodgerblue1","steelblue1","cadetblue2","cadetblue1",
        "white","white","gold","goldenrod","chocolate","orangered","firebrick1",
        "firebrick3","firebrick","firebrick4","red4")

# dot

dot1 <- as.matrix(AvgcorrDJF[,,2,,]>AvgcorrDJF[,,4,,]) ; dot1[is.na(dot1)] <- FALSE     # winter
dot2 <- as.matrix(AvgcorrJJA[,,2,,]>AvgcorrJJA[,,4,,]) ; dot2[is.na(dot2)] <- FALSE
dot3 <- as.matrix(PrAvgcorrDJF[,,2,,]>PrAvgcorrDJF[,,4,,]) ; dot3[is.na(dot3)] <- FALSE # summer
dot4 <- as.matrix(PrAvgcorrJJA[,,2,,]>PrAvgcorrJJA[,,4,,]) ; dot4[is.na(dot4)] <- FALSE


# plot for Nov

postscript("Avg_Corr_OverModels.ps")

layout(matrix(c(1,2,3,4,5,5), 3, 2, byrow = TRUE), respect = TRUE,
       widths=c(2,2), heights=c(2,2,1)) 
#layout.show(m)

# tas
PlotEquiMap(AvgcorrDJF[,,2,,], NovLon, NovLat,
            toptitle = "Winter Temperature Corr- Avg Over Models", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, dots=t(dot1))

PlotEquiMap(AvgcorrJJA[,,2,,], MayLon, MayLat,
            toptitle = "Summer Temperature Corr- Avg Over Models", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, dots=t(dot2))
# prlr
PlotEquiMap(PrAvgcorrDJF[,,2,,], NovLon, NovLat,
            toptitle = "Winter Precipitation Corr- Avg Over Models", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, dots=t(dot3))

PlotEquiMap(PrAvgcorrJJA[,,2,,], MayLon, MayLat,
            toptitle = "Winter Summer Corr- Avg Over Models", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, dots=t(dot4))

ColorBar(interval, cols = color, vert = FALSE , subsampleg = 3, cex = 0.5)

dev.off()




### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
