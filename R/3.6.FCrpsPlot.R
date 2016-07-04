# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# Continue from 2.4.Crps.R
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")
source("/esnas/scratch/nmishra/s2dv_test/3.0.ColorBar.R")


# load data
# ---------

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")



# dot
# ---

  # winter tas
  dot1 <- as.matrix(FCRPSS.GloSea5.DJF$crpss > FCRPSS.GloSea5.DJF$crpss.sigma*qnorm(0.95)); dot1[is.na(dot1)] <- FALSE
  dot2 <- as.matrix(FCRPSS.ECMWF.DJF$crpss > FCRPSS.ECMWF.DJF$crpss.sigma*qnorm(0.95)); dot2[is.na(dot2)] <- FALSE
  dot3 <- as.matrix(FCRPSS.NCEP.DJF$crpss > FCRPSS.NCEP.DJF$crpss.sigma*qnorm(0.95)); dot3[is.na(dot3)] <- FALSE
  dot4 <- as.matrix(FCRPSS.MF.DJF$crpss > FCRPSS.MF.DJF$crpss.sigma*qnorm(0.95)); dot4[is.na(dot4)] <- FALSE
  
  # winter prlr
  dot5 <- as.matrix(FCRPSS.GloSea5.PrDJF$crpss > FCRPSS.GloSea5.PrDJF$crpss.sigma*qnorm(0.95)); dot5[is.na(dot5)] <- FALSE
  dot6 <- as.matrix(FCRPSS.ECMWF.PrDJF$crpss > FCRPSS.ECMWF.PrDJF$crpss.sigma*qnorm(0.95)); dot6[is.na(dot6)] <- FALSE
  dot7 <- as.matrix(FCRPSS.NCEP.PrDJF$crpss > FCRPSS.NCEP.PrDJF$crpss.sigma*qnorm(0.95)); dot7[is.na(dot7)] <- FALSE
  dot8 <- as.matrix(FCRPSS.MF.PrDJF$crpss > FCRPSS.MF.PrDJF$crpss.sigma*qnorm(0.95)); dot8[is.na(dot8)] <- FALSE
  
  # summer tas
  dot9 <- as.matrix(FCRPSS.GloSea5.JJA$crpss > FCRPSS.GloSea5.JJA$crpss.sigma*qnorm(0.95)); dot9[is.na(dot9)] <- FALSE
  dot10 <- as.matrix(FCRPSS.ECMWF.JJA$crpss > FCRPSS.ECMWF.JJA$crpss.sigma*qnorm(0.95)); dot10[is.na(dot10)] <- FALSE
  dot11 <- as.matrix(FCRPSS.NCEP.JJA$crpss > FCRPSS.NCEP.JJA$crpss.sigma*qnorm(0.95)); dot11[is.na(dot11)] <- FALSE
  dot12 <- as.matrix(FCRPSS.MF.JJA$crpss > FCRPSS.MF.JJA$crpss.sigma*qnorm(0.95)); dot12[is.na(dot12)] <- FALSE
  
  # summer prlr
  dot13 <- as.matrix(FCRPSS.GloSea5.PrJJA$crpss > FCRPSS.GloSea5.PrJJA$crpss.sigma*qnorm(0.95)); dot13[is.na(dot13)] <- FALSE
  dot14 <- as.matrix(FCRPSS.ECMWF.PrJJA$crpss > FCRPSS.ECMWF.PrJJA$crpss.sigma*qnorm(0.95)); dot14[is.na(dot14)] <- FALSE
  dot15 <- as.matrix(FCRPSS.NCEP.PrJJA$crpss > FCRPSS.NCEP.PrJJA$crpss.sigma*qnorm(0.95)); dot15[is.na(dot15)] <- FALSE
  dot16 <- as.matrix(FCRPSS.MF.PrJJA$crpss > FCRPSS.MF.PrJJA$crpss.sigma*qnorm(0.95)); dot16[is.na(dot16)] <- FALSE





# map interval/colors
# -------------------

  int <-c(min(CRPSS.GloSea5.DJF$crpss, CRPSS.ECMWF.DJF$crpss,
              CRPSS.NCEP.DJF$crpss, CRPSS.MF.DJF$crpss,
              CRPSS.GloSea5.JJA$crpss, CRPSS.ECMWF.JJA$crpss,
              CRPSS.NCEP.JJA$crpss, CRPSS.MF.JJA$crpss, na.rm = TRUE), seq(-0.9,1,by=0.1))
  ncols <- length(int) -1
  int.col <- c(hcl(240, l=seq(20,99,length=ncols/2), c=seq(70,30,length=ncols/2)),
               hcl(10, l=seq(99,20,length=ncols/2), c=seq(30,70,length=ncols/2)))
  
  int_bar <- c(' ',seq(-0.9,1,by=0.1) ) 



# plot for Nov
# ------------  

postscript("Ano_Winter_Fair_CRPSS.ps")

par(mar=c(.2, .2, .2, .2))
layout(matrix(c(1,1,1,1,2,3,4,5,6,7,8,9,10,10,10,10), 4, 4, byrow = TRUE), 
       respect = TRUE, widths=c(3,3,3,3), heights=c(.65,3,3,.65)) 

#heading
plot.new()
text(0.5,0.5,"Winter Fair CRPS Skill Map for Europe",
     cex=2,font=2)


# tas
PlotEquiMap(FCRPSS.GloSea5.DJF$crpss, Lon, Lat,
            toptitle = "Temperature \nGloSea5", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot1))

