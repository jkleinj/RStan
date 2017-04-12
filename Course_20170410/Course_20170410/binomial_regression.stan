functions {
}

data {
  int<lower=1> K;
  int<lower=1> N;
  matrix[N, K] X;
  int y[N];
  int n[N];
}

transformed data {
}

parameters {
  vector[K] beta;
}

transformed parameters {
}

model {
  vector[N] eta;

  beta[1] ~ normal(-0.27, 0.68^2);
  beta[2] ~ normal(0.47, 0.31^2);

  eta = X * beta;

  // vectorised form of the normal distribution */
  y ~ binomial_logit(n, eta);
}

generated quantities {
}
