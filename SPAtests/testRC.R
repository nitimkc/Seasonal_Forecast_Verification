# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Calc RC from test statistics
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/SPAtests")
library(s2dverification)
library(abind)
library(plyr)




# load data
# ----------

diff <- readRDS("/esnas/scratch/nmishra/s2dv_test/SPAtests/diff.rds")
n <- dim(diff)[2]*dim(diff)[3]
m <- dim(diff)[1]




# calc mean of diff 
# ------------------

# what is the difference in E(d_t) and d_dash
# as per 2005: d_dash is the exp diff I calc below
# mu_k = E(d_t) is assumption?
avg.diff <- apply(diff, c(1,4,5), function(diff) 
  ifelse(all(is.na(diff)), NA, sum(diff, na.rm = TRUE)/n))




# Constructing RC from test statistics
# ------------------------------------

test.RC <- function(x, n) {
  test.stat <- x*sqrt(n)
  return(test.stat)
}

testRCvec <- test.RC(avg.diff, n)

test.stat.RC <- apply(testRCvec, c(2,3), function(testRCvec) 
  ifelse(all(is.na(testRCvec)), NA, max(testRCvec, na.rm = TRUE)))

# which model had max value per grid point?
test.stat.RC.ind <- apply(testRCvec, c(2,3), function(testRCvec) 
  ifelse(all(is.na(testRCvec)), NA, which.max(testRCvec)))

saveRDS(testRCvec, "/esnas/scratch/nmishra/s2dv_test/SPAtests/testRCvec.RDS")




#####################
x <- test.RC.vec[,32,1]
h <- hist(x, breaks=10, col="red")
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)
d <- density(test.RC.vec[,32,1]) # kernel density
plot(d)

