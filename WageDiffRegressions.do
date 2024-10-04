*=====================================================================================================================================================================
*Date: July 2022
*Paper: Hard Work, College Selectivity, and Racial Wage Differentials
*
*This code creates tables containing the regressions used to calculate the KOB decompositions.
*
*database used: WageDiffFinalDataset.dta
*
*output: WageDiffRegressions.smcl, LaTeX regression tables
*
*key variables: - log income from wages and salary
*               - healthlimitswork
*               - work experience in years
*               - graduate degree received
*               - lives in South
*               - occupation code for job 1
*               - asvab percentile
*               - race 
*               - age
*               - sex
*               - female
*               - id
*               - marital status 
*               - attitudes toward hard work
*               - college selectivity
*               - dummies for liberal arts\gen science\humanities and business\marketing/management
*							
*=====================================================================================================================================================================

clear

clear matrix

log using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\logfiles\WageDiffRegressions.smcl"

use "WageDiffFinalDataset.dta"

*Define the directory
global PATH "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\tables"
cd $PATH

*Create white variable for decompositions
generate white = 0

replace white = 1 if race == 0

***Run OLS regressions for each demographic and save the results as a table***

*Regression for marginalized graduates
regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 0

*Save regression results 
est sto m1

*Regression for white graduates
regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1

*Save regression results
est sto m2

*Regression for marginalized women
regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 0 & female == 1

*Save regression results
est sto m3

*Regression for white men 
regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0

*Save regression results
est sto m4

*Save output results for marginalized and white graduates in a table
esttab m1 m2 using WageDiffRegressionsMargWhite.tex, keep (collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement) cells(b(star fmt(3)) se(fmt(3) par)) starlevels(* .1 ** .05 *** .01 **** .001) obslast stats(r2 N, ///
labels("R^2")) legend nolabel nonumber title("Regressions for College Graduate KOB Decompositions") mtitles("Marginalized" "White")

*Save output results for marginalized womena and white men in a table
esttab m3 m4 using WageDiffRegressionsMargWomenWhiteMen.tex, keep (collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement) cells(b(star fmt(3)) se(fmt(3) par)) starlevels(* .1 ** .05 *** .01 **** .001) obslast stats(r2 N, ///
labels("R^2")) legend nolabel nonumber title("Regressions for College Graduate KOB Decompositions") mtitles("Marginalized Women" "White Men")

log close


