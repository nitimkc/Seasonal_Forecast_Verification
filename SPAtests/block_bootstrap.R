####################################################################################################################

# Implements a circular block bootstrap for bootstrapping stationary, dependent series

# INPUTS: (i) DATA   - T by 1 vector of data to be bootstrapped
#        (ii) B      - Number of bootstraps
#       (iii) w      - Block length

# OUTPUTS: (i) BSDATA  - T by B matrix of bootstrapped data
#         (ii) INDICES - T by B matrix of locations of the original BSDATA=DATA(indexes) ?????????

# COMMENTS: To generate bootstrap sequences for other uses, such as bootstrapping vector processes,
#           set DATA to t(1:N).

####################################################################################################################

# test data
data <- rnorm(63,1)
B <- 10
w <- 3


block_bootstrap <- function(data, B, w) {
  
  ####################################
  ##  check input
  
  library(assertthat)
  
  T <- length(data) # no. of time series

  if (T < 2 || is.vector(data) == FALSE) {print("DATA must be a vector with at least 2 observations")}
  if (B < 1 || is.scalar(B) == FALSE ) {print("B must be a positive scalar integer")}
  if (w < 1 || is.scalar(w) == FALSE || w > T) {print("w must be a positive scalar integer smaller than T'")}
  
  ####################################
  
      
  s       <- ceiling(T/w)                              # compute no. of blocks needed 
  Bs      <- floor( matrix(runif(s*B), s)*T )+1        # generate starting points
  
  
  indices <- matrix(0, s*w, B)                         # index original time series and Bs
  index   <- 1
  adder   <- kronecker(matrix(1,1,B), t(0:w-1))        # variable to be added each loop
  
  
  for (i in seq(1, T, 3) ) {
    indices[i, ] <- kronecker(matrix(1,w,1), Bs[index, ]) + adder
    index <- index + 1
  }
  
  
  indices[which(indices>t), ] = indices[which(indices>t), ]- T
  bsdata <- data[indices]                              
  
  
  
  return(as.list(bsdata, indices))
}

  #Compute the number of blocks needed
  #s=ceil(t/w);
  #% Generate the starting points
  #Bs=floor(rand(s,B)*t)+1;
  #indices=zeros(s*w,B);
  #index=1;
  #% Adder is a variable that needs to be added each loop
  #adder=repmat((0:w-1)',1,B);
               #for i=1:w:t
               #indices(i:(i+w-1),:)=repmat(Bs(index,:),w,1)+adder;
               #index=index+1;
               #end
               #indices=indices(1:t,:);
               #indices(indices>t) = indices(indices>t)-t;
               #bsdata=data(indices);
               #indices(i:(i+w-1),:)=repmat(Bs(index,:),w,1)+adder;
               #index=index+1;
               #end
               #indices=indices(1:t,:);
               #indices(indices>t) = indices(indices>t)-t;
               #bsdata=data(indices);
  
  
  
    
}