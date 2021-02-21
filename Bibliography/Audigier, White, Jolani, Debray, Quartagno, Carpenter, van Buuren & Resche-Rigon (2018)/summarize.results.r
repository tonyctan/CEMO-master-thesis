summarize.results<-function(output,digits=3){
  var_to_cor<-function(xx){
    #convert a covariance matrix as a correlation matrix
    yy<-sweep(xx,FUN="/",STATS=sqrt(diag(xx)),MARGIN = 1)
    yy<-sweep(yy,FUN="/",STATS=sqrt(diag(xx)),MARGIN = 2)
    return(yy)
  }
  
  res<-vector("list",6)
  names(res)<-c(names(output$listfit),"times")
  
  #model
  res.model<-array(NA,dim=c(9+length(output$call$sigma_eps),8,length(output$call$method)),dimnames=list(
    c("coef_X0", "coef_X1", "coef_X2", "ranSD_X0", "ranSD_X1", "ranSD_X2", "rancorr_01", 
      "rancorr_02", "rancorr_12",if(!is.null(output$call$sigma_eps)){paste("sigma_eps",seq(length(output$call$sigma_eps)),sep="")}),
    c("True","Est mean","RBias","fmi","Model SE","Emp SE","95% Cover","RMSE"),
    output$call$method
  ))
  
  #true coefficients
  coef_true<-rep(NA,dim(res.model)[[1]])
  names(coef_true)<-dimnames(res.model)[[1]]
  coef_true[c("coef_X0", "coef_X1", "coef_X2")]<-output$call$beta
  psi<-output$call$psi
  psi <-output$call$lambda * psi
  coef_true[c("ranSD_X0", "ranSD_X1", "ranSD_X2", "rancorr_01", "rancorr_02", "rancorr_12")]<-c(sqrt(diag(psi)),var_to_cor(psi)[upper.tri(var_to_cor(psi))])
  coef_true[-which(names(coef_true)%in%c("coef_X0", "coef_X1", "coef_X2","ranSD_X0", "ranSD_X1", "ranSD_X2", "rancorr_01", "rancorr_02", "rancorr_12"))]<-output$call$sigma_eps
  res.model[,"True",]<-coef_true
  
  res.model[,"Est mean",]<-apply((output$listfit[["model"]][dimnames(res.model)[[1]],,]),MARGIN=c(1,3),FUN=mean,na.rm=T)
  res.model[,"RBias",]<-apply(res.model[names(coef_true),"Est mean",],MARGIN=2,FUN="-",coef_true)/coef_true
  res.model[1:3,"fmi",]<-apply((output$listfit[["model"]][c("fmi_X0","fmi_X1","fmi_X2"),,]),MARGIN=c(1,3),FUN=mean,na.rm=T)
  res.model[c("coef_X0", "coef_X1", "coef_X2"),"Model SE",]<-apply((output$listfit[["model"]][c("fixSD_X0","fixSD_X1","fixSD_X2"),,]),MARGIN=c(1,3),FUN=function(xx){return(sqrt(mean(xx^2,na.rm=T)))})
  res.model[c("coef_X0", "coef_X1", "coef_X2"),"Emp SE",]<-apply((output$listfit[["model"]][c("coef_X0", "coef_X1", "coef_X2"),,]),MARGIN=c(1,3),FUN=function(xx){return(sqrt(mean((xx-mean(xx,na.rm=T))^2,na.rm=T)))})
  temp<-apply(output$listfit[["model"]][names(coef_true),,],MARGIN=c(2,3),FUN="-",coef_true)
  temp<-temp^2
  res.model[,"RMSE",]<-sqrt(apply(temp,MARGIN=c(1,3),FUN=mean,na.rm=T))
  res.model[c("coef_X0", "coef_X1", "coef_X2"),"95% Cover",]<-apply((output$listfit[["model"]][c("cov_X0","cov_X1","cov_X2"),,]),MARGIN=c(1,3),FUN=mean,na.rm=T)
  res.model<-res.model[-which(dimnames(res.model)[[1]]%in%c("ranSD_X2","rancorr_02","rancorr_12")),,]
  res$model<-res.model

  #alpha_01   #alpha_02
  
  
  res[c("alpha_01","alpha_02")]<-mapply(FUN=function(xx,alpha_true){
    res<-array(NA,dim=c(7,dim(xx)[[3]]),
               dimnames=list(
                 c("True","Est mean","RBias","Model SE","Emp SE","95% Cover","RMSE"),
                 dimnames(xx)[[3]]))

    coef_true<-alpha_true
    res["True",]<-rep(coef_true,dim(xx)[[3]])
    res["Est mean",]<-apply(xx[1,,],MARGIN=c(2),FUN=mean,na.rm=T)
    res["RBias",]<-(res["Est mean",]-res["True",])/res["True",]
    res["Model SE",]<-apply(xx[2,,],MARGIN=c(2),FUN=function(xx){return(sqrt(mean(xx^2,na.rm=T)))})
    res["Emp SE",]<-apply(xx[1,,],MARGIN=c(2),FUN=function(xx){return(sqrt(mean((xx-mean(xx,na.rm=T))^2,na.rm=T)))})
    temp<-apply(xx[1,,],MARGIN=c(2),FUN="-",coef_true)
    temp<-temp^2
    res["RMSE",]<-sqrt(apply(temp,MARGIN=c(2),FUN=mean,na.rm=T))
    res["95% Cover",]<-apply(xx[6,,],MARGIN=c(2),FUN=mean,na.rm=T)
    return(res)
    },output$listfit[c("alpha_01","alpha_02")],c(output$call$alpha_01,output$call$alpha_02),SIMPLIFY =F)
  
  #time
  res$times<-colMeans(output$times,na.rm=T)
  res<-lapply(res[c(1:4)],function(xx,digits){try(round(xx,digits),silent=T)},digits=digits)
  
  return(res)
}