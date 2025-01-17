*=====================================================================================================================================================================
*Date: January 2022 --> Latest Update: January 2022
*Paper: Hard Work, College Selectivity, and Racial Wage Differentials 
*
*This code renames all variables, drops cases misisng variables for analysis, creates the necessary controls, then matches respondents to their colleges and majors.  
*
*database used: Essay_2_WageDiff.csv, RespondentsMatchedToCollege.dta
*				
*output: WageDiffDataNoSelectivity.dta
*
*key variables: - income for wages and salary
*               - health limits work
*               - work experience as teen
*               - work experience as adult
*               - lives in metropolitan statistical area
*               - highest degree received
*               - region of residence
*               - occupation code for up to 10 jobs
*               - asvab percentile
*               - dads highest education in 1997
*               - moms highest education in 1997
*               - race and ethnicity
*               - sample type
*               - relationship to head of household in 1997
*               - birth year
*               - sex
*               - id
*               - marital status throughout 2019
*							
*=====================================================================================================================================================================

clear

clear matrix

set mem 500m

log using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\logfiles\WageDiffDataNoSelectivity.smcl"

*Define the directory
global PATH "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\dofiles_dtafiles"
cd $PATH

*open NLSY97 Geocode education data 
import delimited "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\rawdata\Essay_2_WageDiff.csv", case(upper) encoding(Big5)


label define vlE7013901 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013901 vlE7013901

label define vlE7013902 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013902 vlE7013902

label define vlE7013903 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013903 vlE7013903

label define vlE7013904 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013904 vlE7013904

label define vlE7013905 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013905 vlE7013905

label define vlE7013906 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013906 vlE7013906

label define vlE7013907 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013907 vlE7013907

label define vlE7013908 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013908 vlE7013908

label define vlE7013909 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013909 vlE7013909

label define vlE7013910 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013910 vlE7013910

label define vlE7013911 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013911 vlE7013911

label define vlE7013912 0 "Never Married, Not Cohabitating"  1 "Never Married, Cohabiting"  2 "Married"  3 "Legally Separated"  4 "Divorced"  5 "Widowed" 
label values E7013912 vlE7013912

label define vlR0000100 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R0000100 vlR0000100

label define vlR0536300 1 "Male"  2 "Female"  0 "No Information" 
label values R0536300 vlR0536300

label define vlR1205300 1 "Both biological parents"  2 "Two parents, biological mother"  3 "Two parents, biological father"  4 "Biological mother only"  5 "Biological father only"  6 "Adoptive parent(s)"  7 "Foster parent(s)"  8 "No parents, grandparents"  9 "No parents, other relatives"  10 "Anything else" 
label values R1205300 vlR1205300

label define vlR1235800 1 "Cross-sectional"  0 "Oversample" 
label values R1235800 vlR1235800

label define vlR1302400 0 "NONE"  1 "1ST GRADE"  2 "2ND GRADE"  3 "3RD GRADE"  4 "4TH GRADE"  5 "5TH GRADE"  6 "6TH GRADE"  7 "7TH GRADE"  8 "8TH GRADE"  9 "9TH GRADE"  10 "10TH GRADE"  11 "11TH GRADE"  12 "12TH GRADE"  13 "1ST YEAR COLLEGE"  14 "2ND YEAR COLLEGE"  15 "3RD YEAR COLLEGE"  16 "4TH YEAR COLLEGE"  17 "5TH YEAR COLLEGE"  18 "6TH YEAR COLLEGE"  19 "7TH YEAR COLLEGE"  20 "8TH YEAR COLLEGE OR MORE"  95 "UNGRADED" 
label values R1302400 vlR1302400

