/******************************************************************************
Project:	ECON 613 HW5
Created by: Yaxuan Jiao
Created:	2019/04/11
******************************************************************************/


******************************************
* HW2 OLS and Discrete Choice *
******************************************
clear all

*Exercise 1*
set seed 100
set obs 10000
generate X1 = runiform(1,3)
generate X2 = rgamma(3,2)
generate X3 = rbinomial(10000,0.3)
generate eps = rnormal(2,1)
generate Y=0.5+1.2*X1-0.9*X2+0.1*X3+eps
egen Y_mean = mean(Y)
gen Ydum = 0
replace Ydum = 1 if Y>Y_mean


*Exercise 2*
*Calculate the correlation between Y and X1
reg Y X1
*regression of Y on X where X = (1,X1,X2,X3) & obtain the OLS standard errors
reg Y X1 X2 X3
*Calculate the standard errors using bootstrap with 49 and 499 replications respectively
*49
bootstrap, reps(49): reg Y X1 X2 X3
*499
bootstrap, reps(499): reg Y X1 X2 X3


*Exercise 4*
*using the probit, logit, and the linear probability model
probit Ydum X1 X2 X3
logit Ydum X1 X2 X3
reg Ydum X1 X2 X3,vce(robust)


*Exercise 5*
*Compute the marginal effect of X on Y according to the probit and logit models & compute the standard deviations using delta method 
probit Ydum X1 X2 X3
margins, dydx(*) atmeans
logit Ydum X1 X2 X3
margins, dydx(*) atmeans
*Compute the standard deviations using bootstrap 
probit Ydum X1 X2 X3, vce(bootstrap, reps(499))
logit Ydum X1 X2 X3, vce(bootstrap, reps(499))
