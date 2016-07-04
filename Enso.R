# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ENSO Map
# Year 1997 ( El Nino) and 1998 (La Nina)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

library(s2dverification)
library(easyVerification)

source("/esnas/scratch/nmishra/s2dv_test/3.0.ColorBar.R")

# load data
# ----------

x=Load("tas", obs = "ERAint", c("glosea5_sea"),
       sdates = c("20060501", "20080501"), leadtimemin = 2, leadtimemax = 4,
       storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "lonlat",
       grid = "r512x256",
       configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")


# generate dataseq for MAY start date
# -----------------------------------
Maystart <- as.Date("19920501", "%Y%m%d")
Mayend <- as.Date("20080501", "%Y%m%d")
Maydateseq <- format(seq(Maystart, Mayend, by = "year"), "%Y%m%d")


MayStartData=Load("tas", obs = "ERAint", c("glosea5_sea"),
                  sdates = Maydateseq, leadtimemin = 2, leadtimemax = 4,
                  storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "lonlat",
                  grid = "r512x256",
                  configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")

# prep data
# ----------

Nino <- x$obs[1,1,1,,,]
avgNino <- Mean1Dim(Nino, 1) 


Nina <- x$obs[1,1,2,,,]
avgNina <- Mean1Dim(Nina, 1) 

summeravg <- MeanListDim(MayStartData$obs, narm = T, c(3,4)) # summer obs
summeravg <- summeravg[1,1,,]


# temperature that year was higher or lower than average

int <- seq(-5, 5, 1)
int
ncols <- length(int) -1
int.col <- c(hcl(240, l=seq(20,99,length=ncols/2), c=seq(70,30,length=ncols/2)),
             hcl(10, l=seq(99,20,length=ncols/2), c=seq(30,70,length=ncols/2)))

NinoChk <- summeravg - avgNino
PlotEquiMap(avgNina, x$lon, x$lat,
            toptitle = "Nino 2006", sizetit = 0.5,
            #brks = int, cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            filled.continents = FALSE, colNA="grey")     


NinaChk <- summeravg - avgNina
PlotEquiMap(NinaChk, x$lon, x$lat,
            toptitle = "Nina 2008", sizetit = 0.5,
            brks = int,
            cols = int.col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            filled.continents = FALSE, colNA="grey")     














