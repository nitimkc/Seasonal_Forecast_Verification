# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# USE FOR LOADING TEMPERATURE - DATA ONLY
# Lake Como E7--E10/N45--N47
# 432x325
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test/LakeComo")
library(s2dverification)
library(ncdf)
library(abind)




# Nov dataseq 
# ------------

Novstart <- as.Date("19921101", "%Y%m%d")
Novend <- as.Date("20121101", "%Y%m%d")
Novdateseq <- format(seq(Novstart, Novend, by = "year"), "%Y%m%d")


# MAY dataseq
# ------------

Maystart <- as.Date("19920501", "%Y%m%d")
Mayend <- as.Date("20120501", "%Y%m%d")
Maydateseq <- format(seq(Maystart, Mayend, by = "year"), "%Y%m%d")


# MASKS
# ------

  # mod
  source("/esnas/scratch/nmishra/s2dv_test/maskmod.R")

  # obs
  fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_480x241.nc")
  maskobs <- get.var.ncdf(fnc,"LSM")
  close.ncdf(fnc)
  maskobs[which(is.na(maskobs))] <- 1 
  listmaskobs=list(maskobs) 

# 1. Glosea5
# ----------

  # load NOVEMBER start date seasonal data - DJF

  LakeComo.G.DJF=Load("tas", "glosea5_sea", obs = "ERAint",
                    sdates = Novdateseq, leadtimemin = 2, leadtimemax = 4,
                    lonmin = 8, lonmax = 10, latmin = 45, latmax = 47,
                    storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "areave",
                    maskmod = maskmod("maskmod.G"), maskobs = listmaskobs, 
                    configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")

  # load MAY start date seasonal data - JJA

  LakeComo.G.JJA=Load("tas", "glosea5_sea", obs = "ERAint",
                    sdates=Maydateseq, leadtimemin = 2, leadtimemax = 4,
                    lonmin = 8, lonmax = 10, latmin = 45, latmax = 47,
                    storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "areave",
                    maskmod = maskmod("maskmod.G"), maskobs = listmaskobs,  
                    configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")




# 2. ECMWF
# ----------

  # load NOVEMBER start date seasonal data - DJF

  LakeComo.E.DJF=Load("tas", "ECMWF_S4_sea", obs = "ERAint",
                    sdates = Novdateseq, leadtimemin = 2, leadtimemax = 4,
                    lonmin = 8, lonmax = 10, latmin = 45, latmax = 47,
                    storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "areave",
                    maskmod = maskmod("maskmod.E"), maskobs = listmaskobs,  
                    configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")
  

  # load MAY start date seasonal data - JJA
  
  LakeComo.E.JJA=Load("tas", "ECMWF_S4_sea", obs = "ERAint",
                    sdates=Maydateseq, leadtimemin = 2, leadtimemax = 4,
                    lonmin = 8, lonmax = 10, latmin = 45, latmax = 47,
                    storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "areave",
                    maskmod = maskmod("maskmod.E"), maskobs = listmaskobs, 
                    configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")
  



# 3. NCEP
# --------  

  # load NOVEMBER start date seasonal data - DJF
  
  LakeComo.N.DJF=Load("tas", "NCEP_sea", obs = "ERAint",
                    sdates = Novdateseq, leadtimemin = 2, leadtimemax = 4,
                    lonmin = 8, lonmax = 10, latmin = 45, latmax = 47,
                    storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "areave",
                    maskmod = maskmod("maskmod.N"), maskobs = listmaskobs, 
                    configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")
  

  # load MAY start date seasonal data - JJA
  
  LakeComo.N.JJA=Load("tas", "NCEP_sea", obs = "ERAint",
                      sdates=Maydateseq, leadtimemin = 2, leadtimemax = 4,
                      lonmin = 8, lonmax = 10, latmin = 45, latmax = 47,
                      storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "areave",
                      maskmod = maskmod("maskmod.N"), maskobs = listmaskobs,   
                      configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")
  



# 4. MF
# --------

  # load NOVEMBER start date seasonal data - DJF
  
  LakeComo.M.DJF=Load("tas", "MF_sea", obs = "ERAint",
                    sdates = Novdateseq, leadtimemin = 2, leadtimemax = 4,
                    lonmin = 8, lonmax = 10, latmin = 45, latmax = 47,
                    storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "areave",
                    maskmod = maskmod("maskmod.M"), maskobs = listmaskobs,   
                    configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")
  

  # load MAY start date seasonal data - JJA
  
  LakeComo.M.JJA=Load("tas", "MF_sea", obs = "ERAint",
                      sdates=Maydateseq, leadtimemin = 2, leadtimemax = 4,
                      lonmin = 8, lonmax = 10, latmin = 45, latmax = 47,
                      storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "areave",
                      maskmod = maskmod("maskmod.M"), maskobs = listmaskobs,   
                      configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")
  



# Combine array
# -------------

LakeComo.DJF.obs <- LakeComo.G.DJF$obs
LakeComo.DJF.exp <- abind(LakeComo.G.DJF$mod, LakeComo.E.DJF$mod, 
                          LakeComo.N.DJF$mod, LakeComo.M.DJF$mod, 
                          along=1)


LakeComo.JJA.obs <- LakeComo.G.JJA$obs
LakeComo.JJA.exp <- abind(LakeComo.G.JJA$mod, LakeComo.E.JJA$mod, 
                          LakeComo.N.JJA$mod, LakeComo.M.JJA$mod, 
                          along=1)


  # save
  saveRDS(LakeComo.DJF.obs, "/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.DJF.obs.rds")
  saveRDS(LakeComo.DJF.exp, "/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.DJF.exp.rds")
  saveRDS(LakeComo.JJA.obs, "/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.JJA.obs.rds")
  saveRDS(LakeComo.JJA.exp, "/esnas/scratch/nmishra/s2dv_test/LakeComo/LakeComo.JJA.exp.rds")
  


