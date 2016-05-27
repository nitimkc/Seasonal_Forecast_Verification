# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CRPS
# for TEMPERATURE data ONLY
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
library(easyVerification)
#library(reshape2)
#library(hash)
#library(RColorBrewer)
#library(rgdal)
#library(leaflet)
#library(raster)

# load data
# ----------

#NovStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovStartData.rds")
#MayStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayStartData.rds")




# average over season
# --------------------

#DJF.Exp <- Mean1Dim(NovStartData$mod, 4) 
#DJF.Obs <- Mean1Dim(NovStartData$obs, 4)

#JJA.Exp <- Mean1Dim(MayStartData$mod, 4) 
#JJA.Obs <- Mean1Dim(MayStartData$obs, 4)

  # save
  #saveRDS(DJF.Exp, "/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Exp.rds")
  #saveRDS(DJF.Obs, "/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Obs.rds")

  #saveRDS(JJA.Exp, "/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Exp.rds")
  #saveRDS(JJA.Obs, "/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Obs.rds")


  # read
  DJF.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Exp.rds")
  DJF.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Obs.rds")

  JJA.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Exp.rds")
  JJA.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Obs.rds")



# calc CRPSS
# -----------
  
  # winter
  CRPSS.GloSea5.DJF <- veriApply('EnsCrpss', fcst=DJF.Exp[1,1:24,,,], obs=DJF.Obs[1,,,,], ensdim=1, tdim=2) 
  CRPSS.ECMWF.DJF <- veriApply('EnsCrpss', fcst=DJF.Exp[2,,,,], obs=DJF.Obs[1,,,,], ensdim=1, tdim=2) 
  CRPSS.NCEP.DJF <- veriApply('EnsCrpss', fcst=DJF.Exp[3,1:28,,,], obs=DJF.Obs[1,,,,], ensdim=1, tdim=2) 
  CRPSS.MF.DJF <- veriApply('EnsCrpss', fcst=DJF.Exp[4,1:15,,,], obs=DJF.Obs[1,,,,], ensdim=1, tdim=2) 

  # summer
  CRPSS.GloSea5.JJA <- veriApply('EnsCrpss', fcst=JJA.Exp[1,1:24,,,], obs=JJA.Obs[1,,,,], ensdim=1, tdim=2) 
  CRPSS.ECMWF.JJA <- veriApply('EnsCrpss', fcst=JJA.Exp[2,,,,], obs=JJA.Obs[1,,,,], ensdim=1, tdim=2) 
  CRPSS.NCEP.JJA <- veriApply('EnsCrpss', fcst=JJA.Exp[3,1:24,,,], obs=JJA.Obs[1,,,,], ensdim=1, tdim=2) 
  CRPSS.MF.JJA <- veriApply('EnsCrpss', fcst=JJA.Exp[4,1:15,,,], obs=JJA.Obs[1,,,,], ensdim=1, tdim=2) 

# Move to 3.4.CrpsPlot.R
  
### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
  
