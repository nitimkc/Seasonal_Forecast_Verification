# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for data manipulation and mapping 
# for TEMPERATURE data ONLY
# Lake Como E7--E10/N45--N47
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
library(easyVerification)




# 1. Load data
# ------------

LakeComo.DJF.obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.DJF.obs.rds")
LakeComo.DJF.exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.DJF.exp.rds")
LakeComo.JJA.obs <- readRDS("/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.JJA.obs.rds")
LakeComo.JJA.exp <- readRDS("/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.JJA.exp.rds")




# 2. calc corr
# -------------

  # avg over members and season
  LakeComo.DJF.meanexp <- MeanListDim(LakeComo.DJF.exp, narm = T, c(2,4)) 
  LakeComo.DJF.meanobs <- MeanListDim(LakeComo.DJF.obs, narm = T, c(2,4)) 

  LakeComo.JJA.meanexp <- MeanListDim(LakeComo.JJA.exp, narm = T, c(2,4)) 
  LakeComo.JJA.meanobs <- MeanListDim(LakeComo.JJA.obs, narm = T, c(2,4)) 


  # corr
  LakeComo.AvgcorrDJF <- Corr(InsertDim(LakeComo.DJF.meanexp, 1, 1), 
                            InsertDim(LakeComo.DJF.meanobs, 1, 1), 
                            posloop = 2, poscor = 3) 


  LakeComo.AvgcorrJJA <- Corr(InsertDim(LakeComo.JJA.meanexp, 1, 1), 
                              InsertDim(LakeComo.JJA.meanobs, 1, 1), 
                              posloop = 2, poscor = 3)




# 3. calc crpss
# -------------

  # avg over season
  LakeComo.DJF.seaExp <- Mean1Dim(LakeComo.DJF.exp, narm = T, 4) 
  LakeComo.DJF.seaObs <- Mean1Dim(LakeComo.DJF.obs, narm = T, 4)
  
  LakeComo.JJA.seaExp <- Mean1Dim(LakeComo.JJA.exp, narm = T, 4)
  LakeComo.JJA.seaObs <- Mean1Dim(LakeComo.JJA.obs, narm = T, 4)
  

  # crpss winter
  LakeComo.G.DJF.crpss <- veriApply('EnsCrpss', 
                                    fcst=LakeComo.DJF.seaExp[1,1:24,], 
                                    obs=LakeComo.DJF.seaObs[1,,], 
                                    ensdim=1, tdim=2) 
  LakeComo.E.DJF.crpss <- veriApply('EnsCrpss', 
                                    fcst=LakeComo.DJF.seaExp[2,,], 
                                    obs=LakeComo.DJF.seaObs[1,,], 
                                    ensdim=1, tdim=2) 
  LakeComo.N.DJF.crpss <- veriApply('EnsCrpss', 
                                    fcst=LakeComo.DJF.seaExp[3,1:28,], 
                                    obs=LakeComo.DJF.seaObs[1,,], 
                                    ensdim=1, tdim=2) 
  LakeComo.M.DJF.crpss <- veriApply('EnsCrpss', 
                                    fcst=LakeComo.DJF.seaExp[4,1:15,], 
                                    obs=LakeComo.DJF.seaObs[1,,], 
                                    ensdim=1, tdim=2) 


  # crpss summer
  LakeComo.G.JJA.crpss <- veriApply('EnsCrpss', 
                                    fcst=LakeComo.JJA.seaExp[1,1:24,], 
                                    obs=LakeComo.JJA.seaObs[1,,], 
                                    ensdim=1, tdim=2) 
  LakeComo.E.JJA.crpss <- veriApply('EnsCrpss', 
                                    fcst=LakeComo.JJA.seaExp[2,,], 
                                    obs=LakeComo.JJA.seaObs[1,,], 
                                    ensdim=1, tdim=2) 
  LakeComo.N.JJA.crpss <- veriApply('EnsCrpss', 
                                    fcst=LakeComo.JJA.seaExp[3,1:24,], 
                                    obs=LakeComo.JJA.seaObs[1,,], 
                                    ensdim=1, tdim=2) 
  LakeComo.M.JJA.crpss <- veriApply('EnsCrpss', 
                                    fcst=LakeComo.JJA.seaExp[4,1:15,], 
                                    obs=LakeComo.JJA.seaObs[1,,], 
                                    ensdim=1, tdim=2) 


# 3. plots
# ---------




















### ----------------------------------ERRORS TO LOOK INTO ----------------------------------
### 