rm(list=ls())
gc()
rm(list=ls())
require(digest)
path<-"C:/Users/vaudigier/Documents/save/261217/Article/Review_30_11_17/R/Multilevel_Compare/"
path.save<-paste(path,"output/",sep="")
library(parallel)
nnodes <- 3



#################################################
#perform simulations for each configuration ii
################################################

#generate parameters for simulation
source(paste(path,"parameter.R",sep=""),encoding="latin1")
Callgros<-Call

#import functions
source(paste(path,"stackresults.R",sep=""),encoding="latin1")
source(paste(path,"generate_data.r",sep=""),encoding="latin1")
source(paste(path,"mice.impute.2l.2stage.norm.reml.R",sep=""),encoding="latin1")
source(paste(path,"mice.impute.2l.2stage.norm.mm.R",sep=""),encoding="latin1")
source(paste(path,"mice.impute.2l.2stage.bin.reml.R",sep=""),encoding="latin1")
source(paste(path,"mice.impute.2l.2stage.bin.mm.R",sep=""),encoding="latin1")
source(paste(path,"mice.impute.2l.glm.bin.R",sep=""),encoding="latin1")
source(paste(path,"mice.impute.2l.glm.norm.R",sep=""),encoding="latin1")
source(paste(path,"mice.impute.2l.norm.syst.r",sep=""),encoding="latin1")
source(paste(path,"analyse.R",sep=""),encoding="latin1")
source(paste(path,"summarize.results.r",sep=""),encoding="latin1")

#simulation for configuration ii
for(ii in 1:26){
  set.seed(1)
  Call<-Callgros[[ii]]

  #generate data / MI / analysis / pooling
  cl <- makeCluster(nnodes, type="PSOCK",
                    outfile=paste(path.save,"output.txt",sep=""))
  clusterExport(cl, list("path","Call","seedlist","create_data","analyse","analyse.cc","create_missing","mice.impute.2l.glm.bin",
                         "mice.impute.2l.glm.norm","mice.impute.2l.2stage.bin.reml",
                         "mice.impute.2l.2stage.bin.mm","mice.impute.2l.2stage.norm.reml",
                         "mice.impute.2l.2stage.norm.mm","summarize.results","mice.impute.2l.norm.syst"))  
  clusterEvalQ(cl, library(mice));clusterEvalQ(cl, library(nlme));
  clusterEvalQ(cl, library(mvtnorm));clusterEvalQ(cl, library(lme4));
  clusterEvalQ(cl, library(xtable))#;clusterEvalQ(cl, library(setRNG));
  clusterEvalQ(cl, library(mvmeta));clusterEvalQ(cl, library(Matrix));
  clusterEvalQ(cl, library(MASS));clusterEvalQ(cl, library(missForest));
  clusterEvalQ(cl, library(missMDA));
  #clusterEvalQ(cl, library(VIM));
  clusterEvalQ(cl, library(jomo));clusterEvalQ(cl, library(parallel)); clusterEvalQ(cl, library(pan))
  
  #################################
  #generate data, perform imputation, perform analysis and pooling
  source(paste(path,"simu_one_par.r",sep=""),encoding="latin1")
  #################################
  
  stopCluster(cl)
  
  ################################
  #stack the inference results in a list 
  res.stack<-stackresults(res=res)
  ################################
  
  #################################
  #calculate the bias, the rmse, model SE and emp se, average time
  sink(file=paste(path.save,"summary_config_",Call$numconfig,".txt",sep=""))
  print(try(summarize.results(res.stack)))
  sink()
  #################################
}