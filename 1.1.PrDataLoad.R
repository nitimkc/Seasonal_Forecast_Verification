# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# USE FOR LOADING PRECIPITATION - DATA ONLY
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("/esnas/scratch/nmishra/s2dv_test")
library(s2dverification)
library(ncdf)




# mask for MODEL
# --------------

fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_512x256.nc")
lataux <- get.var.ncdf(fnc,"lat")
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
#maskobs[which(is.na(maskobs))] <- 1 
#listmaskobs=list(maskobs)


#masklst=list("/esnas/exp/ecearth/land_sea_mask_512x256.nc")



# load NOVEMBER start date seasonal data - DJB
# --------------------------------------------
  
  # generate dataseq for NOVEMBER start date
  # ----------------------------------------
  Novstart <- as.Date("19921101", "%Y%m%d")
  #Novend <- as.Date("19941101", "%Y%m%d")
  Novend <- as.Date("20121101", "%Y%m%d")
  Novdateseq <- format(seq(Novstart, Novend, by = "year"), "%Y%m%d")



#glosea5_sea <- list(name = 'glosea5_sea')
#ECMWF_S4_sea <- list(name = 'ECMWF_S4_sea')
#NCEP_sea <- list(name = 'NCEP_sea')
#MF_sea <- list(name = 'MF_sea') #, dimnames = list(member = 'number'))
PrNovStartData=Load("prlr", obs = "GPCP",
                    c("glosea5_sea", "ECMWF_S4_sea", "NCEP_sea", "MF_sea"),
                    sdates = Novdateseq, leadtimemin = 2, leadtimemax = 4,
                    lonmin = -20, lonmax = 70, latmin = 25, latmax = 75,
                    storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "lonlat",
                    maskmod = listmaskmod, #maskobs = listmaskobs, 
                    grid = "r512x256",
                    configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")


NovLat <- PrNovStartData$lat
NovLon <- PrNovStartData$lon

saveRDS(PrNovStartData, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrNovStartData.rds")
saveRDS(NovLat, "/esnas/scratch/nmishra/s2dv_test/SavedData/NovLat.rds")
saveRDS(NovLon, "/esnas/scratch/nmishra/s2dv_test/SavedData/NovLon.rds")





# load MAY start date seasonal data - JJA
# ---------------------------------------

  # generate dataseq for MAY start date
  # -----------------------------------
  Maystart <- as.Date("19920501", "%Y%m%d")
  Mayend <- as.Date("20120501", "%Y%m%d")
  Maydateseq <- format(seq(Maystart, Mayend, by = "year"), "%Y%m%d")



PrMayStartData=Load("prlr", obs = "GPCP",
                    c("glosea5_sea", "ECMWF_S4_sea", "NCEP_sea", "MF_sea"),
                    sdates=Maydateseq, leadtimemin = 2, leadtimemax = 4,
                    storefreq = "monthly", sampleperiod = 1, nmember = 51, output = "lonlat", 
                    lonmin = -20, lonmax = 70, latmin = 25, latmax = 75, 
                    maskmod = listmaskmod, #maskobs = listmaskobs,
                    grid = "r512x256",
                    configfile = "/home/Earth/nmishra/s2dv_test/BSC_chloe.conf")

saveRDS(PrMayStartData, "/esnas/scratch/nmishra/s2dv_test/SavedData/PrMayStartData.rds")
saveRDS(MayLat, "/esnas/scratch/nmishra/s2dv_test/SavedData/MayLat.rds")
saveRDS(MayLon, "/esnas/scratch/nmishra/s2dv_test/SavedData/MayLon.rds")
