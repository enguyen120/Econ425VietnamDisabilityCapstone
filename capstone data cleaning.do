drop if disabled == 0
drop if disabled == 9 
drop if disblnd == 9
drop if disdeaf == 9 
drop if dismobil == 9 
drop if dismntl == 9 

drop if birthyr > 1976
drop if birthyr < 1970
drop if birthyr == 1976 & birthmo > 3
drop if birthyr == 1970 & birthmo < 3

gen ym = ym(birthyr, birthmo)
label variable ym "Person Age in Months"

gen cutoffreal = 0 
label variable cutoffreal "Born After March 1973"
replace cutoffreal = 1 if ym > 158
replace cutoffreal = 1 if ym == 158

recode urban sex marst lit labforce disabled disblnd disdeaf dismobil dismntl (2=0), gen(urban1 sex1 marst1 lit1 labforce1 disabled1 disblnd1 disdeaf1 dismobil1 dismntl1)

//provincial and district markers
gen nbprov = 0  
gen nbsprayed = 0 
gen nbstorage = 0
label variable nbprov "near base"
label variable nbsprayed  "near sprayed base"
label variable nbstorage "near storage base"

replace nbstorage = 1 if geo1_vn2009 == 49 //da nang
replace nbstorage = 1 if geo1_vn2009 == 52 // binh dinh (phu cat)
replace nbstorage = 1 if geo1_vn2009 == 75 //dong nai (bien hoa)

replace nbprov = 1 if geo1_vn2009 == 79 // Ho Chi Minh city, formerly gia dinh province
replace nbprov = 1 if geo1_vn2009 == 52 // binh dinh (phu cat)
replace nbprov = 1 if geo1_vn2009 == 54 // phu yen
replace nbprov = 1 if geo1_vn2009 == 60 //binh thuan
replace nbprov = 1 if geo1_vn2009 == 56 //khanh hoa 
replace nbprov = 1 if geo1_vn2009 == 92 // can tho 
replace nbprov = 1 if geo1_vn2009 == 64 //gia lai 
replace nbprov = 1 if geo1_vn2009 == 49 //da nang
replace nbprov = 1 if geo1_vn2009 == 75 //dong nai (bien hoa)

// replace nbsprayed = 1 if geo1_vn2009 == 72 -- tay ninh -- eliminated from data
replace nbsprayed = 1 if geo1_vn2009 == 70 // binnh phuoc
replace nbsprayed = 1 if geo1_vn2009 == 74 // binh duong
replace nbsprayed = 1 if geo1_vn2009 == 75 //dong nai (bien hoa)
replace nbsprayed = 1 if geo1_vn2009 == 72 // tay ninh
replace nbsprayed = 1 if geo1_vn2009 == 52 // binh dinh (phu cat)
replace nbsprayed = 1 if geo1_vn2009 == 62  // kon tum
replace nbsprayed = 1 if geo1_vn2009 == 45 //quang tri
replace nbsprayed = 1 if geo1_vn2009 == 51 //quang nam
replace nbsprayed = 1 if geo1_vn2009 == 49 //da nang
replace nbsprayed = 1 if geo1_vn2009 == 46 // thua thien hue

// robustness and hetrogeneity tests
gen cutoff1975 = 0 
label variable cutoff1975 "Born After April 1975"
replace cutoff1975 = 1 if ym > 184
replace cutoff1975 = 1 if ym == 184

gen divide = 0
label variable divide "North-South Divide"
replace divide = 1 if geo1_vn2009 > 45
replace divide = 1 if geo1_vn2009 == 45