PlotEquiMap(FCRPSS.ECMWF.DJF$crpss, Lon, Lat,
            toptitle = "\nECMWF", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot2))

PlotEquiMap(FCRPSS.NCEP.DJF$crpss, Lon, Lat,
            toptitle = "\nNCEP", sizetit = 0.5,
            brks = int, 
            cols = int.col,
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot3))

PlotEquiMap(FCRPSS.MF.DJF$crpss, Lon, Lat,
            toptitle = "\nMF", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot4))


# prlr
PlotEquiMap(FCRPSS.GloSea5.PrDJF$crpss, Lon, Lat,
            toptitle = "Precipitation \nGloSea5", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot5))

PlotEquiMap(FCRPSS.ECMWF.PrDJF$crpss, Lon, Lat,
            toptitle = "\nECMWF", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot6))

PlotEquiMap(FCRPSS.NCEP.PrDJF$crpss, Lon, Lat,
            toptitle = "\nNCEP", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot7))

PlotEquiMap(FCRPSS.MF.PrDJF$crpss, Lon, Lat,
            toptitle = "\nMF", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot8))

# color
ColorBar(int_bar, cols=int.col, upperspace=0.4, lowerspace = 0,
         vert=FALSE, tick=FALSE, cex = 1)

dev.off()




# plot for May
# ------------  

postscript("Ano_Summer_Fair_CRPSS.ps")

par(mar=c(.2, .2, .2, .2))
layout(matrix(c(1,1,1,1,2,3,4,5,6,7,8,9,10,10,10,10), 4, 4, byrow = TRUE), 
       respect = TRUE, widths=c(3,3,3,3), heights=c(.65,3,3,.65)) 

#heading
plot.new()
text(0.5,0.5,"Summer Fair CRPS Skill Map for Europe",
     cex=2,font=2)

# tas
PlotEquiMap(FCRPSS.GloSea5.JJA$crpss, Lon, Lat,
            toptitle = "Temperature \nGloSea5 - ", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot9))

PlotEquiMap(FCRPSS.ECMWF.JJA$crpss, Lon, Lat,
            toptitle = "\nECMWF", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot10))

PlotEquiMap(FCRPSS.NCEP.JJA$crpss, Lon, Lat,
            toptitle = "\nNCEP", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot11))

PlotEquiMap(FCRPSS.MF.JJA$crpss, Lon, Lat,
            toptitle = "\nMF", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot12))


# prlr
PlotEquiMap(FCRPSS.GloSea5.PrJJA$crpss, Lon, Lat,
            toptitle = "Precipitation \nGloSea5", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot13))

PlotEquiMap(FCRPSS.ECMWF.PrJJA$crpss, Lon, Lat,
            toptitle = "\nECMWF", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot14))

PlotEquiMap(FCRPSS.NCEP.PrJJA$crpss, Lon, Lat,
            toptitle = "\nNCEP", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot15))

PlotEquiMap(FCRPSS.MF.PrJJA$crpss, Lon, Lat,
            toptitle = "\nMF", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot16))

# color
ColorBar(int_bar, cols=int.col, upperspace=0.4, lowerspace = 0,
         vert=FALSE, tick=FALSE, cex = 1)

dev.off()




### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 













# max FCRPSS compared to 4 models
# ------------------------------

Fcrpss.max.DJF <- apply(FCRPSS.DJF , c(2,3,4), function(FCRPSS.DJF) ifelse(all(is.na(FCRPSS.DJF)), NA, max(FCRPSS.DJF, na.rm = TRUE))) 
Fcrpss.max.JJA <- apply(FCRPSS.JJA , c(2,3,4), function(FCRPSS.JJA) ifelse(all(is.na(FCRPSS.JJA)), NA, max(FCRPSS.JJA, na.rm = TRUE)))




# index for max FCRPSS compared to 4 models
# ---------------------------------------

FCRPSS.maxInd.DJF <- apply(FCRPSS.DJF , c(2,3,4) , function(FCRPSS.DJF) ifelse(all(is.na(FCRPSS.DJF)), NA, which.max(FCRPSS.DJF))) 
FCRPSS.maxInd.DJF <- FCRPSS.maxInd.DJF[21,,]

FCRPSS.maxInd.JJA <- apply(FCRPSS.JJA , c(2,3,4) , function(FCRPSS.JJA) ifelse(all(is.na(FCRPSS.JJA)), NA, which.max(FCRPSS.JJA))) 
FCRPSS.maxInd.JJA <- FCRPSS.maxInd.JJA[21,,]




# plot for Nov
# ------------  

postscript("Corr_Fair_Skill_by_Model.png")

par(mar=c(.2, 1, .2, 1))
layout(matrix(c(1,1,2,3,4,4), 3, 2, byrow = TRUE), 
       respect = TRUE, widths=c(3,3), heights=c(.5, 3, 1)) 

#heading
plot.new()
text(0.5,0.5,"Fair CRPS Skill Map - Seasonal Temperature over Europe",
     cex=2,font=2)


PlotEquiMap(FCRPSS.maxInd.DJF, Lon, Lat,
            toptitle = "Winter", sizetit = 0.5,
            cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE)

PlotEquiMap(FCRPSS.maxInd.JJA, Lon, Lat,
            toptitle = "Summer", sizetit = 0.5,
            cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE)

plot.new()
legend("top", leg=model, bty="n", fill=col, border=col, horiz=TRUE, cex=.8) 

dev.off()


### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
