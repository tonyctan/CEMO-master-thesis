analyse<-function(try.res,call){
  #try.res: output from try(mice())
  #call: the match call for the function create_data
  
  #intern function
  
  mypool<-function (object, method = "smallsample") 
  {
    #modeifications to handle glmer otputs
    call <- match.call()
    if (!is.mira(object)) 
      stop("The object must have class 'mira'")
    m <- length(object$analyses)
    fa <- getfit(object, 1)
    # print(class(fa))
    if (m == 1) {
      warning("Number of multiple imputations m=1. No pooling done.")
      return(fa)
    }
    analyses <- getfit(object)
    if (class(fa)[1] == "lme" & !requireNamespace("nlme", quietly = TRUE)) 
      stop("Package 'nlme' needed fo this function to work. Please install it.", 
           call. = FALSE)
    if ((class(fa)[1] == "mer" | class(fa)[1] == "lmerMod"| class(fa)[1] == "lmerMod") & 
        !requireNamespace("lme4", quietly = TRUE)) 
      stop("Package 'lme4' needed fo this function to work. Please install it.", 
           call. = FALSE)
    mess <- try(coef(fa), silent = TRUE)
    if (inherits(mess, "try-error")) 
      stop("Object has no coef() method.")
    mess <- try(vcov(fa), silent = TRUE)
    if (inherits(mess, "try-error")) 
      stop("Object has no vcov() method.")
    if (class(fa)[1] == "mer" | class(fa)[1] == "lmerMod"| class(fa)[1] == "glmerMod") {
      k <- length(lme4::fixef(fa))
      names <- names(lme4::fixef(fa))
    }
    else if (class(fa)[1] == "polr") {
      k <- length(coef(fa)) + length(fa$zeta)
      names <- c(names(coef(fa)), names(fa$zeta))
    }
    else {
      k <- length(coef(fa))
      names <- names(coef(fa))
    }
    qhat <- matrix(NA, nrow = m, ncol = k, dimnames = list(1:m, 
                                                           names))
    u <- array(NA, dim = c(m, k, k), dimnames = list(1:m, names, 
                                                     names))
    for (i in 1:m) {
      
      fit <- analyses[[i]]
      # print(class(fit)[1])
      if (class(fit)[1] == "mer" | class(fit)[1] == "glmerMod") {#modif pour glmerMod
        qhat[i, ] <- lme4::fixef(fit)
        ui <- as.matrix(vcov(fit))
        if (ncol(ui) != ncol(qhat)) 
          stop("Different number of parameters: class mer, fixef(fit): ", 
               ncol(qhat), ", as.matrix(vcov(fit)): ", ncol(ui))
        u[i, , ] <- array(ui, dim = c(1, dim(ui)))
      }
      else if (class(fit)[1] == "lmerMod") {
        qhat[i, ] <- lme4::fixef(fit)
        ui <- vcov(fit)
        if (ncol(ui) != ncol(qhat)) 
          stop("Different number of parameters: class lmerMod, fixed(fit): ", 
               ncol(qhat), ", vcov(fit): ", ncol(ui))
        u[i, , ] <- array(ui, dim = c(1, dim(ui)))
      }
      else if (class(fit)[1] == "lme") {
        # print("ok3")
        qhat[i, ] <- fit$coefficients$fixed
        ui <- vcov(fit)
        if (ncol(ui) != ncol(qhat)) 
          stop("Different number of parameters: class lme, fit$coefficients$fixef: ", 
               ncol(qhat), ", vcov(fit): ", ncol(ui))
        u[i, , ] <- array(ui, dim = c(1, dim(ui)))
      }
      else if (class(fit)[1] == "polr") {
        qhat[i, ] <- c(coef(fit), fit$zeta)
        ui <- vcov(fit)
        if (ncol(ui) != ncol(qhat)) 
          stop("Different number of parameters: class polr, c(coef(fit, fit$zeta): ", 
               ncol(qhat), ", vcov(fit): ", ncol(ui))
        u[i, , ] <- array(ui, dim = c(1, dim(ui)))
      }
      else if (class(fit)[1] == "survreg") {
        qhat[i, ] <- coef(fit)
        ui <- vcov(fit)
        parnames <- dimnames(ui)[[1]]
        select <- !(parnames %in% "Log(scale)")
        ui <- ui[select, select]
        if (ncol(ui) != ncol(qhat)) 
          stop("Different number of parameters: class survreg, coef(fit): ", 
               ncol(qhat), ", vcov(fit): ", ncol(ui))
        u[i, , ] <- array(ui, dim = c(1, dim(ui)))
      }
      else {
        qhat[i, ] <- coef(fit)
        ui <- vcov(fit)
        ui <- mice:::expandvcov(qhat[i, ], ui)
        if (ncol(ui) != ncol(qhat)) 
          stop("Different number of parameters: coef(fit): ", 
               ncol(qhat), ", vcov(fit): ", ncol(ui))
        u[i, , ] <- array(ui, dim = c(1, dim(ui)))
      }
    }
    
    qbar <- apply(qhat, 2, mean)
    ubar <- apply(u, c(2, 3), mean)
    e <- qhat - matrix(qbar, nrow = m, ncol = k, byrow = TRUE)
    b <- (t(e) %*% e)/(m - 1)
    t <- ubar + (1 + 1/m) * b
    r <- (1 + 1/m) * diag(b/ubar)
    lambda <- (1 + 1/m) * diag(b/t)
    if("mira"%in%class(object)){dfcom <- mice:::df.residual.mira(object)}#modif
    df <- mice:::mice.df(m, lambda, dfcom, method)
    fmi <- (r + 2/(df + 3))/(r + 1)
    names(r) <- names(df) <- names(fmi) <- names(lambda) <- names
    fit <- list(call = call, call1 = object$call, call2 = object$call1, 
                nmis = object$nmis, m = m, qhat = qhat, u = u, qbar = qbar, 
                ubar = ubar, b = b, t = t, r = r, dfcom = dfcom, df = df, 
                fmi = fmi, lambda = lambda)
    oldClass(fit) <- c("mipo", oldClass(object))
    return(fit)
  }
  
  matfit<-vector(length = 3,mode="list")
  names(matfit)<-c("model","alpha_01","alpha_02")
  
  if(class(try.res)!="try-error"){
    ###########"
    #mixed model
    ###########
    
    if (!is.null(call$sigma_eps)){
      #continuous outcome 
      matfitfix<-rep(NA, (24+length((call$sigma_eps))))
      names(matfitfix)<-c(
        "coef_X0","coef_X1","coef_X2",
        "fixSD_X0","fixSD_X1","fixSD_X2",
        "ranSD_X0","ranSD_X1","ranSD_X2",
        "rancorr_01","rancorr_02","rancorr_12",
        "fmi_X0","fmi_X1","fmi_X2",
        "lo95_X0","lo95_X1","lo95_X2",
        "hi95_X0","hi95_X1","hi95_X2",
        "cov_X0","cov_X1","cov_X2",
        paste("sigma_eps",seq(length((call$sigma_eps))),sep="")
      )
      
      W<-NULL
      if(length(unique(call$sigma_eps))>1){W<-varIdent(form=~1|cluster)}
      
      if(!call$randomslope){
        ana<-try(with(try.res,expr=lme(fixed=formula(Y~X1+X2),random=formula(~1+X1|cluster),method="REML",
                                       control=list(maxIter=100,msMaxIter=100,niterEM=25,returnObject=TRUE),
                                       weights=W)),silent=TRUE)
      }else{
        ana<-try(with(try.res,expr=lme(fixed=formula(Y~X1+X2),random=formula(~1+X1+X2|cluster),method="REML",
                                       control=list(maxIter=100,msMaxIter=100,niterEM=25,returnObject=TRUE),
                                       weights=W)),silent=TRUE)
      }
    }else{
      # binary outcome
      matfitfix<-rep(NA,24)
      names(matfitfix)<-c(
        "coef_X0","coef_X1","coef_X2",
        "fixSD_X0","fixSD_X1","fixSD_X2",
        "ranSD_X0","ranSD_X1","ranSD_X2",
        "rancorr_01","rancorr_02","rancorr_12",
        "fmi_X0","fmi_X1","fmi_X2",
        "lo95_X0","lo95_X1","lo95_X2",
        "hi95_X0","hi95_X1","hi95_X2",
        "cov_X0","cov_X1","cov_X2"
      )
      if(!call$randomslope){
        ana<-try(with(try.res,expr=glmer(Y~X1+X2+(1+X1|cluster),family="binomial")))
      }else{
        ana<-try(with(try.res,expr=glmer(Y~X1+X2+(1+X1+X2|cluster),family="binomial")))
      }
    }
    
    if(class(ana)[1]!="try-error"){
      
      #Fixed effects
      fitmeth<-as.data.frame(summary(mypool(ana)))
      matfitfix[1:3]<-fitmeth$est#estimation ponctuelle
      matfitfix[c(4:6)]<-fitmeth$se#variance estimée de l'estimateurs
      
      matfitfix[c(13:15)]<-fitmeth$fmi
      matfitfix[c(16:18)]<-fitmeth[,"lo 95"]
      matfitfix[c(19:21)]<-fitmeth[,"hi 95"]
      matfitfix[22]<- sum((matfitfix["lo95_X0"]<call$beta[1]) & (call$beta[1]<matfitfix["hi95_X0"]))
      matfitfix[23]<- sum((matfitfix["lo95_X1"]<call$beta[2]) & (call$beta[2]<matfitfix["hi95_X1"]))
      matfitfix[24]<- sum((matfitfix["lo95_X2"]<call$beta[3]) & (call$beta[3]<matfitfix["hi95_X2"]))
      
      #random effects
      if(!call$randomslope){
        if(is.null(call$sigma_eps)){
          #glmer
          matfitfix[c(7:8)]<-rowMeans(sapply(ana$analyses,function(xx){return(attr(lme4::VarCorr(xx)$cluster,"stddev"))}))#variance effet aleatoires
          matfitfix[c(10:12)]<-mean(sapply(ana$analyses,function(xx){
            temp<-attr(lme4::VarCorr(xx)$cluster,"correlation")#correlation effets aleatoires
            return(temp[upper.tri(temp)])}))
        }else{
          #lme
          matfitfix[c(7:8)]<-rowMeans(sapply(ana$analyses,function(xx){return(as.numeric(nlme::VarCorr(xx)[1:2,"StdDev"]))}))#variance effet aleatoires
          matfitfix[c(10:12)]<-mean(sapply(ana$analyses,function(xx){
            temp<-nlme::VarCorr(xx)[-3,-c(1:2)]
            temp<-as.numeric(temp[lower.tri(temp)])
            return(temp)}))
        }
      }else{
        if(is.null(call$sigma_eps)){
          #glmer
          matfitfix[c(7:9)]<-rowMeans(sapply(ana$analyses,function(xx){return(attr(lme4::VarCorr(xx)$cluster,"stddev"))}))#variance effet aleatoires
          matfitfix[c(10:12)]<-rowMeans(sapply(ana$analyses,function(xx){
            temp<-attr(lme4::VarCorr(xx)$cluster,"correlation")#correlation effets aleatoires
            return(temp[upper.tri(temp)])}))
        }else{
          #lme
          matfitfix[c(7:9)]<-rowMeans(sapply(ana$analyses,function(xx){return(as.numeric(nlme::VarCorr(xx)[1:3,"StdDev"]))}))#variance effet aleatoires
          matfitfix[c(10:12)]<-rowMeans(sapply(ana$analyses,function(xx){
            temp<-nlme::VarCorr(xx)[-4,-c(1:2)]
            temp<-as.numeric(temp[lower.tri(temp)])
            return(temp)}))
        }
      }
      
      
      
      #standard error
      if (!is.null(call$sigma_eps)){
        
        vareps<-sapply(ana$analyses,FUN=function(xx,call){
          sigma<-summary(xx)$sigma
          if(length(unique(call$sigma_eps))>1){
            #heterosedastic
            delta<-coef(summary(xx)$modelS$varStruct,unconstrained=F)
            vareps<-c(sigma,delta)
            
          }else{
            #homoscedastic
            vareps<-sigma
          }
          return(vareps)
        },call=call)
        
        if(is.vector(vareps)){vareps<-mean(vareps)}else{vareps<-rowMeans(vareps)}
        vareps<-vareps^2
        if(length(vareps)>1){vareps[-1]<-vareps[-1]*vareps[1]}#pinheiro p209
        matfitfix[c(25:(24+length(vareps)))]<-sqrt(vareps)
      }
      
    }else{print("error analyse")}
    matfit[["model"]]<-matfitfix
    ########################################
    #alpha_01 : coefficient for the continuous incomplete variable
    ########################################
    
    
    matfitmean<-vector(length = 6,mode="numeric")
    names(matfitmean)<-c("coef_X1","fixSD_X1","fmi_X1","lo95_X1","hi95_X1","cov_X1")
    if(!call$bincov){
      ana<-try(with(try.res,expr=lmer(X1~1+(1|cluster))))
      res.pool<-mypool(ana)
      fitmeth<-as.data.frame(summary(res.pool))
      matfitmean[1]<-fitmeth$est#estimation ponctuelle
      matfitmean[2]<-fitmeth$se#variance estimée de l'estimateurs
      matfitmean[3]<-fitmeth$fmi
      matfitmean[4]<-fitmeth[,"lo 95"]
      matfitmean[5]<-fitmeth[,"hi 95"]
      matfitmean[6]<- sum((fitmeth[,"lo 95"]<call$alpha_01) & (call$alpha_01<fitmeth[,"hi 95"]))
    }
    matfit$alpha_01<-matfitmean
    
    ############################################
    #alpha_02 : coefficient for the binary incomplete variable
    ############################################
    
    ana<-try(with(try.res,expr=glmer(X2~1+(1|cluster),family="binomial")),silent=TRUE)
    if(!("try-error"%in%class(ana))){
      matfitprop<-vector(length = 6,mode="numeric")
      names(matfitprop)<-c("coef_X2","fixSD_X2","fmi_X2","lo95_X2","hi95_X2","cov_X2")
      res.pool<-mypool(ana)
      fitmeth<-as.data.frame(summary(res.pool))
      matfitprop[1]<-fitmeth$est#estimation ponctuelle
      matfitprop[2]<-fitmeth$se#variance estimée de l'estimateurs
      matfitprop[3]<-fitmeth$fmi
      matfitprop[4]<-fitmeth[,"lo 95"]
      matfitprop[5]<-fitmeth[,"hi 95"]
      matfitprop[6]<- sum((fitmeth[,"lo 95"]<call$alpha_02) & (call$alpha_02<fitmeth[,"hi 95"]))
      matfit$alpha_02<-matfitprop
    }else{matfit$alpha_02<-NULL}
    
    return(matfit)
  }
}

