# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

library(s2dverification)
source("/esnas/scratch/nmishra/s2dv_test/3.0.ColorBar.R")


# load data
# ----------

corrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/corrDJF.rds")
corrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/corrJJA.rds")

PrcorrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrDJF.rds")
PrcorrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrJJA.rds")

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lon.rds")




# map interval/ colors
# --------------------

interval <- seq(-1, 1, 0.1)
ncols <- length(interval) -1
color <- c(hcl(240, l=seq(20,99,length=ncols/2), c=seq(70,30,length=ncols/2)),
             hcl(10, l=seq(99,20,length=ncols/2), c=seq(30,70,length=ncols/2)))

breaks_plot<-c(min(CRPSS), seq(-0.9,1,by=0.1)) 
breaks_cbar <- seq(-1, 1, by=1) 

# dot
# ---

  # winter
  dot1 <- as.matrix(corrDJF[1,1,2,,]>corrDJF[1,1,4,,]) ; dot1[is.na(dot1)] <- FALSE
  dot2 <- as.matrix(corrDJF[2,1,2,,]>corrDJF[2,1,4,,]) ; dot2[is.na(dot2)] <- FALSE
  dot3 <- as.matrix(corrDJF[3,1,2,,]>corrDJF[3,1,4,,]) ; dot3[is.na(dot3)] <- FALSE
  dot4 <- as.matrix(corrDJF[4,1,2,,]>corrDJF[4,1,4,,]) ; dot4[is.na(dot4)] <- FALSE

  dot5 <- as.matrix(PrcorrDJF[1,1,2,,]>PrcorrDJF[1,1,4,,]) ; dot5[is.na(dot5)] <- FALSE
  dot6 <- as.matrix(PrcorrDJF[2,1,2,,]>PrcorrDJF[2,1,4,,]) ; dot6[is.na(dot6)] <- FALSE
  dot7 <- as.matrix(PrcorrDJF[3,1,2,,]>PrcorrDJF[3,1,4,,]) ; dot7[is.na(dot7)] <- FALSE
  dot8 <- as.matrix(PrcorrDJF[4,1,2,,]>PrcorrDJF[4,1,4,,]) ; dot8[is.na(dot8)] <- FALSE

  # summer
  dot9 <- as.matrix(corrJJA[1,1,2,,]>corrJJA[1,1,4,,]) ; dot9[is.na(dot9)] <- FALSE
  dot10 <- as.matrix(corrJJA[2,1,2,,]>corrJJA[2,1,4,,]) ; dot10[is.na(dot10)] <- FALSE
  dot11 <- as.matrix(corrJJA[3,1,2,,]>corrJJA[3,1,4,,]) ; dot11[is.na(dot11)] <- FALSE
  dot12 <- as.matrix(corrJJA[4,1,2,,]>corrJJA[4,1,4,,]) ; dot12[is.na(dot12)] <- FALSE

  dot13 <- as.matrix(PrcorrJJA[1,1,2,,]>PrcorrJJA[1,1,4,,]) ; dot13[is.na(dot13)] <- FALSE
  dot14 <- as.matrix(PrcorrJJA[2,1,2,,]>PrcorrJJA[2,1,4,,]) ; dot14[is.na(dot14)] <- FALSE
  dot15 <- as.matrix(PrcorrJJA[3,1,2,,]>PrcorrJJA[3,1,4,,]) ; dot15[is.na(dot15)] <- FALSE
  dot16 <- as.matrix(PrcorrJJA[4,1,2,,]>PrcorrJJA[4,1,4,,]) ; dot16[is.na(dot16)] <- FALSE


  
# plot for Nov
# -------------

postscript("Winter_Corr.ps")

  par(mar=c(0,0,0,0))
  layout(matrix(c(1,1,1,1,2,3,4,5,6,7,8,9,10,10,10,10), 4, 4, byrow = TRUE), 
         respect = TRUE, widths=c(3,3,3,3), heights=c(1,3,3,1)) 

  #heading
  plot.new()
  text(0.5,0.5,"Winter Correlation Map for Seasonal Temperature \nand Precipitation over Europe",
       cex=2,font=2)

  # tas
  PlotEquiMap(corrDJF[1,1,2,,], Lon, Lat,
            toptitle = "Temperature \nGlosea5", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot1))

  PlotEquiMap(corrDJF[2,1,2,,], Lon, Lat,
            toptitle = "\nECMWF", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot2))

  PlotEquiMap(corrDJF[3,1,2,,], Lon, Lat,
            toptitle = "\nNCEP", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot3))

  PlotEquiMap(corrDJF[4,1,2,,], Lon, Lat,
            toptitle = "\nMF", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot4))

  # prlr
  PlotEquiMap(PrcorrDJF[1,1,2,,], Lon, Lat,
            toptitle = "Precipitation  \nGlosea5", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot5))

  PlotEquiMap(PrcorrDJF[2,1,2,,], Lon, Lat,
            toptitle = "\nECMWF", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot6))

  PlotEquiMap(PrcorrDJF[3,1,2,,], Lon, Lat,
            toptitle = "\nNCEP",  sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot7))

  PlotEquiMap(PrcorrDJF[4,1,2,,], Lon, Lat,
            toptitle = "\nMF",  sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot8))
  
  # color
  ColorBar(interval, cols=color, upperspace=0.4, lowerspace = 0,
           vert=FALSE, tick=FALSE, cex = .85)

dev.off()





# plot for May
# -------------

postscript("Summer_Corr.ps")

  par(mar=c(0,0,0,0))
  layout(matrix(c(1,1,1,1,2,3,4,5,6,7,8,9,10,10,10,10), 4, 4, byrow = TRUE), 
         respect = TRUE, widths=c(3,3,3,3), heights=c(1,3,3,1)) 
  
  #heading
  plot.new()
  text(0.5,0.5,"Summer Correlation Map for Seasonal Temperature \nand Precipitation over Europe",
       cex=2,font=2)


  # tas
  PlotEquiMap(corrJJA[1,1,2,,], Lon, Lat,
            toptitle = "Temperature \nGlosea5", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot9))

  PlotEquiMap(corrJJA[2,1,2,,], Lon, Lat,
            toptitle = "\nECMWF", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot10))

  PlotEquiMap(corrJJA[3,1,2,,], Lon, Lat,
            toptitle = "\nNCEP", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot11))

  PlotEquiMap(corrJJA[4,1,2,,], Lon, Lat,
            toptitle = "\nMF", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot12))

  # prlr
  PlotEquiMap(PrcorrJJA[1,1,2,,], Lon, Lat,
            toptitle = "Precipitation \nGlosea5", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot13))

  PlotEquiMap(PrcorrJJA[2,1,2,,], Lon, Lat,
            toptitle = "\nECMWF", sizetit = 0.5,
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot14))

  PlotEquiMap(PrcorrJJA[3,1,2,,], Lon, Lat,
            toptitle = "\nNCEP", sizetit = 0.5, 
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot15))

  PlotEquiMap(PrcorrJJA[4,1,2,,], Lon, Lat,
            toptitle = "\nMF", sizetit = 0.5, 
            brks = interval, cols = color, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dot16))

  # color
  ColorBar(interval, cols=color, upperspace=0.4, lowerspace = 0,
           vert=FALSE, tick=FALSE, cex = .85)
  
dev.off()



### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 


























