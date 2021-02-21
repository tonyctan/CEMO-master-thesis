##########################################
#simulations for a given configuration
##########################################

require(mice)
require(nlme)
require(mvtnorm)
require(lme4)
require(xtable)
# require(setRNG)
require(mvmeta)
require(Matrix)
require(MASS)
require(missForest)
require(missMDA)
#require(VIM)
require(jomo)
require(pan)


###################
#initialization of R objects to stack results
###################

nbmethod<-length(Call$method)

mattimes<-vector(length=9,"numeric")
names(mattimes)<- c("FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")

if (!is.null(Call$sigma_eps)){
  #continuous outcome
  arrayfitmodel<-array(NA,dim=c(24+length((Call$sigma_eps)),nbmethod),dimnames=list(c(
    "coef_X0","coef_X1","coef_X2",
    "fixSD_X0","fixSD_X1","fixSD_X2",
    "ranSD_X0","ranSD_X1","ranSD_X2",
    "rancorr_01","rancorr_02","rancorr_12",
    "fmi_X0","fmi_X1","fmi_X2",
    "lo95_X0","lo95_X1","lo95_X2",
    "hi95_X0","hi95_X1","hi95_X2",
    "cov_X0","cov_X1","cov_X2",
    paste("sigma_eps",seq(length((Call$sigma_eps))),sep="")),
    Call$method)
  )
}else{
  # binary outcome
  arrayfitmodel<-array(NA,dim=c(24,nbmethod),dimnames=list(c(
    "coef_X0","coef_X1","coef_X2",
    "fixSD_X0","fixSD_X1","fixSD_X2",
    "ranSD_X0","ranSD_X1","ranSD_X2",
    "rancorr_01","rancorr_02","rancorr_12",
    "fmi_X0","fmi_X1","fmi_X2",
    "lo95_X0","lo95_X1","lo95_X2",
    "hi95_X0","hi95_X1","hi95_X2",
    "cov_X0","cov_X1","cov_X2"),
    Call$method)
  )
}

arrayfitalpha_01<-array(NA,dim=c(6,nbmethod),dimnames=list(
  c("coef_X1","fixSD_X1","fmi_X1","lo95_X1","hi95_X1","cov_X1"),
  Call$method)
)

arrayfitalpha_02<-array(NA,dim=c(6,nbmethod),dimnames=list(
  c("coef_X2","fixSD_X2","fmi_X2","lo95_X2","hi95_X2","cov_X2"),
  Call$method)
)

arrayfitcor<-array(NA,dim=c(Call$I,6,nbmethod),dimnames=list(
  as.character(1:Call$I),
  c("coef_X1X3","lo95_X1X3","hi95_X1X3","fmi_X1X3","fixSD_X1X3","cov_X1X3"),
  Call$method)
)

listfit<-list(arrayfitmodel,arrayfitalpha_01,arrayfitalpha_02,arrayfitcor)
names(listfit)<-c("model","alpha_01","alpha_02","cor")


