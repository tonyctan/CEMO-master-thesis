# //ref https://www.ucl.ac.uk/population-health-sciences/sites/population-health-sciences/files/quartagno_1.pdf
# Author = Quartagno, M., joint work with Carpenter, J.
# Presentation based on R Journal paper with Grund, S.
# Date = 03 April 2019

# Load jomo library
library(jomo)

# Jomo is an R package built to do imputation guaranteeing compatibility in such situations;
# Based on Joint Modelling imputation for clustered/multilevel data
# It can handle missing data in continuous/binary/categorical variables at level 1 (student) and/or 2 (school)
# Let's start from a simple example:

# Import data
data(JSPmiss)
head(JSPmiss) # Data from Junior School Project
# Model of interest: linear regression of English score at 3 years over 1 year test score and sex:
# lm(english ~ ravens + sex)
# Missing data in English and ravens. We can assume simple multivariate normal model with sex as covariate.
# jomo can fit and impute from this model.

# jomo: single level example
Y <- JSPmiss[, c("english", "ravens")]
JSPmiss$cons <- 1
X <- JSPmiss[, c("cons", "sex")]
set.seed(1569)
imp <- jomo(Y = Y, X = X, nburn = 1000, nbetween = 1000, nimp = 5)

# Once we have imputed data in imp, how do we fit model on each imputed data? How do we combine estimates?
# Can use several packages, here we show how to use mitools:
library(mitools)
imp.list <- imputationList(split(imp, imp$Imputation)[-1])
fit.imp <- with(data = imp.list, lm(english ~ ravens + sex))
coefs <- MIextract(fit.imp, fun = coef)
vars <- MIextract(fit.imp, fun = function(x) diag(vcov(x)))
results <- MIcombine(coefs, vars)
summary(results)

# Including categorical variables
# Easy to include categorical/binary variables. Just need to be treated as factor:
JSPmiss <- within(JSPmiss, fluent <- factor(fluent))
Y <- JSPmiss[, c("english", "ravens", "fluent")]
X <- JSPmiss[, c("cons", "sex")]
set.seed(1569)
imp <- jomo(Y = Y, X = X)

# Random intercept model

# Motivation for jomo was multilevel data
# So assume our substantive analysis model is:
# lmer(english ~ ravens + sex + factor(fluent) + (1|school))
# If we have random intercept in analysis model, need to reflect that in the imputation model as well
# In jomo, only thing that changes is that we need to tell software about clusting

# jomo: multilevel data example
clus <- JSPmiss$school
Y <- JSPmiss[, c("english", "ravens", "fluent")]
JSPmiss$cons <- 1
X <- JSPmiss[, c("cons", "sex")]
set.seed(1569)
imp <- jomo(Y=Y,X=X,clus=clus,nburn=2000,nbetween=1000,nimp=5)


# Random slopes
# Fitting the random intercept model on al limputed datasets and combine the estimates is no different than in the single level example
library(lme4)
imp.list <- imputationList(split(imp, imp$Imputation)[-1])
fit.imp <- with(data = imp.list, lmer(english ~ ravens + sex + factor(fluent) + (1 | clus)))
coefs <- MIextract(fit.imp, fun = fixef)
vars <- MIextract(fit.imp, fun = function(x) diag(vcov(x)))
results <- MIcombine(coefs, vars)
summary(results)

# If the analysis model has random slopes:
# lmer(english ~ ravens + sex + factor(fluent) + (1 + ravens|school))
# Or more generally if there is likely heterogeneity between cluster, option "random" must be used:
# imp <- jomo(Y = Y, X = X, clus = clus, meth = "random")

# Some variables may be at level 2, e.g. school-related variables;
# Need to make sure we impute properly, i.e., same value for all individuals in same school
# Easily dealt with by jomo:
head(ExamScores) # Let's use ExamScores data
Y <- ExamScores[, c("normexam", "standlrt")]
Y2 <- ExamScores[, "avslrt", drop = F]
clus <- data.frame(ExamScores$school)
set.seed(1569)
imp <- jomo(Y = Y, Y2 = Y2, clus = clus)

