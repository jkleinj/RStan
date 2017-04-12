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
  real<lower=0> a_sigsq_beta1;
  real<lower=0> b_sigsq_beta1;
}

transformed data {
}

parameters {
  real alpha0;
  vector[N_subj] alpha1;
  real beta0;
  vector[N_subj] beta1;
  real<lower=0> sigsq;
  real<lower=0> sigsq_alpha1;
  real<lower=0> sigsq_beta1;
}

transformed parameters {
}

model {
  // likelihood
  vector[N] alpha;
  vector[N] beta;
  
  alpha = alpha0 + alpha1[subj_label];
  beta = beta0 + beta1[subj_label];
  y ~ normal(alpha + beta .* x, sqrt(sigsq_alpha1));
  
  // prior
  alpha0 ~ normal(m_alpha0, s_alpha0);
  beta0 ~ normal(m_beta0, s_beta0);
  sigsq ~ gamma(a_sigsq, b_sigsq);
  alpha1 ~ normal(0, sqrt(sigsq_alpha1));
  beta1 ~ normal(0, sqrt(sigsq_beta1));
  
  // hyperprior
  sigsq_alpha1 ~ gamma(a_sigsq_alpha1, b_sigsq_alpha1);
  sigsq_beta1 ~ gamma(a_sigsq_beta1, b_sigsq_beta1);
}

generated quantities {
}
