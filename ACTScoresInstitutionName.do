**********************************************************************************************************************************************************************
**Date: January 2022 --> Latest Update: January 2022
*Paper: Hard Work, College Selectivity, and Racial Wage Differentials 
*
*This code renames the variables in the ACT scores and institution datasest and saves the data as dta file  
*
*database used: SATScoresInstitutionName.csv
*				
*output: SATScoresInstitutionName.dta
*
*key variables: - college unitid
*               - institution name 
*               - ACT 75th percentile composite score
*       
*               
*							
*=====================================================================================================================================================================

clear 

clear matrix

log using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\logfiles\ACTScoresInstitutionName.smcl"

*Define the directory
global PATH "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\dofiles_dtafiles"
cd $PATH

*Open data downloaded from IPEDS on SAT scores by institution
import delimited "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\rawdata\ACTScoresInstitutionName.csv"

*drop other test scores except for ACT composite 
drop satwriting75thpercentilescoreadm satmath75thpercentilescoreadm201 satcriticalreading75thpercentile actcomposite25thpercentilescorea v8

*rename variables to prepare dataset for merge and creation of college selectivity variable
rename unitid college 

rename actcomposite75thpercentilescorea act75p

*save dataset
save "ACTScoresInstitutionName.dta"

log close 