analyse.cc<-function(output){
  #output: output from create_data or create_missing
  don.ld<-na.omit(output$don)
  clustobs<-unique(don.ld$cluster)
  don.ld$cluster<-as.numeric(as.factor(don.ld$cluster))
  call<-output$call
  matfit<-vector(length = 4,mode="list")
  names(matfit)<-c("model","alpha_01","alpha_02","cor")
  
  
  ###########"
  #mixed model
  ###########
  
  if (!is.null(call$sigma_eps)){
    #continuous outcome 
    matfitfix<-rep(NA,(24+length((call$sigma_eps))))
    names(matfitfix)<-c(
      "coef_X0","coef_X1","coef_X2",
      "fixSD_X0","fixSD_X1","fixSD_X2",
      "ranSD_X0","ranSD_X1","ranSD_X2",
      "rancorr_01","rancorr_02","rancorr_12",
      "fmi_X0","fmi_X1","fmi_X2",
      "lo95_X0","lo95_X1","lo95_X2",
      "hi95_X0","hi95_X1","hi95_X2",
      "cov_X0","cov_X1","cov_X2",
      paste("sigma_eps",seq(length((call$sigma_eps))),sep="")
    )
    
    W<-NULL
    if(length(unique(call$sigma_eps))>1){W<-varIdent(form=~1|cluster)}
    if(!call$randomslope){
      ana<-try(lme(fixed=formula(Y~X1+X2),random=formula(~1+X1|cluster),method="REML",
                   control=list(maxIter=100,msMaxIter=100,niterEM=25,returnObject=TRUE),
                   weights=W,
                   data=don.ld),silent=TRUE)
    }else{
      ana<-try(lme(fixed=formula(Y~X1+X2),random=formula(~1+X1+X2|cluster),method="REML",
                   control=list(maxIter=100,msMaxIter=100,niterEM=25,returnObject=TRUE),
                   weights=W,
                   data=don.ld),silent=TRUE)
    }
  }else{
    # binary outcome
    matfitfix<-rep(NA,24)
    names(matfitfix)<-c(
      "coef_X0","coef_X1","coef_X2",
      "fixSD_X0","fixSD_X1","fixSD_X2",
      "ranSD_X0","ranSD_X1","ranSD_X2",
      "rancorr_01","rancorr_02","rancorr_12",
      "fmi_X0","fmi_X1","fmi_X2",
      "lo95_X0","lo95_X1","lo95_X2",
      "hi95_X0","hi95_X1","hi95_X2",
      "cov_X0","cov_X1","cov_X2"
    )
    if(!call$randomslope){
      ana<-try(glmer(Y~X1+X2+(1+X1|cluster),family="binomial",data=don.ld))}else{
        ana<-try(glmer(Y~X1+X2+(1+X1+X2|cluster),family="binomial",data=don.ld))
      }
  }
  
  
  if(class(ana)[1]!="try-error"){
    
    
    #Fixed effects
    
    matfitfix[c("coef_X0","coef_X1","coef_X2")]<-fixef(ana)#estimation ponctuelle
    matfitfix[c("fixSD_X0","fixSD_X1","fixSD_X2")]<-sqrt(diag(vcov(ana)))#variance estimée de l'estimateurs
    if(!is.null(call$sigma_eps)){
      temp<-try(intervals(ana,which="fixed"),silent=TRUE)
      if(class(temp)!="try-error"){
        matfitfix[c("lo95_X0","lo95_X1","lo95_X2")]<-temp$fixed[,"lower"]
        matfitfix[c("hi95_X0","hi95_X1","hi95_X2")]<-temp$fixed[,"upper"]
      }
    }else{
      temp<-confint.merMod(ana, method="Wald",parm="beta_")
      matfitfix[c("lo95_X0","lo95_X1","lo95_X2")]<-temp[,"2.5 %"]
      matfitfix[c("hi95_X0","hi95_X1","hi95_X2")]<-temp[,"97.5 %"]
    }
    matfitfix["cov_X0"]<- sum((matfitfix["lo95_X0"]<call$beta[1]) & (call$beta[1]<matfitfix["hi95_X0"]))
    matfitfix["cov_X1"]<- sum((matfitfix["lo95_X1"]<call$beta[2]) & (call$beta[2]<matfitfix["hi95_X1"]))
    matfitfix["cov_X2"]<- sum((matfitfix["lo95_X2"]<call$beta[3]) & (call$beta[3]<matfitfix["hi95_X2"]))
    
    #random effects
    if(!call$randomslope){
      if(is.null(call$sigma_eps)){
        #glmer
        matfitfix[c("ranSD_X0","ranSD_X1")]<-attr(lme4::VarCorr(ana)$cluster,"stddev")#variance effet aleatoires
        temp<-attr(lme4::VarCorr(ana)$cluster,"correlation")
        matfitfix[c("rancorr_01")]<-temp[upper.tri(temp)]#correlation effets aleatoires
        
      }else{
        #lme
        matfitfix[c("ranSD_X0","ranSD_X1")]<-as.numeric(nlme::VarCorr(ana)[1:2,"StdDev"])#variance effet aleatoires
        temp<-nlme::VarCorr(ana)[-3,-c(1:2)]
        matfitfix[c("rancorr_01","rancorr_02","rancorr_12")]<-as.numeric(temp[lower.tri(temp)])
      }
    }else{
      if(is.null(call$sigma_eps)){
        #glmer
        matfitfix[c("ranSD_X0","ranSD_X1","ranSD_X2")]<-attr(lme4::VarCorr(ana)$cluster,"stddev")#variance effet aleatoires
        temp<-attr(lme4::VarCorr(ana)$cluster,"correlation")
        matfitfix[c("rancorr_01","rancorr_02","rancorr_12")]<-temp[upper.tri(temp)]#correlation effets aleatoires
        
      }else{
        #lme
        matfitfix[c("ranSD_X0","ranSD_X1","ranSD_X2")]<-as.numeric(nlme::VarCorr(ana)[1:3,"StdDev"])#variance effet aleatoires
        temp<-nlme::VarCorr(ana)[-4,-c(1:2)]
        matfitfix[c("rancorr_01","rancorr_02","rancorr_12")]<-as.numeric(temp[lower.tri(temp)])
      }
    }
    #standard error
    if (!is.null(call$sigma_eps)){
      
      # temp<-try(nlme::intervals(ana),silent=T)
      sigma<-summary(ana)$sigma
      if(length(unique(call$sigma_eps))>1){
        #heterosedastic
        delta<-coef(summary(ana)$modelS$varStruct,unconstrained=F)
        vareps<-c(sigma,delta)
        
      }else{
        #homoscedastic
        vareps<-sigma
      }
      vareps<-vareps^2
      if(length(vareps)>1){vareps[-1]<-vareps[-1]*vareps[1];matfitfix[24+clustobs]<-sqrt(vareps)}#pinheiro p209/218
      else{matfitfix[25]<-sqrt(vareps)}
    }
  }else{
    print("failure in analyse.cc")
  }
  matfit[["model"]]<-matfitfix
  
  ########################################
  #mean for continuous incomplete covariable
  ########################################
  
  matfitmean<-rep(NA,6)
  names(matfitmean)<-c("coef_X1","fixSD_X1","fmi_X1","lo95_X1","hi95_X1","cov_X1")
  if(!call$bincov){
    ana<-try(lmer(X1~1+(1|cluster),data=output$don))#lme marche pas bien pour IC
    if(class(ana)[1]!="try-error"){
      matfitmean[c("coef_X1")]<-fixef(ana)#estimation ponctuelle
      matfitmean[c("fixSD_X1")]<-sqrt(diag(vcov(ana)))#variance estimée de l'estimateurs
      matfitmean[c("lo95_X1","hi95_X1")]<-confint.merMod(ana,parm=c("(Intercept)"),method="Wald")
      matfitmean["cov_X1"]<- sum((matfitmean["lo95_X1"]<call$alpha_01) & (call$alpha_01<matfitmean["hi95_X1"]))
    }else{matfitmean[1:6]<-rep(NA,6)}
  }
  matfit$alpha_01<-matfitmean
  
  ############################################
  #alpha_02 : coefficient for the binary incomplete covariable
  ############################################
  
  ana<-try(glmer(X2~1+(1|cluster),family="binomial",data=output$don))
  matfitprop<-rep(NA,6)
  names(matfitprop)<-c("coef_X2","fixSD_X2","fmi_X2","lo95_X2","hi95_X2","cov_X2")
  if(class(ana)[1]!="try-error"){
    matfitprop[1]<-fixef(ana)#estimation ponctuelle
    matfitprop[2]<-sqrt(diag(vcov(ana)))#variance estimée de l'estimateurs
    temp<-confint(ana,method="Wald")
    matfitprop[c("lo95_X2","hi95_X2")]<-temp["(Intercept)",]
    matfitprop["cov_X2"]<- sum((matfitprop["lo95_X2"]<call$alpha_02) & (call$alpha_02<matfitprop["hi95_X2"]))
  }else{
    matfitprop[1:6]<-rep(NA,6)
  }
  matfit$alpha_02<-matfitprop
  
  return(matfit)
  
}