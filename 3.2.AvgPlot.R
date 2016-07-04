# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# Avg over 4 models plot
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

library(s2dverification)
library(easyVerification)

source("/esnas/scratch/nmishra/s2dv_test/3.0.ColorBar.R")


# load data
# ---------

AvgcorrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/AvgcorrDJF.rds")
AvgcorrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/AvgcorrJJA.rds")

PrAvgcorrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgcorrDJF.rds")
PrAvgcorrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgcorrJJA.rds")

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lon.rds")



# map interval/color
# ------------------

int <- seq(-1, 1, 0.1)
ncols <- length(int) -1
int.col <- c(hcl(240, l=seq(20,99,length=ncols/2), c=seq(70,30,length=ncols/2)),
             hcl(10, l=seq(99,20,length=ncols/2), c=seq(30,70,length=ncols/2)))


# dot
# ---
dot1 <- as.matrix(AvgcorrDJF[,,2,,]>AvgcorrDJF[,,4,,]) ; dot1[is.na(dot1)] <- FALSE     # winter
dot2 <- as.matrix(AvgcorrJJA[,,2,,]>AvgcorrJJA[,,4,,]) ; dot2[is.na(dot2)] <- FALSE
dot3 <- as.matrix(PrAvgcorrDJF[,,2,,]>PrAvgcorrDJF[,,4,,]) ; dot3[is.na(dot3)] <- FALSE # summer
dot4 <- as.matrix(PrAvgcorrJJA[,,2,,]>PrAvgcorrJJA[,,4,,]) ; dot4[is.na(dot4)] <- FALSE


# plot 
# -----

postscript("Corr_AvgOverModels.ps")

par(mar=c(.2, 1, .2, 1))
layout(matrix(c(1,1,2,3,4,5,6,6), 4, 2, byrow = TRUE), 
       respect = TRUE, widths=c(3,3), heights=c(.65, 2, 2, .5)) 

  #heading
  plot.new()
  text(0.5,0.5,"Correlation Map for Seasonal Temperature and Precipitation over Europe - \nAverage of Four Models",
       cex=2,font=2)


# tas
  PlotEquiMap(AvgcorrDJF[,,2,,], Lon, Lat,
            toptitle = "Winter - Temperature", sizetit = 0.5,
            brks = int, cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, dots=t(dot1))

  PlotEquiMap(AvgcorrJJA[,,2,,], Lon, Lat,
            toptitle = "Summer - Temperature", sizetit = 0.5,
            brks = int, cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, dots=t(dot2))
# prlr
  PlotEquiMap(PrAvgcorrDJF[,,2,,], Lon, Lat,
            toptitle = "Winter - Precipitation", sizetit = 0.5,
            brks = int, cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, dots=t(dot3))

  PlotEquiMap(PrAvgcorrJJA[,,2,,], Lon, Lat,
            toptitle = "Summer - Precipitation", sizetit = 0.5,
            brks = int, cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, dots=t(dot4))
  
  # int.col
  ColorBar(int, cols=int.col, vert=FALSE, cex = .5, tick=FALSE, 
           upperspace=0.4, lowerspace = .6) 

dev.off()




### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