label define vlR1302500 0 "NONE"  1 "1ST GRADE"  2 "2ND GRADE"  3 "3RD GRADE"  4 "4TH GRADE"  5 "5TH GRADE"  6 "6TH GRADE"  7 "7TH GRADE"  8 "8TH GRADE"  9 "9TH GRADE"  10 "10TH GRADE"  11 "11TH GRADE"  12 "12TH GRADE"  13 "1ST YEAR COLLEGE"  14 "2ND YEAR COLLEGE"  15 "3RD YEAR COLLEGE"  16 "4TH YEAR COLLEGE"  17 "5TH YEAR COLLEGE"  18 "6TH YEAR COLLEGE"  19 "7TH YEAR COLLEGE"  20 "8TH YEAR COLLEGE OR MORE"  95 "UNGRADED" 
label values R1302500 vlR1302500

label define vlR1482600 1 "Black"  2 "Hispanic"  3 "Mixed Race (Non-Hispanic)"  4 "Non-Black / Non-Hispanic" 
label values R1482600 vlR1482600

label define vlR9829600 0 "0"  1 "1 TO 999: .001-.999"  1000 "1000 TO 19999: 1.000-19.999"  20000 "20000 TO 39999: 20.000-39.999"  40000 "40000 TO 59999: 40.000-59.999"  60000 "60000 TO 79999: 60.000-79.999"  80000 "80000 TO 100000: 80.000-100.000" 
label values R9829600 vlR9829600

label define vlT3162600 1 "1 -- Disagree strongly"  2 "2 -- Disagree moderately"  3 "3 -- Disagree a little"  4 "4 -- Neither agree nor disagree"  5 "5 -- Agree a little"  6 "6 -- Agree moderately"  7 "7 -- Agree strongly" 
label values T3162600 vlT3162600

label define vlT3162601 1 "1 -- Disagree strongly"  2 "2 -- Disagree moderately"  3 "3 -- Disagree a little"  4 "4 -- Neither agree nor disagree"  5 "5 -- Agree a little"  6 "6 -- Agree moderately"  7 "7 -- Agree strongly" 
label values T3162601 vlT3162601

label define vlT3162602 1 "1 -- Disagree strongly"  2 "2 -- Disagree moderately"  3 "3 -- Disagree a little"  4 "4 -- Neither agree nor disagree"  5 "5 -- Agree a little"  6 "6 -- Agree moderately"  7 "7 -- Agree strongly" 
label values T3162602 vlT3162602

label define vlT3162603 1 "1 -- Disagree strongly"  2 "2 -- Disagree moderately"  3 "3 -- Disagree a little"  4 "4 -- Neither agree nor disagree"  5 "5 -- Agree a little"  6 "6 -- Agree moderately"  7 "7 -- Agree strongly" 
label values T3162603 vlT3162603

label define vlU3315700 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3315700 vlU3315700

label define vlU3315800 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3315800 vlU3315800

label define vlU3315900 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3315900 vlU3315900

label define vlU3316000 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3316000 vlU3316000

label define vlU3316100 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3316100 vlU3316100

label define vlU3316200 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3316200 vlU3316200

label define vlU3316300 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3316300 vlU3316300

label define vlU3316400 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3316400 vlU3316400

label define vlU3316500 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3316500 vlU3316500

label define vlU3316600 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3316600 vlU3316600

