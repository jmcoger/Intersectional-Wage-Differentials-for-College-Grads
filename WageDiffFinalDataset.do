*=====================================================================================================================================================================
*Date: January 2022 --> Latest Update: January 2022
*Paper: Hard Work, College Selectivity, and Racial Wage Differentials 
*
*This code merges respondents with the SAT scores for their colleges and creates controls so that the data is ready for analysis.   
*
*database used: SATScoresInstitutionName.dta , WageDiffDataNoSelectivity.dta
*				
*output: WageDiffFinalDataset.dta
*
*key variables: - log income for wages and salary
*               - health limits work
*               - work experience
*               - lives in metropolitan statistical area
*               - graduate degree received
*               - lives in South
*               - occupation code for job 1
*               - asvab percentile
*               - parents highest education
*               - race 
*               - relationship to head of household in 1997
*               - age
*               - sex
*               - female
*               - id
*               - marital status throughout 2019
*               - attitudes toward hard work
*               - college selectivity
*               - dummies for liberal arts\gen science\humanities and business\marketing/management
*							
*=====================================================================================================================================================================

clear

clear matrix

set mem 500m

log using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\logfiles\WageDiffFinalDataset.smcl"

*Define the directory
global PATH "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\dofiles_dtafiles"
cd $PATH

use "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\dofiles_dtafiles\WageDiffDataNoSelectivity.dta"

merge m:1 college using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\dofiles_dtafiles\SATScoresInstitutionName.dta"

drop _merge 

merge m:1 college using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\dofiles_dtafiles\ACTScoresInstitutionName.dta"

*create college selectivity variable 
generate collegeselectivity = satmath75p + satreadwrite75p

*convert ACT composite score to SAT 1600 point scale
replace collegeselectivity = 930 if act75p == 17

replace collegeselectivity = 970 if act75p == 18

replace collegeselectivity = 1010 if act75p == 19 

replace collegeselectivity = 1040 if act75p == 20

replace collegeselectivity = 1080 if act75p == 21

replace collegeselectivity = 1110 if act75p == 22

replace collegeselectivity = 1140 if act75p == 23

replace collegeselectivity = 1180 if act75p == 24

replace collegeselectivity = 1210 if act75p == 25

replace collegeselectivity = 1240 if act75p == 26

replace collegeselectivity = 1280 if act75p == 27

replace collegeselectivity = 1310 if act75p == 28

replace collegeselectivity = 1340 if act75p == 29

replace collegeselectivity = 1370 if act75p == 30

replace collegeselectivity = 1400 if act75p == 31

replace collegeselectivity = 1430 if act75p == 32

replace collegeselectivity = 1460 if act75p == 33

replace collegeselectivity = 1500 if act75p == 34 

replace collegeselectivity = 1540 if act75p == 35

replace collegeselectivity = 1590 if act75p == 36

*create college selectivity and attitudes toward hard work interaction variable 
generate selectivityandhardwork = collegeselectivity*attitudehardworkscore

*create race variable 
generate race=0

replace race = 1 if raceethnicity == 1| raceethnicity == 2| raceethnicity == 3

label define racialgroup 0 "white" 1 "marginalized"

label values race racialgroup

*create major dummies for liberal arts, general sciences, and humanities and business/marketing/management

generate libartsgensciencehumanities = 0

generate businessmarketingmanagement = 0

replace libartsgensciencehumanities = 1 if major1 == 124| major2 == 124

replace businessmarketingmanagement = 1 if major1 == 152| major2 == 152

*create experience in years, experience squared and experience to the fourth power
generate experienceyears = experience/52.143

generate experienceyearssq = experienceyears*experienceyears

generate experienceyearsquart = experienceyears*experienceyears*experienceyears*experienceyears

*label new variables
label variable satmath75p "SAT math 75th percentile score"

label variable satreadwrite75p "SAT reading and writing 75th percentile score"

label variable institutionname "name of undergraduate institution"

label variable collegeselectivity "composite of 75th percentile SAT math and reading/writing scores"

label variable selectivityandhardwork "interaction between college selectivity and hard work"

label variable race "racial group"

label variable libartsgensciencehumanities "major 1 or 2 is liberal arts, general sciences, and humanities"

label variable businessmarketingmanagement "major 1 or 2 is business, marketing, and management"

label variable experienceyears "experience in years"

label variable experienceyearsq "experience squared"

label variable experienceyearsquart "experience to the fourth power"

save "WageDiffFinalDataset.dta"

log close 




