library(foreach)
library(doSNOW)

pwinR <- 18/37 ## Winning Probability
pwinG <- 1/37
betsizeG <- 1/35

sitting <- function(playlimit) ## strategy
{
  betsize <- 1
  profit <- 0
  n_spin <- 0

  while(profit < 1)
  {
    roulette = runif(1) ## Roulette result
    
    if(roulette < pwinR) 
    {
      profit <- profit + betsize 
      
      if(profit < 1)
      {
        betsize <- ifelse(profit + betsize + 1 > 1, 1 - profit, betsize + 1)
        #betsize <- betsize + 1
      }
    }
    # else if(roulette >= 1 - pwinG)
    # {
    #   profit <- profit + (betsizeG * 35) - betsize
    #   betsize <- ifelse(profit + betsize + 1 > 1, 1 - profit, betsize + 1)
    # }
    else
    {
      profit <- profit - betsize
    }
    
    n_spin <- n_spin + 1
    
    if((n_spin >= playlimit)||(profit <= -20)||(profit == 0)) ## If the number of spins is greater than your limit break and accept your loss. If profit is 0 reset the round as this can mean you just sat down to start playing
    {
      return(profit)
    }
  }
  
  return(profit)
}
 
n_sim <- 10000

cl <- makeCluster(4)
registerDoSNOW(cl)

results <- foreach(i=1:n_sim) %dopar%
{
  sitting(25)
}

stopCluster(cl)

profit_sim <- unlist(results)

summary(profit_sim)
aux <- table(profit_sim)
hist(profit_sim)

table(ifelse(profit_sim > 0, 1, ifelse(profit_sim == 0, 0,-1)))/100



