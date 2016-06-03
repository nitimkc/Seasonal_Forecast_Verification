# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Calc Loss of each model from obs
# Calc Difference between benchmark and ensembles
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/SPAtests")
library(s2dverification)
library(abind)
library(plyr)




# load data
# ----------

ts <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/NovStartData.rds")




# corr
# -----
tsCorr <- Corr(ens, obs, posloop=1, poscor = 2)
saveRDS(tsCorr, "/esnas/scratch/nmishra/s2dv_test/SPAtests/tsCorr.rds")




# calc Climatology (benchmark model)
# ----------------------------------

Clim01 <- InsertDim(Mean1Dim(ts$obs[,,1:2,,,], posdim = 1, narm = TRUE),1,1)
Clim02 <- InsertDim(Mean1Dim(ts$obs[,,1:2,,,], posdim = 1, narm = TRUE),1,1)
Clim03 <- InsertDim(Mean1Dim(ts$obs[,,1:3,,,], posdim = 1, narm = TRUE),1,1)
Clim04 <- InsertDim(Mean1Dim(ts$obs[,,1:4,,,], posdim = 1, narm = TRUE),1,1)
Clim05 <- InsertDim(Mean1Dim(ts$obs[,,1:5,,,], posdim = 1, narm = TRUE),1,1)
Clim06 <- InsertDim(Mean1Dim(ts$obs[,,1:6,,,], posdim = 1, narm = TRUE),1,1)
Clim07 <- InsertDim(Mean1Dim(ts$obs[,,1:7,,,], posdim = 1, narm = TRUE),1,1)
Clim08 <- InsertDim(Mean1Dim(ts$obs[,,1:8,,,], posdim = 1, narm = TRUE),1,1)
Clim09 <- InsertDim(Mean1Dim(ts$obs[,,1:9,,,], posdim = 1, narm = TRUE),1,1)
Clim10 <- InsertDim(Mean1Dim(ts$obs[,,1:10,,,], posdim = 1, narm = TRUE),1,1)
Clim11 <- InsertDim(Mean1Dim(ts$obs[,,1:11,,,], posdim = 1, narm = TRUE),1,1)
Clim12 <- InsertDim(Mean1Dim(ts$obs[,,1:12,,,], posdim = 1, narm = TRUE),1,1)
Clim13 <- InsertDim(Mean1Dim(ts$obs[,,1:13,,,], posdim = 1, narm = TRUE),1,1)
Clim14 <- InsertDim(Mean1Dim(ts$obs[,,1:14,,,], posdim = 1, narm = TRUE),1,1)
Clim15 <- InsertDim(Mean1Dim(ts$obs[,,1:15,,,], posdim = 1, narm = TRUE),1,1)
Clim16 <- InsertDim(Mean1Dim(ts$obs[,,1:16,,,], posdim = 1, narm = TRUE),1,1)
Clim17 <- InsertDim(Mean1Dim(ts$obs[,,1:17,,,], posdim = 1, narm = TRUE),1,1)
Clim18 <- InsertDim(Mean1Dim(ts$obs[,,1:18,,,], posdim = 1, narm = TRUE),1,1)
Clim19 <- InsertDim(Mean1Dim(ts$obs[,,1:19,,,], posdim = 1, narm = TRUE),1,1)
Clim20 <- InsertDim(Mean1Dim(ts$obs[,,1:20,,,], posdim = 1, narm = TRUE),1,1)
Clim21 <- InsertDim(Mean1Dim(ts$obs[,,1:21,,,], posdim = 1, narm = TRUE),1,1)


Clim <- abind(Clim01, Clim02, Clim03, Clim04, Clim05, Clim06, Clim07, Clim08, Clim09, Clim10,
              Clim11, Clim12, Clim13, Clim14, Clim15, Clim16, Clim17, Clim18, Clim19, Clim20,
              Clim21, along=1)




# calc loss based on point forecast
# Page 4 : http://www-siepr.stanford.edu/workp/swp05003.pdf
# ----------------------------------------------------------

  # prepare data
  Clim <- InsertDim(Clim, 1, 1)
  Mod1 <- ts$mod[1,1:24,,,,]
  Mod2 <- ts$mod[2,,,,,]
  Mod3 <- ts$mod[3,1:28,,,,]
  Mod4 <- ts$mod[4,1:15,,,,]
   
  ens <- abind(Clim, Mod1,Mod2,Mod3,Mod4, along=1) # [1]   119  21   3  71 128
  obs <- InsertDim(ts$obs[,,,,,], 1, 1)            # [1]     1  21   3  71 128
  
  # calc loss   
  dimens <- dim(ens)
  nens <- dimens[1]
  ndates <- dimens[2]
  ntime <- dimens[3] 
  n <- (ndates*ntime)
  nlat <- dimens[4]
  nlon <- dimens[5]
  
  loss <- array(NA, dim=c(nens, ndates, ntime, nlat, nlon))
  for ( i in 1:nens) {
    loss[i,,,,] <- (obs[,,,,] - ens[i,,,,])^2
  }
  
  #save
  saveRDS(loss, "/esnas/scratch/nmishra/s2dv_test/SPAtests/loss.rds")

  # According to 2005 paper(pg7), exp diff is not necessary
  # provided that mu = E(d_t)
  #exp.loss <- array(NA, dim=c(nens, ndates, ntime, nlat, nlon))
  #for ( i in 1:nens) {
  #  exp.loss[i,,,,] <- ((obs[,,,,] - ens[i,,,,])^2)/(n)
  #}
  
  #save
  #saveRDS(exp.loss, "/esnas/scratch/nmishra/s2dv_test/SPAtests/exp.loss.rds")


# calc diff from Benchmark model (119)
# -------------------------------------

Bchmrk.Forecast <- InsertDim(loss[1,,,,], 1, 1)
Eval.Forecast <- loss[-1,,,,]


diff <- array(NA, dim=c((nens-1), ndates, ntime, nlat, nlon))
for ( i in 1:(nens-1)) {
  diff[i,,,,] <- Bchmrk.Forecast[,,,,] - Eval.Forecast[i,,,,]
}

saveRDS(diff, "/esnas/scratch/nmishra/s2dv_test/SPAtests/diff.rds")




#### test data ###
# testdata <- diff[1:5,,,,]
# saveRDS(testdata, "/esnas/scratch/nmishra/s2dv_test/SPAtests/testdata.rds")

# avg.testdata <- apply(testdata, 1, function(testdata) 
#   ifelse(all(is.na(testdata)), NA, sum(testdata, na.rm = TRUE)/(n)))




#####################
x <- test.RC.vec[,32,1]
h <- hist(x, breaks=10, col="red")
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)
d <- density(test.RC.vec[,32,1]) # kernel density
plot(d)









