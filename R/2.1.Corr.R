# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for data manipulation and mapping 
# for TEMPERATURE data ONLY
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)





# load data
# ----------

#NovStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovStartData.rds")
#MayStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayStartData.rds")

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/Lon.rds")


# calc avg over 3 months for exp and obs
# --------------------------------------

#DJFmeanExp <- MeanListDim(NovStartData$mod, narm = T, c(2,4)) # winter exp
#DJFmeanObs <- MeanListDim(NovStartData$obs, narm = T, c(2,4)) # winter obs

#JJAmeanExp <- MeanListDim(MayStartData$mod, narm = T, c(2,4)) # summer exp
#JJAmeanObs <- MeanListDim(MayStartData$obs, narm = T, c(2,4)) # summer obs


  # save
  #saveRDS(DJFmeanExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/DJFmeanExp.rds")
  #saveRDS(DJFmeanObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/DJFmeanObs.rds")

  #saveRDS(JJAmeanExp, "/esnas/scratch/nmishra/s2dv_test/SavedData/JJAmeanExp.rds")
  #saveRDS(JJAmeanObs, "/esnas/scratch/nmishra/s2dv_test/SavedData/JJAmeanObs.rds")


  # read
  DJFmeanExp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJFmeanExp.rds")
  DJFmeanObs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJFmeanObs.rds")

  JJAmeanExp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJAmeanExp.rds")
  JJAmeanObs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJAmeanObs.rds")




# calc corr
# ---------
  
corrDJF <- Corr(DJFmeanExp, DJFmeanObs , posloop = 1, poscor = 2) # for each model
corrJJA <- Corr(JJAmeanExp, JJAmeanObs , posloop = 1, poscor = 2) 

  # save  
  saveRDS(corrDJF, "/esnas/scratch/nmishra/s2dv_test/SavedData/corrDJF.rds")
  saveRDS(corrJJA, "/esnas/scratch/nmishra/s2dv_test/SavedData/corrJJA.rds")

  # read
  corrDJF <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/corrDJF.rds")
  corrJJA <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/corrJJA.rds")




### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 







