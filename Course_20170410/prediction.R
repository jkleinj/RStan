#! /usr/bin/R

library(jrRstan);
data(api);

rstan_options(auto_write = TRUE);
options(mc.core = parallel::detectCores);

head(api);

## school performance
y = api$api;

## school type
middle = as.numeric(api$stype == "M");
high = as.numeric(api$stype == "H");

## design matrix
X = cbind(1, api[ ,c("meals", "not.hsg", "ell", "enroll")]);
class(X);
## as matrix
X = as.matrix(X);
head(X);

## mean-centre continuous covariates
X_means = colMeans(X[ , 2:5]);
for(n in 1:nrow(X)) {
  X[n, 2:5] = X[n, 2:5] - X_means;
}

## prediction for hypothetical school
meals = not.hsg = ell = 50;
enroll = 1000;
## create and mean-centre continuous covariates
x_pred = c(1, 50, 50, 50, 1000, 0, 0);
x_pred[2:5] = x_pred[2:5] - X_means;
## specify hyperparameters in prior


