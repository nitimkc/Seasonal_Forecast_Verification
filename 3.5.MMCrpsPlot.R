# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# Continue from 2.5.MMCrps.R
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

#library(s2dverification)
#library(fields)


# replace values less than 0 with NA
# -----------------------------------

CRPSS.Multimodel.DJF$crpss[CRPSS.Multimodel.DJF$crpss < 0] <- NA
CRPSS.Multimodel.JJA$crpss[CRPSS.Multimodel.JJA$crpss < 0] <- NA


# map interval/colors
# -------------------

int <- seq(0,1,.2)
ncols <- length(int) -1
int.col <- c(hcl(10, l=seq(99,20,length=ncols), c=seq(30,70,length=ncols)))




# dot
# ---

dotDJF <- as.matrix(CRPSS.Multimodel.DJF$crpss > CRPSS.Multimodel.DJF$crpss.sigma*qnorm(0.95)); dotDJF[is.na(dotDJF)] <- FALSE
dotJJA <- as.matrix(CRPSS.Multimodel.JJA$crpss > CRPSS.Multimodel.JJA$crpss.sigma*qnorm(0.95)); dotJJA[is.na(dotJJA)] <- FALSE




# plot for MM
# ------------  


postscript("CRPSS_MM.ps")

#layout(matrix(c(1,2,3,4,5,5), 3, 2, byrow = TRUE), 
 #      respect = TRUE,
  #     widths=c(3,3), heights=c(3,3,1)) 

layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE), 
       respect = TRUE,
       widths=c(2,2), heights=c(2,.25)) 

# tas DJF
PlotEquiMap(CRPSS.Multimodel.DJF$crpss, Lon, Lat,
            toptitle = "CRPSS MM Winter", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dotDJF))

# prlr DJF
#PlotEquiMap(CRPSS.Multimodel.DJF$crpss, Lon, Lat,
#            toptitle = "CRPSS MM Winter", sizetit = 0.5,
#            brks = int, 
#            cols = int.col, 
#            drawleg = FALSE, numbfig = 4, axelab = FALSE,
#            #labW = FALSE, intylat = 20, intxlon = 20,
#            filled.continents = FALSE, square = TRUE, dots=t(dotDJF))

# tas JJA
PlotEquiMap(CRPSS.Multimodel.JJA$crpss, Lon, Lat,
            toptitle = "CRPSS MM Summer", sizetit = 0.5,
            brks = int, 
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            #labW = FALSE, intylat = 20, intxlon = 20,
            filled.continents = FALSE, square = TRUE, dots=t(dotJJA))

# prlr JJA
#PlotEquiMap(CRPSS.Multimodel.DJF$crpss, Lon, Lat,
#            toptitle = "CRPSS MM Summerr", sizetit = 0.5,
#            brks = int, 
#            cols = int.col, 
#            drawleg = FALSE, numbfig = 4, axelab = FALSE,
#            #labW = FALSE, intylat = 20, intxlon = 20,
#            filled.continents = FALSE, square = TRUE, dots=t(dotDJF))

#colorbar
ColorBar(int, cols=int.col, vert=FALSE, subsampleg=.5, 
         tick=FALSE, upperspace=0.4, cex = 0.5)

dev.off()


### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
