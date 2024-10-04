*=====================================================================================================================================================================
*Date: February 2022 --> Latest Update: March 2022
*Paper: Hard Work, College Selectivity, and Racial Wage Differentials 
*
*This code analyzes the data using Kitagawa-Oaxaca-Blinder decompositions to examine differences in the wages of white and marginalized college graduates.    
*
*database used: WageDiffFinalDataset.dta
*				
*output: WageDiffAnalysis.smcl
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

log using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\logfiles\WageDiffAnalysis.smcl"

use "WageDiffFinalDataset.dta"

global infile="C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\graphs"

*Define the directory
global PATH "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\tables"
cd $PATH

*install commands for oaxaca rif
ssc install rif

*install coefplot command
ssc install coefplot

*determine necessary controls using lasso method
lasso linear logwageincome (selectivityandhardwork) maritalstatus female age experienceyears experienceyearssq experienceyearsquart south asvabpercentile graduatedegree businessmarketingmanagement libartsgensciencehumanities healthlimitswork 

*display selected controls and coefficients 
lassocoef, display(coef, postselection)

*selectivityandhardwork, experienceyearsquart, maritalstatus, asvabpercentile, graduatedegree, healthlimitswork, businessmarketingmanagement, female, age selected as controls by lasso

*add experienceyears to regression since we have experiencequart as a control, and test to see correlation between age, experienceyears, and experiencequart
regress logwageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female age

vif

corr selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female age

regress logwageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female 

vif
 
*remove age from controls since it has moderate correlation with experienceyears and experienceyearsquart, seemingly redundant, and is also insignificant (p-value =.6) (mean VIF now 1.60)

***estimate Kitagawa-Oaxaca-Blinder decompositions and quantile RIF decompositions***

****Racial wage differential analysis***

*twofold decomposition with logwageincome as dependent variable using pooled coefficients
oaxaca logwageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female, by(race) se vce(robust) pooled noisily

estimates store pooled

*create graph of pooled decocomposition results
coefplot, drop(overall:group*) keep(selectivityandhardwork experienceyears maritaltstatus asvabpercentile graduatedegree female _cons) xline(0) ///
recast(bar) barwidth(.7) base(0) nolabels citop ciopts(recast(rcap))

*export coefplot for pooled decomposition
graph export "$infile/RacePooledDecomp.eps", as(eps) preview(off) replace

!epstopdf "$infile/RacePooledDecomp.eps"

*create table of explained and unexplained results for pooled model
. nlcom (explained: _b[overall:explained] /_b[overall:difference]*100) ///
(unexplained: _b[overall:unexplained]/_b[overall:difference]*100), post

estimates store pct

esttab pooled pct using RacePooledTable.tex, replace ///
keep(difference explained unexplained) nostar ci wide ///
noobs nonumber mtitle("Pooled Decomposition" "In percent") eqlab(none)

*twofold decomposition with logwageincome as dependent variable and Cotton weight for coefficients
oaxaca logwageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female, by(race) se vce(robust) weight(.70) noisily

estimates store Cotton

*create graph of Cotton decomposition results
coefplot, drop(overall:group*) keep(selectivityandhardwork experienceyears maritaltstatus asvabpercentile graduatedegree female _cons) xline(0) ///
recast(bar) barwidth(.7) base(0) nolabels citop ciopts(recast(rcap))

*export coefplot for Cotton decompostion
graph export "$infile/RaceCottonDecomp.eps", as(eps) preview(off) replace

!epstopdf "$infile/RaceCottonDecomp.eps"

*Create table of explained and unexplained results for Cotton model
nlcom (explained: _b[overall:explained] /_b[overall:difference]*100) ///
(unexplained: _b[overall:unexplained]/_b[overall:difference]*100), post

estimates store pct

esttab Cotton pct using RaceCottonTable.tex, replace ///
keep(difference explained unexplained) nostar ci wide ///
noobs nonumber mtitle("Cotton Decomposition" "In percent") eqlab(none)

*Create graph comparing Cotton and pooled decomposition results
coefplot Cotton pooled, keep(selectivityandhardwork experienceyears maritaltstatus asvabpercentile graduatedegree female _cons) drop(overall:group*) xline(0) ///
recast(bar) barwidth(.3) base(0) nolabels citop ciopts(recast(rcap))

graph export "$infile/RaceCottonVsPooledDecomp.eps", as(eps) preview(off) replace

!epstopdf "$infile/RaceCottonVsPooledDecomp.eps"

*twofold decomposition with wageincome as dependent variable at .25 quantile
bootstrap: oaxaca_rif wageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female, by(race) rif(q(25)) robust swap w(0)

estimates store race25quant

*create graph of .25 quantile decomposition results
coefplot, drop(overall:group*) keep(selectivityandhardwork experienceyears maritaltstatus asvabpercentile graduatedegree female _cons) xline(0) ///
recast(bar) barwidth(.7) base(0) nolabels citop ciopts(recast(rcap))