label define vlU3316700 10 "10 TO 430: EXECUTIVE, ADMINISTRATIVE AND MANAGERIAL"  500 "500 TO 950: MANAGEMENT RELATED"  1000 "1000 TO 1240: MATHEMATICAL AND COMPUTER SCIENTISTS"  1300 "1300 TO 1530: ENGINEERS, ARCHITECTS, AND SURVEYORS"  1540 "1540 TO 1560: ENGINEERING AND RELATED TECHNICIANS"  1600 "1600 TO 1760: PHYSICAL SCIENTISTS"  1800 "1800 TO 1860: SOCIAL SCIENTISTS AND RELATED WORKERS"  1900 "1900 TO 1960: LIFE, PHYSICAL, AND SOCIAL SCIENCE TECHNICIANS"  2000 "2000 TO 2060: COUNSELORS, SOCIAL, AND RELIGIOUS WORKERS"  2100 "2100 TO 2150: LAWYERS, JUDGES, AND LEGAL SUPPORT WORKERS"  2200 "2200 TO 2340: TEACHERS"  2400 "2400 TO 2550: EDUCATION, TRAINING, AND LIBRARY WORKERS"  2600 "2600 TO 2760: ENTERTAINERS AND PERFORMERS, SPORTS AND RELATED WORKERS"  2800 "2800 TO 2960: MEDIA AND COMMUNICATION WORKERS"  3000 "3000 TO 3260: HEALTH DIAGNOSIS AND TREATING PRACTITIONERS"  3300 "3300 TO 3650: HEALTH CARE TECHNICAL AND SUPPORT"  3700 "3700 TO 3950: PROTECTIVE SERVICE"  4000 "4000 TO 4160: FOOD PREPARATIONS AND SERVING RELATED"  4200 "4200 TO 4250: CLEANING AND BUILDING SERVICE"  4300 "4300 TO 4430: ENTERTAINMENT ATTENDANTS AND RELATED WORKERS"  4460 "4460: FUNERAL RELATED OCCUPATIONS"  4500 "4500 TO 4650: PERSONAL CARE AND SERVICE WORKERS"  4700 "4700 TO 4960: SALES AND RELATED WORKERS"  5000 "5000 TO 5930: OFFICE AND ADMINISTRATIVE SUPPORT WORKERS"  6000 "6000 TO 6130: FARMING, FISHING, AND FORESTRY"  6200 "6200 TO 6940: CONSTRUCTION TRADES AND EXTRACTION WORKERS"  7000 "7000 TO 7620: INSTALLATION, MAINTENANCE, AND REPAIR WORKERS"  7700 "7700 TO 7750: PRODUCTION AND OPERATING WORKERS"  7800 "7800 TO 7850: FOOD PREPARATION"  7900 "7900 TO 8960: SETTER, OPERATORS, AND TENDERS"  9000 "9000 TO 9750: TRANSPORTATION AND MATERIAL MOVING WORKERS"  9800 "9800 TO 9840: MILITARY SPECIFIC OCCUPATIONS"  9950 "9950 TO 9990: ACS SPECIAL CODES" 
label values U3316700 vlU3316700

label define vlU3438000 1 "Northeast (CT, ME, MA, NH, NJ, NY, PA, RI, VT)"  2 "North Central (IL, IN, IA, KS, MI, MN, MO, NE, OH, ND, SD, WI)"  3 "South (AL, AR, DE, DC, FL, GA, KY, LA, MD, MS, NC, OK, SC, TN , TX, VA, WV)"  4 "West (AK, AZ, CA, CO, HI, ID, MT, NV, NM, OR, UT, WA, WY)" 
label values U3438000 vlU3438000

label define vlU3444500 0 "None"  1 "GED"  2 "High school diploma (Regular 12 year program)"  3 "Associate/Junior college (AA)"  4 "Bachelor's degree (BA, BS)"  5 "Master's degree (MA, MS)"  6 "PhD"  7 "Professional degree (DDS, JD, MD)" 
label values U3444500 vlU3444500

label define vlU3451600 1 "Not in CBSA"  2 "In CBSA, not in central city"  3 "In CBSA, in central city"  4 "In CBSA, not known"  5 "Not in country" 
label values U3451600 vlU3451600

label define vlU4282300 0 "0"  1 "1 TO 4999"  5000 "5000 TO 9999"  10000 "10000 TO 14999"  15000 "15000 TO 19999"  20000 "20000 TO 24999"  25000 "25000 TO 29999"  30000 "30000 TO 39999"  40000 "40000 TO 49999"  50000 "50000 TO 59999"  60000 "60000 TO 69999"  70000 "70000 TO 79999"  80000 "80000 TO 89999"  90000 "90000 TO 99999"  100000 "100000 TO 149999"  150000 "150000 TO 99999999: 150000+" 
label values U4282300 vlU4282300

