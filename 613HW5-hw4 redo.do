/******************************************************************************
Project:	ECON 613 HW5
Created by: Yaxuan Jiao
Created:	2019/04/11
******************************************************************************/


******************************************
* HW4 Panel Data Model
******************************************

*Exercise 1*
*Import data 
insheet using C:\Users\yj124\Desktop\Koop-Tobias.csv,names
*convert data into panel data
xtset personid timetrnd
bysort personid: gen t = _n
*Represent the panel dimension of wages for 5 randomly selected individuals
tabulate timetrnd logwage if personid == 3
tabulate timetrnd logwage if personid == 13
tabulate timetrnd logwage if personid == 133
tabulate timetrnd logwage if personid == 1133
tabulate timetrnd logwage if personid == 1333

*Exercise 2 Random Effect Model
xtreg logwage educ potexper, re

*Exercise 3 Fixed effect model*

*Between Estimator 
xtreg logwage educ potexper,be 

*Within Estimator 
xtreg logwage educ potexper,fe

*First time difference estimator 

xtset personid t
xtdes
gen logwage_D = D.logwage
gen educ_D = D.educ
gen potexper_D = D.potexper
xtreg logwage_D educ_D potexper_D, fe
