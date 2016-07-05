# RC  & SPA TEST

install.packages("devtools")
library("devtools")
install_github("ttrTests", username="cran")

library(abind)
library(reshape2)
library(s2dverification)
require(ttrTests)
require(quantmod)
require(lattice)
require(Metrics)
library(stats)
library(tseries)
library(forecast)
library(TTR)


# fnc to convert to celsius
kelvin_to_celsius <- function(temp) {
  #Converts Kelvin to Celsius
  Celsius <- temp - 273.15
  Celsius
}

#### DATA ####
# obs
obs <- readRDS("/Users/peaceforlives/DATASCIENCE/PRACTICUM/Seasonal_Forecast_Verification/Data/tas/JJA.obs.rds")
obs <- obs[,,,46,26]
obs <- kelvin_to_celsius(obs)
obs <- ts(obs, start=1992, end=2012, frequency=1) 

# exp
finalDF <- readRDS("/Users/peaceforlives/DATASCIENCE/PRACTICUM/SPA/finalDF.rds")
finalDF <- kelvin_to_celsius(finalDF)
rownames(finalDF) <- c("MM", paste0(1:24, rep("GLOS", 24)), paste0(1:51, rep("ECMW", 51)),
                       paste0(1:24, rep("NCEP", 24)), paste0(1:15, rep("MF", 15)))

#finalTS <- apply(finalDF, 1, function(x) ts(x, start=1992, end=2012, frequency=1))

# bnchmark
clim <- sapply(obs, mean, simplify = TRUE)
clim <- ts(clim, start=1992, end=2012, frequency=1) 


### ---- ####

conf_int <- returnStats(finalDF[,1])
p_val <- nullModel(finalDF[,1])
RC <- dataSnoop(finalDF[,1], bSamples=3, test="RC")
SPA <- dataSnoop(finalDF[,1], bSamples=3, test="SPA")
persistence_sig <- subperiods(finalDF[,1], periods=1)
param <- paramPersist(finalDF[,1])

for (i in 1:nrow(finalDF)) {
  test_price <- as.vector(finalDF[i,])
  
  RC <- dataSnoop(x=test_price, bSamples=3, test="RC")
  
  
  
  
  # param test
  param_results <- paramStats(x=test_price, start = 20, nSteps = 30, stepSize = 10,
                              restrict = FALSE, burn = 0, short = FALSE, condition = NULL,
                              silent = TRUE, TC = 0.001, loud = TRUE, plot = FALSE, alpha = 0.025,
                              begin = 1, percent = 1, file = "", benchmark = climTS)
  #get excess returns and add to matrix
  ifelse(i==1,param_all <- param_results[[1]],
         param_all <- cbind(param_all,param_results[[1]]))
  #get best parameter and add to matrix
  ifelse(i==1,param_best <- param_results[[5]],
         param_best <- rbind(param_best,param_results[[5]]))
}

### ---- ####
# calc MSE
mse <- function(x_hat, x) rowMeans( (x_hat-x)^2 )
loss <- mse(finalDF, obs) 



ttr <- function ( x , params , burn , short)
  
  
# calc diff between MSE of bnchmrk and MSE of ensembles
diff <- rep(NA, 115)
for (i in 2:115) {
  diff[i] <- loss[1] - loss[i] 
  diff[is.na(diff)] <- 0
}

# log transformation
diff <- (1 + exp(diff))







# calc tests: RC and SPA
rc <- dataSnoop(diff, bSamples=5, test="RC")

dataSnoop(diff, ttr = "macd4", start = 0, nSteps = 0, stepSize = 0, 
          restrict=FALSE, burn = 0, short = FALSE, condition = NULL, silent = TRUE, 
          TC = 0.001, loud = TRUE, alpha = 0.025, crit = "sharpe" , begin = 1, 
          percent = 1, file = "", benchmark = "hold", bSamples = 100, 
          model = "blockBootstrap", userParams=4, test="SPA", latex="output")
}
#ensure luck is not the source of a system’s returns.
spa <- dataSnoop(diff, bSamples=5, test="SPA")


require(quantmod)   #get Dow Jones Industrials from Yahoo! Finance
getSymbols("^DJI",from="1896-01-01",to=Sys.Date())
