# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# Continue from 2.4.Crps.R
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

#library(s2dverification)
#library(easyVerification)

source("/esnas/scratch/nmishra/s2dv_test/3.0.ColorBar.R")

# load data
# ---------

# continue from 2.4.Crps.R

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")




# dot
# ---

  # winter tas
  dot1 <- as.matrix(CRPSS.GloSea5.DJF$crpss > CRPSS.GloSea5.DJF$crpss.sigma*qnorm(0.95)); dot1[is.na(dot1)] <- FALSE
  dot2 <- as.matrix(CRPSS.ECMWF.DJF$crpss > CRPSS.ECMWF.DJF$crpss.sigma*qnorm(0.95)); dot2[is.na(dot2)] <- FALSE
  dot3 <- as.matrix(CRPSS.NCEP.DJF$crpss > CRPSS.NCEP.DJF$crpss.sigma*qnorm(0.95)); dot3[is.na(dot3)] <- FALSE
  dot4 <- as.matrix(CRPSS.MF.DJF$crpss > CRPSS.MF.DJF$crpss.sigma*qnorm(0.95)); dot4[is.na(dot4)] <- FALSE
  
  # winter prlr
  #dot5 <- as.matrix(PrCRPSS.GloSea5.DJF$crpss > PrCRPSS.GloSea5.DJF$crpss.sigma*qnorm(0.95)); dot5[is.na(dot5)] <- FALSE
  #dot6 <- as.matrix(PrCRPSS.ECMWF.DJF$crpss > PrCRPSS.ECMWF.DJF$crpss.sigma*qnorm(0.95)); dot6[is.na(dot6)] <- FALSE
  #dot7 <- as.matrix(PrCRPSS.NCEP.DJF$crpss > PrCRPSS.NCEP.DJF$crpss.sigma*qnorm(0.95)); dot7[is.na(dot7)] <- FALSE
  #dot8 <- as.matrix(PrCRPSS.MF.DJF$crpss > PrCRPSS.MF.DJF$crpss.sigma*qnorm(0.95)); dot8[is.na(dot8)] <- FALSE
  
  # summer tas
  dot9 <- as.matrix(CRPSS.GloSea5.JJA$crpss > CRPSS.GloSea5.JJA$crpss.sigma*qnorm(0.95)); dot9[is.na(dot9)] <- FALSE
  dot10 <- as.matrix(CRPSS.ECMWF.JJA$crpss > CRPSS.ECMWF.JJA$crpss.sigma*qnorm(0.95)); dot10[is.na(dot10)] <- FALSE
  dot11 <- as.matrix(CRPSS.NCEP.JJA$crpss > CRPSS.NCEP.JJA$crpss.sigma*qnorm(0.95)); dot11[is.na(dot11)] <- FALSE
  dot12 <- as.matrix(CRPSS.MF.JJA$crpss > CRPSS.MF.JJA$crpss.sigma*qnorm(0.95)); dot12[is.na(dot12)] <- FALSE
  
  # summer prlr
  #dot13 <- as.matrix(PrCRPSS.GloSea5.JJA$crpss > PrCRPSS.GloSea5.JJA$crpss.sigma*qnorm(0.95)); dot13[is.na(dot13)] <- FALSE
  #dot14 <- as.matrix(PrCRPSS.ECMWF.JJA$crpss > PrCRPSS.ECMWF.JJA$crpss.sigma*qnorm(0.95)); dot14[is.na(dot14)] <- FALSE
  #dot15 <- as.matrix(PrCRPSS.NCEP.JJA$crpss > PrCRPSS.NCEP.JJA$crpss.sigma*qnorm(0.95)); dot15[is.na(dot15)] <- FALSE
  #dot16 <- as.matrix(PrCRPSS.MF.JJA$crpss > PrCRPSS.MF.JJA$crpss.sigma*qnorm(0.95)); dot16[is.na(dot16)] <- FALSE
  


# replace values less than 0 with NA
# -----------------------------------

CRPSS.GloSea5.DJF$crpss[CRPSS.GloSea5.DJF$crpss < 0] <- NA
CRPSS.GloSea5.JJA$crpss[CRPSS.GloSea5.JJA$crpss < 0] <- NA

CRPSS.ECMWF.DJF$crpss[CRPSS.ECMWF.DJF$crpss < 0] <- NA
CRPSS.ECMWF.JJA$crpss[CRPSS.ECMWF.JJA$crpss < 0] <- NA

CRPSS.NCEP.DJF$crpss[CRPSS.NCEP.DJF$crpss < 0] <- NA
CRPSS.NCEP.JJA$crpss[CRPSS.NCEP.JJA$crpss < 0] <- NA

CRPSS.MF.DJF$crpss[CRPSS.MF.DJF$crpss < 0] <- NA
CRPSS.MF.JJA$crpss[CRPSS.MF.JJA$crpss < 0] <- NA




# map interval/colors
# -------------------

int <- seq(0,1,.2)
ncols <- length(int) -1
int.col <- c(hcl(10, l=seq(99,20,length=ncols), c=seq(30,70,length=ncols)))

# plot for Nov
# ------------  

#postscript("CRPSS_Nov.ps")
postscript("CRPSS_Temperature.ps")

