library(sqldf)

rouleta <- data.frame(0:36,
                      c(0,32,15,19,4,21,2,25,17,34,6,27,13,36,11,30,8,23,10,5,24,16,33,1,20,14,31,9,22,18,29,7,28,12,35,3,26),
                      c("Green",rep(c("Red","Black"),18)))
                      
colnames(rouleta) <- c("Number","Actual","Color")

outcome <- sample(rouleta$Number,1,replace = TRUE)



