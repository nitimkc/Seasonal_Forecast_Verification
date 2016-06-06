# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# Continue from 2.4.Crps.R
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

library(s2dverification)
library(easyVerification)

source("/esnas/scratch/nmishra/s2dv_test/3.0.ColorBar.R")


# load data
# ---------

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")




# map interval/colors
# -------------------

interval <- seq(0,4,1)
col <- c("#fb8072", "#b3de69", "#80b1d3", "#fdb462")




# max corr compared to 4 models
# ------------------------------

Fcrpss.max.DJF <- apply(FCRPSS.DJF , c(2,3,4), function(FCRPSS.DJF) ifelse(all(is.na(FCRPSS.DJF)), NA, max(FCRPSS.DJF, na.rm = TRUE))) 
Fcrpss.max.JJA <- apply(FCRPSS.JJA , c(2,3,4), function(FCRPSS.JJA) ifelse(all(is.na(FCRPSS.JJA)), NA, max(FCRPSS.JJA, na.rm = TRUE)))




# index for max corr compared to 4 models
# ---------------------------------------

FCRPSS.maxInd.DJF <- apply(FCRPSS.DJF , c(2,3,4) , function(FCRPSS.DJF) ifelse(all(is.na(FCRPSS.DJF)), NA, which.max(FCRPSS.DJF))) 
FCRPSS.maxInd.DJF <- FCRPSS.maxInd.DJF[21,,]

FCRPSS.maxInd.JJA <- apply(FCRPSS.JJA , c(2,3,4) , function(FCRPSS.JJA) ifelse(all(is.na(FCRPSS.JJA)), NA, which.max(FCRPSS.JJA))) 
FCRPSS.maxInd.JJA <- FCRPSS.maxInd.JJA[21,,]




# plot for Nov
# ------------  

postscript("Corr_Fair_Skill_by_Model.ps")

layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE), 
       respect = TRUE,
       widths=c(1,1), heights=c(1,.50)) 

PlotEquiMap(FCRPSS.maxInd.DJF, Lon, Lat,
            toptitle = "Map of FairSkill by Model Winter", sizetit = 0.5,
            brks = interval, 
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE)

PlotEquiMap(FCRPSS.maxInd.JJA, Lon, Lat,
            toptitle = "Map of FairSkill by Model Summer", sizetit = 0.5,
            brks = interval, 
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE)

ColorBar(interval, cols=col, vert=FALSE, subsampleg=1, 
         tick=FALSE, upperspace=0.4, cex = 0.5)

dev.off()

#postscript("CRPSS_Nov.ps")
postscript("CRPSS_Temperature.ps")

layout(matrix(c(1,2,3,4,5,6,7,8,9,9,9,9), 3, 4, byrow = TRUE), 
       respect = TRUE,
       widths=c(3,3,3,3), heights=c(3,3,.75)) 


# tas
PlotEquiMap(Fcrpss.max.DJF[21,,], Lon, Lat,
            toptitle = "CRPSS GloSea5 Winter", sizetit = 0.5,
            brks = int, 
            cols = int.col, colNA = "lightgrey",
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE)

PlotEquiMap(CRPSS.ECMWF.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS ECMWF Winter", sizetit = 0.5,
            brks = int, 
            cols = int.col, colNA = "lightgrey",
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot2))

PlotEquiMap(CRPSS.NCEP.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS NCEP Winter", sizetit = 0.5,
            brks = int, 
            cols = int.col, colNA = "lightgrey",
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot3))

PlotEquiMap(CRPSS.MF.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS MF Winter", sizetit = 0.5,
            brks = int, 
            cols = int.col, colNA = "lightgrey",
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot4))


# prlr
#PlotEquiMap(PrCRPSS.GloSea5.DJF$crpss, Lon, Lat,
#          toptitle = "prlr CRPSS GloSea5 Winter", sizetit = 0.5,
#          brks = int, 
#          cols = int.col, colNA = "lightgrey",
#          drawleg = FALSE, numbfig = 4, axelab = FALSE,
#          #labW = FALSE, intylat = 20, intxlon = 20,
#          filled.continents = FALSE, square = TRUE, dots=t(dot5))

#PlotEquiMap(PrCRPSS.ECMWF.DJF$crpss, Lon, Lat,
#          toptitle = "prlr CRPSS ECMWF Winter", sizetit = 0.5,
#          brks = int, 
#          cols = int.col, colNA = "lightgrey",
#          drawleg = FALSE, numbfig = 4, axelab = FALSE,
#          #labW = FALSE, intylat = 20, intxlon = 20,
#          filled.continents = FALSE, square = TRUE, dots=t(dot6))

