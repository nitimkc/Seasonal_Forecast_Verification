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
NovStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovStartData.rds")
MayStartData <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayStartData.rds")

NovLat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLat.rds")
NovLon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")

MayLat <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/MayLat.rds")
MayLon <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")

# average over season
DJF.Exp <- Mean1Dim(NovStartData$mod, 4) 
DJF.Obs <- Mean1Dim(NovStartData$obs, 4)

JJA.Exp <- Mean1Dim(MayStartData$mod, 4) 
JJA.Obs <- Mean1Dim(MayStartData$obs, 4)

# save
saveRDS(DJF.Exp, "/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Exp.rds")
saveRDS(DJF.Obs, "/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Obs.rds")

saveRDS(JJA.Exp, "/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Exp.rds")
saveRDS(JJA.Obs, "/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Obs.rds")


# read
DJF.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Exp.rds")
DJF.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Obs.rds")

JJA.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Exp.rds")
JJA.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Obs.rds")


# calc CRPSS


CRPSS.GloSea5.DJF <- veriApply('EnsCrpss', fcst=DJF.Exp[1,,,,], obs=DJF.Obs[1,,,,], 
                               ensdim=1, tdim=2) 

CRPSS.ECMWF.DJF <- veriApply('EnsCrpss', fcst=DJF.Exp[2,,,,], obs=DJF.Obs[1,,,,], 
                             ensdim=1, tdim=2) 

CRPSS.NCEP.DJF <- veriApply('EnsCrpss', fcst=DJF.Exp[3,,,,], obs=DJF.Obs[1,,,,], 
                             ensdim=1, tdim=2) 

CRPSS.MF.DJF <- veriApply('EnsCrpss', fcst=DJF.Exp[4,,,,], obs=DJF.Obs[1,,,,], 
                          ensdim=1, tdim=2) 











tm <- toyarray(c(13,5), N=15, nens=51)
fo.crpss <- veriApply("EnsCrpss", fcst=tm$fcst, obs=tm$obs)

## if the data are organized differently such that forecast
## instance and ensemble members are NOT the last two array
## dimensions, this has to be indicated

## alternative setup:
## forecast instance, ensemble members, all forecast locations
## collated in one dimension
fcst2 <- array(aperm(tm$fcst, c(3,4,1,2)), c(15, 51, 13*5))
obs2 <- array(aperm(tm$obs, c(3,1,2)), c(15, 13*5))
fo2.crpss <- veriApply("EnsCrpss", fcst=fcst2, obs=obs2, 
                       ensdim=2, tdim=1)


