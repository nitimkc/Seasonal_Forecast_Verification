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
NovStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovStartData.rds")
MayStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayStartData.rds")


# calc avg over all 4 models
# ---------------------------

AvgDJFExp <- MeanListDim(NovStartData$mod, narm = T, c(1,2,4)) # winter 
AvgDJFObs <- MeanListDim(NovStartData$obs, narm = T, c(1,2,4))
AvgJJAExp <- MeanListDim(NovStartData$mod, narm = T, c(1,2,4)) # summer
AvgJJAObs <- MeanListDim(NovStartData$obs, narm = T, c(1,2,4))

  # save
  saveRDS(AvgDJFExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/AvgDJFExp.rds")
  saveRDS(AvgDJFObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/AvgDJFObs.rds")
  saveRDS(AvgJJAExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/AvgJJAExp.rds")
  saveRDS(AvgJJAObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/AvgJJAObs.rds")

  # read
  AvgDJFExp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/AvgDJFExp.rds")
  AvgDJFObs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/AvgDJFObs.rds")
  AvgJJAExp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/AvgJJAExp.rds")
  AvgJJAObs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/AvgJJAObs.rds")


# calc corr for avg data
# ----------------------

AvgcorrDJF <- Corr(InsertDim(AvgDJFExp, 1, 1), InsertDim(AvgDJFObs, 1, 1), posloop = 1, poscor = 2) 
AvgcorrJJA <- Corr(InsertDim(AvgJJAExp, 1, 1), InsertDim(AvgJJAObs, 1, 1), posloop = 1, poscor = 2)

  # save
  saveRDS(AvgcorrDJF, "/esnas/scratch/nmishra/s2dv_test/SavedData/AvgcorrDJF.rds")
  saveRDS(AvgcorrJJA, "/esnas/scratch/nmishra/s2dv_test/SavedData/AvgcorrJJA.rds")



### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 






