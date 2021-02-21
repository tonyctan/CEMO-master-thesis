Call<-vector(length=26,"list")



##config 1
numconfig<-1#index config
I<-28#number of clusters
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)#cluster size
sigma2_v1<-sigma2_v2<-0.12;rho<- 0.001#elements of the covariance matrix for the latent variables generating covariates
alpha_01<-2.9;sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)#parameters for generating X1 and X3 (mean and variance)
alpha_02<- .42 #mean of X2
beta<-c(.72,-.11,.03)#fixed coefficient for the analysis model
lambda<-1#scalar for multiplying the covariance of random effects psi
seed<-NULL#seed
sigma_eps<-.15#standard error in the analysis model
randomslope<-FALSE#random coefficient on X2 in the analysis model?
probit<-FALSE#probit link instead of logistic link to generate X2 ?
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)#covariance of random effects
pi_spor<-.25#proportion of sporadically missing values
pi_syst<-.25#proportion of systematically missing values missing values
vna.mcar<-c("X1","X2")#incomplete covariates
betaMAR_0<-NULL;betaMAR_1<-NULL#parameters of a logistic model (beta_0, beta_1) used to generate missing values from X3
bincov<-F#is X1 binary ?
nbsim<-500#number of generated incomplete datasets
affichage<-FALSE#print some results ?
maxit<-5#number of iterations in FCS methods
m<-5#number of imputed datasets in the MI methods
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")#tested methods
methodjomo<-"random";iterjomo<-c("nburn"=2000,"nbetween"=1000)#parameters for JM-jomo


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)



##config 2
numconfig<-2
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
round(psi,4)
pi_spor<-.375
pi_syst<-.1
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)
Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 3
numconfig<-3
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
round(psi,4)
pi_spor<-0.0625
pi_syst<-.4
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)
Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)


##config 4 
numconfig<-4
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-1.19
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-T
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 5
numconfig<-5
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(4.03, -1.44, 0.39)
lambda<-1
seed<-NULL
sigma_eps<-NULL
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*1.24*.23,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(1.54,.05,2)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 6
numconfig<-6
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-1
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 7
numconfig<-7
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
round(psi,4)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-1
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 8
numconfig<-8
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<- -4
betaMAR_1<-1
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)



##config 9
numconfig<-9
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,0.0007)
pi_spor<-.25
pi_syst<-.25
randomslope<-TRUE
probit<-FALSE
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)

Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 10
numconfig<-10
I<-14
n<-ceiling(c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)[1:14]*2.745536)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)


##config 11
numconfig<-11
I<-28
n<-round(c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)/2)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)

Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 12
numconfig<-12
I<-28
n<-round(c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)/4)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 13

numconfig<-13
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.36
rho<- 0.003
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15

randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 14

numconfig<-14
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.04
rho<- 0.000333
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)


##config 15
numconfig<-15
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- .04
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 16
numconfig<-16
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.5*.36,0.5*.36,.36),2,2)#chgmt
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)


##config 17
numconfig<-17
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-2#chgmt
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 18
numconfig<-18
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.3*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##config 19
numconfig<-19
I<-28
n<-c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-TRUE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)


##config 20
numconfig<-20
I<-7
n<-ceiling(c(410, 567, 210, 375, 107, 267, 203, 354, 137, 48,208, 622, 78, 670, 1000, 1093, 18, 1834, 358, 54, 588,651, 455, 294, 397, 295, 303, 89)[1:I]*5.462833)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)


###########
#Influence of the cluster size: configuration 21:26
###########

##parametrage config 21 : 28 cluster 400 ind
numconfig<-21
I<-28
n<-rep(400,I)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##parametrage config 22 : 28 cluster 200 ind
numconfig<-22
I<-28
n<-rep(200,I)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##parametrage config 23 : 28 cluster 100 ind
numconfig<-23
I<-28
n<-rep(100,I)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##parametrage config 24 : 28 cluster 50 ind
numconfig<-24
I<-28
n<-rep(50,I)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##parametrage config 25 : 28 cluster 25 ind
numconfig<-25
I<-28
n<-rep(25,I)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)

Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)