label define vlU4368500 1 "YES"  0 "NO" 
label values U4368500 vlU4368500

*rename variables according to download names
rename E7013901 MAR_STATUS_2019_01_XRND   // MAR_STATUS_2019.01
rename E7013902 MAR_STATUS_2019_02_XRND   // MAR_STATUS_2019.02
rename E7013903 MAR_STATUS_2019_03_XRND   // MAR_STATUS_2019.03
rename E7013904 MAR_STATUS_2019_04_XRND   // MAR_STATUS_2019.04
rename E7013905 MAR_STATUS_2019_05_XRND   // MAR_STATUS_2019.05
rename E7013906 MAR_STATUS_2019_06_XRND   // MAR_STATUS_2019.06
rename E7013907 MAR_STATUS_2019_07_XRND   // MAR_STATUS_2019.07
rename E7013908 MAR_STATUS_2019_08_XRND   // MAR_STATUS_2019.08
rename E7013909 MAR_STATUS_2019_09_XRND   // MAR_STATUS_2019.09
rename E7013910 MAR_STATUS_2019_10_XRND   // MAR_STATUS_2019.10
rename E7013911 MAR_STATUS_2019_11_XRND   // MAR_STATUS_2019.11
rename E7013912 MAR_STATUS_2019_12_XRND   // MAR_STATUS_2019.12
rename R0000100 PUBID_1997 
rename R0536300 SEX_1997 
rename R0536402 BDATE_Y_1997 
rename R1205300 CV_YTH_REL_HH_CURRENT_1997 
rename R1235800 CV_SAMPLE_TYPE_1997 
rename R1302400 CV_HGC_BIO_DAD_1997 
rename R1302500 CV_HGC_BIO_MOM_1997 
rename R1482600 RACE_ETHNICITY_1997 
rename R9829600 ASVAB_MATH_VERBAL_SCORE_PCT_1999 
rename T3162600 YTEL_IND_000001_2008   // YTEL-IND~000001
rename T3162601 YTEL_IND_000002_2008   // YTEL-IND~000002
rename T3162602 YTEL_IND_000003_2008   // YTEL-IND~000003
rename T3162603 YTEL_IND_000004_2008   // YTEL-IND~000004
rename U3315700 YEMP_OCCODE_2002_01_2019   // YEMP_OCCODE-2002.01
rename U3315800 YEMP_OCCODE_2002_02_2019   // YEMP_OCCODE-2002.02
rename U3315900 YEMP_OCCODE_2002_03_2019   // YEMP_OCCODE-2002.03
rename U3316000 YEMP_OCCODE_2002_04_2019   // YEMP_OCCODE-2002.04
rename U3316100 YEMP_OCCODE_2002_05_2019   // YEMP_OCCODE-2002.05
rename U3316200 YEMP_OCCODE_2002_06_2019   // YEMP_OCCODE-2002.06
rename U3316300 YEMP_OCCODE_2002_07_2019   // YEMP_OCCODE-2002.07
rename U3316400 YEMP_OCCODE_2002_08_2019   // YEMP_OCCODE-2002.08
rename U3316500 YEMP_OCCODE_2002_09_2019   // YEMP_OCCODE-2002.09
rename U3316600 YEMP_OCCODE_2002_10_2019   // YEMP_OCCODE-2002.10
rename U3316700 YEMP_OCCODE_2002_11_2019   // YEMP_OCCODE-2002.11
rename U3438000 CV_CENSUS_REGION_2019 
rename U3444500 CV_HIGHEST_DEGREE_EVER_EDT_2019 
rename U3451600 CV_MSA_2019 
rename U4282300 YINC_1700_2019   // YINC-1700
rename U4368500 YHEA_1006_2019   // YHEA-1006
rename Z9065201 CVC_WKSWK_TEEN2_XRND 
rename Z9065401 CVC_WKSWK_ADULT2_ALL_XRND 

