# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for data manipulation and mapping 
# for TEMPERATURE data ONLY
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


# calc avg over all 4 models
# ---------------------------

PrAvgDJFExp <- MeanListDim(PrNovStartData$mod, narm = T, c(1,2,4)) # winter 
PrAvgDJFObs <- MeanListDim(PrNovStartData$obs, narm = T, c(1,2,4))
PrAvgJJAExp <- MeanListDim(PrNovStartData$mod, narm = T, c(1,2,4)) # summer
PrAvgJJAObs <- MeanListDim(PrNovStartData$obs, narm = T, c(1,2,4))

  # save
  saveRDS(PrAvgDJFExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgDJFExp.rds")
  saveRDS(PrAvgDJFObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgDJFObs.rds")
  saveRDS(PrAvgJJAExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgJJAExp.rds")
  saveRDS(PrAvgJJAObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgJJAObs.rds")

  # read
  PrAvgDJFExp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgDJFExp.rds")
  PrAvgDJFObs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgDJFObs.rds")
  PrAvgJJAExp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgJJAExp.rds")
  PrAvgJJAObs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgJJAObs.rds")



# calc corr
# ---------

PrAvgcorrDJF <- Corr(InsertDim(PrAvgDJFExp, 1, 1), InsertDim(PrAvgDJFObs, 1, 1), posloop = 1, poscor = 2)
PrAvgcorrJJA <- Corr(InsertDim(PrAvgJJAExp, 1, 1), InsertDim(PrAvgJJAObs, 1, 1), posloop = 1, poscor = 2)

  # save
  saveRDS(PrAvgcorrDJF, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgcorrDJF.rds")
  saveRDS(PrAvgcorrJJA, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrAvgcorrJJA.rds")



### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
