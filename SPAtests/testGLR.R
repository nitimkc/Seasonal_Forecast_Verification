# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Calc GLR from test statistics
# 
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd("/esnas/scratch/nmishra/s2dv_test/SPAtests")
library(s2dverification)
library(abind)
library(plyr)




# load data
# ----------

diff <- readRDS("/esnas/scratch/nmishra/s2dv_test/SavedData/diff.rds")




# calc mean of diff 
# ------------------

# what is the difference in E(d_t) and d_dash
# as per 2005: d_dash is the exp diff I calc below
# mu_k = E(d_t) is assumption?
exp.diff <- apply(diff, c(1,4,5), function(diff) 
  ifelse(all(is.na(diff)), NA, sum(diff, na.rm = TRUE)/n))




# Constructing GLR from test statistics
#