graph export "$infile/Race25QuantDecomp.eps", as(eps) preview(off) replace

!epstopdf "$infile/Race25QuantDecomp.eps"

*Create table of explained and unexplained results for 25 Quantile model
nlcom (explained: _b[overall:explained] /_b[overall:difference]*100) ///
(unexplained: _b[overall:unexplained]/_b[overall:difference]*100), post

estimates store pct

esttab race25quant pct using Race25QuantTable.tex, replace ///
keep(difference explained unexplained) nostar ci wide ///
noobs nonumber mtitle("25th Quantile Decomposition" "In percent") eqlab(none)

*twofold decomposition with wageincome as dependent variable at .5 quantile 
bootstrap: oaxaca_rif wageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female, by(race) rif(q(50)) robust swap w(0)

estimates store race50quant

*create graph of .5 quantile decomposition results
coefplot, drop(overall:group*) keep(selectivityandhardwork experienceyears maritaltstatus asvabpercentile graduatedegree female _cons) xline(0) ///
recast(bar) barwidth(.7) base(0) nolabels citop ciopts(recast(rcap))

graph export "$infile/Race50QuantDecomp.eps", as(eps) preview(off) replace

!epstopdf "$infile/Race50QuantDecomp.eps"

*Create table of explained and unexplained results for 50 quantile model
nlcom (explained: _b[overall:explained] /_b[overall:difference]*100) ///
(unexplained: _b[overall:unexplained]/_b[overall:difference]*100), post

estimates store pct

esttab race50quant pct using Race50QuantTable.tex, replace ///
keep(difference explained unexplained) nostar ci wide ///
noobs nonumber mtitle("50th Quantile Decomposition" "In percent") eqlab(none)

*twofold decomposition with wageincome as dependent variable at .75 quantile 
bootstrap: oaxaca_rif wageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement female, by(race) rif(q(75)) robust swap w(0)

estimates store race75quant

*create graph of .75 quantile decomposition results
coefplot, drop(overall:group*) keep(selectivityandhardwork experienceyears maritaltstatus asvabpercentile graduatedegree female _cons) xline(0) ///
recast(bar) barwidth(.7) base(0) nolabels citop ciopts(recast(rcap))

graph export "$infile/Race75QuantDecomp.eps", as(eps) preview(off) replace

!epstopdf "$infile/Race75QuantDecomp.eps"

*Create table of explained and unexplained results for 75 quantile model
nlcom (explained: _b[overall:explained] /_b[overall:difference]*100) ///
(unexplained: _b[overall:unexplained]/_b[overall:difference]*100), post

estimates store pct

esttab race75quant pct using Race75QuantTable.tex, replace ///
keep(difference explained unexplained) nostar ci wide ///
noobs nonumber mtitle("75th Quantile Decomposition" "In percent") eqlab(none)

***Gender wage differential analysis***

*twofold decomposition with logwageincome as dependent variable by gender using pooled coefficients
oaxaca logwageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement race, by(female) se vce(robust) pooled noisily

estimates store genderpooled

*create graph of gender pooled decomposition results
coefplot, drop(overall:group*) keep(selectivityandhardwork experienceyears maritaltstatus asvabpercentile graduatedegree race female _cons) xline(0) ///
recast(bar) barwidth(.7) base(0) nolabels citop ciopts(recast(rcap))

graph export "$infile/GenderPooledDecomp.eps", as(eps) preview(off) replace

!epstopdf "$infile/GenderPooledDecomp.eps"

oaxaca, eform

*twofold decomposition with logwageincome as dependent variable by gender using Cotton weight for coefficients
oaxaca logwageincome selectivityandhardwork experienceyears experienceyearsquart maritalstatus asvabpercentile graduatedegree healthlimitswork businessmarketingmanagement race, by(female) se vce(robust) weight(.44) noisily

estimates store genderCotton

*create graph of gender Cotton decomposition results
coefplot, drop(overall:group*) keep(selectivityandhardwork experienceyears maritaltstatus asvabpercentile graduatedegree race female _cons) xline(0) ///
recast(bar) barwidth(.7) base(0) nolabels citop ciopts(recast(rcap))

graph export "$infile/GenderCottonDecomp.eps", as(eps) preview(off) replace

!epstopdf "$infile/GenderCottonDecomp.eps"

*Create graph comparing Cotton and pooled decomposition results by gender
coefplot genderpooled genderCotton, keep(selectivityandhardwork experienceyears maritaltstatus asvabpercentile graduatedegree female _cons) drop(overall:group*) xline(0) ///
recast(bar) barwidth(.3) base(0) nolabels citop ciopts(recast(rcap))

graph export "$infile/GenderCottonVsPooledDecomp.eps", as(eps) preview(off) replace

!epstopdf "$infile/GenderCottonVsPooledDecomp.eps"

log close 


 





