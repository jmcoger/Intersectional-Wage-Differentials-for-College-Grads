*=====================================================================================================================================================================
*Date: February 2022 --> Latest Update: June 2022
*Paper: Hard Work, College Selectivity, and Racial Wage Differentials 
*
*This code analyzes the data using Kitagawa-Oaxaca-Blinder decompositions to examine differences in the wages of white and marginalized college graduates.    
*
*database used: WageDiffFinalDataset.dta
*				
*output: WageDiffRaceAnalysis.smcl
*
*key variables: - log income for wages and salary
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

log using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\logfiles\WageDiffRaceAnalysis.smcl"

use "WageDiffFinalDataset.dta"

*Create white variable for decompositions
generate white = 0

replace white = 1 if race == 0

*determine necessary independent variables using lasso method
lasso linear logwageincome (selectivityandhardwork) maritalstatus female age experienceyears experienceyearssq experienceyearsquart south asvabpercentile graduatedegree businessmarketingmanagement libartsgensciencehumanities healthlimitswork 

*display selected controls and coefficients 
lassocoef, display(coef, postselection)

*selectivityandhardwork, experienceyearsquart, maritalstatus, asvabpercentile, graduatedegree, healthlimitswork, businessmarketingmanagement, female, age selected as independent variables by lasso

*add experienceyears to regression since we have experiencequart as an independent variable, and test to see correlation between age, experienceyears, and experiencequart
regress logwageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female age

vif

corr selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female age

regress logwageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female 

vif
 
*remove age from independent variables since it has moderate correlation with experienceyears and experienceyearsquart, seemingly redundant, and is also insignificant (p-value =.6) (mean VIF now 1.60)

***Marginalized graduates and white graduates***

*Cotton decomposition with benefit and cost 
nldecompose, by (white) omega(cotton) regoutput: regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement, vce (robust)

*Cotton decomposition with detailed decomposition
oaxaca logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement, by(white) se vce(robust) weight(.70) noisily

*Exponentiatetd results for Cotton decomposition
oaxaca, eform

*Neumark pooled decomposition with benefit and cost
nldecompose, by (white) omega(neumark) regoutput: regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement, vce (robust)

*Neumark pooled decomposition with detailed decomposition
oaxaca logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement, by(white) se vce(robust) omega noisily

***Marginalized women and white men***

*Cotton decomposition with benefit and cost
nldecompose, by (white) omega(cotton) regoutput: regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 1, vce (robust)

*Cotton decomposition with detailed decomposition
oaxaca logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 1, by(white) se vce(robust) weight(.66) noisily

*Exponentiatetd results for Cotton decomposition
oaxaca, eform

*Neumark pooled decomposition with benefit and cost
nldecompose, by (white) omega(neumark) regoutput: regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 1, vce (robust)

*Neumark pooled decomposition with detailed decomposition
oaxaca logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 1, by(white) se vce(robust) omega noisily

***Marginalized men and white men***

*Cotton decomposition with benefit and cost
nldecompose, by (white) omega(cotton) regoutput: regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 0, vce (robust)

*Cotton decomposition with detailed decomposition
oaxaca logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 0, by(white) se vce(robust) weight(.74) noisily

*Exponentiatetd results for Cotton decomposition
oaxaca, eform

*Neumark pooled decomposition with benefit and cost
nldecompose, by (white) omega(neumark) regoutput: regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 0, vce (robust)

*Neumark pooled decomposition with detailed decomposition
oaxaca logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 0, by(white) se vce(robust) omega noisily

***White men and marginalized graduates***

*Cotton decomposition with benefit and cost
nldecompose, by (white) omega(cotton) regoutput: regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 0| white == 0 & female == 1, vce (robust)

*Cotton decomposition with detailed decomposition
oaxaca logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 0| white == 0 & female == 1, by(white) se vce(robust) weight(.53) noisily

*Exponentiatetd results for Cotton decomposition
oaxaca, eform

*Neumark pooled decomposition with benefit and cost
nldecompose, by (white) omega(neumark) regoutput: regress logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 0| white == 0 & female == 1, vce (robust)

*Neumark pooled decomposition with detailed decomposition
oaxaca logwageincome collegeselectivity selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement if white == 1 & female == 0| white == 0 & female == 0| white == 0 & female == 1, by(white) se vce(robust) omega noisily

log close 





