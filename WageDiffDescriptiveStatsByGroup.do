*=====================================================================================================================================================================
*Date: June 2022 --> Latest Update: August 2022
*Paper: Exceptional Yet Unequal?: College Selectivity, Hard Work, and NLSY97 Racial Wage Differentials
*
*This code creates summary statistics for our dependent variables and independent variables then generates descriptive statistics tables for LaTeX.
*
*database used: WafeDiffFinalDataset.dta
*				
*output: WageDiffDescriptiveStatsByGroup.tex
*
*key variables: -female
*				-race
*				-marital status
*				-health limits work
*				-attitude toward hard work personality scale score
*				-college selectivity
*				-asvab percentile score
*				-experience in years
*               -income from salary and wages for 2019
*               -log income from salary and wages for 2019
*               -graduate degree
*               -major in business, marketing, or management
*							
*=====================================================================================================================================================================

clear

clear matrix

set mem 500m

log using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\logfiles\WageDiffDescriptiveStatsByGroup.smcl"

*install estout package
ssc install estout, replace

which estout  // check versions

which esttab

*Define the directory
global PATH "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\tables"
cd $PATH

*open final dataset 
use "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\dofiles_dtafiles\WageDiffFinalDataset.dta"

*Delete cases without collegeselectivityardworkscore data
keep if collegeselectivity != .

*Create white variable
generate white = 0

replace white = 1 if race == 0

*Drop observations with zeroes for wageincome
drop if wageincome < = 0

**Create table for pooled sample descriptive statistics
tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome white, c(stat) stat(mean sd min max n)

ereturn list

est clear  // clear the est locals

estpost tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome white, c(stat) stat(mean sd min max n)

esttab, ///
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs collabels("Mean" "SD" "Min" "Max" "N")

*export table as LaTeX file
esttab using "./WageDiffPooledDescriptives.tex", replace ////
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs booktabs f ///
  collabels("Mean" "SD" "Min" "Max" "N")

**create table ouput for white group descriptive statistics
tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 1, c(stat) stat(mean sd min max n)

ereturn list

est clear  // clear the est locals

estpost tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 1, c(stat) stat(mean sd min max n)

esttab, ///
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs collabels("Mean" "SD" "Min" "Max" "N")

*export table as LaTeX file
esttab using "./WageDiffWhiteDescriptives.tex", replace ////
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs booktabs f ///
  collabels("Mean" "SD" "Min" "Max" "N")
 
**create table ouput for marginalized group descriptive statistics
tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 0, c(stat) stat(mean sd min max n)

ereturn list

est clear  // clear the est locals

estpost tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 0, c(stat) stat(mean sd min max n)

esttab, ///
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs collabels("Mean" "SD" "Min" "Max" "N")

*export table as LaTeX file
esttab using "./WageDiffMargDescriptives.tex", replace ////
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs booktabs f ///
  collabels("Mean" "SD" "Min" "Max" "N")
  
**create table ouput for marginalized women descriptive statistics
tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 0 & female == 1, c(stat) stat(mean sd min max n)

ereturn list

est clear  // clear the est locals

estpost tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 0 & female == 1, c(stat) stat(mean sd min max n)

esttab, ///
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs collabels("Mean" "SD" "Min" "Max" "N")

*export table as LaTeX file
esttab using "./WageDiffMargWomenDescriptives.tex", replace ////
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs booktabs f ///
  collabels("Mean" "SD" "Min" "Max" "N") 

**create table ouput for marginalized men descriptive statistics
tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 0 & female == 0, c(stat) stat(mean sd min max n)

ereturn list

est clear  // clear the est locals

estpost tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 0 & female == 0, c(stat) stat(mean sd min max n)

esttab, ///
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs collabels("Mean" "SD" "Min" "Max" "N")

*export table as LaTeX file
esttab using "./WageDiffMargMenDescriptives.tex", replace ////
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs booktabs f ///
  collabels("Mean" "SD" "Min" "Max" "N") 

**create table ouput for white women descriptive statistics
tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 1 & female == 1, c(stat) stat(mean sd min max n)

ereturn list

est clear  // clear the est locals

estpost tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 1 & female == 1, c(stat) stat(mean sd min max n)

esttab, ///
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs collabels("Mean" "SD" "Min" "Max" "N")

*export table as LaTeX file
esttab using "./WageDiffWhiteWomenDescriptives.tex", replace ////
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs booktabs f ///
  collabels("Mean" "SD" "Min" "Max" "N")
  
**create table ouput for white men descriptive statistics
tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 1 & female == 0, c(stat) stat(mean sd min max n)

ereturn list

est clear  // clear the est locals

estpost tabstat age asvabpercentile attitudehardworkscore businessmarketingmanagement collegeselectivity experienceyears experienceyearsquart female healthlimitswork graduatedegree logwageincome maritalstatus wageincome if white == 1 & female == 0, c(stat) stat(mean sd min max n)

esttab, ///
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs collabels("Mean" "SD" "Min" "Max" "N")

*export table as LaTeX file
esttab using "./WageDiffWhiteMenDescriptives.tex", replace ////
 cells("mean(fmt(%13.2fc)) sd(fmt(%13.2fc)) min max count") nonumber ///
  nomtitle nonote noobs booktabs f ///
  collabels("Mean" "SD" "Min" "Max" "N") 

  
 
 