layout(matrix(c(1,2,3,4,5,6,7,8,9,9,9,9), 3, 4, byrow = TRUE), 
       respect = TRUE,
       widths=c(3,3,3,3), heights=c(3,3,1)) 


  # tas
  PlotEquiMap(CRPSS.GloSea5.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS GloSea5 Winter", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot1))

  PlotEquiMap(CRPSS.ECMWF.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS ECMWF Winter", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot2))

  PlotEquiMap(CRPSS.NCEP.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS NCEP Winter", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot3))

  PlotEquiMap(CRPSS.MF.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS MF Winter", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot4))


  # prlr
  #PlotEquiMap(PrCRPSS.GloSea5.DJF$crpss, Lon, Lat,
  #          toptitle = "prlr CRPSS GloSea5 Winter", sizetit = 0.5,
  #          brks = int, 
  #          cols = int.col, 
  #          drawleg = FALSE, numbfig = 4, axelab = FALSE,
  #          #labW = FALSE, intylat = 20, intxlon = 20,
  #          filled.continents = FALSE, square = TRUE, dots=t(dot5))

  #PlotEquiMap(PrCRPSS.ECMWF.DJF$crpss, Lon, Lat,
  #          toptitle = "prlr CRPSS ECMWF Winter", sizetit = 0.5,
  #          brks = int, 
  #          cols = int.col, 
  #          drawleg = FALSE, numbfig = 4, axelab = FALSE,
  #          #labW = FALSE, intylat = 20, intxlon = 20,
  #          filled.continents = FALSE, square = TRUE, dots=t(dot6))

  #PlotEquiMap(PrCRPSS.NCEP.DJF$crpss, Lon, Lat,
  #          toptitle = "prlr CRPSS NCEP Winter", sizetit = 0.5,
  #          brks = int, 
  #          cols = int.col, 
  #          drawleg = FALSE, numbfig = 4, axelab = FALSE,
  #          #labW = FALSE, intylat = 20, intxlon = 20,
  #          filled.continents = FALSE, square = TRUE, dots=t(dot7))

  #PlotEquiMap(PrCRPSS.MF.DJF$crpss, Lon, Lat,
  #          toptitle = "prlr CRPSS MF Winter", sizetit = 0.5,
  #          brks = int, 
  #          cols = int.col, 
  #          drawleg = FALSE, numbfig = 4, axelab = FALSE,
  #          #labW = FALSE, intylat = 20, intxlon = 20,
  #          filled.continents = FALSE, square = TRUE, dots=t(dot8))

  # color
  #ColorBar(int, cols=int.col, vert=FALSE, subsampleg=.5, 
  #         tick=FALSE, upperspace=0.4, cex = 0.5)
  
#dev.off()




# plot for May
# ------------  

#postscript("CRPSS_Nov.ps")
#postscript("CRPSS_Temperature.ps")

#layout(matrix(c(1,2,3,4,5,6,7,8,9,9,9,9), 3, 4, byrow = TRUE), 
#       respect = TRUE,
#       widths=c(3,3,3,3), heights=c(3,3,2)) 


  # tas
  PlotEquiMap(CRPSS.GloSea5.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS GloSea5 Summer", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot9))

  PlotEquiMap(CRPSS.ECMWF.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS ECMWF Summer", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot10))

  PlotEquiMap(CRPSS.NCEP.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS NCEP Summer", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot11))

  PlotEquiMap(CRPSS.MF.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS MF Summer", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot12))


  # prlr
  #PlotEquiMap(PrCRPSS.GloSea5.JJA$crpss, Lon, Lat,
  #          toptitle = "prlr CRPSS GloSea5 Summer", sizetit = 0.5,
  #          brks = int, 
  #          cols = int.col, 
  #          drawleg = FALSE, numbfig = 4, axelab = FALSE,
  #          #labW = FALSE, intylat = 20, intxlon = 20,
  #          filled.continents = FALSE, square = TRUE, dots=t(dot13))

  #PlotEquiMap(PrCRPSS.ECMWF.JJA$crpss, Lon, Lat,
  #          toptitle = "prlr CRPSS ECMWF Summer", sizetit = 0.5,
  #          brks = int, 
  #          cols = int.col, 
  #          drawleg = FALSE, numbfig = 4, axelab = FALSE,
  #          #labW = FALSE, intylat = 20, intxlon = 20,
  #          filled.continents = FALSE, square = TRUE, dots=t(dot14))

  #PlotEquiMap(PrCRPSS.NCEP.JJA$crpss, Lon, Lat,
  #          toptitle = "prlr CRPSS NCEP Summer", sizetit = 0.5,
  #          brks = int, 
  #          cols = int.col, 
  #          drawleg = FALSE, numbfig = 4, axelab = FALSE,
  #          #labW = FALSE, intylat = 20, intxlon = 20,
  #          filled.continents = FALSE, square = TRUE, dots=t(dot15))

  #PlotEquiMap(PrCRPSS.MF.JJA$crpss, Lon, Lat,
  #          toptitle = "prlr CRPSS MF Summer", sizetit = 0.5,
  #          brks = int, 
  #         cols = int.col, 
  #          drawleg = FALSE, numbfig = 4, axelab = FALSE,
  #          #labW = FALSE, intylat = 20, intxlon = 20,
  #          filled.continents = FALSE, square = TRUE, dots=t(dot16))
  
 #colorbar
 ColorBar(int, cols=int.col, vert=FALSE, subsampleg=.5, 
          tick=FALSE, upperspace=0.4, cex = 0.5)

dev.off()




### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 

