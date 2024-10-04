**********************************************************************************************************************************************************************
**Date: January 2022 --> Latest Update: January 2022
*Paper: Hard Work, College Selectivity, and Racial Wage Differentials 
*
*This code renames the variables in the SAT scores and institution datasest and saves the data as dta file  
*
*database used: SATScoresInstitutionName.csv
*				
*output: SATScoresInstitutionName.dta
*
*key variables: - college unitid
*               - institution name 
*               - SAT critical reading score
*               - SAT math score 
*               
*							
*=====================================================================================================================================================================

clear 

clear matrix

log using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\logfiles\SATScoresInstitutionName.smcl"

*Define the directory
global PATH "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\dofiles_dtafiles"
cd $PATH

*Open data downloaded from IPEDS on SAT scores by institution
import delimited "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\rawdata\SATScoresInstitutionName.csv"

*drop v5
drop v5

*rename variables to prepare dataset for merge and creation of college selectivity variable

rename satmath75thpercentilescoreadm201 satmath75p

rename satcriticalreading75thpercentile satreadwrite75p

rename unitid college 

*save dataset
save "SATScoresInstitutionName.dta"

log close 


