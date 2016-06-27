# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Use for data manipulation and mapping 
# for TEMPERATURE data ONLY
# Lake Como E7--E10/N45--N47
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
library(easyVerification)
library(reshape2)
library(plyr)



# 1. Load data
# ------------

LakeComo.JJA.meanobs <- readRDS("/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.JJA.obs.rds")
LakeComo.JJA.meanexp <- readRDS("/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.JJA.exp.rds")


# 2. calc avg
# -------------



# 2. calc benchmark
# ------------------



# prepare data
Clim <- InsertDim(Clim, 1, 1)
Mod1 <- ts$mod[1,1:24,,,,]
Mod2 <- ts$mod[2,,,,,]
Mod3 <- ts$mod[3,1:28,,,,]
Mod4 <- ts$mod[4,1:15,,,,]

ens <- abind(Clim, Mod1,Mod2,Mod3,Mod4, along=1) # [1]   119  21   3  71 128
obs <- InsertDim(ts$obs[,,,,,], 1, 1)            # [1]     1  21   3  71 128

