functions {
  real deviance(vector y, matrix X, vector beta, real sigma_sq)  {
    real dev;
    dev = 0;
    for (n in 1:num_elements(y)) {
      real eta;
      eta = 0;
      for (k in 1:cols(X)) {
        eta = eta + X[n, k] * beta[k];
      }
      dev = dev + (-2) * normal_lpdf(y[n] | eta, sqrt(sigma_sq));
    }
    return dev;
  }
}

data {
  int<lower=1> K;
  int<lower=1> N;
  matrix[N, K] X;
  vector[N] y;
  row_vector[K] x_pred;
  real m_beta[K];
  real m_sigma_sq;
  real<lower=0> s_beta[K];
  real<lower=0> s_sigma_sq;
}

transformed data {
}

parameters {
  real<lower=0> sigma_sq;
  vector[K] beta;
}

transformed parameters {
}

model {
  for (n in 1:N) {
    real eta;
    eta = 0;
    for (k in 1:K) {
      eta = eta + X[n, k] * beta[k];
    }
    y[n] ~ normal(eta, sqrt(sigma_sq));
  }

  for (k in 1:K) {
    beta[k] ~ normal(m_beta[k], s_beta[k]); 
  }
  
  sigma_sq ~ lognormal(m_sigma_sq, s_sigma_sq);
}

generated quantities {
  real y_pred;
  real dev;
  {
    real eta_pred;
    eta_pred = 0;
    for (k in 1:K) {
      eta_pred = eta_pred + x_pred[k] + beta[k];
    }
    y_pred = normal_rng(eta_pred, sqrt(sigma_sq));
  }
  dev = deviance(y, X, beta, sigma_sq);
}

