# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for data manipulation and mapping 
# for PRECIPITATION DATA ONLY
# ENSEMBLES data to compare with EUROSIP
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

NovEnsembleData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovEnsembleData.rds")
MayEnsembleData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayEnsembleData.rds")



# calc avg over 3 months for exp and obs
# --------------------------------------

# this part is not necessary because we will compare avgs over the models
# avg of 4 models in EUROSIP vs avg of 5 models in ENSEMBLE

EnsemDJFmeanExp <- MeanListDim(NovEnsembleData$mod, narm = T, c(2,4))
EnsemDJFmeanObs <- MeanListDim(NovEnsembleData$obs, narm = T, c(2,4))
#dim(EnsemDJFmeanObs)

EnsemJJAmeanExp <- MeanListDim(MayEnsembleData$mod, narm = T, c(2,4))
EnsemJJAmeanObs <- MeanListDim(MayEnsembleData$obs, narm = T, c(2,4))
#dim(EnsemJJAmeanObs)


##################### NOW CALCULATE THE DIFF BETWEEN ENSEMBLE & EUROSIP ###################

# calc avg over all 4 models
# ---------------------------

c<- MeanListDim(NovEnsembleData$mod, narm = T, c(1,2,4))
EnsemAvgDJFObs <- MeanListDim(NovEnsembleData$obs, narm = T, c(1,2,4))
#dim(EnsemAvgDJFExp)
#dim(EnsemAvgDJFObs)

EnsemAvgJJAExp <- MeanListDim(NovEnsembleData$mod, narm = T, c(1,2,4))
EnsemAvgJJAObs <- MeanListDim(NovEnsembleData$obs, narm = T, c(1,2,4))
#dim(EnsemAvgJJAExp)
#dim(EnsemAvgJJAObs)


##################### NOW CALCULATE THE DIFF BETWEEN ENSEMBLE & EUROSIP ###################

# calc corr
# ---------

corrDJF <- Corr(EnsemAvgDJFExp, EnsemAvgDJFObs , posloop = 1, poscor = 2) 
corrJJA <- Corr(EnsemAvgJJAExp, EnsemAvgJJAObs , posloop = 1, poscor = 2) 

# calc corr for avg over model
# ----------------------------

AvgcorrDJF <- Corr(EnsemAvgDJFExp, EnsemAvgDJFObs, posloop = 1, poscor = 1) 
AvgcorrJJA <- Corr(EnsemAvgJJAExp, EnsemAvgJJAObs, posloop = 1, poscor = 1) 




### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 