*rename variables to something easy to interpet
rename MAR_STATUS_2019_01_XRND marriedmonth1
rename MAR_STATUS_2019_02_XRND marriedmonth2
rename MAR_STATUS_2019_03_XRND marriedmonth3
rename MAR_STATUS_2019_04_XRND marriedmonth4
rename MAR_STATUS_2019_05_XRND marriedmonth5
rename MAR_STATUS_2019_06_XRND marriedmonth6
rename MAR_STATUS_2019_07_XRND marriedmonth7
rename MAR_STATUS_2019_08_XRND marriedmonth8
rename MAR_STATUS_2019_09_XRND marriedmonth9
rename MAR_STATUS_2019_10_XRND marriedmonth10
rename MAR_STATUS_2019_11_XRND marriedmonth11
rename MAR_STATUS_2019_12_XRND marriedmonth12
rename PUBID_1997 id
rename SEX_1997 sex 
rename BDATE_Y_1997 birthyear
rename CV_YTH_REL_HH_CURRENT_1997 hhousehold97
rename CV_SAMPLE_TYPE_1997 sampletype
rename CV_HGC_BIO_DAD_1997 dadeducation
rename CV_HGC_BIO_MOM_1997 momeducation 
rename RACE_ETHNICITY_1997 raceethnicity
rename ASVAB_MATH_VERBAL_SCORE_PCT_1999 asvab 
rename YEMP_OCCODE_2002_01_2019 occupationjob1
rename YEMP_OCCODE_2002_02_2019 occupationjob2
rename YEMP_OCCODE_2002_03_2019 occupationjob3  
rename YEMP_OCCODE_2002_04_2019 occupationjob4
rename YEMP_OCCODE_2002_05_2019 occupationjob5
rename YEMP_OCCODE_2002_06_2019 occupationjob6  
rename YEMP_OCCODE_2002_07_2019 occupationjob7
rename YEMP_OCCODE_2002_08_2019 occupationjob8  
rename YEMP_OCCODE_2002_09_2019 occupationjob9
rename YEMP_OCCODE_2002_10_2019 occupationjob10
rename YEMP_OCCODE_2002_11_2019 occupationjob11 
rename YTEL_IND_000001_2008 hardworker
rename YTEL_IND_000002_2008 amountofwork
rename YTEL_IND_000003_2008 workstandards
rename YTEL_IND_000004_2008 effortatwork
rename CV_CENSUS_REGION_2019 censusregion
rename CV_HIGHEST_DEGREE_EVER_EDT_2019 highestdegree
rename CV_MSA_2019 metroarea
rename YINC_1700_2019 wageincome
rename YHEA_1006_2019 healthlimitswork 
rename CVC_WKSWK_TEEN2_XRND experienceteen
rename CVC_WKSWK_ADULT2_ALL_XRND experienceadult

*drop if missing 2019 wage and salary income
keep if wageincome > = 0

*drop if missing data for all attitudes towards hard work variables
keep if hardworker > 0| amountofwork > 0| workstandards > 0| effortatwork > 0

*replace missing experienceteen data with .
replace experienceteen = . if experienceteen < 0

*drop if missing adult experience data
replace experienceadult = . if experienceadult < 0

*drop if missing health limits work data
keep if healthlimitswork > = 0

*drop if missing occupation data for main job, drop other 10 occupation variables
keep if occupationjob1 > 0

drop occupationjob2 occupationjob3 occupationjob4 occupationjob5 occupationjob6 occupationjob7 occupationjob8 occupationjob9 occupationjob10 occupationjob11 

