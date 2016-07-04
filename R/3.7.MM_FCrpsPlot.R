# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# Continue from 2.5.MMCrps.R
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")
source("/esnas/scratch/nmishra/s2dv_test/3.0.ColorBar.R")

library(s2dverification)
library(easyVerification)
library(fields)




# load data
# ----------

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lon.rds")




# dot
# ---

dotDJF <- as.matrix(FCRPSS.Multimodel.DJF$crpss > FCRPSS.Multimodel.DJF$crpss.sigma*qnorm(0.95)); dotDJF[is.na(dotDJF)] <- FALSE
dotJJA <- as.matrix(FCRPSS.Multimodel.JJA$crpss > FCRPSS.Multimodel.JJA$crpss.sigma*qnorm(0.95)); dotJJA[is.na(dotJJA)] <- FALSE

dotPrDJF <- as.matrix(FCRPSS.Multimodel.PrDJF$crpss > FCRPSS.Multimodel.PrDJF$crpss.sigma*qnorm(0.95)); dotPrDJF[is.na(dotPrDJF)] <- FALSE
dotPrJJA <- as.matrix(FCRPSS.Multimodel.PrJJA$crpss > FCRPSS.Multimodel.PrJJA$crpss.sigma*qnorm(0.95)); dotPrJJA[is.na(dotPrJJA)] <- FALSE




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





# plot for MM
# ------------  


postscript("Ano_Fair_CRPSS_MM.ps")

par(mar=c(.2, 1, .2, 1))
layout(matrix(c(1,1,2,3,4,5,6,6), 4, 2, byrow = TRUE), 
       respect = TRUE, widths=c(3,3), heights=c(.65, 2, 2, .5)) 

#heading
plot.new()
text(0.5,0.5,"Seasonal Multi-Model Fair CRPS Skill over Europe",
     cex=2,font=2)


# tas DJF
PlotEquiMap(FCRPSS.Multimodel.DJF$crpss, Lon, Lat,
            toptitle = "Winter - Temperature", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dotDJF))

# tas JJA
PlotEquiMap(FCRPSS.Multimodel.JJA$crpss, Lon, Lat,
            toptitle = "Summer - Temperature", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dotJJA))

# prlr DJF
PlotEquiMap(FCRPSS.Multimodel.PrDJF$crpss, Lon, Lat,
            toptitle = "Winter - Precipitation", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dotPrDJF))



# prlr JJA
PlotEquiMap(FCRPSS.Multimodel.PrJJA$crpss, Lon, Lat,
            toptitle = "Summer - Temperature", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dotPrJJA))


# color
ColorBar(int_bar, cols=int.col, upperspace=0.4, lowerspace = 0,
         vert=FALSE, tick=FALSE, cex = 1)

dev.off()


### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
