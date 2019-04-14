/******************************************************************************
Project:	ECON 613 HW5
Created by: Yaxuan Jiao
Created:	2019/04/11
******************************************************************************/


******************************************
* HW3 Multinomial Choices 
******************************************
clear all
set more off, perm
set scrollbufsize 2000000

*Exercise 1*
import excel "C:\Users\yj124\Desktop\product.xlsx", sheet("data1") firstrow clear
save "C:\Users\yj124\Desktop\product.dta",replace
import excel "C:\Users\yj124\Desktop\demos.xlsx", sheet("data2") firstrow clear
drop A
save "C:\Users\yj124\Desktop\demos.dta",replace
merge 1:m hhid using "C:\Users\yj124\Desktop\product.dta"
*average and dispersion in product characteristics
summarize PPk_Stk PBB_Stk PFl_Stk PHse_Stk PGen_Stk PImp_Stk PSS_Tub PPk_Tub PFl_Tub PHse_Tub
*market share
tabulate choice
tabulate Income choice
tabulate Fam_Size choice


*Exercise 2&4 Conditional Logit Model*
drop hhid
rename (PPk_Stk PBB_Stk PFl_Stk PHse_Stk PGen_Stk PImp_Stk PSS_Tub PPk_Tub PFl_Tub PHse_Tub)(c1 c2 c3 c4 c5 c6 c7 c8 c9 c10)
reshape long c, i(A) j(price)
gen dummy=cond(price==choice,1,0)
*Calculate the marginal effects
asclogit d c, case(A) alternatives(price)
est sto c_logit
estat mfx

*Exercise 3&4 Multinomial Logit Model*
asclogit dummy, case(A) alternatives(price) casevar(Income)
*Calculate the marginal effects
est sto m_logit
estat mfx

*Exercies 5 Mixed Logit Model*
asmixlogit dummy, random(c) casevars(Income) alternatives(price) case(A)
est sto all
drop if choice==1
drop if price==1
asmixlogit dummy, random(c) casevars(Income) alternatives(price) case(A)
est sto partial 
hausman partial all, alleqs constant