*drop if missing marital status data for every month of 2019
keep if marriedmonth1 > = 0| marriedmonth2 > = 0| marriedmonth3 > = 0| marriedmonth4 > = 0| marriedmonth5 > = 0| marriedmonth6 > = 0| marriedmonth7 > = 0| marriedmonth8 > = 0|marriedmonth9 > = 0| marriedmonth10 > = 0| marriedmonth11 > = 0| marriedmonth12 > = 0

*drop if missing metropolitan area data 
keep if metroarea > 0 

*drop if missing region data
keep if censusregion > 0 

*drop if missing data on highest degree received
keep if highestdegree > = 0

*drop if missing asvab score
keep if asvab > = 0

*drop if missing head of household data
keep if hhousehold97 > 0

*create maritalstatus variable
generate maritalstatus = 0

replace maritalstatus = 1 if marriedmonth1 == 2| marriedmonth2 == 2| marriedmonth3 == 2| marriedmonth4 == 2| marriedmonth5 == 2| marriedmonth6 == 2| marriedmonth7 == 2| marriedmonth8 == 2|marriedmonth9 == 2| marriedmonth10 == 2| marriedmonth11 == 2| marriedmonth12 == 2

*create attitudes towards hard work total score
replace hardworker = . if hardworker < 0
replace hardworker = 7 if hardworker == 1
replace hardworker = 6 if hardworker == 2
replace hardworker = 5 if hardworker == 3

replace amountofwork = . if amountofwork < 0
replace amountofwork = 7 if amountofwork == 1
replace amountofwork = 6 if amountofwork == 2
replace amountofwork = 5 if amountofwork == 3

replace workstandards = . if workstandards < 0

replace effortatwork = . if effortatwork < 0

egen attitudehardworkscore = rowtotal (hardworker amountofwork workstandards effortatwork)

*create both biological parents variable 
generate bothbioparents = 0

replace bothbioparents = 1 if hhousehold97 == 1

*create asvab percentile variable
generate asvabpercentile = asvab / 1000

*create resides in south variable
generate south = 0

replace south = 1 if censusregion == 3

*create graduate degree variable
generate graduatedegree = 0

replace graduatedegree = 1 if highestdegree > 4

*create msa variable
generate msa = 0

replace msa = 1 if metroarea > 1

*create experience variable
egen experience = rowtotal (experienceadult experienceteen)

*create age variable 
generate age = 2019-birthyear

*create female dummy variable
generate female = 0

replace female = 1 if sex == 2

*create log of wageincome
generate logwageincome = log(wageincome)

*label variables 
label variable id "identification number"

label variable sampletype "sample original or supplemental"

label variable sex "respondents sex at birth"

label variable female "dummy for female"

label variable age "respondents age"

label variable raceethnicity "respondents race and ethnicity"

label variable wageincome "2019 income from wages and salary"

label variable logwageincome "log of 2019 income from wages and salary"

label variable attitudehardworkscore "total on attitudes toward hark work personality scale"

label variable experience "work experience since age 14"

label variable msa "resides in metropolitan statistical area"

label variable graduatedegree "earned a graduate degree"

label variable south "resides in the southern U.S."

label variable asvabpercentile "percentile score on the ASVAB"

label variable bothbioparents "both biological parents lived in household for 1997"

label variable maritalstatus "marital status in 2019, married or not"

label variable occupationjob1 "occupation code for the main job listed"

label variable healthlimitswork "respondents health limits their amount of work"

label variable momeducation "mothers highest level of education in 1997"

label variable dadeducation "fathers highest level of education in 1997"

*merge datasets to add data on degree majors and types
merge 1:1 id using "C:\Users\jcoger\Documents\Essay2\NLSY97WageDifferentialsV1\dofiles_dtafiles\RespondentsMatchedToCollege.dta"

keep if _merge == 3

drop _merge 

*label variables from merged dataset
label variable college "college where bachelors degree earned"

label variable major1 "bachelors degree major 1 for respondent"

label variable major2 "bachelors degree major 2 for respondent"

*save dataset 
save "WageDiffDataNoSelectivity.dta"

log close 




  
  
