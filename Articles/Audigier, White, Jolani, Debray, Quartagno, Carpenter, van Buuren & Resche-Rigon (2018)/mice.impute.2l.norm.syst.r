mice.impute.2l.norm.syst<-function (y, ry, x, type, intercept = TRUE,niter = 100,wy=NULL,...){
  
  if(is.factor(y)){
    stop("y need to be continuous")
  }
  
  typena<-unlist(by(data=ry,INDICES = factor(as.character((x[, type == (-2)])),levels=as.character(unique(x[, type == (-2)]))),FUN=function(xx){
    val.out<-sum(xx)==0
    if(val.out){return("syst")}else{return("spor")}
  }))
  
  if(sum(typena=="syst")==length(typena)){
    warning("The outcome is fully unobserved, no imputation")
    return(y)
  }else if(sum(typena=="spor")==length(typena)){
    res.out<-mice.impute.2l.norm(y=y,ry=ry,x =x,type = type,intercept = intercept,wy=wy)
    return(res.out)
  }
  
  classspor<-unique(x[, type == (-2)])[which(typena=="spor")]
  
  indspor<-which(x[, type == (-2)]%in%classspor)
  indsyst<-which(!(x[, type == (-2)]%in%classspor));
  yspor<-y[indspor]
  ryspor<-ry[indspor]
  rysyst<-ry[indsyst]
  if(sum(rysyst)>0){stop("impossible")}
  if((sum(!ryspor)+length(rysyst))!=sum(!ry)){stop("impossible")}
  xspor<-x[indspor,,drop=F]
  xsyst<-x[indsyst,,drop=F]
  
  mice.impute.2l.norm.intern<-function (y, ry, x, type, intercept = TRUE, n.iter,wy=NULL,...) 
  {
    rwishart <- function(df, p = nrow(SqrtSigma), SqrtSigma = diag(p)) {
      Z <- matrix(0, p, p)
      diag(Z) <- sqrt(rchisq(p, df:(df - p + 1)))
      if (p > 1) {
        pseq <- 1:(p - 1)
        Z[rep(p * pseq, pseq) + unlist(lapply(pseq, seq))] <- rnorm(p * 
                                                                      (p - 1)/2)
      }
      crossprod(Z %*% SqrtSigma)
    }
    symridge <- function(xx, ridge = 0.0001, ...) {
      if(mean(unlist(dim(xx)))==1){return(xx+xx*ridge)}
      xxx <- (xx + t(xx))/2
      return(xxx + diag(diag(xxx) * ridge))
    }
    
    if (intercept) {
      xdesign <- cbind(1, as.matrix(x))
      type <- c(2, type)
    }else{xdesign<-x}
    nry <- !ry
    n.class <- length(unique(xdesign[, type == (-2)]))
    if (n.class == 0) 
      stop("No class variable")
    gf.full <- factor(xdesign[, type == (-2)], labels = 1:n.class)
    gf <- gf.full[ry]
    XG <- split.data.frame(as.matrix(xdesign[ry, type == 2]), gf)
    X.SS <- lapply(XG, crossprod)
    yg <- split(as.vector(y[ry]), gf)
    n.g <- tabulate(gf)
    n.rc <- ncol(XG[[1]])
    bees <- matrix(0, nrow = n.class, ncol = n.rc)
    ss <- vector(mode = "numeric", length = n.class)
    mu <- rep(0, n.rc)
    inv.psi <- diag(1, n.rc, n.rc)
    inv.sigma2 <- rep(1, n.class)
    sigma2.0 <- 1
    theta <- 1
    for (iter in 1:n.iter) {
      for (class in 1:n.class) {
        vv <- symridge(inv.sigma2[class] * X.SS[[class]] + inv.psi)
        bees.var <- chol2inv(chol(vv))
        bees[class, ] <- drop(bees.var %*% (crossprod(inv.sigma2[class] * 
                                                        XG[[class]], yg[[class]]) + inv.psi %*% mu)) + 
          drop(rnorm(n = n.rc) %*% chol(symridge(bees.var)))
        ss[class] <- crossprod(yg[[class]] - XG[[class]] %*% 
                                 bees[class, ])
      }
      mu <- colMeans(bees) + drop(rnorm(n = n.rc) %*% chol(chol2inv(chol(symridge(inv.psi)))/n.class))
      inv.psi <- rwishart(df = n.class - n.rc - 1, SqrtSigma = chol(chol2inv(chol(symridge(crossprod(t(t(bees) - 
                                                                                                         mu)))))))
      inv.sigma2 <- rgamma(n.class, n.g/2 + 1/(2 * theta), 
                           scale = 2 * theta/(ss * theta + sigma2.0))
      H <- 1/mean(inv.sigma2)
      sigma2.0 <- rgamma(1, n.class/(2 * theta) + 1, scale = 2 * 
                           theta * H/n.class)
      G <- exp(mean(log(1/inv.sigma2)))
      theta <- 1/rgamma(1, n.class/2 - 1, scale = 2/(n.class * 
                                                       (sigma2.0/H - log(sigma2.0) + log(G) - 1)))
    }
    imps <- rnorm(n = sum(nry), sd = sqrt(1/inv.sigma2[gf.full[nry]])) + 
      rowSums(as.matrix(xdesign[nry, type == 2, drop = FALSE]) * 
                bees[gf.full[nry], ])
    return(list(imps=imps,inv.sigma2=inv.sigma2[1],bees=bees[1, ]))
  }
  
  res.2lnorm<-mice.impute.2l.norm.intern(y=yspor, ry=ryspor, x=xspor, type=type, intercept = intercept, n.iter = niter,wy=wy)
  imps.spor <- res.2lnorm$imps
  
  if (intercept) {
    xsyst <- cbind(1, as.matrix(xsyst))
    type <- c(2, type)
  }
  
  imps.syst <- rnorm(n = sum(!rysyst), sd = sqrt(1/res.2lnorm$inv.sigma2)) + 
    rowSums(as.matrix(xsyst[!rysyst, type == 2, drop = FALSE]) * 
              matrix(res.2lnorm$bees,nrow=sum(!rysyst),ncol=length(res.2lnorm$bees),byrow=TRUE))
  
  yimp<-y
  yimp[indspor][!ryspor]<-imps.spor
  yimp[indsyst][!rysyst]<-imps.syst
  return(yimp[!ry])
}


