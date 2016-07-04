# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CRPS
# for TEMPERATURE data ONLY
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#setwd("/esnas/scratch/nmishra/s2dv_test")
#library(s2dverification)
#library(easyVerification)
library(abind)




# load data
# ----------
  
  # Winter
  DJF.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Exp.rds")
  DJF.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/DJF.Obs.rds")
  
  PrDJF.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Exp.rds")
  PrDJF.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/PrDJF.Obs.rds")

  # Summer
  JJA.Exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Exp.rds")
  JJA.Obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/JJA.Obs.rds")
  
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
  
  
  # summer
  clim.PrDJF.Exp <- Clim(PrDJF.Exp, PrDJF.Obs)
  PrDJF.Exp <- Ano(PrDJF.Exp, clim.PrDJF.Exp$clim_exp)
  PrDJF.Obs <- Ano(PrDJF.Obs, clim.PrDJF.Exp$clim_obs)
  
  clim.PrJJA.Exp <- Clim(PrJJA.Exp, PrJJA.Obs)
  PrJJA.Exp <- Ano(PrJJA.Exp, clim.PrJJA.Exp$clim_exp)
  PrJJA.Obs <- Ano(PrJJA.Obs, clim.PrJJA.Exp$clim_obs)
  
  
  
# multimodel
# ----------

  # Winter
  Multimodel.DJF.Exp <- abind(DJF.Exp[1,1:24,,,],
                              DJF.Exp[2,,,,],
                              DJF.Exp[3,1:28,,,],
                              DJF.Exp[4,1:15,,,], along=1)
    
  Multimodel.PrDJF.Exp <- abind(PrDJF.Exp[1,1:24,,,],
                              PrDJF.Exp[2,,,,],
                              PrDJF.Exp[3,1:28,,,],
                              PrDJF.Exp[4,1:15,,,], along=1)
  
  # Summer  
  Multimodel.JJA.Exp <- abind(JJA.Exp[1,1:24,,,],
                              JJA.Exp[2,,,,],
                              JJA.Exp[3,1:24,,,],
                              JJA.Exp[4,1:15,,,], along=1)
      
  Multimodel.PrJJA.Exp <- abind(PrJJA.Exp[1,1:24,,,],
                              PrJJA.Exp[2,,,,],
                              PrJJA.Exp[3,1:24,,,],
                              PrJJA.Exp[4,1:15,,,], along=1)



  
# calc CRPSS
# -----------

  # Winter
  CRPSS.Multimodel.DJF <- veriApply('EnsCrpss',
                                    fcst=Multimodel.DJF.Exp, 
                                    obs=DJF.Obs[1,,,,], 
                                    ensdim=1, tdim=2) 

  CRPSS.Multimodel.PrDJF <- veriApply('EnsCrpss',
                                    fcst=Multimodel.PrDJF.Exp, 
                                    obs=PrDJF.Obs[1,,,,], 
                                    ensdim=1, tdim=2) 
  
  
  # Summer
  CRPSS.Multimodel.JJA <- veriApply('EnsCrpss',
                                    fcst=Multimodel.JJA.Exp,
                                    obs=JJA.Obs[1,,,,], 
                                    ensdim=1, tdim=2) 

  CRPSS.Multimodel.PrJJA <- veriApply('EnsCrpss', 
                                    fcst=Multimodel.PrJJA.Exp, 
                                    obs=PrJJA.Obs[1,,,,], 
                                    ensdim=1, tdim=2) 


# Move to 3.5.MMCrpsPlot.R


### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 