##parametrage config 26 : 28 cluster 15 ind
numconfig<-26
I<-28
n<-rep(15,I)
sigma2_v1<-sigma2_v2<-0.12
rho<- 0.001
alpha_01<-2.9
alpha_02<- .42
sigma2_epsi<-matrix(c(.36,0.3*.36,0.3*.36,.36),2,2)
beta<-c(.72,-.11,.03)
lambda<-1
seed<-NULL
sigma_eps<-.15
randomslope<-FALSE
probit<-FALSE
psi<-matrix(-.87*.088*.02,3,3);psi[,3]<-psi[3,]<-0;diag(psi)<-c(.0077,.0004,.005)
pi_spor<-.25
pi_syst<-.25
vna.mcar<-c("X1","X2")
betaMAR_0<-NULL
betaMAR_1<-NULL
bincov<-F
nbsim<-500
affichage<-FALSE
maxit<-5
m<-5
method<-c("Full","CC","FCS-2stageREML","FCS-2stageMM","JM-pan","FCS-GLM","JM-jomo","FCS-fixclustPMM","FCS-fixclust","FCS-noclust","FCS-2lnorm")
methodjomo<-"random"
iterjomo<-c("nburn"=2000,"nbetween"=1000)


Call[[numconfig]]<-list(numconfig=numconfig,seed = seed,I = I, n = n,sigma2_v1 = sigma2_v1,rho = rho,sigma2_v2 = sigma2_v2,alpha_01 =
                          alpha_01,sigma2_epsi = sigma2_epsi,alpha_02 = alpha_02,beta = beta,lambda =
                          lambda,sigma_eps = sigma_eps,pi_spor = pi_spor,pi_syst=pi_syst,betaMAR_0 =betaMAR_0, betaMAR_1 = betaMAR_1,
                        nbsim=nbsim,affichage=affichage,maxit=maxit,m=m,method=method,vna.mcar=vna.mcar,psi=psi,methodjomo=methodjomo,bincov=bincov,iterjomo=iterjomo,randomslope=randomslope,probit=probit)


