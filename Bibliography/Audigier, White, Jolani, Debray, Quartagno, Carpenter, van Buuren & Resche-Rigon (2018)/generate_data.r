create_data <- function(seed = NULL,I, n,
                        sigma2_v1,rho,sigma2_v2,
                        alpha_01,sigma2_epsi,
                        alpha_02,
                        beta,lambda,
                        sigma_eps = NULL,psi=NULL,bincov=FALSE,randomslope=FALSE,probit=FALSE) {
  #generate a complete data set X
  
  # I number of clusters
  # n nombre d'individus par cluster (entier ou vecteur)
  # sigma2_v1,rho,sigma2_v2 element of the covariance matrix for the latent variables generating covariates
  # alpha_01,sigma2_epsi parameters for the first covariate
  # alpha_02 parameter for the second covariate
  # beta vector of fixed coefficients
  # lambda scalar for the variance of the random coefficient
  #sigma_eps a vector indicating the standard error for each cluster or a scalar for homogeneous error
  
  call <- list(
    seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
      alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
      lambda,sigma_eps = sigma_eps,psi=psi,bincov=bincov,randomslope=randomslope,probit=probit
  )
  
  if (!is.null(seed)) {
    set.seed(seed)
  }
  if (length(n)==1){
    n<-rep(n,I)
  }else if(length(n)!=I){
    stop("length de n != I")
  }
  
  cluster<-c()
  for(i in 1:I){
    cluster<-c(cluster,rep(i,n[i]))
  }
  cluster<-as.factor(cluster)
  names(n)<-levels(cluster)
  
  
  Nbind<-length(cluster)
  if(!bincov){
  X <- data.frame(
    cluster = cluster,
    X1 = rep(0,Nbind),
    X2 = as.factor(rep(c("0","1"),ceiling(Nbind / 2))[1:Nbind]),
    Y = if (is.null(sigma_eps)) {
      as.factor(rep(c("0","1"),ceiling(Nbind / 2))[1:Nbind])
    }else{
      rep(0,Nbind)
    },
    X3 = rep(0,Nbind)
  )
  }else{
    X <- data.frame(
      cluster = cluster,
      X1 = as.factor(rep(c("0","1"),ceiling(Nbind / 2))[1:Nbind]),
      X2 = as.factor(rep(c("0","1"),ceiling(Nbind / 2))[1:Nbind]),
      Y = if (is.null(sigma_eps)) {
        as.factor(rep(c("0","1"),ceiling(Nbind / 2))[1:Nbind])
      }else{
        rep(0,Nbind)
      },
      X3 = rep(0,Nbind)
    )
    }
  
  v <-
    rmvnorm(I,mean = rep(0,3),sigma = matrix(
      c(sigma2_v1,rho,rho,rho,sigma2_v2,rho,rho,rho,sigma2_v1),nrow = 3,ncol =
        3,byrow = TRUE
    ))
  
  if(!bincov){
  for (i in levels(X$cluster)) {
    if(is.matrix(sigma2_epsi)){
      sigma2_epsi_temp<-sigma2_epsi
    }else if(length(sigma2_epsi)>1){
        sigma2_epsi_temp<-diag(sigma2_epsi)
    }else{
          sigma2_epsi_temp<-sigma2_epsi*diag(2)
          }
    
    temp<-rmvnorm(n[i],mean=c((alpha_01 + v[which(levels(X$c) == i),1]),(alpha_01 + v[which(levels(X$c) == i),3])),sigma=sigma2_epsi_temp)
    X$X1[X$cluster == i] <-temp[,1]
    X$X3[X$cluster == i] <-temp[,2]
    if(!probit){
    probsucces <-
      exp((alpha_02 + v[which(levels(X$c) == i),2])) / (1 + exp((alpha_02 + v[which(levels(X$c) ==
                                                                                      i),2])))
    }else{
      probsucces <-
        dnorm((alpha_02 + v[which(levels(X$c) == i),2]))
      }
    X$X2[X$cluster == i] <-
      sample(
        size = n[i],levels(X$X2),prob = c(1 - probsucces,probsucces),replace = T
      )
  }}else{
    for (i in levels(X$cluster)) {
      
        sigma2_epsi_temp<-sigma2_epsi
      
      
      temp<-rnorm(n[i],mean=c((alpha_01 + v[which(levels(X$c) == i),3])),sd=sqrt(sigma2_epsi_temp))
      
      X$X3[X$cluster == i] <-temp
      if(!probit){
      probsucces <-
        exp((alpha_02 + v[which(levels(X$c) == i),2])) / (1 + exp((alpha_02 + v[which(levels(X$c) ==
                                                                                        i),2])))
      }else{
        probsucces <- dnorm((alpha_02 + v[which(levels(X$c) == i),2]))
        }
      X$X2[X$cluster == i] <-
        sample(
          size = n[i],levels(X$X2),prob = c(1 - probsucces,probsucces),replace = T
        )
      if(!probit){
      probsucces <-
        exp((alpha_02 + v[which(levels(X$c) == i),1])) / (1 + exp((alpha_02 + v[which(levels(X$c) ==
                                                                                        i),1])))
      }else{
        probsucces <- dnorm((alpha_02 + v[which(levels(X$c) == i),1]))
        }
      X$X1[X$cluster == i] <-
        sample(
          size = n[i],levels(X$X1),prob = c(1 - probsucces,probsucces),replace = T
        )
      
    }
    }
  
  #draw random coefficients
  if(is.null(psi)){psi <- matrix(.3*.5**2,nrow = 3,ncol = 3);diag(psi) <- .5**2}
  psi <-lambda * psi
  u <- rmvnorm(I,mean = rep(0,3),sigma = psi)
  if(!randomslope){u[,3]<-0}#on supprime l'effet aleatoire sur la variable binaire
  temp <- vector(mode = "list",length = I)
  
  if(!bincov){
  for (i in 1:I) {
    temp[[i]] <-
      tcrossprod(cbind(rep(1,n[i]),
                       X[which(X$cluster == levels(X$cluster)[i]),"X1"],
                       as.numeric(as.character(X[which(X$cluster == levels(X$cluster)[i]),"X2"]))
      )
      ,beta + u[i,,drop = F])
  }
  }else{
    for (i in 1:I) {
    temp[[i]] <-
      tcrossprod(cbind(rep(1,n[i]),
                       as.numeric(as.character(X[which(X$cluster == levels(X$cluster)[i]),"X1"])),
                       as.numeric(as.character(X[which(X$cluster == levels(X$cluster)[i]),"X2"]))
      )
      ,beta + u[i,,drop = F])
    }
  }
  if (is.null(sigma_eps)) {
    #A binary variable Y is drawn
    
    temp <- lapply(
      temp,FUN = function(x,Y) {
        u <- runif(length(x))
        res <- rep(1,length(x))#echec niveau 1 de Y
        res[which(u < (exp(x) / (1 + exp(x))))] <- 2#succes niveau 2 de Y
        output <- as.factor(levels(Y)[res])
        return(output)
      },Y = X$Y)
  }else{
    if (length(sigma_eps)==1){sigma_list<-as.list(rep(sigma_eps,I))}
    else {sigma_list<-as.list(sigma_eps)}
    ##A continuous variable Y is drawn
    temp <- mapply(
      temp,FUN = function(x,sigma_eps) {
        x <- x + rnorm(length(x),0,sd = sigma_eps)
        return(x)
      },sigma_eps = sigma_list,SIMPLIFY=FALSE
    )
    
  }
  
  X$Y <- unlist(temp)
  class(X$cluster)<-"numeric"#required by mice
  
  return(list(
    don = X,call = call))
}

