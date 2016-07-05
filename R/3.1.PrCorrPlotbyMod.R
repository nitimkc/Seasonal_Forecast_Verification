# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

library(s2dverification)


# load data
# ---------

PrCorrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrDJF.rds")
PrCorrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrJJA.rds")

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lon.rds")




# max PrCorr compared to 4 models
# ------------------------------

# PrCorr.max <- apply(PrCorrDJF , c(3,4,5) , function(PrCorrDJF) ifelse(all(is.na(PrCorrDJF)), NA, max(PrCorrDJF, na.rm = TRUE))) 
# PrCorr.max.JJA <- apply(PrCorrJJA , c(3,4,5) , function(PrCorrJJA) ifelse(all(is.na(PrCorrJJA)), NA, max(PrCorrJJA, na.rm = TRUE))) 



# index for max PrCorr compared to 4 models
# ---------------------------------------

PrCorr.maxInd <- apply(PrCorrDJF , c(3,4,5) , function(PrCorrDJF) ifelse(all(is.na(PrCorrDJF)), NA, which.max(PrCorrDJF))) 
PrCorr.maxInd <- PrCorr.maxInd[2,,]

PrCorr.maxInd.JJA <- apply(PrCorrJJA , c(3,4,5) , function(PrCorrJJA) ifelse(all(is.na(PrCorrJJA)), NA, which.max(PrCorrJJA))) 
PrCorr.maxInd.JJA <- PrCorr.maxInd.JJA[2,,]



# check
# print(c(PrCorrDJF[1,1,2,32,1], PrCorrDJF[2,1,2,32,1], PrCorrDJF[3,1,2,32,1], PrCorrDJF[4,1,2,32,1]))
# print(PrCorr.maxInd[32,1])


# dot
# ----

# winter
dot9 <- as.matrix(PrCorrDJF[1,1,2,,]>PrCorrDJF[1,1,4,,]) ; dot9[is.na(dot9)] <- FALSE
dot10 <- as.matrix(PrCorrDJF[2,1,2,,]>PrCorrDJF[2,1,4,,]) ; dot10[is.na(dot10)] <- FALSE
dot11 <- as.matrix(PrCorrDJF[3,1,2,,]>PrCorrDJF[3,1,4,,]) ; dot11[is.na(dot11)] <- FALSE
dot12 <- as.matrix(PrCorrDJF[4,1,2,,]>PrCorrDJF[4,1,4,,]) ; dot12[is.na(dot12)] <- FALSE


Prdot.max <- matrix(NA, 71, 128)
for (i in 1:71) {
  for (j in 1:128) {
    ifelse (PrCorr.maxInd[i,j] == 1, Prdot.max[i,j] <- dot9[i,j],
            ifelse (PrCorr.maxInd[i,j] == 2, Prdot.max[i,j] <- dot10[i,j],
                    ifelse (PrCorr.maxInd[i,j] == 3, Prdot.max[i,j] <- dot11[i,j],
                            ifelse (PrCorr.maxInd[i,j] == 4, Prdot.max[i,j] <- dot12[i,j],FALSE))))
  }
}
Prdot.max[is.na(Prdot.max)] <- FALSE


# summer
dot13 <- as.matrix(PrCorrJJA[1,1,2,,]>PrCorrJJA[1,1,4,,]) ; dot13[is.na(dot13)] <- FALSE
dot14 <- as.matrix(PrCorrJJA[2,1,2,,]>PrCorrJJA[2,1,4,,]) ; dot14[is.na(dot14)] <- FALSE
dot15 <- as.matrix(PrCorrJJA[3,1,2,,]>PrCorrJJA[3,1,4,,]) ; dot15[is.na(dot15)] <- FALSE
dot16 <- as.matrix(PrCorrJJA[4,1,2,,]>PrCorrJJA[4,1,4,,]) ; dot16[is.na(dot16)] <- FALSE


Prdot.max.JJA <- matrix(NA, 71, 128)
for (i in 1:71) {
  for (j in 1:128) {
    ifelse (PrCorr.maxInd.JJA[i,j] == 1, Prdot.max.JJA[i,j] <- dot13[i,j],
            ifelse (PrCorr.maxInd.JJA[i,j] == 2, Prdot.max.JJA[i,j] <- dot14[i,j],
                    ifelse (PrCorr.maxInd.JJA[i,j] == 3, Prdot.max.JJA[i,j] <- dot15[i,j], dot16[i,j])))
    #ifelse (PrCorr.maxInd.JJA[i,j] == 4, Prdot.max.JJA[i,j] <- dot16[i,j],FALSE))))
  }
}
Prdot.max.JJA[is.na(Prdot.max.JJA)] <- FALSE




# plot
# ----

model <- c("Glosea5", "ECMWF", "NCEP", "MF")
col <- c("#b2182b", "#ef8a62", "#abdda4", "#67a9cf")

postscript("MapofSkill_Precipitation.png")

par(mar=c(.2, 1, .2, 1))
layout(matrix(c(1,1,2,3,4,4), 3, 2, byrow = TRUE), 
       respect = TRUE, widths=c(3,3), heights=c(.5, 3, 1)) 
  
#heading
plot.new()
text(0.5,0.5,"Map of Skill - Seasonal Precipitation over Europe",
       cex=2,font=2)

PlotEquiMap(PrCorr.maxInd, Lon, Lat,
            toptitle = "Winter Precipitation", sizetit = 0.5,
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            filled.continents = FALSE, square = TRUE, dots=t(Prdot.max))

PlotEquiMap(PrCorr.maxInd.JJA, Lon, Lat,
            toptitle = "Summer precipitation", sizetit = 0.5,
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            filled.continents = FALSE, square = TRUE, dots=t(Prdot.max.JJA))

plot.new()
legend("top", leg=model, bty="n", fill=col, border=col, horiz=TRUE, cex=.8) 

dev.off()