#PlotEquiMap(PrCRPSS.NCEP.DJF$crpss, Lon, Lat,
#          toptitle = "prlr CRPSS NCEP Winter", sizetit = 0.5,
#          brks = int, 
#          cols = int.col, colNA = "lightgrey",
#          drawleg = FALSE, numbfig = 4, axelab = FALSE,
#          #labW = FALSE, intylat = 20, intxlon = 20,
#          filled.continents = FALSE, square = TRUE, dots=t(dot7))

#PlotEquiMap(PrCRPSS.MF.DJF$crpss, Lon, Lat,
#          toptitle = "prlr CRPSS MF Winter", sizetit = 0.5,
#          brks = int, 
#          cols = int.col, colNA = "lightgrey",
#          drawleg = FALSE, numbfig = 4, axelab = FALSE,
#          #labW = FALSE, intylat = 20, intxlon = 20,
#          filled.continents = FALSE, square = TRUE, dots=t(dot8))

# color
#ColorBar(int, cols=int.col, vert=FALSE, subsampleg=.5, 
#ColorBar(int, cols=int.col, vert=FALSE, subsampleg=1, 
#       tick=FALSE, upperspace=0.4, cex = 0.5)

#dev.off()




# plot for May
# ------------  

#postscript("CRPSS_Nov.ps")
#postscript("CRPSS_Temperature.ps")

#layout(matrix(c(1,2,3,4,5,6,7,8,9,9,9,9), 3, 4, byrow = TRUE), 
#       respect = TRUE,
#       widths=c(3,3,3,3), heights=c(3,3,.75)) 


# tas
PlotEquiMap(CRPSS.GloSea5.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS GloSea5 Summer", sizetit = 0.5,
            brks = int, 
            cols = int.col, colNA = "lightgrey",
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot9))

PlotEquiMap(CRPSS.ECMWF.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS ECMWF Summer", sizetit = 0.5,
            brks = int, 
            cols = int.col, colNA = "lightgrey",
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot10))

PlotEquiMap(CRPSS.NCEP.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS NCEP Summer", sizetit = 0.5,
            brks = int, 
            cols = int.col, colNA = "lightgrey",
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot11))

PlotEquiMap(CRPSS.MF.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS MF Summer", sizetit = 0.5,
            brks = int, 
            cols = int.col, colNA = "lightgrey",
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot12))


# prlr
#PlotEquiMap(PrCRPSS.GloSea5.JJA$crpss, Lon, Lat,
#          toptitle = "prlr CRPSS GloSea5 Summer", sizetit = 0.5,
#          brks = int, 
#          cols = int.col, colNA = "lightgrey",
#          drawleg = FALSE, numbfig = 4, axelab = FALSE,
#          #labW = FALSE, intylat = 20, intxlon = 20,
#          filled.continents = FALSE, square = TRUE, dots=t(dot13))

#PlotEquiMap(PrCRPSS.ECMWF.JJA$crpss, Lon, Lat,
#          toptitle = "prlr CRPSS ECMWF Summer", sizetit = 0.5,
#          brks = int, 
#          cols = int.col, colNA = "lightgrey",
#          drawleg = FALSE, numbfig = 4, axelab = FALSE,
#          #labW = FALSE, intylat = 20, intxlon = 20,
#          filled.continents = FALSE, square = TRUE, dots=t(dot14))

#PlotEquiMap(PrCRPSS.NCEP.JJA$crpss, Lon, Lat,
#          toptitle = "prlr CRPSS NCEP Summer", sizetit = 0.5,
#          brks = int, 
#          cols = int.col, colNA = "lightgrey",
#          drawleg = FALSE, numbfig = 4, axelab = FALSE,
#          #labW = FALSE, intylat = 20, intxlon = 20,
#          filled.continents = FALSE, square = TRUE, dots=t(dot15))

#PlotEquiMap(PrCRPSS.MF.JJA$crpss, Lon, Lat,
#          toptitle = "prlr CRPSS MF Summer", sizetit = 0.5,
#          brks = int, 
#         cols = int.col, colNA = "lightgrey",
#          drawleg = FALSE, numbfig = 4, axelab = FALSE,
#          #labW = FALSE, intylat = 20, intxlon = 20,
#          filled.continents = FALSE, square = TRUE, dots=t(dot16))

#colorbar
ColorBar(int, cols=int.col, vert=FALSE, subsampleg=1, 
         tick=FALSE, upperspace=0.4, cex = 0.5)

dev.off()




### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
