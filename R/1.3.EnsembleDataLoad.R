# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ENSEMBLES data to compare with EUROSIP
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
library(s2dverification)
library(ncdf)


# mask for MODEL
# --------------

fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_ENSEMBLES.nc")
maskmod <- get.var.ncdf(fnc,"LSM")
close.ncdf(fnc)
maskmod[maskmod > 0.5] <- 1
maskmod[maskmod <= 0.5]<- 0

listmaskmod=list(maskmod, maskmod, maskmod, maskmod, maskmod)


# mask for OBSERVATION
# --------------------

fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_480x241.nc")
maskobs <- get.var.ncdf(fnc,"LSM")
close.ncdf(fnc)
maskobs[which(is.na(maskobs))] <- 1 

listmaskobs=list(maskobs)



# load NOVEMBER start date seasonal data - DJB
# --------------------------------------------

  # generate dataseq for NOVEMBER start date
  # ----------------------------------------
  ################################# REVSIT THESE DATES##########################
  Novstart <- as.Date("19790501", "%Y%m%d")
  Novend <- as.Date("20100501", "%Y%m%d")
  Novdateseq <- format(seq(Novstart, Novend, by = "year"), "%Y%m%d")


NovEnsembleData=Load("tas",
                   c( "EnsCmccSeas","EnsIfmSeas","EnsEcmwfSeas","EnsMetfrSeas","EnsUkmoSeas"),
                   obs = "ERAint", 
                   sdates=Novdateseq, leadtimemin = 2, leadtimemax = 4,
                   lonmin = -20, lonmax = 70, latmin = 25, latmax = 75,
                   storefreq = "monthly", sampleperiod = 1, nmember=9, output = "lonlat", 
                   maskmod = listmaskmod, maskobs = listmaskobs,
                   configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")

saveRDS(NovEnsembleData, "/esnas/scratch/nmishra/s2dv_test/SavedData/NovEnsembleData.rds")



# load MAY start date seasonal data - JJA
# ---------------------------------------

  # generate dataseq for MAY start date
  # -----------------------------------
  ################################# REVSIT THESE DATES##########################
  Maystart <- as.Date("19920501", "%Y%m%d")
  Mayend <- as.Date("20120501", "%Y%m%d")
  Maydateseq <- format(seq(Maystart, Mayend, by = "year"), "%Y%m%d")


MayEnsembleData=Load("tas",
                     c( "EnsCmccSeas","EnsIfmSeas","EnsEcmwfSeas","EnsMetfrSeas","EnsUkmoSeas"),
                     obs = "ERAint", 
                     sdates=Maydateseq, leadtimemin = 2, leadtimemax = 4,
                     lonmin = -20, lonmax = 70, latmin = 25, latmax = 75,
                     storefreq = "monthly", sampleperiod = 1, nmember=9, output = "lonlat", 
                     maskmod = listmaskmod, maskobs = listmaskobs,
                     configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")

saveRDS(MayEnsembleData, "/esnas/scratch/nmishra/s2dv_test/SavedData/MayEnsembleData.rds")






