# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for data manipulation and mapping 
# for NOVEMBER start date ONLY
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
#library(reshape2)
#library(hash)
#library(RColorBrewer)
#library(rgdal)
#library(leaflet)
#library(raster)




# load data
# ---------

PrNovStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrNovStartData.rds")
PrMayStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrMayStartData.rds")




# calc avg over 3 months for exp and obs
# --------------------------------------

PrDJFmeanExp <- MeanListDim(PrNovStartData$mod, narm = T, c(2,4))
PrDJFmeanObs <- MeanListDim(PrNovStartData$obs, narm = T, c(2,4))

PrJJAmeanExp <- MeanListDim(PrMayStartData$mod, narm = T, c(2,4))
PrJJAmeanObs <- MeanListDim(PrMayStartData$obs, narm = T, c(2,4))

  # save
  saveRDS(PrDJFmeanExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJFmeanExp.rds")
  saveRDS(PrDJFmeanObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJFmeanObs.rds")

  saveRDS(PrJJAmeanExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJAmeanExp.rds")
  saveRDS(PrJJAmeanObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJAmeanObs.rds")

  # read
  PrDJFmeanExp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJFmeanExp.rds")
  PrDJFmeanObs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJFmeanObs.rds")

  PrJJAmeanExp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJAmeanExp.rds")
  PrJJAmeanObs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJAmeanObs.rds")



# calc avg over all 4 models
# ---------------------------

PrAvgDJFExp <- Mean1Dim(PrDJFmeanExp, 1)
PrAvgDJFObs <- Mean1Dim(PrDJFmeanObs, 1)

PrAvgJJAExp <- Mean1Dim(PrJJAmeanExp, 1)
PrAvgJJAObs <- Mean1Dim(PrJJAmeanObs, 1)

  #save
  saveRDS(PrAvgDJFExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgDJFExp.rds")
  saveRDS(PrAvgDJFObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgDJFObs.rds")

  saveRDS(PrAvgJJAExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgJJAExp.rds")
  saveRDS(PrAvgJJAObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgJJAObs.rds")

  # read
  PrAvgDJFExp <- readRDS(PrAvgDJFExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgDJFExp.rds")
  PrAvgDJFObs <- readRDS(PrAvgDJFObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgDJFObs.rds")

  PrAvgJJAExp <- readRDS(PrAvgJJAExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgJJAExp.rds")
  PrAvgJJAobs <- readRDS(PrAvgJJAObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgJJAObs.rds")



# calc corr
# ---------
  
PrcorrDJF <- Corr(PrDJFmeanExp, PrDJFmeanObs , posloop = 1, poscor = 2) 
PrcorrJJA <- Corr(PrJJAmeanExp, PrJJAmeanObs , posloop = 1, poscor = 2) 

  # save
  saveRDS(PrcorrDJF, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrDJF.rds")
  saveRDS(PrcorrJJA, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrJJA.rds")

  # read
  PrcorrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrDJF.rds")
  PrcorrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrcorrJJA.rds")




### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 










