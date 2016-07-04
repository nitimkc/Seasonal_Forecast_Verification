####################################################################################################################

# Calculate Whites and Hansens p-vals for out-performance using unmodified data or studentized
# residuals, the latter often providing better power, particularly when the losses functions are
# heteroskedastic
# INPUTS: (i) BENCH  - Losses from the benchmark model
#        (ii) MODELS - Losses from each of the models used for comparison
#       (iii) B      - Number of Bootstrap replications
#        (iv) W      - Desired block length
#         (v) TYPE   - String, either 'STANDARD' or 'STUDENTIZED'(default)
#        (vi) BOOT   - 'STATIONARY' (default) or 'BLOCK' [OPTIONAL]

# OUTPUTS: (i) C - Consistent P-val(Hansen)
#         (ii) U - Upper P-val(White) (Original RC P-vals)
#        (iii) L - Lower P-val(Hansen)

# COMMENTS: This version of the BSDS operates on quantities that should be 'bads', such as losses.  The null
#           hypothesis is that the average performance of  the benchmark is as small as the minimum average
#           performance across the models.  The alternative is that the minimum average loss across the
#           models is smaller than the the average performance of the benchmark.

####################################################################################################################

# test data
# testdata <- readRDS("/esnas/scratch/nmishra/s2dv_test/SPAtests/testdata.rds")
bench <- rnorm(63,1)
models <- matrix(rnorm(63,10), 5, 63)
B <- 10
w <- 3


bsds <- function(bench, models, B, w, type, boot) {
  
  ####################################
  ##  check input
  
  library(assertthat)
  
  if (nargs() < 4 || narg() > 6) {print("4 to inputs required")}
  
  if (a == 4) {boot = 'STATIONARY' ; type = 'STUDENTIZED'
  } else { 
    if (a == 5) {boot = 'STATIONARY'} }
  
  if (missing(type)) {type = 'STUDENTIZED'}

  # Get the length of the data
  T <- length(bench)
  k <- nrow(models)
  
  if (is.null(nrow(bench)) == FALSE) {print("BENCH must be a column vector")}
  if (T < 2) {print("BENCH must have at least 2 observations.")}
  if (T != ncol(models)) {"BENCH and MODELS must have the same number of observations."}

  if (B < 1 || is.scalar(B) == FALSE || floor(B) != B) 
    {print("B must be a positive scalar integer")}
  
  if (w < 1 || is.scalar(w) == FALSE || floor(w) != w || w > T) 
    {print("w must be a positive scalar integer smaller than T'")}
  
  if (is.na(match(boot, c('STATIONARY','BLOCK')) == TRUE)) 
    {print("BOOT must be either 'STATIONARY' or 'BLOCK'.")}
  
  ####################################
  ## obtain bootstrap data
  
  if (boot == 'BLOCK') {
      bsdata <- block_bootstrap(t(1:T), B, w)
    } else {
      bsdata=stationary_bootstrap(t(1:t), B, w)}
  
  ####################################
  
  ## obtain difference  
  diffs <- models - t(kronecker(matrix(1,1,k),bench))
  
  ## weights
  q <- 1/w
  i <- 1:T-1
  
  ## compute bootstrap sample averages, db*
  kappa=((T-i)/T)*(1-q)^i + i/T*(1-q)^(T-i)
  
  ## Next compute the variances, omegak
  vars = t(matrix(0,k,1))
  for (i in 1:k) {
    workdata = diffs[ ,i] - mean(diffs[ ,i])
    vars[i]= t(workdata)*workdata/T;
  }
  for (j in 1:T-1) {
  vars[i] = vars[i] + 2*kappa[j]*(t(workdata[1-j])*workdata[j+1])/T
  }
  
  # Aold is the original method to compute the truncation point
  Aold <- 1/4*T^(0.25)*sqrt(vars/T)
  Aold <- mean(Aold)
  # A new used the log(log(t)) rule
  Anew = sqrt((vars/T)*2*log(log(T)));
  
  # Only recenter if the average is reasonably small or the model is better
  # (in which case mean(diffs) is negative).  If it is unreasonably large set
  # the mean adjustment to 0
  gc <- mean(diffs)*(mean(diffs) < Anew)
  
  # The lower assumes that every loss function that is worse than BM is
  # unimportant for the asymptotic distribution, hence if its mean is
  # less than 0, g=0.  This is different from the consistent where the
  # threshold was it had to be greater than -A(i)
  gl <- min(0, mean(diffs))
  
  #Then the upper, which assumes all models used are reasonably close to
  #the benchmark that they could be better
  gu <- mean(diffs)
  
  # Perf will hold the boostrapped statistics for B iterations
  perfc <- matrix(0,B,k)
  perfl <- matrix(0,B,k)
  perfu <- matrix(0,B,k)
  
  if (type == 'STUDENTIZED') {stdDev <- sqrt(vars)
  } else { 
    if (type == 'STANDARD') {stdDev <- matrix(1,1,k) } } 

  for (i in 1:k) {
  
    workdata <- diffs[ , i]   
  
    ## the i'th column of perf holds the B bootstrapped statistics
    mworkdata <- mean(workdata(bsdata))
    perfc[ , i] <- t( (mworkdata - gc[i]) )/stdDev[i]
    perfl[ , i] <- t( (mworkdata - gl[i]) )/stdDev[i]
    perfu[ , i] <- t( (mworkdata - gu[i]) )/stdDev[i]
    
    ## Compute the test statistic
    stat <- min( mean(diffs)/stdDev )
    
    ## Compute the min in each row
    perfc <- min( perfc, [] , 2)
    perfc <- min( perfc, 0 )
    
    perfl <- min( perfl, [], 2)
    perfl <- min( perfl, 0)
    
    perfu <- min( perfu, [], 2)
    perfu <- min( perfu, 0)
  }
  
  ## Count the number of time the min is below the statistic
  c <- mean( perfc<stat )
  l <- mean( perfl<stat )
  u <- mean( perfu<stat )

}  