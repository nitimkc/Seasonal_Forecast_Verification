# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for PLOTS only
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/plots")

library(s2dverification)


# load data
# ---------

corrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/corrDJF.rds")
corrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/corrJJA.rds")

PrcorrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrDJF.rds")
PrcorrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrJJA.rds")

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lon.rds")




# max corr compared to 4 models
# ------------------------------

# corr.max <- apply(corrDJF , c(3,4,5) , function(corrDJF) ifelse(all(is.na(corrDJF)), NA, max(corrDJF, na.rm = TRUE))) 
# corr.max.JJA <- apply(corrJJA , c(3,4,5) , function(corrJJA) ifelse(all(is.na(corrJJA)), NA, max(corrJJA, na.rm = TRUE))) 


# max Prcorr compared to 4 models
# ------------------------------

# Prcorr.max <- apply(PrcorrDJF , c(3,4,5) , function(PrcorrDJF) ifelse(all(is.na(PrcorrDJF)), NA, max(PrcorrDJF, na.rm = TRUE))) 
# Prcorr.max.JJA <- apply(PrcorrJJA , c(3,4,5) , function(PrcorrJJA) ifelse(all(is.na(PrcorrJJA)), NA, max(PrcorrJJA, na.rm = TRUE))) 




# index for max corr compared to 4 models
# ---------------------------------------

corr.maxInd <- apply(corrDJF , c(3,4,5) , function(corrDJF) ifelse(all(is.na(corrDJF)), NA, which.max(corrDJF))) 
corr.maxInd <- corr.maxInd[2,,]

corr.maxInd.JJA <- apply(corrJJA , c(3,4,5) , function(corrJJA) ifelse(all(is.na(corrJJA)), NA, which.max(corrJJA))) 
corr.maxInd.JJA <- corr.maxInd.JJA[2,,]


# index for max Prcorr compared to 4 models
# ---------------------------------------

Prcorr.maxInd <- apply(PrcorrDJF , c(3,4,5) , function(PrcorrDJF) ifelse(all(is.na(PrcorrDJF)), NA, which.max(PrcorrDJF))) 
Prcorr.maxInd <- Prcorr.maxInd[2,,]

Prcorr.maxInd.JJA <- apply(PrcorrJJA , c(3,4,5) , function(PrcorrJJA) ifelse(all(is.na(PrcorrJJA)), NA, which.max(PrcorrJJA))) 
Prcorr.maxInd.JJA <- Prcorr.maxInd.JJA[2,,]


# check
print(c(corrDJF[1,1,2,32,1], corrDJF[2,1,2,32,1], 
        corrDJF[3,1,2,32,1], corrDJF[4,1,2,32,1]))

# check
print(c(PrcorrDJF[1,1,2,32,1], PrcorrDJF[2,1,2,32,1], 
        PrcorrDJF[3,1,2,32,1], PrcorrDJF[4,1,2,32,1]))


# dot
# ----

  # winter temp
  dot1 <- as.matrix(corrDJF[1,1,2,,]>corrDJF[1,1,4,,]) ; dot1[is.na(dot1)] <- FALSE
  dot2 <- as.matrix(corrDJF[2,1,2,,]>corrDJF[2,1,4,,]) ; dot2[is.na(dot2)] <- FALSE
  dot3 <- as.matrix(corrDJF[3,1,2,,]>corrDJF[3,1,4,,]) ; dot3[is.na(dot3)] <- FALSE
  dot4 <- as.matrix(corrDJF[4,1,2,,]>corrDJF[4,1,4,,]) ; dot4[is.na(dot4)] <- FALSE


dot.max <- matrix(NA, 71, 128)
for (i in 1:71) {
  for (j in 1:128) {
    ifelse (corr.maxInd[i,j] == 1, dot.max[i,j] <- dot1[i,j],
            ifelse (corr.maxInd[i,j] == 2, dot.max[i,j] <- dot2[i,j],
                    ifelse (corr.maxInd[i,j] == 3, dot.max[i,j] <- dot3[i,j],
                            ifelse (corr.maxInd[i,j] == 4, dot.max[i,j] <- dot4[i,j],FALSE))))
  }
}
dot.max[is.na(dot.max)] <- FALSE


  # summer temp
  dot5 <- as.matrix(corrJJA[1,1,2,,]>corrJJA[1,1,4,,]) ; dot5[is.na(dot5)] <- FALSE
  dot6 <- as.matrix(corrJJA[2,1,2,,]>corrJJA[2,1,4,,]) ; dot6[is.na(dot6)] <- FALSE
  dot7 <- as.matrix(corrJJA[3,1,2,,]>corrJJA[3,1,4,,]) ; dot7[is.na(dot7)] <- FALSE
  dot8 <- as.matrix(corrJJA[4,1,2,,]>corrJJA[4,1,4,,]) ; dot8[is.na(dot8)] <- FALSE


dot.max.JJA <- matrix(NA, 71, 128)
for (i in 1:71) {
  for (j in 1:128) {
    ifelse (corr.maxInd.JJA[i,j] == 1, dot.max.JJA[i,j] <- dot5[i,j],
            ifelse (corr.maxInd.JJA[i,j] == 2, dot.max.JJA[i,j] <- dot6[i,j],
                    ifelse (corr.maxInd.JJA[i,j] == 3, dot.max.JJA[i,j] <- dot7[i,j],
                            ifelse (corr.maxInd.JJA[i,j] == 4, dot.max.JJA[i,j] <- dot8[i,j],FALSE))))
  }
}
dot.max.JJA[is.na(dot.max.JJA)] <- FALSE


