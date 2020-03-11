*/ The City is estimating how many New Yorkers age 50 or older have one or more health conditions that make one vulnerable to the effects of COVID-19 – namely:
/*
Chronic lung disease (asthma, COPD, emphysema)
Heart disease (chronic heart disease, stroke or heart attack)
Weakened immune system (people living with HIV or AIDS)
Cancer
Diabetes
*/

use "C:\Users\bz22\Desktop\SARS2NYCData\MEPS2014-2017Age50+NEOnly.dta"

gen AgeCat = .
replace AgeCat = 0 if AGE < 65
replace AgeCat = 1 if AGE >= 65 & AGE <75
replace AgeCat = 2 if AGE >= 75
label define AgeCat 0 "50-64" 1 "65-74" 2 "75+"
label values AgeCat AgeCat

/* I define Chronic Lung Disease to be someone who fulfills any of the following criteria; reports still having asthma, was ever diagnosed with empheysema, or has chronic bronchitis in the last 12 months*/

gen ChronicLung = 0
replace ChronicLung = 1 if CHBRON31 == 1 | ASSTIL31 == 1 | EMPHDX == 1

/* I define heart disease as anyone who fills any of the following criteria; was diganosed with coronary heart disease, angina, other heart disease/condition, diagnosed with having a heart attack or stroke */

gen HeartDisease = 0
replace HeartDisease = 1 if CHDDX == 1 | MIDX == 1 | OHRTDX == 1 | STRKDX == 1

* cancer and diabetes definitions are for any cancer dx
gen Diabetes = 0
replace Diabetes = 1 if DIABDX == 1

gen Cancer = 0
replace Cancer = 1 if CANCERDX == 1

*Merge HIV info from medical condition files
gen year = .
foreach y in $year{
  replace year = 20`y' if PERWT`y'F != .
}

merge 1:1 DUPERSID year using "C:\Users\bz22\Desktop\SARS2NYCData\HIVStatus2014-2017.dta"
drop if _merge == 2

replace HIV = 0 if HIV == .

gen NumCond = HIV + HeartDisease + Cancer + Diabetes + ChronicLung

* Make tables?
table FYI AgeCat [fw=round(PERWT)], c(mean Diabetes mean HeartDisease mean Cancer mean ChronicLung mean HIV)

table FYI AgeCat [fw=round(PERWT)], c(mean Diabetes)
table FYI AgeCat [fw=round(PERWT)], c(mean HeartDisease)
table FYI AgeCat [fw=round(PERWT)], c(mean Cancer)
table FYI AgeCat [fw=round(PERWT)], c(mean ChronicLung)
table FYI AgeCat [fw=round(PERWT)], c(mean HIV)

table FYI AgeCat SEX [fw=round(PERWT)], c(mean Diabetes mean HeartDisease mean Cancer mean ChronicLung mean HIV)

*Table by number of conditions
gen ZeroConditions = 0
replace ZeroConditions = 1 if NumCond == 0

gen OneCondition = 0
replace OneCondition = 1 if NumCond == 1

gen TwoCondition = 0
replace TwoCondition = 1 if NumCond == 2

gen ThreeCondition = 0
replace ThreeCondition = 1 if NumCond == 3

gen FourCondition = 0
replace FourCondition = 1 if NumCond == 4

table FYI AgeCat [fw=round(PERWT)], c(mean ZeroConditions mean OneCondition mean TwoCondition mean ThreeCondition mean FourCondition)

table FYI AgeCat SEX [fw=round(PERWT)], c(mean ZeroConditions mean OneCondition mean TwoCondition mean ThreeCondition mean FourCondition)

save "C:\Users\bz22\Desktop\SARS2NYCData\MEPS2014-2017Age50+NEOnly.dta", replace
