# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Calc SPA from test statistics
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/SPAtests")
library(s2dverification)
library(abind)
library(plyr)
library(boot)




# load data
# ----------

diff <- readRDS("/esnas/scratch/nmishra/s2dv_test/SPAtests/diff.rds")
test.RC.vec <- readRDS("/esnas/scratch/nmishra/s2dv_test/SPAtests/test.RC.vec.rds")
n <- dim(diff)[2]*dim(diff)[3]
m <- dim(diff)[1]




# Constructing SPA from test statistics
# ------------------------------------

# studentized test
# SPA = max( max( sqrt(n)*exp.diff/std.dev ), 0)
# mu_SPA = exp.diff*ind.fnc(teststat <= correction.term)

correction.term <- -sqrt(2*log(log(n)))

# bootstrap to construct covar
B <- 10
boot.samples <- matrix(sample(test.RC.vec[,32,1], size = B, replace = TRUE), B, n)
boot.statistics <- apply(boot.samples, 1, mean)

# does this preserve time series? of course not block wise but dimwise?
# boot.samples <- array(sample(test.RC.vec[,32,1], size = B, replace = TRUE), c(B,21,3))










# density plot
ggplot(data.frame(meanTime = boot.statistics), aes(x=meanTime)) +
  geom_histogram(binwidth=0.25,aes(y=..density..)) +
  geom_density(color="red")

# std.dev
time.se = sd(boot.statistics)
time.se

# confidence interval
time.mean = mean(test.RC.vec, na.rm=TRUE)
me = ceiling(10 * 2 * time.se)/10
round(time.mean, 1) + c(-1, 1) * me
me = ceiling(10 * 2 * time.se)/10
round(time.mean, 1) + c(-1, 1) * me




# using the boot package











