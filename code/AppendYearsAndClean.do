global year "2014 2015 2016 2017"
foreach y in $year{
  append using C:/Users/bz22/Desktop/PrimaryCareData/FullYearConsolidated/MEPS`y'.dta
}
save "C:\Users\bz22\Desktop\SARS2NYCData\MEPS2014-2017.dta"

gen AGE = .
foreach y in $year{
  replace AGE = AGE`y'X if PERWT`y'F != .
}
drop if AGE < 50
global month "JA FE MA AP MY JU JL AU SE OC NO DE"

global year "14 15 16 17"
foreach y in $year{
  * private full year
  gen PRI`y' = 0
  replace PRI`y' = 1 if PRIJA`y' == 1 & PRIFE`y' == 1 & PRIMA`y' == 1 & PRIAP`y' == 1 & PRIMY`y' == 1 & PRIJU`y' == 1 & PRIJL`y' == 1 & PRIAU`y' == 1 & PRISE`y' == 1 & PRIOC`y' == 1 & PRINO`y' == 1 & PRIDE`y' == 1
  * Medicare full year
  gen MCR`y' = 0
  replace MCR`y' = 1 if MCRJA`y' == 1 & MCRFE`y' == 1 & MCRMA`y' == 1 & MCRAP`y' == 1 & MCRMY`y' == 1 & MCRJU`y' == 1 & MCRJL`y' == 1 & MCRAU`y' == 1 & MCRSE`y' == 1 & MCROC`y' == 1 & MCRNO`y' == 1 & MCRDE`y' == 1
  * Medicaid Full year
  gen MCD`y' = 0
  replace MCD`y' = 1 if MCDJA`y' == 1 & MCDFE`y' == 1 & MCDMA`y' == 1 & MCDAP`y' == 1 & MCDMY`y' == 1 & MCDJU`y' == 1 & MCDJL`y' == 1 & MCDAU`y' == 1 & MCDSE`y' == 1 & MCDOC`y' == 1 & MCDNO`y' == 1 & MCDDE`y' == 1

}

gen PRI = .
gen MCR= .
gen MCD = .
gen UNINS = .

foreach y in $year{
  replace PRI = PRI`y' if PERWT`y'F != .
  replace MCR = MCR`y' if PERWT`y'F != .
  replace MCD = MCD`y' if PERWT`y'F != .
  replace UNINS = UNINS`y' if PERWT`y'F != .
}
replace UNINS = 0 if UNINS == 2

gen PERWT = .
foreach y in $year{
  replace PERWT = PERWT`y'F if PERWT`y'F != .
}

gen FYI = 5
replace FYI = 4  if PRI == 1
replace FYI = 1 if MCR == 1
replace FYI = 2 if MCD == 1
replace FYI = 3 if MCD ==1 & MCR == 1
replace FYI = 0 if UNINS == 1
label define FYI 0 "UninsuredAllYear" 1 "MedicareAllYear" 2 "MedicaidAllYear" 3 "Medicaid+MedicareAllYear" 4 "PrivateInsuranceAllYear" 5 "AllOther"
label values FYI FYI

keep if REGION31 == 1


save "C:\Users\bz22\Desktop\SARS2NYCData\MEPS2014-2017Age50+NEOnly.dta"