create_missing <-
  function(res.create,pi_spor = NULL,pi_syst,betaMAR_0 = NULL, betaMAR_1 = NULL,ExplMAR ="X3",vna.mcar=c("X1","X2")) {
    #res.create : output of createdata
    #beta_0MAR, beta_1MAR : parameters for MAR mecanism
    
    # sporadically missing
    don.na <- res.create$don
    if (length(res.create$call$n)==1){
      n<-rep(res.create$call$n,res.create$call$I)
    }else{
      n<-res.create$call$n
    }
    
    while(sum(is.na(don.na))==0){
      if (is.null(betaMAR_0) & is.null(betaMAR_1)) {
        #MCAR
        NAloc <- rep(FALSE, nrow(don.na) * length(vna.mcar))
        NAloc[sample(nrow(don.na) * length(vna.mcar), size = floor(nrow(don.na) * length(vna.mcar) * pi_spor))] <-
          TRUE
        don.na[,vna.mcar][matrix(NAloc, nrow = nrow(don.na), ncol = length(vna.mcar))] <-
          NA
      }else{
        #MAR

          #NA sur X2
          probsucces <-
            exp(betaMAR_0 + betaMAR_1*res.create$don$X3) / (1 + exp(betaMAR_0 + betaMAR_1*res.create$don$X3))
          temp<-rep(FALSE,nrow(res.create$don))
          temp[runif(nrow(res.create$don))<probsucces]<-TRUE
          don.na$X2[which(temp)] <-NA
          
          #NA sur X1
          probsucces <-
            exp(betaMAR_0 + betaMAR_1*as.numeric(as.character(res.create$don$X3))) / (1 + exp(betaMAR_0 + betaMAR_1*as.numeric(as.character(res.create$don$X3))))
          temp<-rep(FALSE,nrow(res.create$don))
          temp[runif(nrow(res.create$don))<probsucces]<-TRUE
          don.na$X1[which(temp)] <-NA
        

      }
      
      #systematic
      if(pi_syst>0){
        temp <-
          lapply(as.data.frame(matrix(runif(res.create$call$I * length(vna.mcar)) < pi_syst,ncol = length(vna.mcar),dimnames=list(NULL,vna.mcar))),which)
        for(ii in vna.mcar){
          if(is.null(temp[[ii]])){
            next()
          }else if(length(temp[[ii]])>1){
            don.na[don.na$cluster %in% temp[[ii]],ii] <- NA
          }else{
            don.na[which(don.na$cluster == temp[[ii]]),vna.mcar] <- NA}
        }
        
      }
    }
    return(list(don.na=don.na,
                call=list(seed = res.create$call$seed,I = res.create$call$I, n = res.create$call$n,sigma2_v1 = res.create$call$sigma2_v1,rho = res.create$call$rho,sigma2_v2 = res.create$call$sigma2_v2,alpha_01 =
                            res.create$call$alpha_01,sigma2_epsi = res.create$call$sigma2_epsi,alpha_02 = res.create$call$alpha_02,beta = res.create$call$beta,lambda =
                            res.create$call$lambda,sigma_eps = res.create$call$sigma_eps,psi=res.create$call$psi,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,vna.mcar=vna.mcar,bincov=res.create$call$bincov,randomslope=res.create$call$randomslope,probit=res.create$call$probit)
    ))
  }