# winter prlr
dot9 <- as.matrix(PrcorrDJF[1,1,2,,]>PrcorrDJF[1,1,4,,]) ; dot9[is.na(dot9)] <- FALSE
dot10 <- as.matrix(PrcorrDJF[2,1,2,,]>PrcorrDJF[2,1,4,,]) ; dot10[is.na(dot10)] <- FALSE
dot11 <- as.matrix(PrcorrDJF[3,1,2,,]>PrcorrDJF[3,1,4,,]) ; dot11[is.na(dot11)] <- FALSE
dot12 <- as.matrix(PrcorrDJF[4,1,2,,]>PrcorrDJF[4,1,4,,]) ; dot12[is.na(dot12)] <- FALSE


Prdot.max <- matrix(NA, 71, 128)
for (i in 1:71) {
  for (j in 1:128) {
    ifelse (Prcorr.maxInd[i,j] == 1, Prdot.max[i,j] <- dot9[i,j],
            ifelse (Prcorr.maxInd[i,j] == 2, Prdot.max[i,j] <- dot10[i,j],
                    ifelse (Prcorr.maxInd[i,j] == 3, Prdot.max[i,j] <- dot11[i,j],
                            ifelse (Prcorr.maxInd[i,j] == 4, Prdot.max[i,j] <- dot12[i,j],FALSE))))
  }
}
Prdot.max[is.na(Prdot.max)] <- FALSE


# summer prlr
dot13 <- as.matrix(PrcorrJJA[1,1,2,,]>PrcorrJJA[1,1,4,,]) ; dot13[is.na(dot13)] <- FALSE
dot14 <- as.matrix(PrcorrJJA[2,1,2,,]>PrcorrJJA[2,1,4,,]) ; dot14[is.na(dot14)] <- FALSE
dot15 <- as.matrix(PrcorrJJA[3,1,2,,]>PrcorrJJA[3,1,4,,]) ; dot15[is.na(dot15)] <- FALSE
dot16 <- as.matrix(PrcorrJJA[4,1,2,,]>PrcorrJJA[4,1,4,,]) ; dot16[is.na(dot16)] <- FALSE


Prdot.max.JJA <- matrix(NA, 71, 128)
for (i in 1:71) {
  for (j in 1:128) {
    ifelse (Prcorr.maxInd.JJA[i,j] == 1, Prdot.max.JJA[i,j] <- dot13[i,j],
            ifelse (Prcorr.maxInd.JJA[i,j] == 2, Prdot.max.JJA[i,j] <- dot14[i,j],
                    ifelse (Prcorr.maxInd.JJA[i,j] == 3, Prdot.max.JJA[i,j] <- dot15[i,j], dot16[i,j])))
    #ifelse (Prcorr.maxInd.JJA[i,j] == 4, Prdot.max.JJA[i,j] <- dot16[i,j],FALSE))))
  }
}
Prdot.max.JJA[is.na(Prdot.max.JJA)] <- FALSE



# plot
model <- c("Glosea5", "ECMWF", "NCEP", "MF")
col <- c("#b2182b", "#ef8a62", "#abdda4", "#67a9cf")




# plot for temp only
# -------------------


postscript("MapofSkill_Temperature.ps")

par(mar=c(.2, 1, .2, 1))
layout(matrix(c(1,1,2,3,4,4), 3, 2, byrow = TRUE), 
       respect = TRUE, widths=c(3,3), heights=c(.5, 3, 1)) 

#heading
plot.new()
text(0.5,0.5,"Map of Skill - Seasonal Temperature over Europe",
     cex=2,font=2)

PlotEquiMap(corr.maxInd, Lon, Lat,
            toptitle = "Winter", sizetit = 0.5,
            cols = col, 
            drawleg = FALSE, numbfig = 2, axelab = FALSE,
            filled.continents = FALSE, square = TRUE, dots=t(dot.max))

PlotEquiMap(corr.maxInd.JJA, Lon, Lat,
            toptitle = "Summer", sizetit = 0.5,
            cols = col, 
            drawleg = FALSE, numbfig = 2, axelab = FALSE,
            filled.continents = FALSE, square = TRUE, dots=t(dot.max.JJA))

plot.new()
legend("top", leg=model, bty="n", fill=col, border=col, horiz=TRUE, cex=.8) 

dev.off()




# one plot for temp and prlr
----------------------------

postscript("4_MapofSkill.ps")

par(mar=c(.2, .2, .2, .2))
layout(matrix(c(1,1,2,3,4,5,6,6), 4, 2, byrow = TRUE), 
       respect = TRUE, widths=c(4,4), heights=c(.65, 3, 3, 1))  

#heading
plot.new()
text(0.5,0.5,"Map of Skill over Europe",
     cex=2,font=2)

PlotEquiMap(corr.maxInd, Lon, Lat,
            toptitle = "Winter Temperature", sizetit = 0.5,
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            filled.continents = FALSE, square = TRUE, dots=t(dot.max))

PlotEquiMap(corr.maxInd.JJA, Lon, Lat,
            toptitle = "Summer Temperature", sizetit = 0.5,
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            filled.continents = FALSE, square = TRUE, dots=t(dot.max.JJA))

PlotEquiMap(Prcorr.maxInd, Lon, Lat,
            toptitle = "Winter Precipitation", sizetit = 0.5,
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            filled.continents = FALSE, square = TRUE, dots=t(Prdot.max))

PlotEquiMap(Prcorr.maxInd.JJA, Lon, Lat,
            toptitle = "Summer precipitation", sizetit = 0.5,
            cols = col, 
            drawleg = FALSE, numbfig = 4, axelab = FALSE,
            filled.continents = FALSE, square = TRUE, dots=t(Prdot.max.JJA))

plot.new()
legend("top", leg=model, bty="n", fill=col, border=col, horiz=TRUE, cex=.8) 

dev.off()

library(fields)
colorbar.plot( 2.5, 30, y)