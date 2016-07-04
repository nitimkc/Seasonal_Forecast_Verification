# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Mask for MOD
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

maskmod <- function(x) {
  
  if ( x == "maskmod.G") {
    fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_432x325.nc")
    maskmod <- get.var.ncdf(fnc,"LSM")
    close.ncdf(fnc)
    maskmod[maskmod > 0.5] <- 1
    maskmod[maskmod <= 0.5]<- 0
    #maskmod=t(maskmod)
    listmaskmod=list(maskmod)  
    return(listmaskmod) 
  } 
  else if ( x == "maskmod.E") {
    fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_i360x181.nc")
    maskmod <- get.var.ncdf(fnc,"LSM")
    close.ncdf(fnc)
    maskmod[maskmod > 0.5] <- 1
    maskmod[maskmod <= 0.5]<- 0
    #maskmod=t(maskmod)
    listmaskmod=list(maskmod)  
    return(listmaskmod) 
  } 
  else if ( x == "maskmod.N") {
    fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_384x190.nc")
    maskmod <- get.var.ncdf(fnc,"LSM")
    close.ncdf(fnc)
    maskmod[maskmod > 0.5] <- 1
    maskmod[maskmod <= 0.5]<- 0
    #maskmod=t(maskmod)
    listmaskmod=list(maskmod)  
    return(listmaskmod)
  } 
  else {
    fnc <- open.ncdf("/esnas/exp/ecearth/land_sea_mask_i256x128.nc")
    maskmod <- get.var.ncdf(fnc,"LSM")
    close.ncdf(fnc)
    maskmod[maskmod > 0.5] <- 1
    maskmod[maskmod <= 0.5]<- 0
    #maskmod=t(maskmod)
    listmaskmod=list(maskmod)  
    return(listmaskmod) 
  }
}