seedlist<-c(1090336799, 1509190052, 787700018, 815254674, 1200684040, 1587129789, 
            698260779, 958496955, 1311158317, 1462755734, 539545856, 1045185700, 
            1229681718, 1346512271, 658838809, 709695725, 1565141115, 1145272768, 
            860113238, 757128438, 1512565860, 1127136729, 875138383, 613847263, 
            1402052681, 1251537394, 1033879908, 603673800, 1425826898, 1307915755, 
            988939645, 211036225, 2073237719, 1654278508, 362641914, 200928346, 
            2097077456, 1710722421, 317767139, 38772851, 1967689957, 1816248670, 
            457634248, 86140012, 1915049214, 1798047047, 472593873, 287520805, 
            1713637555, 2133678344, 136997278, 374275134, 1632226476, 2017500433, 
            256355719, 536391703, 1761575041, 1912000826, 116515244, 412447760, 
            1871856794, 1989874979, 27010485, 1093028121, 908163471, 791160884, 
            1479481506, 1179356418, 827112856, 675671085, 1598217403, 1342030123, 
            955969981, 569614342, 1458868368, 1217398068, 1066874278, 647914527, 
            1369003145, 1553029501, 731277803, 849295440, 1167591622, 1543282022, 
            754691572, 905116745, 1123405023, 1380634959, 625861081, 1011134562, 
            1262715124, 1428624728, 572532162, 992572539, 1278100717, 2051566033, 
            223304007, 340134140, 1665218666, 2099621322, 170040672, 321637605, 
            1680669811, 1955848675, 60084597, 446529742, 1838854232, 1946035708, 
            83432814, 502285527, 1794602049, 1744796085, 284707107, 166795416, 
            2130061326, 1620229550, 395676988, 245161089, 2040261655, 1764028807, 
            505659665, 120230058, 1882038332, 1850291616, 424543498, 4674739, 
            2000708645, 1514310568, 759544638, 877456005, 1129044499, 1563381681, 
            707297063, 857812638, 1143348748, 1419314074, 597570316, 982999735, 
            1301303841, 1408550787, 619968277, 1039836848, 1258133050, 1207278540, 
            821209946, 704379617, 1593625207, 1083727829, 933195587, 781598458, 
            1502678640, 1227756542, 1042883432, 656437971, 1344750149, 1313069031, 
            960817009, 541963980, 1464501854, 1630317408, 371956726, 253938253, 
            2015754971, 1715564409, 289824751, 139398742, 2135441092, 1878467410, 
            418386884, 33112703, 1996387049, 1754982219, 530438109, 110397032, 
            1905506034, 2090580740, 194808722, 311810601, 1704127167, 2079751965, 
            217141131, 368582194, 1660890792, 1916810038, 88540064, 474894875, 
            1799971469, 1965946671, 36358073, 455316996, 1814341270, 748603960, 
            1536817838, 1116777237, 899128195, 737349153, 1559510711, 1174236942, 
            855269276, 574964234, 1430418076, 1279992615, 994841521, 623412755, 
            1378858629, 1260840768, 1008850858, 824826460, 1177479882, 1596439409, 
            673221607, 910433861, 1094921939, 1481277290, 793595904, 1072845422, 
            1224041208, 1375482691, 653984725, 949982839, 1335404257, 1452406620, 
            563529678, 401664752, 1626856038, 2046725085, 251247435, 278736617, 
            1738153599, 2123583430, 160726868, 422273730, 1848398420, 1998914543, 
            2241401, 507946715, 1765905997, 1883817976, 122681186, 172489364, 
            2101398018, 1682545593, 323922735, 220872333, 2049773083, 1663328162, 
            337866552, 77361830, 1939554864, 1787958155, 496313117, 66172607, 
            1962313257, 1845483412, 452519686, 786512330, 1508247904, 1089427685, 
            937977971, 697105873, 1586220359, 1199742204, 814066794, 540717564, 
            1463648622, 1312084183, 959701057, 660043235, 1347437941, 1230574798, 
            1046357080, 861284782, 1146165564, 1566066817, 710899735, 876342709, 
            1128062243, 1513458840, 758299662, 1032692128, 1250595082, 1401143475, 
            612692005, 987784583, 1307006225, 1424884906, 602485820, 361699586, 
            1653090712, 2072082477, 210127035, 316857625, 1709567375, 2095889460, 
            199986338, 458527028, 1817420198, 1968893983, 39698569, 473519403, 
            1799251389, 1916220422, 87032976, 137890150, 2134850036, 1714841673, 
            288446687, 257281405, 2018704875, 1633397840, 375168198, 115573080, 
            1910813122, 1760419963, 535482605, 26101071, 1988720089, 1870668898, 
            411505908, 1480423514, 792348880, 909318517, 1093937635, 1599126593, 
            676826327, 828300652, 1180298746, 1457975404, 568443134, 954765639, 
            1341104593, 1368077427, 646710501, 1065702750, 1216505288, 1166698558, 
            848124076, 730073361, 1552103815, 1122479141, 903912627, 753519880, 
            1542389150, 1263656976, 1012322458, 627015971, 1381544373, 1279009815, 
            993727617, 573719866, 1429566892, 1666406546, 341075976, 224213437, 
            2052720939, 1681824905, 322546719, 170982820, 2100809010, 1837682852, 
            445636662, 59158927, 1954644249, 1793397947, 501359661, 82539926, 
            1944864000, 2128890102, 165902436, 283781593, 1743591759, 2039057645, 
            244235387, 394784192, 1619058006, 1883226312, 121172050, 506569195, 
            1765183869, 2001863903, 5583945, 425485810, 1851479396, 1129954025, 
            878611071, 760732614, 1515252564, 1144291056, 859000422, 708452317, 
            1564290891, 1300378331, 981795405, 596399096, 1418421090, 1257240258, 
            1038665300, 618764271, 1407625081, 1592699533, 703175195, 820038562, 
            1206385464, 1501785748, 780426754, 931991481, 1082801967, 1345659583, 
            657592873, 1044071316, 1228698374, 1465444006, 543151664, 961972107, 
            1313978141, 2016909857, 254847671, 372898574, 1631505308, 2136628792, 
            140340910, 290733845, 1716719491, 1995182611, 32187013, 417493824, 
            1877296042, 1904334346, 109504156, 529512231, 1753778097, 1702922821, 
            310885075, 193915754, 2089409536, 1659719260, 367689418, 216215409, 
            2078547943, 1801126519, 475804385, 89482076, 1917998030, 1815529070, 
            456259320, 37267267, 1967101909, 897973113, 1115868143, 1535875670, 
            747416260, 854081376, 1173295094, 1558601293, 736194267, 996045643, 
            1280918493, 1431310952, 576135922, 1010022226, 1261733828, 1379784319, 
            624617193, 674425629, 1597365131, 1178372658, 825997992, 794767108, 
            1482170258, 1095847465, 911638207, 652829487, 1374573497, 1223098884, 
            1071657622, 562341686, 1451464608, 1334494747, 948827789, 250338225, 
            2045569831, 1625668254, 400722444, 159784872, 2122395454, 1736998533, 
            277827091, 3167107, 2000118549, 1849569968, 423166522, 123574170, 
            1884989196, 1767110327, 508872225, 324848597, 1683749699, 2102569722, 
            173382256, 338759628)

rm(list=c("method","numconfig","seed","I","n","sigma2_v1","rho","sigma2_v2","alpha_01","sigma2_epsi","alpha_02","beta","lambda",
"sigma_eps","pi_spor","pi_syst","betaMAR_0","betaMAR_1","nbsim","affichage","maxit","m","vna.mcar","bincov","iterjomo","randomslope","probit"))