res<-parSapply(cl,as.list(1:Call$nbsim), FUN=function(sim,Call,seedlist,listfit,mattimes,matdiagnos){
  print(sim)
  ###### intern functions
  tab.disjonctif.NA <- function(tab) {
    tab <- as.data.frame(tab)
    modalite.disjonctif <- function(i) {
      moda <- tab[, i]
      nom <- names(tab)[i]
      n <- length(moda)
      moda <- as.factor(moda)
      x <- matrix(0, n, length(levels(moda)))
      ind <- (1:n) + n * (unclass(moda) - 1)
      indNA <- which(is.na(ind))
      x[(1:n) + n * (unclass(moda) - 1)] <- 1
      x[indNA, ] <- NA
      if ((ncol(tab) != 1) & (levels(moda)[1] %in% c(1:nlevels(moda), 
                                                     "n", "N", "y", "Y"))) 
        dimnames(x) <- list(row.names(tab), paste(nom, 
                                                  levels(moda), sep = "."))
      else dimnames(x) <- list(row.names(tab), levels(moda))
      return(x)
    }
    if (ncol(tab) == 1) 
      res <- modalite.disjonctif(1)
    else {
      res <- lapply(1:ncol(tab), modalite.disjonctif)
      res <- as.matrix(data.frame(res, check.names = FALSE))
    }
    return(res)
  }
  
  prelim.pmm<-function (res.mice, don.na) 
  {
    
    res.mi<-sapply(seq_len(res.mice$m), FUN=complete,x=res.mice,simplify = FALSE)
    res.mi<-lapply(res.mi,FUN=function(xx,don.na){
      don.out<-cbind.data.frame(cluster=don.na$cluster,xx[,(ncol(xx)-ncol(don.na)+2):ncol(xx)])
      return(don.out)
    },don.na=don.na)
    longformat <- rbind(don.na, do.call(rbind, res.mi))
    longformat <- cbind(.imp = rep(0:length(res.mi), 
                                   each = nrow(don.na)), .id = rep(1:nrow(don.na), (length(res.mi) + 
                                                                                      1)), longformat)
    rownames(longformat) <- NULL
    imp.mids <- as.mids(longformat)
    
    
    return(imp.mids)
  }
  
  ######  Generate complete data
  don.full<-create_data(seed=seedlist[sim],I=Call$I,n=Call$n,sigma2_v1=Call$sigma2_v1,rho=Call$rho,sigma2_v2=Call$sigma2_v2,
                        alpha_01=Call$alpha_01,sigma2_epsi=Call$sigma2_epsi,alpha_02=Call$alpha_02,
                        beta=Call$beta,lambda=Call$lambda,sigma_eps=Call$sigma_eps,psi=Call$psi,bincov=Call$bincov,randomslope=Call$randomslope,probit=Call$probit)
  ###### add missing values
  don.na<-create_missing(don.full,pi_spor=Call$pi_spor,pi_syst=Call$pi_syst,vna.mcar = Call$vna.mcar,betaMAR_0=Call$betaMAR_0,betaMAR_1=Call$betaMAR_1)
  
  ##### inference according to a given method
  

  
  if("Full"%in%Call$method){
    ###### Reference analysis on full data
    print("Full")
    res.temp<-analyse.cc(don.full)
    listfit[["model"]][,"Full"]<-res.temp$model
    listfit[["alpha_01"]][,"Full"]<-res.temp$alpha_01
    listfit[["alpha_02"]][,"Full"]<-res.temp$alpha_02
  }
  
  if("CC"%in%Call$method){
    ###### Complete Case analysis
    print("CC")
    res.temp<-analyse.cc(don.na)
    listfit[["model"]][,"CC"]<-res.temp$model
    listfit[["alpha_01"]][,"CC"]<-res.temp$alpha_01
    listfit[["alpha_02"]][,"CC"]<-res.temp$alpha_02
  }
  
  if("FCS-2stageREML"%in%Call$method){
    ###### 2 stage method
    print("2steps REML")
    tmptimes<-Sys.time()
    temp<-mice(don.na$don.na,m=Call$m,maxit=0,defaultMethod = c("2l.2stage.norm.reml","2l.2stage.bin.reml","2l.2stage.bin.reml"))
    temp$pred[,"cluster"]<-c(0,-2,-2,-2,-2)
    temp$pred[temp$pred==1]<-2
    res.mice<-try(mice(don.na$don.na,m=Call$m,defaultMethod = c("2l.2stage.norm.reml","2l.2stage.bin.reml","2l.2stage.bin.reml"),
                       pred=temp$pred,maxit = Call$maxit,printFlag=Call$affichage))
    mattimes["FCS-2stageREML"]<-as.numeric(difftime(Sys.time(),tmptimes),unit="mins")
    if(class(res.mice)!="try-error"){
      res.temp<-try(analyse(res.mice,call = don.na$call))
      if(class(res.temp)!="try-error"){
        listfit[["model"]][,"FCS-2stageREML"]<-res.temp$model
        listfit[["alpha_01"]][,"FCS-2stageREML"]<-res.temp$alpha_01
        listfit[["alpha_02"]][,"FCS-2stageREML"]<-res.temp$alpha_02
      }
    }else{print("failure 2stepsREML")}
  }
  
  if("FCS-2stageMM"%in%Call$method){
    ###### 2 stage method (version MM)
    print("2steps MM")
    tmptimes<-Sys.time()
    temp<-mice(don.na$don.na,m=Call$m,maxit=0,defaultMethod = c("2l.2stage.norm.mm","2l.2stage.bin.mm","2l.2stage.bin.mm"))
    temp$pred[,"cluster"]<-c(0,-2,-2,-2,-2)
    temp$pred[temp$pred==1]<-2
    res.mice<-try(mice(don.na$don.na,m=Call$m,defaultMethod = c("2l.2stage.norm.mm","2l.2stage.bin.mm","2l.2stage.bin.mm"),
                       pred=temp$pred,maxit = Call$maxit,printFlag=Call$affichage))
    mattimes["FCS-2stageMM"]<-as.numeric(difftime(Sys.time(),tmptimes),unit="mins")
    if(class(res.mice)!="try-error"){
      res.temp<-try(analyse(res.mice,call = don.na$call))
      if(class(res.temp)!="try-error"){
        listfit[["model"]][,"FCS-2stageMM"]<-res.temp$model
        listfit[["alpha_01"]][,"FCS-2stageMM"]<-res.temp$alpha_01
        listfit[["alpha_02"]][,"FCS-2stageMM"]<-res.temp$alpha_02
      }
    }else{print("failure 2stageMM")}
  }
  
  
  
  if("FCS-GLM"%in%Call$method){
    ###### FCS-GLM
    print("FCS-GLM")
    tmptimes<-Sys.time()
    temp<-mice(don.na$don.na,m=Call$m,maxit=0,defaultMethod = c("2l.glm.norm","2l.glm.bin"))
    temp$pred[,"cluster"]<-c(0,-2,-2,-2,-2)
    temp$pred[temp$pred==1]<-2
    res.mice<-try(mice(don.na$don.na,m=Call$m,defaultMethod = c("2l.glm.norm","2l.glm.bin"),
                       pred=temp$pred,maxit = Call$maxit,printFlag=Call$affichage))
    mattimes["FCS-GLM"]<-as.numeric(difftime(Sys.time(),tmptimes),unit="mins")
    if(class(res.mice)!="try-error"){
      res.temp<-analyse(res.mice,call = don.na$call)
      listfit[["model"]][,"FCS-GLM"]<-res.temp$model
      listfit[["alpha_01"]][,"FCS-GLM"]<-res.temp$alpha_01
      listfit[["alpha_02"]][,"FCS-GLM"]<-res.temp$alpha_02
    }else{print("failure FCS-GLM")}
  }
  
  
  
  if("JM-jomo"%in%Call$method){
    ###### jomo
    print("JM-jomo")
    if(!Call$affichage){aff<-0}else{aff<-1}
    tmptimes<-Sys.time()
    yjomo<-don.na$don.na[,c("X1","X2","X3","Y")]
    clusjomo<-data.frame(don.na$don.na[,"cluster",drop=F])
    xjomo<-zjomo<-data.frame("intercept"=rep(1,nrow(don.na$don.na)))
    if(is.null(Call$iterjomo)){nbetween<-nburn<-100}else{nbetween<-Call$iterjomo["nbetween"];nburn<-Call$iterjomo["nburn"]}
    try.res<-try(jomo(Y=yjomo,
                      clus=clusjomo,
                      nimp=Call$m,
                      X=xjomo,
                      Z=zjomo,
                      meth=Call$methodjomo,
                      output=aff,
                      nbetween=nbetween,
                      nburn=nburn))
    
    mattimes["JM-jomo"]<-as.numeric(difftime(Sys.time(),tmptimes),unit="mins")
    if(class(try.res)!="try-error"){
      
      #change the output format
      try.res<-try.res[,-which(colnames(try.res)=="intercept")]
      try.res<-try.res[,c(1:(ncol(don.na$don.na)-1),(ncol(try.res)-2):ncol(try.res))]
      for(i in 1:(ncol(try.res)-3)){
        if((colnames(try.res)[i])%in%colnames(don.na$don.na)){
          if(class(try.res[,i])!=class(don.na$don.na[,colnames(try.res)[i]])){
            if(class(don.na$don.na[,colnames(try.res)[i]])=="factor"){
              try.res[,i]<-as.factor(as.character(try.res[,i]))
            }else{
              cat("\n pb jomo var",i)
            }
          }
        }
      }
      colnames(try.res)[which(colnames(try.res)=="clus")]<-"cluster"
      try.res$cluster<-rep(don.na$don.na$cluster,Call$m+1)
      res.jomo<-as.mids(try.res,.imp=which(colnames(try.res)=="Imputation"),.id=which(colnames(try.res)=="id"))
      
      #analyse
      res.temp<-try(analyse(res.jomo,call = don.na$call))
      if(class(res.temp)!="try-error"){
        listfit[["model"]][,"JM-jomo"]<-res.temp$model
        listfit[["alpha_01"]][,"JM-jomo"]<-res.temp$alpha_01
        listfit[["alpha_02"]][,"JM-jomo"]<-res.temp$alpha_02
      }
    }else{print("failure JM")}
  }
  
  
  if("FCS-fixclustPMM"%in%Call$method){
    ###### PMM
    print("FCS-fixclustPMM")
    tmptimes<-Sys.time()
    don.temp<-cbind.data.frame(scale(tab.disjonctif.NA(don.na$don.na$cluster),scale=F),don.na$don.na[,-which("cluster"==colnames(don.na$don))])
    res.mice<-try(mice(don.temp,m=Call$m,method="pmm",
                       maxit = Call$maxit,printFlag=Call$affichage))
    mattimes["FCS-fixclustPMM"]<-as.numeric(difftime(Sys.time(),tmptimes),unit="mins")
    if(class(res.mice)!="try-error"){
      res.mice<-prelim.pmm(res.mice,don.na$don.na)
      res.temp<-try(analyse(res.mice,call = don.na$call))
      if(class(res.temp)!="try-error"){
        listfit[["model"]][,"FCS-fixclustPMM"]<-res.temp$model
        listfit[["alpha_01"]][,"FCS-fixclustPMM"]<-res.temp$alpha_01
        listfit[["alpha_02"]][,"FCS-fixclustPMM"]<-res.temp$alpha_02
      }
    }else{print("failure FCS-fixclustPMM")}
  }
  
  if("FCS-fixclust"%in%Call$method){
    print("FCS-fixclust")
    tmptimes<-Sys.time()
    don.temp<-cbind.data.frame(scale(tab.disjonctif.NA(don.na$don.na$cluster),scale=F),don.na$don.na[,-which("cluster"==colnames(don.na$don))])
    res.mice<-try(mice(don.temp,m=Call$m,method.default=c("norm","logreg","polyreg"),
                       maxit = Call$maxit,printFlag=Call$affichage))
    mattimes["FCS-fixclust"]<-as.numeric(difftime(Sys.time(),tmptimes),unit="mins")
    if(class(res.mice)!="try-error"){
      res.mice<-prelim.pmm(res.mice,don.na$don.na)
      res.temp<-try(analyse(res.mice,call = don.na$call))
      if(class(res.temp)!="try-error"){
        listfit[["model"]][,"FCS-fixclust"]<-res.temp$model
        listfit[["alpha_01"]][,"FCS-fixclust"]<-res.temp$alpha_01
        listfit[["alpha_02"]][,"FCS-fixclust"]<-res.temp$alpha_02
      }
    }else{print("failure FCS-fixclust")}
  }
  
  if("FCS-noclust"%in%Call$method){
    print("FCS-noclust")
    temp<-mice(don.na$don.na,m=Call$m,maxit=0)
    temp$pred[,"cluster"]<-c(0,0,0,0,0)
    tmptimes<-Sys.time()
    don.temp<-don.na$don.na
    don.temp$cluster<-as.numeric(don.temp$cluster)
    res.mice<-try(mice(don.temp,m=Call$m,method.default=c("norm","logreg","polyreg"),
                       maxit = Call$maxit,printFlag=Call$affichage))
    mattimes["FCS-noclust"]<-as.numeric(difftime(Sys.time(),tmptimes),unit="mins")
    if(class(res.mice)!="try-error"){
      res.temp<-try(analyse(res.mice,call = don.na$call))
      if(class(res.temp)!="try-error"){
        listfit[["model"]][,"FCS-noclust"]<-res.temp$model
        listfit[["alpha_01"]][,"FCS-noclust"]<-res.temp$alpha_01
        listfit[["alpha_02"]][,"FCS-noclust"]<-res.temp$alpha_02
      }
    }else{print("failure FCS-noclust")}
  }
  
  if("FCS-2lnorm"%in%Call$method){
    ###### 2l.norm
    print("2l.norm")
    tmptimes<-Sys.time()
    don.temp<-as.data.frame(lapply(don.na$don.na,FUN=function(xx){as.numeric(as.character(xx))}))
    temp<-mice(don.temp,m=Call$m,maxit=0)
    temp$pred[,"cluster"]<-c(0,-2,-2,-2,-2)
    temp$pred[temp$pred==1]<-2
    res.mice<-try(mice(don.temp,m=Call$m,defaultMethod =c("2l.norm.syst","2l.norm.syst","2l.norm.syst"),pred=temp$pred,maxit = Call$maxit,printFlag=Call$affichage),silent=Call$affichage)
    mattimes["FCS-2lnorm"]<-as.numeric(difftime(Sys.time(),tmptimes),unit="mins")
    if(class(res.mice)!="try-error"){
      res.temp<-try(analyse(res.mice,call = don.na$call))
      if(class(res.temp)!="try-error"){
        listfit[["model"]][,"FCS-2lnorm"]<-res.temp$model
        listfit[["alpha_01"]][,"FCS-2lnorm"]<-res.temp$alpha_01
      }
    }else{print("failure FCS-2lnorm")}
  }
  
  if("JM-pan" %in%Call$method){
    print("JM-pan")
    tmptimes<-Sys.time()
    subj <- don.na$don.na$clust
    ypan<-don.na$don.na[,-which(colnames(don.na$don.na)=="cluster")]
    ypan$X2<-as.numeric(ypan$X2)
    pred <- rep(1,nrow(don.na$don.na))
    xcol <- 1
    zcol <- 1
    a <- ncol(ypan)
    c <- ncol(ypan)
    id2 <- diag(a)
    Binv <- a*id2
    Dinv <- c*id2
    prior <- list(a=a, Binv=Binv, c=c, Dinv=Dinv)
    iter<-Call$iterjomo["nbetween"]+Call$iterjomo["nburn"]
    res.mice <- try(lapply(as.list(sample(seq(1000,9999,1),size=Call$m)),FUN=function(xx,y,subj,pred,xcol,zcol,prior,iter){
      res.pan<-pan(as.matrix(y), subj, pred, xcol, zcol, prior, seed=xx,iter=iter)
      return(data.frame(res.pan$y,cluster=subj))
    },y=ypan,subj=subj,pred=pred,xcol=xcol,zcol=zcol,prior=prior,iter=iter))
    mattimes["JM-pan"]<-as.numeric(difftime(Sys.time(),tmptimes),unit="mins")
    
    prelim.pan<-function (res.mi, X) 
    {
      longformat <- rbind(X, do.call(rbind, res.mi))
      longformat <- cbind(.imp = rep(0:length(res.mi), 
                                     each = nrow(X)), .id = rep(1:nrow(X), (length(res.mi) + 
                                                                              1)), longformat)
      rownames(longformat) <- NULL
      imp.mids <- as.mids(longformat)
      
      return(imp.mids)
    }
    
    if(class(res.mice)!="try-error"){
      res.mice<-prelim.pan(res.mice,data.frame(ypan,cluster=subj))
      res.temp<-try(analyse(res.mice,call = don.na$call))
      if(class(res.temp)!="try-error"){
        listfit[["model"]][,"JM-pan"]<-res.temp$model
        listfit[["alpha_01"]][,"JM-pan"]<-res.temp$alpha_01
      }
    }else{print("failure JM-pan")}
  }
  
  #synthese
  res<-list(listfit=listfit,times=mattimes,call=Call)
  return(res)
},Call=Call,seedlist=seedlist,listfit=listfit,mattimes=mattimes)


