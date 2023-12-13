use "D:\capstone data files\ipumsi_00004.dta\Viet2009CensusCleaned.dta"

// summary tables 
iebaltab regnvn age sex perwt urban1 empstat yrschool disabled1 disblnd1 disdeaf1 dismobil1 dismntl1 wgcogn wghear wgmobil wgvision if cutoffreal == 0, groupvar(nbstorage) savexlsx(capstonebalance12)

iebaltab regnvn age sex1 perwt urban1 empstat yrschool disabled1 disblnd1 disdeaf1 dismobil1 dismntl1 wgcogn wghear wgmobil wgvision if cutoffreal == 1, groupvar(nbstorage) savexlsx(capstonebalance13)

//initial visualizations

// bar graph of disabled and nprov  
graph bar (mean) disabled1 disblnd1 disdeaf1 dismobil1 dismntl1, over(cutoffreal)  by(nbstorage) ///
legend(label(1 "Disabled") label(2 "Vision Impaired") label(3 "Hearing Impaired")label(4 "Mobility Impaired") label(5 "Mental Disability"))

graph bar (mean) disabled1 disblnd1 disdeaf1 dismobil1 dismntl1, over(nbstorage)  by(cutoffreal) ///
legend(label(1 "Disabled") label(2 "Vision Impaired") label(3 "Hearing Impaired")label(4 "Mobility Impaired") label(5 "Mental Disability"))

// primary regressions 
diff disabled1, treated(nbprov) p(cutoffreal)
outreg2 using diffsredo1.doc

diff disabled1, treated(nbstorage) p(cutoffreal)
outreg2 using diffsredo1.doc

diff disabled1, treated(nbsprayed) p(cutoffreal)
outreg2 using diffsredo1.doc

// robustness checks
asdoc ttest disabled1 if cutoffreal == 0, by(nbprov), stat(obs mean se df t)
asdoc ttest disabled1 if cutoffreal == 0, by(nbstorage), rowappend stat(obs mean se df t)
asdoc ttest disabled1 if cutoffreal == 0, by(nbsprayed), rowappend stat(obs mean se df t)

diff disabled1, treated(nbprov) p(cutoff1975)
outreg2 using diffsrobust.doc

diff disabled1, treated(nbstorage) p(cutoff1975)
outreg2 using diffsrobust.doc

diff disabled1, treated(nbsprayed) p(cutoff1975)
outreg2 using diffsrobust.doc

// heterogeneity tests
diff disabled1 if sex1 == 0, treated(nbstorage) p(cutoffreal) 
outreg2 using diffhetrogeneity.doc

diff disabled1 if sex1 == 1, treated(nbstorage) p(cutoffreal) 
outreg2 using diffhetrogeneity.doc

diff disabled1, treated(nbstorage) p(cutoffreal) cov(sex1)
outreg2 using diffhetrogeneity.doc

* north south 
diff disabled1 if divide == 0, treated(nbstorage) p(cutoffreal) 
outreg2 using diffhetrogeneity1.doc

diff disabled1 if divide == 1, treated(nbstorage) p(cutoffreal) 
outreg2 using diffhetrogeneity1.doc

diff disabled1, treated(nbstorage) p(cutoffreal) cov(divide)
outreg2 using diffhetrogeneity1.doc

// extention
reg empstat cutoffreal disabled1 nbstorage
outreg2 using workextension.doc
reg empstat urban1 yrschool sex1 perwt marst cutoffreal disabled1 nbstorage if yrschool !=99 
outreg2 using workextension.doc

reg yrschool cutoffreal disabled1 nbstorage 
outreg2 using eduextension.doc
reg yrschool urban sex1 perwt lit1 marst cutoffreal disabled1 nbstorage 
outreg2 using eduextension.doc