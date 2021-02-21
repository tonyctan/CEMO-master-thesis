############
#READ ME
############

The main program is main.par.r. For a given configuration, it runs calculation in parallel: multiple imputations of incomplete datasets (function simu_one_par), stack of the inference results as a list of arrays (stack.results), and calculate criteria (bias, coverage,...) for evaluation of the imputation method (summarize.results).

------------------------------------
The function simu_one_par.r allows generation of one incomplete dataset, multiple imputation according to the several methods, and analyse of the multiply imputed dataset:

- incomplete datasets are generated via the program generate_data.r according to the parameters given in the R file parameter.r.

- multiple imputation is performed using the suitable R packages or using the addon functions for the R package mice:
mice.impute.2l.glm.bin / mice.impute.2l.glm.norm to impute binary or continuous variables using FCS-GLM
mice.impute.2l.2stage.bin.reml / mice.impute.2l.2stage.norm.reml to impute binary or continuous variables using FCS-2stage (version REML)
mice.impute.2l.2stage.bin.mm / mice.impute.2l.2stage.norm.mm to impute binary or continuous variables using FCS-2stage (version MM)
mice.impute.2l.norm.syst impute continuous variables according to the FCS-2lnorm method

- analyse of the multiply imputed dataset is performed using the program analyse.r
------------------------------------

------------------------------------
The program stackresults.r modifies the format of the output provided by the 500 calls to simu_one_par.r
------------------------------------

------------------------------------
The function summarize.results provides relative bias, rmse, model se, empirical se and time from the 500 generated datasets
------------------------------------