# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# CRPSS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

library(s2dverification)
library(easyVerification)
library(fields)
#library(reshape2)
#library(hash)
#library(RColorBrewer)
#library(rgdal)
#library(leaflet)
#library(raster)

# load data
# ---------

DJF.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Exp.rds")
DJF.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Obs.rds")
JJA.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Exp.rds")
JJA.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Obs.rds")

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")




# replace values less than 0 with NA
# -----------------------------------

CRPSS.GloSea5.DJF$crpss[CRPSS.GloSea5.DJF$crpss <= -1] <- NA
CRPSS.GloSea5.JJA$crpss[CRPSS.GloSea5.JJA$crpss <= -1] <- NA

CRPSS.ECMWF.DJF$crpss[CRPSS.ECMWF.DJF$crpss <= -1] <- NA
CRPSS.ECMWF.JJA$crpss[CRPSS.ECMWF.JJA$crpss <= -1] <- NA

CRPSS.NCEP.DJF$crpss[CRPSS.NCEP.DJF$crpss <= -1] <- NA
CRPSS.NCEP.JJA$crpss[CRPSS.NCEP.JJA$crpss <= -1] <- NA

CRPSS.MF.DJF$crpss[CRPSS.MF.DJF$crpss <= -1] <- NA
CRPSS.MF.JJA$crpss[CRPSS.MF.JJA$crpss <= -1] <- NA




# map interval/colors
# -------------------

int <- seq(-1,1,.1)
ncols <- length(int) -1
int.col <- c(hcl(240, l=seq(20,99,length=ncols/2), c=seq(70,30,length=ncols/2)),
             hcl(10, l=seq(99,20,length=ncols/2), c=seq(30,70,length=ncols/2)))




# dot
# ---

  # winter
  dot1 <- as.matrix(CRPSS.GloSea5.DJF$crpss > CRPSS.GloSea5.DJF$crpss.sigma*qnorm(0.95)); dot1[is.na(dot1)] <- FALSE
  dot2 <- as.matrix(CRPSS.ECMWF.DJF$crpss > CRPSS.ECMWF.DJF$crpss.sigma*qnorm(0.95)); dot2[is.na(dot2)] <- FALSE
  dot3 <- as.matrix(CRPSS.NCEP.DJF$crpss > CRPSS.NCEP.DJF$crpss.sigma*qnorm(0.95)); dot3[is.na(dot3)] <- FALSE
  dot4 <- as.matrix(CRPSS.MF.DJF$crpss > CRPSS.MF.DJF$crpss.sigma*qnorm(0.95)); dot4[is.na(dot4)] <- FALSE

  # summer
  dot9 <- as.matrix(CRPSS.GloSea5.JJA$crpss > CRPSS.GloSea5.JJA$crpss.sigma*qnorm(0.95)); dot9[is.na(dot9)] <- FALSE
  dot10 <- as.matrix(CRPSS.ECMWF.JJA$crpss > CRPSS.ECMWF.JJA$crpss.sigma*qnorm(0.95)); dot10[is.na(dot10)] <- FALSE
  dot11 <- as.matrix(CRPSS.NCEP.JJA$crpss > CRPSS.NCEP.JJA$crpss.sigma*qnorm(0.95)); dot11[is.na(dot11)] <- FALSE
  dot12 <- as.matrix(CRPSS.MF.JJA$crpss > CRPSS.MF.JJA$crpss.sigma*qnorm(0.95)); dot12[is.na(dot12)] <- FALSE

  
  
  
# plot for Nov
# ------------  

#postscript("CRPSS_Nov.ps")
postscript("CRPSS_Temperature.ps")

layout(matrix(c(1,2,3,4,5,6,7,8,9,9,9,9), 3, 4, byrow = TRUE), 
       respect = TRUE,
       widths=c(3,3,3,3), heights=c(3,3,2)) 


  # tas
  PlotEquiMap(CRPSS.GloSea5.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS GloSea5 Winter", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot1))

  PlotEquiMap(CRPSS.ECMWF.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS ECMWF Winter", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot2))

  PlotEquiMap(CRPSS.NCEP.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS NCEP Winter", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot3))

  PlotEquiMap(CRPSS.MF.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS MF Winter", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot4))


  # prlr
  PlotEquiMap(PrCRPSS.GloSea5.DJF$crpss, Lon, Lat,
            toptitle = "prlr CRPSS GloSea5 Winter", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot1))

  PlotEquiMap(PrCRPSS.ECMWF.DJF$crpss, Lon, Lat,
            toptitle = "prlr CRPSS ECMWF Winter", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot2))

  PlotEquiMap(PrCRPSS.NCEP.DJF$crpss, Lon, Lat,
            toptitle = "prlr CRPSS NCEP Winter", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot3))

  PlotEquiMap(PrCRPSS.MF.DJF$crpss, Lon, Lat,
            toptitle = "prlr CRPSS MF Winter", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot4))

  # color
  ColorBar(interval, cols = color, vert = FALSE , subsampleg = 3, cex = 0.5)
  
dev.off()




# plot for May
# ------------  

#postscript("CRPSS_Nov.ps")
postscript("CRPSS_Temperature.ps")

layout(matrix(c(1,2,3,4,5,6,7,8,9,9,9,9), 3, 4, byrow = TRUE), 
       respect = TRUE,
       widths=c(3,3,3,3), heights=c(3,3,2)) 


  # tas
  PlotEquiMap(CRPSS.GloSea5.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS GloSea5 Summer", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot9))

  PlotEquiMap(CRPSS.ECMWF.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS ECMWF Summer", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot10))

  PlotEquiMap(CRPSS.NCEP.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS NCEP Summer", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot11))

  PlotEquiMap(CRPSS.MF.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS MF Summer", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot12))


  # prlr
  PlotEquiMap(PrCRPSS.GloSea5.JJA$crpss, Lon, Lat,
            toptitle = "prlr CRPSS GloSea5 Summer", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot9))

  PlotEquiMap(PrCRPSS.ECMWF.JJA$crpss, Lon, Lat,
            toptitle = "prlr CRPSS ECMWF Summer", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot10))

  PlotEquiMap(PrCRPSS.NCEP.JJA$crpss, Lon, Lat,
            toptitle = "prlr CRPSS NCEP Summer", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot11))

  PlotEquiMap(PrCRPSS.MF.JJA$crpss, Lon, Lat,
            toptitle = "prlr CRPSS MF Summer", sizetit = 0.5,
            #brks = interval, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot12))
  
  #colorbar
  ColorBar(int, cols = int.col, vert = FALSE , subsampleg = 3, cex = 0.5)

dev.off()




### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 

