stackresults<-function(res,Call=NULL){
  if(is.null(Call)){Call<-res["call",1][[1]]}
  #aggregate the several outputs of the function simu_one_par
  nbmethod<-length(Call$method)
  
  mattimes<-matrix(NA,ncol=length(c("FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")),nrow=ncol(res))
  colnames(mattimes)<- c("FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
  
  
  if (!is.null(Call$sigma_eps)){
    #continuous outcome
    arrayfitmodel<-array(NA,dim=c(24+length((Call$sigma_eps)),ncol(res),nbmethod),dimnames=list(c(
      "coef_X0","coef_X1","coef_X2",
      "fixSD_X0","fixSD_X1","fixSD_X2",
      "ranSD_X0","ranSD_X1","ranSD_X2",
      "rancorr_01","rancorr_02","rancorr_12",
      "fmi_X0","fmi_X1","fmi_X2",
      "lo95_X0","lo95_X1","lo95_X2",
      "hi95_X0","hi95_X1","hi95_X2",
      "cov_X0","cov_X1","cov_X2",
      paste("sigma_eps",seq(length((Call$sigma_eps))),sep="")),
      as.character(1:ncol(res)),
      Call$method)
    )
  }else{
    # binary outcome
    arrayfitmodel<-array(NA,dim=c(24,ncol(res),nbmethod),dimnames=list(c(
      "coef_X0","coef_X1","coef_X2",
      "fixSD_X0","fixSD_X1","fixSD_X2",
      "ranSD_X0","ranSD_X1","ranSD_X2",
      "rancorr_01","rancorr_02","rancorr_12",
      "fmi_X0","fmi_X1","fmi_X2",
      "lo95_X0","lo95_X1","lo95_X2",
      "hi95_X0","hi95_X1","hi95_X2",
      "cov_X0","cov_X1","cov_X2"),
      as.character(1:ncol(res)),
      Call$method)
    )
  }
  
  arrayfitalpha_01<-array(NA,dim=c(6,ncol(res),nbmethod),dimnames=list(
    c("coef_X1","fixSD_X1","fmi_X1","lo95_X1","hi95_X1","cov_X1"),
    as.character(1:ncol(res)),
    Call$method)
  )
  
  arrayfitalpha_02<-array(NA,dim=c(6,ncol(res),nbmethod),dimnames=list(
    c("coef_X2","fixSD_X2","fmi_X2","lo95_X2","hi95_X2","cov_X2"),
    as.character(1:ncol(res)),
    Call$method)
  )
  
  listfit<-list(arrayfitmodel,arrayfitalpha_01,arrayfitalpha_02)
  names(listfit)<-c("model","alpha_01","alpha_02")
  
  
  for(i in 1:ncol(res)){
    listfit$model[,i,]<-res[,i]$listfit$model
    listfit$alpha_01[,i,]<-res[,i]$listfit$alpha_01
    listfit$alpha_02[,i,]<-res[,i]$listfit$alpha_02
    mattimes[i,]<-res[,i]$times
  }
  
  return(list(listfit=listfit,times=mattimes,call=Call))
}