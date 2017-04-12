functions {
}

data {
  int<lower=1> N_subj;
  int<lower=1> N;
  int<lower=1> subj_label[N];
  vector[N] x;
  vector[N] y;
  real m_alpha0;
  real<lower=0> s_alpha0;
  real m_beta0;
  real<lower=0> s_beta0;
  real<lower=0> a_sigsq;
  real<lower=0> b_sigsq;
  real<lower=0> a_sigsq_alpha1;
  real<lower=0> b_sigsq_alpha1;
}

transformed data {
}

parameters {
  real alpha0;
  vector[N_subj] alpha1;
  real beta0;
  real<lower=0> sigsq;
  real<lower=0> sigsq_alpha1;
}

transformed parameters {
}

model {
  // likelihood
  vector[N] alpha;
  alpha = alpha0 + alpha1[subj_label];
  y ~ normal(0, sqrt(sigsq_alpha1));
  
  // prior
  alpha0 ~ normal(m_alpha0, s_alpha0);
  beta0 ~ normal(m_beta0, s_beta0);
  sigsq ~ gamma(a_sigsq, b_sigsq);
  alpha1 ~ normal(0, sqrt(sigsq_alpha1));
  
  // hyperprior
  sigsq_alpha1 ~ gamma(a_sigsq_alpha1, b_sigsq_alpha1);
}

generated quantities {
}
