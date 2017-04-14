#! /usr/bin/R

library("rstan");
library("jrRstan");
library("nlme");

rstan_options(auto_write = TRUE);
options(mc.core = parallel::detectCores);

data("Oxboys");
head(Oxboys);

## observable
y = Oxboys$height;

## covariate
x = Oxboys$age;

## subject labels
subj_label = as.numeric(Oxboys$Subject);
## number of subjects
N_subj = length(unique(subj_label));

### list for Stan
Oxboys_data = list(y = y, N = length(y), N_subj = N_subj, x = x, subj_label = subj_label,
                   m_alpha0 = 140, s_alpha0 = 3, m_beta0 = 15, s_beta0 = 7.5,
                   a_sigsq = 1.1, b_sigsq = 0.025, a_sigsq_alpha1 = 1.1, b_sigsq_alpha1 = 0.05);

randslope = stan("oxboys.stan", data = Oxboys_data);
