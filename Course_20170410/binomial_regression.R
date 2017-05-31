#! /usr/bin/R

library("rstan");
library("jrRstan");

rstan_options(auto_write = TRUE);
options(mc.core = parallel::detectCores);

data("sideeffect");
head(sideeffect);

## observable
y = sideeffect$effects;

## design matrix
dose_centred = scale(sideeffect$dose, scale = FALSE);

X = cbind(1, dose_centred);
X = as.matrix(X);

sideeffect_data = list(y = y, N = nrow(X), K = ncol(X), X = X, n = sideeffect$n);

binreg = stan("binomial_regression.stan", data = sideeffect_data);

