# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Calc SPA from test statistics
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/SPAtests")
library(s2dverification)
library(abind)
library(plyr)
library(boot)
library(reshape2)





# load data
# ----------

test.RC.vec <- readRDS("/esnas/scratch/nmishra/s2dv_test/SPAtests/test.RC.vec.rds")
diff <- readRDS("/esnas/scratch/nmishra/s2dv_test/SPAtests/diff.rds")

ts <- readRDS("/esnas/scratch/nmishra/s2dv_test/SPAtests/ts.rds")
avg.ts <- readRDS("/esnas/scratch/nmishra/s2dv_test/SPAtests/avg.ts.rds")

n <- dim(diff)[2]*dim(diff)[3]
m <- dim(diff)[1]


# Constructing SPA from test statistics
# ------------------------------------

correction.term <- -sqrt(2*log(log(n)))

# bootstrap to construct covar
ts1 <- ts[,,32,1]

statistics <- function(x, ind) {
  return(mean(x[ind]))
}

# can you return a vector of sample mean for each grid point here?
# http://people.tamu.edu/~alawing/materials/ESSM689/Btutorial.pdf

B = 1000
block = 3
boot <- tsboot(tseries = ts1, statistic = statistics, R = B, l = 3, 
                     sim = "fixed", endcorr = TRUE)

summary(boot)
plot(boot) # for t1*

CI <- boot.ci(boot, conf = 0.95, type = 'norm')
print(CI)
CI_norm <- CI$normal[ ,c(2,3)]
print(CI_norm)
hist(boot$t[,1], main = 'Coefficient of Determination: Difference', 
     xlab = 'what is this', col = 'grey', prob = T)
lines(density(boot$t[,1]), col = 'blue')
abline(v = CI_norm, col = 'red')




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











