#! /usr/bin/R

## load rstan package
library("rstan");

## allow rstan to explount parallel computation
rstan_options(auto_write = TRUE);
options(mc.cores = parallel::detectCores());

## set up some constants to pass to rstan
constants = list(N = 30, p = 0.8);

## compile and run rstan programme
output = stan(file = "simulation.stan", data = constants, iter = 1, chains = 1, algorithm = "Fixed_param");

## extract simulated data
out = as.matrix(output);
dim(out);
head(out);

## format as vector, removing the log posterior
x = out[1, -length(out)];

## plot data
barplot(table(x));

## simulating data
## violating constraints
faulty_constants = list(N = 30, p = 10);

