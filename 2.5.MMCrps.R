# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CRPS
# for TEMPERATURE data ONLY
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
library(easyVerification)
library(abind)


# load data
# ----------

DJF.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Exp.rds")
DJF.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Obs.rds")

JJA.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Exp.rds")
JJA.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Obs.rds")

Lat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLat.rds")
Lon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")



# multimodel
# ----------

Multimodel.DJF.Exp <- abind(DJF.Exp[1,1:24,,,],
                            DJF.Exp[2,,,,],
                            DJF.Exp[3,1:28,,,],
                            DJF.Exp[4,1:15,,,], along=1)

Multimodel.JJA.Exp <- abind(JJA.Exp[1,1:24,,,],
                            JJA.Exp[2,,,,],
                            JJA.Exp[3,1:24,,,],
                            JJA.Exp[4,1:15,,,], along=1)

# calc CRPSS
# -----------

CRPSS.Multimodel.DJF <- veriApply('EnsCrpss', 
                                  fcst=Multimodel.DJF.Exp, 
                                  obs=DJF.Obs[1,,,,], 
                                  ensdim=1, tdim=2) 

CRPSS.Multimodel.JJA <- veriApply('EnsCrpss', 
                                  fcst=Multimodel.JJA.Exp, 
                                  obs=JJA.Obs[1,,,,], 
                                  ensdim=1, tdim=2) 


# Move to 3.4.MMCrpsPlot.R


### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 