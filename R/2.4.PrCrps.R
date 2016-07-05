# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CRPS
# for PRECIPITATION data ONLY
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
library(easyVerification)



# load data
# ----------

NovStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrNovStartData.rds")
MayStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrMayStartData.rds")




# average over season
# --------------------

PrDJF.Exp <- Mean1Dim(NovStartData$mod, 4) 
PrDJF.Obs <- Mean1Dim(NovStartData$obs, 4)

PrJJA.Exp <- Mean1Dim(MayStartData$mod, 4) 
PrJJA.Obs <- Mean1Dim(MayStartData$obs, 4)

  # save
  saveRDS(PrDJF.Exp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Exp.rds")
  saveRDS(PrDJF.Obs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Obs.rds")
  
  saveRDS(PrJJA.Exp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJA.Exp.rds")
  saveRDS(PrJJA.Obs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJA.Obs.rds")


  # read
  PrDJF.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Exp.rds")
  PrDJF.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Obs.rds")
  
  PrJJA.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJA.Exp.rds")
  PrJJA.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJA.Obs.rds")


# calc Anomalies
# ---------------
  
  clim.PrDJF.Exp <- Clim(PrDJF.Exp, PrDJF.Obs)
  PrDJF.Exp <- Ano(PrDJF.Exp, clim.PrDJF.Exp$clim_exp)
  PrDJF.Obs <- Ano(PrDJF.Obs, clim.PrDJF.Exp$clim_obs)
  
  clim.PrJJA.Exp <- Clim(PrJJA.Exp, PrJJA.Obs)
  PrJJA.Exp <- Ano(PrJJA.Exp, clim.PrJJA.Exp$clim_exp)
  PrJJA.Obs <- Ano(PrJJA.Obs, clim.PrJJA.Exp$clim_obs)
  
  

# calc CRPSS
# -----------

  # winter
  PrCRPSS.GloSea5.DJF <- veriApply('EnsCrpss', fcst=PrDJF.Exp[1,1:24,,,], obs=PrDJF.Obs[1,,,,], ensdim=1, tdim=2) 
  PrCRPSS.ECMWF.DJF <- veriApply('EnsCrpss', fcst=PrDJF.Exp[2,,,,], obs=PrDJF.Obs[1,,,,], ensdim=1, tdim=2) 
  PrCRPSS.NCEP.DJF <- veriApply('EnsCrpss', fcst=PrDJF.Exp[3,1:28,,,], obs=PrDJF.Obs[1,,,,], ensdim=1, tdim=2) 
  PrCRPSS.MF.DJF <- veriApply('EnsCrpss', fcst=PrDJF.Exp[4,1:15,,,], obs=PrDJF.Obs[1,,,,], ensdim=1, tdim=2) 
  
  # summer
  PrCRPSS.GloSea5.JJA <- veriApply('EnsCrpss', fcst=PrJJA.Exp[1,1:24,,,], obs=PrJJA.Obs[1,,,,], ensdim=1, tdim=2) 
  PrCRPSS.ECMWF.JJA <- veriApply('EnsCrpss', fcst=PrJJA.Exp[2,,,,], obs=PrJJA.Obs[1,,,,], ensdim=1, tdim=2) 
  PrCRPSS.NCEP.JJA <- veriApply('EnsCrpss', fcst=PrJJA.Exp[3,1:24,,,], obs=PrJJA.Obs[1,,,,], ensdim=1, tdim=2) 
  PrCRPSS.MF.JJA <- veriApply('EnsCrpss', fcst=PrJJA.Exp[4,1:15,,,], obs=PrJJA.Obs[1,,,,], ensdim=1, tdim=2) 


# Move to 3.4.CrpsPlot.R

### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