# Checking convergence

# jomo imputes by running MCMC. Crutial to check chains have converged begore registering imputations.
# Can do this with jomo.MCMCchain function:
# (Go back to the very first example)
Y <- JSPmiss[, c("english", "ravens")]
JSPmiss$cons <- 1
X <- JSPmiss[, c("cons", "sex")]
# Save chains
imp <- jomo.MCMCchain(Y=Y, X=X,nburn=5000)
# Visualise chains
plot(imp$collectbeta[1, 1, 1:5000], type = "l", xlab = "Iteraction number", ylab = expression(beta["m,0"]))

# jomo assumes flat prior for all parameters but covariance matrices; default is identity, if not suitable either use expert-informed priors or derive from data:
JSPmiss <- within(JSPmiss, fluent <- factor(fluent))
Y <- JSPmiss[, c("english", "ravens", "fluent")]
X <- JSPmiss[, c("cons", "sex")]
imp1 <- jomo.MCMCchain(Y = Y, X = X)
l1cov.guess <- apply(imp1$collectomega, c(1, 2), mean)
l1cov.prior <- l1cov.guess * 4
imp <- jomo(Y=Y,X=X,l1cov.prior=l1cov.prior)

# Recommended workflow:
# 1. Before running the imputation model (which may take some time), perform a "dry run", i.e., run .MCMCchain function with nburn=2 and check the output;
# 2. Re-run the same function for a larger number of iterations (e.g. 5000) and analyse trace plots to choose sensible number of burn-in and between-imputation iterations;
# 3. Run the jomo function for the chose number of iterations
# 4. Fit the substantive model on the imputed data sets and apply Rubin's rules

# mitml: alternative interfact to jomo
# Package mitml offers an alternative interface, based on the classic formula/data framework
library(mitml)
fml <- english + ravens + fluent ~ sex + (1|school)
imp <- jomoImpute(data=JSPmiss, formula=fml, n.burn=1000, n.iter=1000, m=5, seed=1569)
summary(imp)

# Package mitml offers an alternative interface, based on the classic formula/data framework
plot(imp, trace="all")

# jomo and compatibility
# We said the motivation for jomo was imputing when there are compatibility problems
# Functions used thus far solve compatibility with random intercept and approximately for random slopes
# However, still no compatibility with interactions, non-linearities, survival models.
# For this, new "Substantive Model Compatible" functions. SMC-jomo for friends...
# For example, if our substantive model is random intercept model with quadratic effect:
cldata <- within(cldata, sex <- factor(sex))
# We define the data frame with all the variables
data <- cldata[, c("measure", "age", "sex", "city")]
mylevel <- c(1, 1, 1, 1)
# Add the formula of the sustantive lm model
formula <- as.formula(measure ~ sex + age + I(age^2) + (1 | city))
# And finally we run the imputation function
imp <- jomo.lmer(formula,data,level=mylevel, nburn=1000,nbetween=1000)

# SMC-jomo
# Currently SMC-jomo available for imputation compatible with lm and lmer, glm and glmer (binomial only), coxph, polr and clmm
# Can handle random intercept and slopes with unstructured covariance matrix
# Non-linearities and interactions
# Future developments: splines, other variance structures, other models (e.g. frailty), ...

# Conclusions
# MI has become gold standard in handling missing data
# However, needs to be used carefully. Compatibility of imputation and analysis model is keymul
# jomo provides a software to impute compatibly when analysis model is multilevel
# Additionally the SMC-jomo functions can handel interaction, nonlinearities, and are the only ones 100% compatible with random slopes

# Limitations/extensions
# Important to always check the sampler has converged before starting registering imputations
# jomo can be very slow with large data sets, particularly with categorical variables with several categories--plan to speed up package in the future
# We will keep maintaining the package and including new functions, for imputation compatible with other analysis models
