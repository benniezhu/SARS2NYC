use "C:\Users\bz22\Desktop\SARS2NYCData\MEPS2014-2017Age50+NEOnly.dta"

* ChronicLung HeartDisease Diabetes Cancer HIV

gen COPD = 0
replace COPD = 1 if EMPHDX == 1 | CHBRON31 == 1

gen Asthma = 0
replace Asthma =1 if ASSTIL31 == 1

*comorbid of COPD Asthma HeartDisease Cancer Diabetes HIV
gen COPDAsthma = 0
replace COPDAsthma =1 if COPD == 1 & Asthma == 1

gen COPDHeartDisease = 0
replace COPDHeartDisease = 1 if COPD == 1 & HeartDisease == 1

gen COPDCancer = 0
replace COPDCancer = 1 if COPD == 1 & Cancer == 1

gen COPDDiabetes = 0
replace COPDDiabetes =1 if COPD == 1 & Diabetes == 1

gen COPDHIV = 0
replace COPDHIV = 1 if COPD == 1 & HIV == 1

gen AsthmaHeartDisease = 0
replace AsthmaHeartDisease = 1 if Asthma == 1 & HeartDisease == 1

gen AsthmaCancer = 0
replace AsthmaCancer = 1 if Asthma == 1 & Cancer == 1

gen AsthmaDiabetes = 0
replace AsthmaDiabetes = 1 if Asthma == 1 & Diabetes == 1

gen AsthmaHIV = 0 
replace Asthma = 1 if Asthma == 1 & HIV == 1

gen HeartDiseaseCancer = 0
replace HeartDiseaseCancer = 1 if HeartDisease == 1 & Cancer == 1

gen HeartDiseaseDiabetes = 0
replace HeartDiseaseDiabetes = 1 if HeartDisease == 1 & Diabetes== 1

gen HeartDiseaseHIV = 0
replace HeartDiseaseHIV =1 if HeartDisease == 1 & HIV == 1

gen CancerDiabetes = 0
replace CancerDiabetes = 1 if Cancer == 1 & Diabetes == 1

gen CancerHIV = 0
replace CancerHIV = 1 if Cancer == 1 & HIV == 1

gen DiabetesHIV = 0
replace DiabetesHIV = 1 if Diabetes == 1 & HIV == 1

table AgeCat
