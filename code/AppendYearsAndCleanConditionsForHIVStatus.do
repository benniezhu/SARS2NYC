global year "14 15 16 17"
foreach y in $year{
  append using "C:\Users\bz22\Desktop\Technology Data\NDC\2011-2017\ConditionFiles\COND`y'.dta"
}

save "C:\Users\bz22\Desktop\SARS2NYCData\Conditions2014-2017.dta"

/* I define HIV as if you have the clinical classification code for HIV (005) for the years 2014 and 2015. Because MEPS switched to ICD10, I use this code to define HIV status. We only have one ICD10 code in our sample (Z21) for asymptomatic HIV */

gen HIV = 0
replace HIV = 1 if CCCODEX == "005" | ICD10CDX == "Z21"

keep if HIV == 1
keep DUPERSID year HIV

duplicates drop

save "C:\Users\bz22\Desktop\SARS2NYCData\HIVStatus2014-2017.dta"
