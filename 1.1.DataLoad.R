# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# USE FOR LOADING TEMPERATURE - DATA ONLY
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
library(ncdf)



# mask for MODEL
# --------------
fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_512x256.nc")
lataux <- get.var.ncdf(fnc,"lat")
lot <- get.var.ncdf(fnc,"lon")
maskaux <- get.var.ncdf(fnc,"LSM")
close.ncdf(fnc)

nlat=length(lataux)
if (lataux[1]>0){
  lataux=rev(lataux)
  maskmod=maskaux[,seq(nlat,1)]
}

maskmod[which(maskmod > 0.5)] <- 1
maskmod[which(maskmod < 0.5)] <- 0

#maskmod=t(maskmod)
listmaskmod=list(maskmod, maskmod, maskmod, maskmod)




# mask for OBSERVATION
# --------------------

#fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_512x256.nc")
#maskobs <- get.var.ncdf(fnc,"LSM")
#close.ncdf(fnc)  
#maskobs[which(is.na(maskmod))] <- 1 
#listmaskobs=list(maskobs)


#masklst=list("/esnas/exp/ecearth/land_sea_mask_512x256.nc")




# load NOVEMBER start date seasonal data - DJB
# --------------------------------------------

  # generate dataseq for NOVEMBER start date
  # ----------------------------------------
  Novstart <- as.Date("19921101", "%Y%m%d")
  #Novend <- as.Date("19921101", "%Y%m%d")
  Novend <- as.Date("20121101", "%Y%m%d")
  Novdateseq <- format(seq(Novstart, Novend, by = "year"), "%Y%m%d")


NovStartData=Load("tas", #prlr
               c( "glosea5_sea", "ECMWF_S4_sea", "NCEP_sea", "MF_sea"),
               obs = "ERAint", #GPCP
               sdates = Novdateseq, leadtimemin = 2, leadtimemax = 4,
               lonmin = -20, lonmax = 70, latmin = 25, latmax = 75,
               storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "lonlat",
               maskmod = listmaskmod, #maskobs = listmaskobs, 
               grid = "r512x256",
               configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")

Lat <- NovStartData$lat
Lon <- NovStartData$lon

saveRDS(NovStartData, "/esnas/scratch/nmishra/s2dv_test/SavedData/NovStartData.rds")
saveRDS(Lat, "/esnas/scratch/nmishra/s2dv_test/SavedData/Lat.rds")
saveRDS(Lon, "/esnas/scratch/nmishra/s2dv_test/SavedData/Lon.rds")




# load MAY start date seasonal data - JJA
# ---------------------------------------

  # generate dataseq for MAY start date
  # -----------------------------------
  Maystart <- as.Date("19920501", "%Y%m%d")
  Mayend <- as.Date("20120501", "%Y%m%d")
  Maydateseq <- format(seq(Maystart, Mayend, by = "year"), "%Y%m%d")


MayStartData=Load("tas", #prlr
                  c( "glosea5_sea", "ECMWF_S4_sea", "NCEP_sea", "MF_sea"),
                  obs = "ERAint", #GPCP
                  sdates=Maydateseq, leadtimemin = 2, leadtimemax = 4,
                  lonmin = -20, lonmax = 70, latmin = 25, latmax = 75,
                  storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "lonlat",
                  maskmod = listmaskmod, #maskobs = listmaskobs, 
                  grid = "r512x256",
                  configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")


saveRDS(MayStartData, "/esnas/scratch/nmishra/s2dv_test/SavedData/MayStartData.rds")






# ----------------------------------------------------------------------------------------

# subset
NovGlosea <- NovStartData$mod[1, , , , , ] # "glosea5_sea"
NovECMWF <- NovStartData$mod[2, , , , , ] # "ECMWF_S4_sea"
NovNCEP <- NovStartData$mod[3, , , , , ] # "NCEP_sea"
NovMF <- NovStartData$mod[4, , , , , ] # "MF_sea"
NovObs <- NovStartData$obs[]

# save subset
saveRDS(NovGlosea, "NovGlosea.rds")
saveRDS(NovECMWF, "NovECMWF.rds")
saveRDS(NovNCEP, "NovNCEP.rds")
saveRDS(NovMF, "NovMF.rds")
# ----------------------------------------------------------------------------------------
