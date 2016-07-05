# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# FairCRPS
# for TEMPERATURE data ONLY
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
library(easyVerification)
library(SpecsVerification)
library(abind)

# load data
# ----------

PrNovStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovStartData.rds")
PrMayStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayStartData.rds")




# average over season
# --------------------

#PrDJF.Exp <- Mean1Dim(NovStartData$mod, 4) 
#PrDJF.Obs <- Mean1Dim(NovStartData$obs, 4)

#PrJJA.Exp <- Mean1Dim(MayStartData$mod, 4) 
#PrJJA.Obs <- Mean1Dim(MayStartData$obs, 4)

# save
#saveRDS(PrDJF.Exp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Exp.rds")
#saveRDS(PrDJF.Obs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Obs.rds")

#saveRDS(PrJJA.Exp, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJA.Exp.rds")
#saveRDS(PrJJA.Obs, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJA.Obs.rds")


# read
PrDJF.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Exp.rds")
PrDJF.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Obs.rds")

PrJJA.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJA.Exp.rds")
PrJJA.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrJJA.Obs.rds")



# calc Anomalies
# ---------------

# winter
clim.DJF.Exp <- Clim(DJF.Exp, DJF.Obs)
DJF.Exp <- Ano(DJF.Exp, clim.DJF.Exp$clim_exp)
DJF.Obs <- Ano(DJF.Obs, clim.DJF.Exp$clim_obs)

clim.JJA.Exp <- Clim(JJA.Exp, JJA.Obs)
JJA.Exp <- Ano(JJA.Exp, clim.JJA.Exp$clim_exp)
JJA.Obs <- Ano(JJA.Obs, clim.JJA.Exp$clim_obs)




# calc CRPSS
# -----------

# winter
FCRPSS.GloSea5.PrDJF <- veriApply('FairCrpss', fcst=PrDJF.Exp[1,1:24,,,], obs=PrDJF.Obs[1,,,,], ensdim=1, tdim=2) 
FCRPSS.ECMWF.PrDJF <- veriApply('FairCrpss', fcst=PrDJF.Exp[2,,,,], obs=PrDJF.Obs[1,,,,], ensdim=1, tdim=2) 
FCRPSS.NCEP.PrDJF <- veriApply('FairCrpss', fcst=PrDJF.Exp[3,1:28,,,], obs=PrDJF.Obs[1,,,,], ensdim=1, tdim=2) 
FCRPSS.MF.PrDJF <- veriApply('FairCrpss', fcst=PrDJF.Exp[4,1:15,,,], obs=PrDJF.Obs[1,,,,], ensdim=1, tdim=2) 


# summer
FCRPSS.GloSea5.PrJJA <- veriApply('FairCrpss', fcst=PrJJA.Exp[1,1:24,,,], obs=PrJJA.Obs[1,,,,], ensdim=1, tdim=2) 
FCRPSS.ECMWF.PrJJA <- veriApply('FairCrpss', fcst=PrJJA.Exp[2,,,,], obs=PrJJA.Obs[1,,,,], ensdim=1, tdim=2) 
FCRPSS.NCEP.PrJJA <- veriApply('FairCrpss', fcst=PrJJA.Exp[3,1:24,,,], obs=PrJJA.Obs[1,,,,], ensdim=1, tdim=2) 
FCRPSS.MF.PrJJA <- veriApply('FairCrpss', fcst=PrJJA.Exp[4,1:15,,,], obs=PrJJA.Obs[1,,,,], ensdim=1, tdim=2) 




# Move to 3.6.FCrpsPlot.R

### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
