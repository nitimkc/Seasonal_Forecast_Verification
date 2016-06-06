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
nlon <- dim(diff)[4]
nlat <- dim(diff)[5]


# convert to timeseries
ts <- array(NA, c(118,63,1,71,128))
for (i in 1:m) {
 for (j in 1:nlon) {
   for (k in 1:nlat) {
     ts[i,,,j,k] <- cbind(c(diff[i,,,j,k]))
   }
 }
}
ts <- ts[,,1,,]
saveRDS(ts, "/esnas/scratch/nmishra/s2dv_test/SPAtests/ts.rds")
ts <- readRDS("/esnas/scratch/nmishra/s2dv_test/SPAtests/ts.rds")





# calc mean of diff 
# ------------------

# what is the difference in E(d_t) and d_dash
# as per 2005: d_dash is the exp diff I calc below
# mu_k = E(d_t) is assumption?
avg.ts <- apply(ts, c(1,3,4), function(ts) 
  ifelse(all(is.na(ts)), NA, sum(ts, na.rm = TRUE)/n))

saveRDS(avg.ts, "/esnas/scratch/nmishra/s2dv_test/SPAtests/avg.ts.rds")



# Constructing RC from test statistics
# ------------------------------------

# multiply mean by root n
test.RC <- function(x, n) {
  test.stat <- x*sqrt(n)
  return(test.stat)
}

test.RC.vec <- test.RC(avg.ts, n)
saveRDS(test.RC.vec, "/esnas/scratch/nmishra/s2dv_test/SPAtests/test.RC.vec.rds")


# pick max for each grid point
test.stat.RC <- apply(test.RC.vec, c(2,3), function(test.RC.vec) 
  ifelse(all(is.na(test.RC.vec)), NA, max(test.RC.vec, na.rm = TRUE)))

# which model had max value per grid point?
test.stat.RC.ind <- apply(test.RC.vec, c(2,3), function(test.RC.vec) 
  ifelse(all(is.na(test.RC.vec)), NA, which.max(test.RC.vec)))















#####################
x <- test.RC.vec[,32,1]
h <- hist(x, breaks=10, col="red")
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)
d <- density(test.RC.vec[,32,1]) # kernel density
plot(d)

